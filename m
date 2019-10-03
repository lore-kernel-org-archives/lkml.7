Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C1C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC9D21848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfJCNWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJCNWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:22:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D0153061213;
        Thu,  3 Oct 2019 13:22:43 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7094600CD;
        Thu,  3 Oct 2019 13:22:37 +0000 (UTC)
Date:   Thu, 3 Oct 2019 15:22:35 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] KVM: arm64: Support stolen time reporting via
 shared structure
Message-ID: <20191003132235.ruanyfmdim5s6npj@kamzik.brq.redhat.com>
References: <20191002145037.51630-1-steven.price@arm.com>
 <20191002145037.51630-6-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002145037.51630-6-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 03 Oct 2019 13:22:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:50:32PM +0100, Steven Price wrote:
> +int kvm_update_stolen_time(struct kvm_vcpu *vcpu, bool init)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u64 steal;
> +	u64 steal_le;
> +	u64 offset;
> +	int idx;
> +	u64 base = vcpu->arch.steal.base;
> +
> +	if (base == GPA_INVALID)
> +		return -ENOTSUPP;
> +
> +	/* Let's do the local bookkeeping */
> +	steal = vcpu->arch.steal.steal;
> +	steal += current->sched_info.run_delay - vcpu->arch.steal.last_steal;
> +	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
> +	vcpu->arch.steal.steal = steal;
> +
> +	steal_le = cpu_to_le64(steal);

Agreeing on a byte order for this interface makes sense, but I don't see
it documented anywhere. Is this an SMCCC thing? Because I skimmed some
of those specs and other users too but didn't see anything obvious. Anyway
even if everybody but me knows that all data returned from SMCCC calls
should be LE, it might be nice to document that in the pvtime doc.

Thanks,
drew
