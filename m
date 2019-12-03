Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E743E2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urbzj+fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLCVg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:36:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42866 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfLCVg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:36:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id l22so2479915pff.9;
        Tue, 03 Dec 2019 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M46RQcwxgINKa8vpC6RQJq2Z/PQ6+1z2D0+STFMlBWs=;
        b=urbzj+fb0UgJ2kkk6FK8gZeFnG9Pq/7eGIL09MywLyrSLgc7gWFEFJMGlba57wpQre
         U/QVyeD5K1RojUp3LtTMzsY+BcZJn7n4hkbGJGSJmg/KggF5UtJW4tu0vFa3CyNlckd6
         uy+TyRW3zvg1jiQgsBUTraTrrXpFPZVwxW8H9kWybJ6NsC/Ah8VromsvK3wRr13zRLw2
         zGPuzTnlZ1Y3BRlZhaPCETSdizhP4vGTS1ikgNd/WpMt9TmY990JhNsc6MbLla7/FdA+
         pnWBnRJSozy3sS9S1yBHsojALEfXaIGW65K8MDWrCNitpu+Ay8O/Jwyq9tEgWAJy6HRx
         x0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M46RQcwxgINKa8vpC6RQJq2Z/PQ6+1z2D0+STFMlBWs=;
        b=AhLz0uRPASQvErdDV3i7HitXvgXFw6pEKE7f6FIy0uohwwoUOUBBxQE8nMA8nkSa6W
         tU0FWqPvFThPhctFDEBBFElLnpaW7WFb+aiFWIajcs7EenIG8vir2vqu/vb/ZneA99F+
         8O+Mvx1aFgvPODZzNZO+0i9Igj8YQwmoDA5M2N3SwfTVUo0mDZQyliT1PMrJ9ONK3NDi
         MJq4PkT4X3DOe5RRI1hdjeS0CKRT45E4MvAu1OFeaTsdFgr2DK/ZzroxZEqKLp3e4JLM
         YK+EcfhzVn6nwXlIxQWJIC8aygOLBbkOZi1wLZ2tnBs9twmQrOWVZurSP3PHgram0jW/
         PaDw==
X-Gm-Message-State: APjAAAWM7yBIu4tKUo4kdzaj0twtdI33eCa5N0xBKivKzDxsGHVZrJYD
        t4fyTARTgIyJppZjN+uAHW8=
X-Google-Smtp-Source: APXvYqwx9HpYfEdeX8KitmYjpnkNfmF/IvBAHRIQ0bmZBBtsrNU5eUEvackFZxQtljNcP1d0JoGxKw==
X-Received: by 2002:a62:1447:: with SMTP id 68mr7217396pfu.53.1575409017456;
        Tue, 03 Dec 2019 13:36:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x11sm4765624pfn.53.2019.12.03.13.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Dec 2019 13:36:56 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:36:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] sh: Modernize printing of kernel messages
Message-ID: <20191203213655.GA3253@roeck-us.net>
References: <20191203162645.19950-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203162645.19950-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 05:26:38PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series fixes the broken lines in kernel output, which I
> presume have been happening since commit 4bcc595ccd80decb ("printk:
> reinstate KERN_CONT for printing continuat ion lines").
> Most annoying are the ones in call traces and disassembly dumps, as they
> cause lots of small bits of information to fly by your serial console.
> 
> Thanks!
> 
> Geert Uytterhoeven (7):
>   sh: kernel: disassemble: Fix broken lines in disassembly dumps
>   sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
>   sh: process: Fix broken lines in register dumps
>   sh: sh2007: Modernize printing of kernel messages
>   sh: pci: Modernize printing of kernel messages
>   sh: machvec: Modernize printing of kernel messages
>   sh: fault: Modernize printing of kernel messages
> 
Yes, the output does look a bit nicer with those patches applied.

For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

>  arch/sh/boards/board-sh2007.c    |   4 +-
>  arch/sh/drivers/pci/common.c     |   6 +-
>  arch/sh/drivers/pci/pci-sh7780.c |  23 ++++---
>  arch/sh/drivers/pci/pci.c        |  11 ++--
>  arch/sh/kernel/disassemble.c     | 103 ++++++++++++++++---------------
>  arch/sh/kernel/dumpstack.c       |  24 +++----
>  arch/sh/kernel/machvec.c         |   8 +--
>  arch/sh/kernel/process_32.c      |  38 +++++-------
>  arch/sh/mm/fault.c               |  39 ++++++------
>  9 files changed, 124 insertions(+), 132 deletions(-)
> 
> -- 
> 2.17.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
