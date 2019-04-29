Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DF0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A9C215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gPhueT4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfD2TmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:42:10 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40243 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfD2TmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:42:09 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so939760itb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OfSXGm/ZOpE/A5OPPtROuilo3cIAMJykM1qQwH2z66U=;
        b=gPhueT4Rp4VegY21P3pKS9Ih/RR/nUEkk7jhKA1RfbY03ZnKHvyqL2Wk4lzdTDTHew
         xJvCjJt/zV14JZ8yo42NKhZo1GXXGsru7NvXarkjF84DA6TNMB0w/Seaco92ZgKmPQAp
         Wbmk1wofnz4d/0bHdBOMpivJ+knKJjh1QZ7Sblvpy6eEa9kQNKKbpWlvgzqushvBRdZT
         BChOhN2sliOuqFf7iD2f5CS7krUZ8wCqwo4bSX0iceJ8QK+Xyd80HiWowfUqUXWe5IYG
         EYZokboxA+1ZIybHhTM6idYhaLVjhpX7E7dKPr4P4x3DWqzMfOmYg5DxRkKClQzrKnhM
         F6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OfSXGm/ZOpE/A5OPPtROuilo3cIAMJykM1qQwH2z66U=;
        b=VNXbYPhkTOvTaJHxXslY8wXyEQWiECWqlbEHLhH4AeH18/GsA6DnGntTNFcFnNpzBK
         0euKQSBz+as0Hn0WHFhuPLwPIz1fAhgDTSSorftul1KNCsJEzddxkzRA5wGfgxXocoZm
         VptK0rhcmwWQpBgX4ygBA4GD3AxtlFEKhZ8jo1Y8wXmvzPYeYfQrZCfaQy1wGar2yLrr
         en76b3/wNd2MYad+eHS1XTfK/xN2N1cYpPucw3+lVuXfW5A/VNRSaqECj8EY1Hd5oTfI
         hNc67SSIW/AVXwKz4SKAR1SXxS01j9MSMSMmLQzl34LBBQqYRSdceN5mLZKfzXirfkRz
         nI6A==
X-Gm-Message-State: APjAAAUebAKZ+X/16nUNZaHVSx5ghypOt/V1Se/HiJpiv8cp6wgu1xSH
        Z/oV1TVHn1QjZzIaFIvBrFMskA==
X-Google-Smtp-Source: APXvYqyLjolJDasdvL/lXithdtFoxBopxLY0mM3Qb0W7s1HdM9MPrXYGgLBx7TSF2DI2OVcQaX56KA==
X-Received: by 2002:a24:4d85:: with SMTP id l127mr658460itb.53.1556566928783;
        Mon, 29 Apr 2019 12:42:08 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t24sm7949990ioc.1.2019.04.29.12.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 12:42:07 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:42:07 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Paul Walmsley <paul.walmsley@sifive.com>
cc:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
In-Reply-To: <alpine.DEB.2.21.9999.1904262031510.10713@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1904291141340.7063@viisi.sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <155632691100.168659.14460051101205812433@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904262031510.10713@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, 26 Apr 2019, Paul Walmsley wrote:

> On Fri, 26 Apr 2019, Stephen Boyd wrote:
> 
> > Quoting Paul Walmsley (2019-04-11 01:27:32)
> > > Add common library code for the Analog Bits Wide-Range PLL (WRPLL) IP
> > > block, as implemented in TSMC CLN28HPC.
> > 
> > I haven't deeply reviewed at all, but I already get two problems when
> > compile testing these patches. I can fix them up if nothing else needs
> > fixing.
> > 
> > drivers/clk/analogbits/wrpll-cln28hpc.c:165 __wrpll_calc_divq() warn: should 'target_rate << divq' be a 64 bit type?
> > drivers/clk/sifive/fu540-prci.c:214:16: error: return expression in void function
> 
> Hmm, that's odd.  I will definitely take a look and repost.

I'm not able to reproduce these problems.  The configs tried here were:

- 64-bit RISC-V defconfig w/ PRCI driver enabled (gcc 8.2.0 built with 
  crosstool-NG 1.24.0)

- 32-bit ARM defconfig w/ PRCI driver enabled (gcc 8.3.0 built with 
  crosstool-NG 1.24.0)

- 32-bit i386 defconfig w/ PRCI driver enabled (gcc 
  5.4.0-6ubuntu1~16.04.11)

Could you post the toolchain and kernel config you're using?


- Paul
