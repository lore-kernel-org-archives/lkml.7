Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF81CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E72D218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfCOKUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfCOKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:20:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2FEA2E606E;
        Fri, 15 Mar 2019 10:20:41 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12A80600C0;
        Fri, 15 Mar 2019 10:20:34 +0000 (UTC)
Date:   Fri, 15 Mar 2019 11:20:32 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Message-ID: <20190315112032.13b259c2.cohuck@redhat.com>
In-Reply-To: <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 15 Mar 2019 10:20:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 17:04:58 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> +/*
> + * handle_pqap: Handling pqap interception
> + * @vcpu: the vcpu having issue the pqap instruction
> + *
> + * We now support PQAP/AQIC instructions and we need to correctly
> + * answer the guest even if no dedicated driver's hook is available.
> + *
> + * The intercepting code calls a dedicated callback for this instruction
> + * if a driver did register one in the CRYPTO satellite of the
> + * SIE block.
> + *
> + * For PQAP/AQIC instructions only, verify privilege and specifications.
> + *
> + * If no callback available, the queues are not available, return this to
> + * the caller.
> + * Else return the value returned by the callback.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	uint8_t fc;
> +	struct ap_queue_status status = {};
> +	int ret;
> +	/* Verify that the AP instruction are available */
> +	if (!ap_instructions_available())
> +		return -EOPNOTSUPP;
> +	/* Verify that the guest is allowed to use AP instructions */
> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> +		return -EOPNOTSUPP;
> +	/* Verify that the function code is AQIC */
> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
> +	/* We do not want to change the behavior we had before this patch*/
> +	if (fc != 0x03)
> +		return -EOPNOTSUPP;
> +
> +	/* PQAP instructions are allowed for guest kernel only */
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +	/* AQIC instruction is allowed only if facility 65 is available */
> +	if (!test_kvm_facility(vcpu->kvm, 65))
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	/* Verify that the hook callback is registered and call it */
> +	if (vcpu->kvm->arch.crypto.pqap_hook) {
> +		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> +			return -EOPNOTSUPP;
> +		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> +		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> +		return ret;
> +	}
> +	/*
> +	 * It is the duty of the vfio_driver to register a hook
> +	 * If it does not and we get an exception on AQIC we must
> +	 * guess that there is no vfio_ap_driver at all and no one
> +	 * to handle the guests's CRYCB and the CRYCB is empty.
> +	 */
> +	status.response_code = 0x01;

I'm still confused here, sorry. From previous discussions I recall that
this indicates "no crypto device" (please correct me if I'm wrong.)

Before this patch, we had:
- guest issues PQAP/AQIC -> drop to userspace

With a correct implementation, we get:
- guest issues PQAP/AQIC -> callback does what needs to be done

With an incorrect implementation (no callback), we get:
- guest issues PQAP/AQIC -> guest gets response code 0x01

Why not drop to userspace in that case?


> +	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> +	return 0;
> +}
> +
