Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB6721473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A8u1Zhdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDHO5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:57:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfDHO5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:57:24 -0400
Received: from zn.tnic (p200300EC2F07270021E2DB6109CF2936.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:21e2:db61:9cf:2936])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88EE01EC086F;
        Mon,  8 Apr 2019 16:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554735443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LoCFx9MJe0PXjinUMyeaglOeK9PXPBvrxIMkZ361EIo=;
        b=A8u1Zhdg1OlAMHua3TEVSyrTXK5E5IG9qigANF7/zx8k7ZyfoAix51ndMCpmiECw3T88hE
        lVRGjZRM2vUivzaUJDWZYjGuTvdHaAbIJ6l+0ETvwwv73n/jeZ/5UDLHnHAUgcYQJ3bsXI
        eEQ3suaJt1QoU0xwXZ9B75EqoDTj6pk=
Date:   Mon, 8 Apr 2019 16:57:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     KVM <kvm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: Re: [PATCH -v5] x86/kvm: Implement HWCR support
Message-ID: <20190408145716.GG15689@zn.tnic>
References: <20190408090946.GA2315@zn.tnic>
 <20190408144115.GA25880@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408144115.GA25880@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:41:15AM -0700, Sean Christopherson wrote:
> > +{
> > +	if (guest_cpuid_is_amd(vcpu)) {
> > +		struct msr_data tmp;
> > +
> > +		tmp.index = MSR_K7_HWCR;
> > +
> > +		if (kvm_get_msr_common(vcpu, &tmp))
> 
> No need to get through kvm_get_msr_common(), vcpu->arch.msr_hwcr can be
> queried directly.  Going that route would likely eliminate the need for a
> helper func, i.e. avoid the naming confusion and the comment below.

Agree with every point except this: the helper function abstracts
the guest cpuid check and the rest of the handling nicely. If I put
everything in an already too big default: label in set_msr_mce(), then
the code there will become even more unreadable than it is.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
