Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC14C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9521670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bQErha4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfD3SnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:43:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45801 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:06 -0400
Received: by mail-io1-f67.google.com with SMTP id e8so13095982ioe.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DLjxUveV79/tHlmvW7ccnABKpIkFLlfeyoe8liucNic=;
        b=bQErha4EjiqJxeUe/P9SK3n/xxmcbiBLR5l5w1XVpEEBjl7QZYqpRj+9h9kxiG2rgK
         1VdF2h9RK9nLj84vXUfJiWNpLmEWovRidP1FT+DQ9cpWymF0fBCsO1BFVXPRn8n4RKxX
         F2T/FAff9rmIWgf/RoN/sbKtK9jZazHWSAE73Mx3uRcXKOAf3ryoZ3wC6ENAPmmJtn0Y
         wzVzOKZnRFsSboA44cwHYarKn0G1sU+ofNn0ibC77BPFE2wGvvXx2aWCrtAFVY5CgKI0
         uwEpJ3JRZMpFgw0Nob+qPPIuEJkkqfxaO917awDUuacRIbUwChHKMncdRXoSqZiH+maR
         jouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DLjxUveV79/tHlmvW7ccnABKpIkFLlfeyoe8liucNic=;
        b=SW/hFRZm9UcFGqeBmyxsvxItcWElzxJAjkl2bhwdtOrIY4pkEneR0/bTipP9To/DsQ
         AyDQN8taIEFrKDtT6/w9cSTpPWg5g2tGqY4dp81nFWQBioCG8xQh/RSfDzxp469CKgab
         XXZa0bjiSZhL/yLgKPK69/zAKJvqtOKupOLZdomdBMZ5kd7pY2FYWXU2gv5Pl+eTnu/t
         S7qIKgwGcbqwZu2PC2JtnEo683ar9G+5b3CbJbHEXCcT/OEtoaaqDT2XG2KPDiTolnBB
         NXYuq8t/s+QYz7JSz8lAiWhabv+Ue+quKPvQs3Iq/xeed5TlDkYUtYdBzP2PbC++ED1j
         tbUQ==
X-Gm-Message-State: APjAAAUYQmTBnToU5LXo6uVX0UZBx/EQ8j9odSik1rBnv6FMpmvPhaTp
        gCXluzMOxh/NNW6JhNABvY2ACw==
X-Google-Smtp-Source: APXvYqzGhGKQGPue8kK8kj48O6yd673gTEubxpzNdjb5TQdDGz6d5hXCIN+puIhxJSsx+8sbr+znfQ==
X-Received: by 2002:a6b:6004:: with SMTP id r4mr9495485iog.8.1556649785559;
        Tue, 30 Apr 2019 11:43:05 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id c7sm12214445ioc.63.2019.04.30.11.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 11:43:04 -0700 (PDT)
Date:   Tue, 30 Apr 2019 11:43:03 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Stephen Boyd <sboyd@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
In-Reply-To: <155664891171.168659.10903540623861208390@swboyd.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.9999.1904301142521.7063@viisi.sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <155632691100.168659.14460051101205812433@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904262031510.10713@viisi.sifive.com> <alpine.DEB.2.21.9999.1904291141340.7063@viisi.sifive.com>
 <155657878993.168659.6676692672888882237@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904292252120.7063@viisi.sifive.com> <155664891171.168659.10903540623861208390@swboyd.mtv.corp.google.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, Stephen Boyd wrote:

> Quoting Paul Walmsley (2019-04-29 22:57:15)
> > On Mon, 29 Apr 2019, Stephen Boyd wrote:
> > 
> > > Quoting Paul Walmsley (2019-04-29 12:42:07)
> > > > On Fri, 26 Apr 2019, Paul Walmsley wrote:
> > > > > On Fri, 26 Apr 2019, Stephen Boyd wrote:
> > > > > 
> > > > > > Quoting Paul Walmsley (2019-04-11 01:27:32)
> > > > > > > Add common library code for the Analog Bits Wide-Range PLL (WRPLL) IP
> > > > > > > block, as implemented in TSMC CLN28HPC.
> > > > > > 
> > > > > > I haven't deeply reviewed at all, but I already get two problems when
> > > > > > compile testing these patches. I can fix them up if nothing else needs
> > > > > > fixing.
> > > > > > 
> > > > > > drivers/clk/analogbits/wrpll-cln28hpc.c:165 __wrpll_calc_divq() warn: should 'target_rate << divq' be a 64 bit type?
> > > > > > drivers/clk/sifive/fu540-prci.c:214:16: error: return expression in void function
> > > > > 
> > > > > Hmm, that's odd.  I will definitely take a look and repost.
> > > > 
> > > > I'm not able to reproduce these problems.  The configs tried here were:
> > > > 
> > > > - 64-bit RISC-V defconfig w/ PRCI driver enabled (gcc 8.2.0 built with 
> > > >   crosstool-NG 1.24.0)
> > > > 
> > > > - 32-bit ARM defconfig w/ PRCI driver enabled (gcc 8.3.0 built with 
> > > >   crosstool-NG 1.24.0)
> > > > 
> > > > - 32-bit i386 defconfig w/ PRCI driver enabled (gcc 
> > > >   5.4.0-6ubuntu1~16.04.11)
> > > > 
> > > > Could you post the toolchain and kernel config you're using?
> > > > 
> > > 
> > > I'm running sparse and smatch too.
> > 
> > OK.  I was able to reproduce the __wrpll_calc_divq() warning.  It's been 
> > resolved in the upcoming revision.  
> > 
> > But I don't see the second error with either sparse or smatch.  (This is 
> > with sparse at commit 2b96cd804dc7 and smatch at commit f0092daff69d.)
> > 
> 
> Weird! The return in void function is pretty obvious though so please
> fix it regardless.

Done.

- Paul
