Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C3C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C7120679
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564853669;
	bh=bx09sU0odmrKWlcv+dufqUQnT28Goo0TWyeKBPwhXDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2bCn/c2fHE7Gsdre8Q2T65oy1waNFYHa4aLNNqXNiL64mOiifDQFUwr8YYwOXxpWi
	 BpcTu9pGTXpHF0Eg+0qXkav4nnXQyH+IqFJMfU7dc2r6OLdUUyq5wzGcC9lWZImjt1
	 Pccpwk4uRCmHjEHsRsaA+64HdbUi45g7F8dtVfqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfHCRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 13:34:28 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:32912 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfHCRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:34:28 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1htxvC-0001u7-Ep; Sat, 03 Aug 2019 19:34:22 +0200
Date:   Sat, 3 Aug 2019 18:34:20 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 6/9] KVM: arm64: Provide a PV_TIME device to user space
Message-ID: <20190803183335.149e0113@why>
In-Reply-To: <20190803135113.6cdf500c@why>
References: <20190802145017.42543-1-steven.price@arm.com>
        <20190802145017.42543-7-steven.price@arm.com>
        <20190803135113.6cdf500c@why>
Organization: Approximate
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: steven.price@arm.com, kvm@vger.kernel.org, catalin.marinas@arm.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, pbonzini@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2019 13:51:13 +0100
Marc Zyngier <maz@kernel.org> wrote:

[forgot that one]

> On Fri,  2 Aug 2019 15:50:14 +0100
> Steven Price <steven.price@arm.com> wrote:

[...]

> > +static int __init kvm_pvtime_init(void)
> > +{
> > +	kvm_register_device_ops(&pvtime_ops, KVM_DEV_TYPE_ARM_PV_TIME);
> > +
> > +	return 0;
> > +}
> > +
> > +late_initcall(kvm_pvtime_init);

Why is it an initcall? So far, the only initcall we've used is the one
that initializes KVM itself. Can't we just the device_ops just like we
do for the vgic?

	M.
-- 
Without deviation from the norm, progress is not possible.
