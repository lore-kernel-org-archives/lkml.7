Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC62C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B29218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfCONlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11365 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfCONlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:41:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B01530F8DAC;
        Fri, 15 Mar 2019 13:41:52 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5843D60BE6;
        Fri, 15 Mar 2019 13:41:43 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:41:41 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Message-ID: <20190315144141.100f2be7.cohuck@redhat.com>
In-Reply-To: <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
        <20190315112032.13b259c2.cohuck@redhat.com>
        <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 15 Mar 2019 13:41:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 14:26:34 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Conclusion:  we must handle this in userland, it will have the benefit 
> to keep old behavior when there is no callback.
> OLD QEMU will not see change as they will not set aqic facility
> NEW QEMU will handle this correctly.
> 
> In this case we also do not need to handle all other tests here but can 
> move it to the callback as Tony wanted.
> 
> Would you agree with something simple like:
> 
> static int handle_pqap(struct kvm_vcpu *vcpu)
> {
>          int ret = -EOPNOTSUPP;
> 
>          /* Verify that the hook callback is registered and call it */
>          if (pqap_hook)
>                  if (try_module_get(pqap_hook->owner)) {
>                          ret = pqap_hook->hook(vcpu);
>                          module_put(pqap_hook->owner);
>                  }
>          return ret;
> }
> 
> All other tests in QEMU and in the callback.

With the hook checking for priv, fc, etc.? Yeah, might work.

But don't count on my feedback too much right now, better wait for
others' comments :) I'll resume in April, if needed.
