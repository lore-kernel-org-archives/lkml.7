Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5085C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874A32081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBh7s0my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCHVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:14:01 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43764 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:14:00 -0500
Received: by mail-yw1-f65.google.com with SMTP id d129so3526170ywe.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4QBcweZDC6d+E7G2Q1RjpmY84iAiS/0RsnZ9+73CEpo=;
        b=rBh7s0mywKYDYxEyLNxU8Gjrm0UcovTSjnddxl+iZxcrNQUmya4AMDAyCSW1nt7Ym+
         SgqZny4eSEAHgF/Bu5bPeT++rSFtrgkabv591cQlc8SunbHfdNYd7y7SJWGCH3GSkuOw
         vKevqKojNRVO2s5j6//Abf90JON0CghwJ9KZ3mhSBAEnaAvqKKJYqnGUMp5J8nP52KH3
         ST80PiDALhMKu5igb9FMFuTsh0CWb8dXctaISIMVG1oc+EvwldT06YlwjpD9zLpPxyIZ
         ynM5+n2FiGsxe9KPK1h4PB/lgSpQPrOrv2WHj2aEUSHEiPT7ge3HGsakADwsr5Htj3oV
         H2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4QBcweZDC6d+E7G2Q1RjpmY84iAiS/0RsnZ9+73CEpo=;
        b=mBcr+WK0e3TTRbpJA+qsxyKxlcX+QffNyR1Cdw8Vlxp8MVtcwbbVcd3kNbAf6CbwSX
         Aeon93kg0XkW/UvBmH0jdUIhLBa/LoMybRYspRboElXS/fvvB/4ACUrDgO9G9VtkAClF
         xWZh7u/Urld+EiPwUJx+MVmq0cpDeK5p6q27FTANIAmwi6N4w++MTodY/LD/1dksSCck
         ue4nkIENlqHq/12z+MUSdlfLbp5HdCUVwYI8/S5DGAICLWFBaU0K6VLlVuDiMnzLbTvx
         R6ce8J6Nhx2CAXMjqEr4TyYGI73l95TvdTmV8tTFUZZrfApysglqlTo51vpGw/a/ltqN
         7+EA==
X-Gm-Message-State: APjAAAVCTH4sp/n8+e9K3NsLN1jYHxIfrTLnaPTQ4h5qFTwr8LGcJM1J
        BtEJI2+lRKLIM9ciln9fXPKOSVl3
X-Google-Smtp-Source: APXvYqz5UC64RnsMUSrhkrrYjhHiXZLtR5znmVQodQBfLjrafIGEw2EyqRPSX/BGZh9EukxcvNAP7Q==
X-Received: by 2002:a0d:e20b:: with SMTP id l11mr16538703ywe.1.1552079639392;
        Fri, 08 Mar 2019 13:13:59 -0800 (PST)
Received: from laptop ([185.175.33.171])
        by smtp.gmail.com with ESMTPSA id z23sm5870903ywj.36.2019.03.08.13.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 13:13:58 -0800 (PST)
Message-ID: <c6d40256460614f7aa3d8aab7c0044eb16841876.camel@gmail.com>
Subject: Re: [PATCH 1/1] MIPS: Ensure ELF appended dtb is relocated
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Mar 2019 23:13:55 +0200
In-Reply-To: <20190308190233.jqgkw26dpryz5izy@pburton-laptop>
References: <20190308125851.31806-1-yasha.che3@gmail.com>
         <20190308125851.31806-2-yasha.che3@gmail.com>
         <20190308190233.jqgkw26dpryz5izy@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, 2019-03-08 at 19:02 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Fri, Mar 08, 2019 at 02:58:51PM +0200, Yasha Cherikovsky wrote:
> > This fixes booting with the combination of CONFIG_RELOCATABLE=y
> > and CONFIG_MIPS_ELF_APPENDED_DTB=y.
> > 
> > Sections that appear after the relocation table are not relocated
> > on system boot (except .bss, which has special handling).
> > 
> > With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
> > vmlinux ELF, so it must be relocated together with everything else.
> 
> Do you have any ideas how CONFIG_RELOCATABLE interacts with
> CONFIG_MIPS_RAW_APPENDED_DTB? I'm wondering whether we should move both
> variants of appended DTB to before .data.reloc, but haven't yet thought
> it through.
> 
> Thanks,
>     Paul
> 

I booted now a image with RELOCATABLE and MIPS_RAW_APPENDED_DTB and it
works.

Behind the scenes it's complicated:

1. MIPS_RAW_APPENDED_DTB works this way (the way I understand it):
   In run time, the dtb appears in memory right after the original
   vmlinux.bin image (the one that "make" created).
   If the dtb was concatenated to vmlinuz.bin: at run time, after vmlinuz
   extracts vmlinux.bin,
   it takes care of copying the dtb to the end of vmlinux.bin in memory.
   If the dtb was concatenated to vmlinux.bin at build time, no run-time
   work is needed.

2. Therefore, the __appended_dtb pointer in the linker script must point to
   the end of the actual data in vmlinux.bin.
   So we can't move it to before .data.reloc.

3. When the kernel relocates itself, it doesn't copy the appended dtb 
   along with the kernel.
   This behavior is documented, see this code comment: [1].


Yasha

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/kernel/relocate.c?h=v5.0#n339


> > Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
> > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/mips/kernel/vmlinux.lds.S | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/vmlinux.lds.S
> > b/arch/mips/kernel/vmlinux.lds.S
> > index cb7e9ed7a453..33ee0d18fb0a 100644
> > --- a/arch/mips/kernel/vmlinux.lds.S
> > +++ b/arch/mips/kernel/vmlinux.lds.S
> > @@ -140,6 +140,13 @@ SECTIONS
> >  	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
> >  #endif
> >  
> > +#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
> > +	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
> > +		*(.appended_dtb)
> > +		KEEP(*(.appended_dtb))
> > +	}
> > +#endif
> > +
> >  #ifdef CONFIG_RELOCATABLE
> >  	. = ALIGN(4);
> >  
> > @@ -164,11 +171,6 @@ SECTIONS
> >  	__appended_dtb = .;
> >  	/* leave space for appended DTB */
> >  	. += 0x100000;
> > -#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
> > -	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
> > -		*(.appended_dtb)
> > -		KEEP(*(.appended_dtb))
> > -	}
> >  #endif
> >  	/*
> >  	 * Align to 64K in attempt to eliminate holes before the
> > -- 
> > 2.21.0
> > 

