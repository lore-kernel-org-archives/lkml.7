Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E16AC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CB2206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp32Vj5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfG1ROw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:14:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1ROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:14:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so26756269pfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HkbyZyJEQ/Ssvm6OUV8hiP66D8y0xk9KIRre5UDSbVs=;
        b=fp32Vj5xYOUQny52R139hlGJEQvlHzw/76qF/0ZcRGO1MT5TalPnuHY/IFMe81eBTb
         S9sKXFFDo2XzRl09BIZh+tOkXFS06NwLBsRMgIWSTc8ggPXDCTekbsw+ODUXPNPWrMUO
         Bs75iqyn3IOud/dPTUFjxRPdnZHjT90vghs4Ujzy66gYAE4tYB7Vo3KvDVOVPW3sDz4+
         2SHd2vXS8WvhbEfpqwzLxKYGk01J9or9gLfypRCls1WLrtoNo37rp+8zLLfDGRF6mYRA
         pNMA71j/TV0ALEjVtLAPk36MaN1CYpHbXYFMpCCfUoJwHSBaC0FNW+UNXAGP7GmhaQxS
         QldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HkbyZyJEQ/Ssvm6OUV8hiP66D8y0xk9KIRre5UDSbVs=;
        b=DMOpOU9qKEDm9gvYFaJmWR0ZpJHdSVYF05fnl/BkPl06fX2TJKuOlkbPWapZg7TeD5
         Nmj5w9QOz+93Ze7yMQVJq1C+W99amHYn/ryVcagR9kr8hZgFEu+TJyi12GRwRa/grvWH
         Kiq/eZKeSGtHVouHgabnTKPVG0mjHQ5s8RVfmc2m1QO3Ohqpv0Tt0cRElBFv3m5v5AUr
         SZbolYPp06QwBKfXolXT3nZp935aHN/gotsbd9s54kGegh7xdZR7VvWJgejp+sffVRTJ
         0DaDI+c6nLvbpqydbGiVM4fRnwgZbF5gJLPaphRA2WQBjzXi/dlirdWt8za2Q2hnCWGY
         qs9A==
X-Gm-Message-State: APjAAAWxCNPmfuyOi64CtU9tRksx6ZOgwO2gMaN8fHD/E5bAdrvQrdjh
        dWyBjGsYdephgLy/ajYELHc=
X-Google-Smtp-Source: APXvYqytpVgADNli32f+hrmvxVRseblYsJBXkimlV7OoBXU38EsQJxDIlR4XbAKqFEq7eId9aJ6roQ==
X-Received: by 2002:aa7:956d:: with SMTP id x13mr32889819pfq.132.1564334090984;
        Sun, 28 Jul 2019 10:14:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6sm59487040pga.72.2019.07.28.10.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 10:14:49 -0700 (PDT)
Date:   Sun, 28 Jul 2019 10:14:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Makefile: Globally enable fall-through warning
Message-ID: <20190728171448.GB29181@roeck-us.net>
References: <20190728135826.GA10262@roeck-us.net>
 <a0e789dd-5244-6af3-56c2-970b03d264a8@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0e789dd-5244-6af3-56c2-970b03d264a8@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Sun, Jul 28, 2019 at 11:42:28AM -0500, Gustavo A. R. Silva wrote:
> Hi Guenter,
> 
> On 7/28/19 8:58 AM, Guenter Roeck wrote:
> > On Thu, Jun 06, 2019 at 07:46:17PM -0500, Gustavo A. R. Silva wrote:
> >> Now that all the fall-through warnings have been addressed in the
> >> kernel, enable the fall-through warning globally.
> >>
> > 
> > Not really "all".
> > 
> > powerpc:85xx/sbc8548_defconfig:
> > 
> > arch/powerpc/kernel/align.c: In function ‘emulate_spe’:
> > arch/powerpc/kernel/align.c:178:8: error: this statement may fall through
> > 
> > Plus many more similar errors in the same file.
> > 
> > All sh builds:
> > 
> > arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> > arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> > 
> > Again, this is seen in several places.
> > 
> > mips:cavium_octeon_defconfig:
> > 
> > arch/mips/cavium-octeon/octeon-usb.c: In function 'dwc3_octeon_clocks_start':
> > include/linux/device.h:1499:2: error: this statement may fall through
> > 
> > None of those are from recent changes. And this is just from my small
> > subset of test builds.
> > 
> 
> Thank you for letting me know about this. I don't have access to build
> infrastructure like yours.
> 

I am always happy to run test builds on my infrastructure.

> My build infrastructure is similar to that of Linus.
> 
> But if you send me all of those I can create a patch and send it back
> to you to make sure what you see is addressed. If we can coordinate for
> this it'd be great for everybody. :)
> 

Just have a look at the output of https://kerneltests.org/builders/,
in the 'master' and/or 'next' column. There are many additional warnings
in 'next'. Only downside is that you won't see the warnings unless there
are also build errors, but -next tends to have lots of those.

Just wondering ... wouldn't it be possible to run a coccinelle script
to identify those problems automatically, without depending on compile
warnings ? Or smatch/sparse, maybe ?

Thanks,
Guenter
