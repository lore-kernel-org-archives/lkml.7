Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F2C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458CD20656
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eul0uJlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgADBGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:06:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34455 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgADBGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 20:06:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so38137892qtz.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 17:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hh5F5krN3LWZxGpDu/50qQGTG2uQZAPCOnhR4ARYHnA=;
        b=Eul0uJlQt6DICntdHemW6eGGFPZ/1VhFWlBwq3Uy3Rcnu9KsrS/Z1IDv0Hs2zXLJEo
         qPG+giGqitGky3rjRIQAOE34qlCurmV4Z24AGg92ADc+yR1neckfy0gMpG16Nh+md9Bn
         h2opUrSznOYgiNsaFhX9f6D6vtEi9TonRuuTTeVE1RrRmu6Swd3TPrxhdQHrOBUDDUCS
         8agRVX6mZjKRGYN263vcMCxmrnBt3x9a1dwxVUQ3hhsi+XsIJghPJTujYN+geMzQ1jbt
         NqqY496VxJ9xpH06FQWwziE1y96m0a0xCp24g4do4087que8eD4gZfbQO4IPGcAh1qHV
         pq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hh5F5krN3LWZxGpDu/50qQGTG2uQZAPCOnhR4ARYHnA=;
        b=hXIAoB67Hy6aP7Hkvzx9kheuCYPTCcopTCLQBUZsntOL6a0qEdVQyc5fz+jhIId8dW
         MnET1bwnA1O+vktB7vD/yC0+QZx+ed8544/va+3x3aG7kFRrvzyTpVLbjT3lFmrihTIh
         xrXivV7u+dYv86y8AgO7WxjcxxtOWBfP/lurihI6DIiAdoc8bX9spGbTzbLuYh5uVu8q
         kjUYizMr9L9AAl5VQHxun5uZX9Vqrc6uBiuRsubLbCOMmvP378jcHkf+f+8bMbviZM2g
         DlQE9UTOYgA5jKUQrGGGk+K5rx6fVgjkP72CmnlVJHsKHhZpDn8wenqI34DdQEo4kKl3
         HYSQ==
X-Gm-Message-State: APjAAAWYW84IJ8HhZYm/4RiAiSgYJy9nyPZ9v/WDcJ8u5InuGCYEprPX
        2n2J+KRLaR9vRQ36sXZf5W8=
X-Google-Smtp-Source: APXvYqxFJfgqzwZLGeNy/ZJ7uwLIZYqpJ5ReT8WcytV/ZU1T8cjzuwVWVKVSzG41OObvyaMPzwD4fA==
X-Received: by 2002:ac8:461a:: with SMTP id p26mr64146952qtn.317.1578099959734;
        Fri, 03 Jan 2020 17:05:59 -0800 (PST)
Received: from localhost ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id v67sm14733627qkh.46.2020.01.03.17.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:05:59 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:05:58 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lib/find_bit.c: uninline helper _find_next_bit()
Message-ID: <20200104010558.GA26661@yury-thinkpad>
References: <20200103202846.21616-1-yury.norov@gmail.com>
 <20200103202846.21616-3-yury.norov@gmail.com>
 <e76bdf736141d5a390e57f2bc8f6f6f9fbe574c1.camel@perches.com>
 <20200104000843.GA23653@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104000843.GA23653@yury-thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 04:08:43PM -0800, Yury Norov wrote:
> On Fri, Jan 03, 2020 at 01:46:07PM -0800, Joe Perches wrote:
> > On Fri, 2020-01-03 at 12:28 -0800, Yury Norov wrote:
> > > It saves 25% of .text for arm64, and more for BE architectures.
> > 
> > This seems a rather misleading code size reduction description.
> > 
> > Please detail the specific code sizes using "size lib/find_bit.o"
> > before and after this change.
> 
> Before:
> $ size lib/find_bit.o
>    text    data     bss     dec     hex filename
>    1012      56       0    1068     42c lib/find_bit.o
> 
> After:
> $ size lib/find_bit.o
>    text    data     bss     dec     hex filename
>     776      56       0     832     340 lib/find_bit.o
> 
> > Also, _find_next_bit is used 3 times, perhaps any code size
> > increase is appropriate given likely reduced run time.
> 
> Second patch of the series switches find_next_zero_bit_le()
> and find_next_bit_le() to _find_next_bit(), so totally 5.
>  
> Yury

> > perhaps any code size
> > increase is appropriate given likely reduced run time.

I have a benchmark for the find_bit functions upstream, however, it cannot
measure the overall performance degradation related to increased probability
of cache eviction.

When I originally wrote _find_next_bit() in 2014, it was simpler and had 2
users. Now there are 5 of them, and I think it's good time to stop inlining
_find_next_bit().

Yury
