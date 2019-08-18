Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89CC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33082184D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MBEg5HmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHRUS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 16:18:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfHRUS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:18:59 -0400
Received: from zn.tnic (p200300EC2F259C00DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:9c00:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 212BA1EC072D;
        Sun, 18 Aug 2019 22:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566159538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fg4DRhDxqlSGrxzeW4xJX7VDIaQ6tHk0+TbwMA7LRc=;
        b=MBEg5HmHRGu+/dLdhVqWx7pfuVDEVEpj5PsVb7/RpX+mzgsFTQI1L5yCMl7MJNUVbs97fw
        uHdz/NMrypFQkEvrPFymcKqT3C/NyUCUNLy3e8QsPglc2H1Y59aVcA72o6mClE/Bnh65sa
        /OgGo92l+yv6aJFK4hv4Bvh7nDPFMj0=
Date:   Sun, 18 Aug 2019 22:19:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190818201942.GC29353@zn.tnic>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818143316.4906-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 04:33:14PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> This is intended to be used by drivers using the backdoor, and
> we follow the kvm example using alternatives self-patching to
> choose between vmcall, vmmcall and inl instructions.
> 
> This patch defines two new x86 cpu feature flags.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Also, s/cpu/CPU/g in the text.

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Doug Covelli <dcovelli@vmware.com>
> ---
>  MAINTAINERS                        |  1 +
>  arch/x86/include/asm/cpufeatures.h |  2 ++
>  arch/x86/include/asm/vmware.h      | 13 +++++++++++++
>  3 files changed, 16 insertions(+)
>  create mode 100644 arch/x86/include/asm/vmware.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1bd7b9c2d146..412206747270 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17203,6 +17203,7 @@ M:	"VMware, Inc." <pv-drivers@vmware.com>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Supported
>  F:	arch/x86/kernel/cpu/vmware.c
> +F:	arch/x86/include/asm/vmware.h
>  
>  VMWARE PVRDMA DRIVER
>  M:	Adit Ranadive <aditr@vmware.com>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 998c2cc08363..69cecc3bc9cb 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -232,6 +232,8 @@
>  #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
>  #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
>  #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
> +#define X86_FEATURE_VMW_VMCALL		( 8*32+18) /* VMware prefers VMCALL hypercall instruction */
> +#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */

Those are not set anywhere in the patchset. Please send them with their
user.

Then, there already is X86_FEATURE_VMMCALL which you can use too, I'd
guess.

Which would turn the macro into

	ALTERNATIVE_2(".byte 0xed", \
		      ".byte 0x0f, 0x01, 0xc1", X86_FEATURE_VMW_VMCALL,	\
		      ".byte 0x0f, 0x01, 0xd9", X86_FEATURE_VMMCALL)

and then you end up adding a single new feature bit X86_FEATURE_VMW_VMCALL.

Also, I don't see a reason to show the synthetic bit in /proc/cpuinfo
so when you define it, add "":

#define X86_FEATURE_VMW_VMCALL		( 8*32+18) /* "" VMware prefers VMCALL hypercall instruction */
						      ^
						      |
						      |
						      this here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
