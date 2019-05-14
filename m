Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D134EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C59C21707
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmEJgE98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfENPnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:43:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46319 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:43:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so8815443pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a+kzP7bTSrlqs6pxiIkhPgzkbpOEzOvI/LVVdexE6gA=;
        b=NmEJgE98WryIUtsub6GRiQIiyIsE2uwPAreI69Pj4fx4ojw38vOcHXKjmFyjBBfiiG
         thRok67oRcIMUQwR25v4IQ9agD0nPS6lCTLMk10ghl9oWnjMQra/JzrXqV3GxUIUvtz/
         zLEkWIBMhRjDJpPnAmIAL8zF2uH8A7phi5uFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+kzP7bTSrlqs6pxiIkhPgzkbpOEzOvI/LVVdexE6gA=;
        b=EPabsEc5vr64nGpJ/37RpynLwJdpBbqsb3RopNUz92e/+dE/4GKnTVE2EMJAGJHnXP
         SpYpdsqogYeWr6G1te7jd2Jpigqt14+s+2OvAqlyh/RR+PaYZuNSuNKUEuNe7r40mytB
         pzoB7apDVO8mlW5RJ3HU64b5cSnGPEzX12BywsWBDtyk6Lo47WQwfTbGicw2qnKWZFx7
         44A3bGGr6JBGG20ZlYScjfPMqfm0y2DQVOGbRS4SgfFqVHandgwFUO27+gyi6dWLT3ia
         YvR40T8FyEAwQ+IMBXh0wBEdNY/L2vUT+bU9lX2L0+8aKmAtEGKz+sQOUJ1bOzKPXL6w
         UJ3Q==
X-Gm-Message-State: APjAAAXwlNABu/H6ygFUjIHCdGxo5Hr72nFRM/C/LpGuL9h8PmMaD7K4
        y50zlhjpPeYHwvmTaVeBZO4ogA==
X-Google-Smtp-Source: APXvYqzsP8e8QRxVOyHU5sBm60A1Q9PIvYBT6eseOgywB9aHiVIWXwYBtH5p1ELsWM3lb1vmI/3qAA==
X-Received: by 2002:a63:5742:: with SMTP id h2mr38531680pgm.194.1557848601184;
        Tue, 14 May 2019 08:43:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm18095082pgj.75.2019.05.14.08.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 08:43:20 -0700 (PDT)
Date:   Tue, 14 May 2019 08:43:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <201905140842.21066115C5@keescook>
References: <20190423183827.GA4012@beast>
 <20190514120416.GA11736@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514120416.GA11736@probook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 02:04:21PM +0200, Johannes Hirte wrote:
> On 2019 Apr 23, Kees Cook wrote:
> > When building x86 with Clang LTO and CFI, CFI jump regions are
> > automatically added to the end of the .text section late in linking. As a
> > result, the _etext position was being labelled before the appended jump
> > regions, causing confusion about where the boundaries of the executable
> > region actually are in the running kernel, and broke at least the fault
> > injection code. This moves the _etext mark to outside (and immediately
> > after) the .text area, as it already the case on other architectures
> > (e.g. arm64, arm).
> > 
> > Reported-and-tested-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index bad8c51fee6e..de94da2366e7 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -141,11 +141,11 @@ SECTIONS
> >  		*(.text.__x86.indirect_thunk)
> >  		__indirect_thunk_end = .;
> >  #endif
> > -
> > -		/* End of text section */
> > -		_etext = .;
> >  	} :text = 0x9090
> >  
> > +	/* End of text section */
> > +	_etext = .;
> > +
> >  	NOTES :text :note
> >  
> >  	EXCEPTION_TABLE(16) :text = 0x9090
> > -- 
> > 2.17.1
> 
> This breaks the build on my system:
> 
>   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
>   CC      arch/x86/boot/compressed/early_serial_console.o
>   CC      arch/x86/boot/compressed/kaslr.o
>   AS      arch/x86/boot/compressed/mem_encrypt.o
>   CC      arch/x86/boot/compressed/kaslr_64.o
> Invalid absolute R_X86_64_32S relocation: _etext
> make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> make: *** [arch/x86/Makefile:283: bzImage] Error 2

Interesting! Can you send along your .config and compiler details?

-- 
Kees Cook
