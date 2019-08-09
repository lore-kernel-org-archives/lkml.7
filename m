Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EC4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F2120C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEyqJaGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHIT4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:56:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46569 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:56:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id c3so23449221pfa.13;
        Fri, 09 Aug 2019 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMkNogCa+wjaBsrfGqpBWAHpK/JdMQPfScAVKdODCEw=;
        b=OEyqJaGJnGNUad0hvWkyQBcqMCILNJsyAI048QcPhvp8QPGBVvpim8DkwvmdXwIjup
         yby5B89qAr1vTsQzimWMtr2LAKltZW2Y+2/4eWq+FiyHUQURguE8s4mWAtV4MDI5mHTa
         +RgJreJ37oYxGwVriH+Pf1TzRuV7WdDqK4efFhBZfJZbiA0Iucl24Jcw2cXBjNiSFZYX
         +g4fDcaUdN7GX333a6vDXeTV/Iw/T7exHiQMaNDtDRQGeh/Lb5VJmRHl3+t0sTVRUs3e
         6n/c2Dqa6J6I6k+5IOk222khlhxH7I0jmKWPEGdctsOxqCyJMMkdc4Y0oJn9QUKTSMa+
         02fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMkNogCa+wjaBsrfGqpBWAHpK/JdMQPfScAVKdODCEw=;
        b=t9q56Tf1BCW/1fC6G+K5fpRiikndHGRmquDB0weu3BxRyHpTiOifVmXZMXptrNWCom
         cQyAf7kbk9ruIGWRqHdktjO+P33/na3/xFzYhLkCM1dTwXKJJw4HWjesTLZBBy1EmPur
         ngA1HpP/rYJr6E4QhzsUqvxPIYBB8ZEf/ouxwa6LM/FT+l5QD7KGtjGneFv2Ka4iQUjx
         1B745nQSEIe8BXXIXj3RFYwtNyUoalY6fnothLq2uwdth1A2qvIVQrjGbxQaxadSZi0z
         uBPy0AO5K4A/nnsnByvsM+BnAkiwZJEQ0eAj3+1V8LLNbP0iznFC848VpcmF7vJL95mg
         bjxQ==
X-Gm-Message-State: APjAAAWO1yAQqkPJoJ8IiqQy9NkVUBHNT+01BogWer0Y2g7swm87nN8c
        djbHrBmYllKKhDn48L5qKsM9KBUo
X-Google-Smtp-Source: APXvYqyD+0dYhCqOR1C3M8oJqSTHihcRcMgVfMUM2WjJMTWQY/rPiiJaPjvnP3uDRaVY91eMUu1eYA==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr19473544pgo.64.1565380593272;
        Fri, 09 Aug 2019 12:56:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b123sm144827pfg.64.2019.08.09.12.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 12:56:32 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:56:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rich Felker <dalias@libc.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-ID: <20190809195630.GA15606@roeck-us.net>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <20190805032441.GO9017@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805032441.GO9017@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
> On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
> > Since commit a035d552a93b ("Makefile: Globally enable fall-through
> > warning"), all sh builds fail with errors such as
> > 
> > arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> > arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> > 
> > Since this effectively disables all build and boot tests for the
> > architecture, let's drop -Werror from the sh kernel Makefile until
> > the problems are fixed.
> > 
> > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Rich Felker <dalias@libc.org>
> 
Any chance to get this or a similar patch applied soon ? All sh builds
in mainline and -next are still broken.

Thanks,
Guenter

> > ---
> >  arch/sh/kernel/Makefile | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
> > index 59673f8a3379..ef65f0625c6c 100644
> > --- a/arch/sh/kernel/Makefile
> > +++ b/arch/sh/kernel/Makefile
> > @@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
> >  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
> >  obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
> >  obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
> > -
> > -ccflags-y := -Werror
> > -- 
> > 2.7.4
