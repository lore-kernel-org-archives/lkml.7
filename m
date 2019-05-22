Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF1C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA00E2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 04:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YZiet3Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfEVEr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 00:47:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40757 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVEr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 00:47:28 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so1024693itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bZWJrnzfEsibHqusNcJ77q9p3tppUCleq0pTHWaLH0A=;
        b=YZiet3TmRASetZh+Y/8SOVD3gS3dI2AcvkN+WaDJ2A4nO/c1bIt/Uvw6l5pDMT3DhU
         Y0lcJMi6WGPdmh1KaSAClFENuPFUTPX6/UcaxFV4M4UlMyZ3F2rCuHDp7DtNMjUN8x8z
         r1E+faQ2+1+5W6Fz0t0hrikorZvPj62oHvUs4st582Sc55NyDrxHDv7lF9vs+i3p9qRg
         z19uJJd2OTiqwiTIKqv0cKVZSJBFa9Y0m3+fCeRDKCvBCgA7kXCjYi9Is8b5iwOBaG2l
         UsyPoh+fYTPDAuJrR45Zc0W0AjInGgt59dTYB8/wf52Mp3uoW7daWdxwBVxvt37za7Ve
         BX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bZWJrnzfEsibHqusNcJ77q9p3tppUCleq0pTHWaLH0A=;
        b=fUuKiGlD1z6bJyzU+WjD2zfv1J+KqP6oxiy/4GY38EQozu19XKSALxhQVJARoZevRR
         C0jiwGYV/QgY/VBHT0Mo9uv3ODeklIrI/osXoKj5Ijs5eIzMM7bp4YHNmnFxtDxNycrd
         hCW+ggXzwNA/GgtdQdENnH6qOmn4YJVQ0k0qPn8ZhLG18nPO0uguYOefWtW/TOtt0Dbb
         S9oUJ/2iy7frAGJiEkpUbZJ8CyBKqfjVmguHz/IbG5jTKxOeRAktulf0SEX6vukKd/Fy
         0BN9cmFjUyGcgpQPPghJmIh2yXJllD0wZ4TRmaeE8asaqHfFY931w1DJhfZNiVmNbqZ7
         STVA==
X-Gm-Message-State: APjAAAXMfXaWwNNfPYb+TUnQoHTUtd+wqCvziRKoGI6uS9f9u4T31MB+
        1RhaAUhqEMkqNzw4A71Xevlfly1uvBU=
X-Google-Smtp-Source: APXvYqyiw7jaz+HifD4bDHFBIogK33qlo2NOApxwKo+SMHZpwpcrysML9YAzDMITPVq0XSw2jaBWLA==
X-Received: by 2002:a24:454a:: with SMTP id y71mr6863724ita.135.1558500447612;
        Tue, 21 May 2019 21:47:27 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e22sm7611400ioe.45.2019.05.21.21.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 21:47:26 -0700 (PDT)
Date:   Tue, 21 May 2019 21:47:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
In-Reply-To: <20190521171422.c7ef965e39b27f6142788412@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.9999.1905212134310.23235@viisi.sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com> <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com> <alpine.DEB.2.21.9999.1905191108180.10723@viisi.sifive.com> <20190521171422.c7ef965e39b27f6142788412@linux-foundation.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Andrew Morton wrote:

> On Sun, 19 May 2019 11:24:22 -0700 (PDT) Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > On Sat, 18 May 2019, Joe Perches wrote:
> > 
> > > On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> > > > The RISC-V architecture has a register named the "Supervisor Exception
> > > > Program Counter", or "sepc".  This abbreviation triggers
> > > > checkpatch.pl's misspelling detector, resulting in noise in the
> > > > checkpatch output.  The risk that this noise could cause more useful
> > > > warnings to be missed seems to outweigh the harm of an occasional
> > > > misspelling of "spec".  Thus drop the "sepc" entry from the
> > > > misspelling list.
> > > 
> > > I would agree if you first fixed the existing sepc/spec
> > > and sepcific/specific typos.
> > > 
> > > arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
> > > arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
> > > drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
> > > drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register
> > > drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1
> > 
> > Your agreement shouldn't be needed for the patch I sent.
> 
> I always find Joe's input to be very useful.
> 
> Here:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: scripts-spellingtxt-drop-sepc-from-the-misspelling-list-fix
> 
> fix existing "sepc" instances, per Joe
> 
> Cc: Joe Perches <joe@perches.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Thanks Andrew.  Sorry that you had to do it.

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

What troubled me about Joe's message is that it seems like poor kernel 
developer precedent to block a fix for static analysis false positives to 
fix comment spelling errors -- particularly considering that four out of 
five of them were unrelated to the actual patch in question.  While 
comment spelling fixes are worthwhile, I think we should make sure that 
the "tail doesn't wag the dog" by prioritizing code fixes first.

Reflecting on it on Sunday evening, if Joe had acked the patch, or added a 
Reviewed-by, and asked whether I might send a patch to fix those spelling 
errors, it probably would have gotten done.  

I will try to do better next time,


- Paul
