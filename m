Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF99CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443721872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VB/qqTmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633086AbfJYQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:40:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbfJYQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:40:04 -0400
Received: from zn.tnic (p200300EC2F0D3C00114ACBE854FF623C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3c00:114a:cbe8:54ff:623c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F32741EC0CEA;
        Fri, 25 Oct 2019 18:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572021599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0BspKpTHhDFSD1ZazQbF6BaHRpi/K3Vkd5wkOxwr3Uw=;
        b=VB/qqTmGFF8Yi8RkacH5DLJuVU0U9IqUfWngALGk+fTOeRrDA/+T4P/36rsat5pU8IeTew
        CJU2MTqabu5iSd1V54Ac/1opw9t7EsALqLAAlEYfzXwWqJJFbvxKitLo2X8743kggIYmj/
        CQt2vMAFjwy+idp4WfLS+C2kGNx14h8=
Date:   Fri, 25 Oct 2019 18:39:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/16] KVM: VMX: Drop initialization of
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191025163958.GG6483@zn.tnic>
References: <20191021234632.32363-1-sean.j.christopherson@intel.com>
 <20191022000820.1854-1-sean.j.christopherson@intel.com>
 <20191025162645.GE6483@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025162645.GE6483@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 06:26:45PM +0200, Borislav Petkov wrote:
> On Mon, Oct 21, 2019 at 05:08:20PM -0700, Sean Christopherson wrote:
> > +	if (WARN_ON_ONCE(!(msr & FEATURE_CONTROL_LOCKED)))
> > +		return 1;
> > +
> > +	/* launched w/ TXT and VMX disabled */
> > +	if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX) &&
> > +	    tboot_enabled())
> > +		return 1;
> > +	/* launched w/o TXT and VMX only enabled w/ TXT */
> > +	if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX) &&
> > +	    (msr & FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX) &&
> > +	    !tboot_enabled()) {
> > +		pr_warn("kvm: disable TXT in the BIOS or "
> > +			"activate TXT before enabling KVM\n");
> > +		return 1;
> 
> Might as well fix that with a cleanup patch ontop:
> 
> WARNING: quoted string split across lines
> #69: FILE: arch/x86/kvm/vmx/vmx.c:2208:
> +               pr_warn("kvm: disable TXT in the BIOS or "
> +                       "activate TXT before enabling KVM\n");
> 
> 
> Also in that same cleanup patch, if the order of those tests doesn't
> matter, you can simplify them a bit:
> 
> 	if (tboot_enabled()) {
> 		/* msr flag test here */
> 
> 	/* tboot disabled */
> 	} else {
> 		/* other two tests here */
> 	}
> 
> Should make it a bit easier to parse.

Nevermind - just saw patch 7. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
