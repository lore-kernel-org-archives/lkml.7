Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3070BC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08817222C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqggzOeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgADALQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:11:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42711 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADALP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:11:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so38050660qtq.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gr54e9OrfkVOvNjzhIGsXOPty1HA7/3Mz6eV20dIdCY=;
        b=UqggzOeEKnBHtwqiZ1srv1D1UXWSqMiAvg+8cgzPCeQiA1HayjeS2lBPRpE4NtLMQK
         LJRYpXNgkQWXhGplBdxbQAEi3pQl+wBpkpSS/YYYZCWDAdcFU+Jcm96IjR5ThkclPeqK
         4b9DNPXquRH+UkH5WJV9vIX2QYRpfbqtDJq7Qx+ek4dOdtP0x2Ja+2mlrNPCYsINOqT9
         k8mDKX3uHtDS07c2Z3PhRQ0KBvL3cj4tuhal6bm+AQ7qRwCO7dluwsW/r9vqjK1y24Cf
         imOKDKQvaSG2ELmyGbzTkd64T6UWQD5+R3XuI9hhiGRXWEkt40wfAMAvxRha4jSMYtWO
         SoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gr54e9OrfkVOvNjzhIGsXOPty1HA7/3Mz6eV20dIdCY=;
        b=Ai1+AoZKp5gz1sqWJR50Yh99PX4dSL3qKKzcqsdtwo8DzXwkerZ7e0WwK8dDY+8PNk
         61VDOt1c36ZQpQ8OLQYKWYRep8Bo9PzQojmWAn5N56LTmyfCT2tEwU9pGrjCoyeR9+tm
         amzw6pZe1P0h0umz2duExzRzNe05kGOySGDAluZEuXk6L1g2rI6ohromDlkoZu3+m4OD
         31tRyjRy+NEKDdNX1Pj41V97sikaf4AMobq4zxsWCuXVjEyVG/SzN6X9azAKANVHTp82
         B202QZsFKwo+GjDM/s7qlkhcBc4FieOO5eG0cS+hjuKpDT62WktZY85gLfDh1bJvlVP1
         Hxrw==
X-Gm-Message-State: APjAAAUEqA/G6U6r255x6vcLRgvf8gvbiyYXjcy0x5n1wb+J4iXte4df
        qdBiXE/4Gw8xKuSQ5HxLnmA=
X-Google-Smtp-Source: APXvYqzMhNxOKRNndsp76ADDjHR7xjkTfoPuYCq/Juv9WtmQRSyU6A7hroH56pvXkagP4+E5oc2jpw==
X-Received: by 2002:ac8:7155:: with SMTP id h21mr62613940qtp.95.1578096674812;
        Fri, 03 Jan 2020 16:11:14 -0800 (PST)
Received: from localhost ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id j194sm17272507qke.83.2020.01.03.16.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:11:14 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:11:13 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lib/find_bit.c: uninline helper _find_next_bit()
Message-ID: <20200104000843.GA23653@yury-thinkpad>
References: <20200103202846.21616-1-yury.norov@gmail.com>
 <20200103202846.21616-3-yury.norov@gmail.com>
 <e76bdf736141d5a390e57f2bc8f6f6f9fbe574c1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76bdf736141d5a390e57f2bc8f6f6f9fbe574c1.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 01:46:07PM -0800, Joe Perches wrote:
> On Fri, 2020-01-03 at 12:28 -0800, Yury Norov wrote:
> > It saves 25% of .text for arm64, and more for BE architectures.
> 
> This seems a rather misleading code size reduction description.
> 
> Please detail the specific code sizes using "size lib/find_bit.o"
> before and after this change.

Before:
$ size lib/find_bit.o
   text    data     bss     dec     hex filename
   1012      56       0    1068     42c lib/find_bit.o

After:
$ size lib/find_bit.o
   text    data     bss     dec     hex filename
    776      56       0     832     340 lib/find_bit.o

> Also, _find_next_bit is used 3 times, perhaps any code size
> increase is appropriate given likely reduced run time.

Second patch of the series switches find_next_zero_bit_le()
and find_next_bit_le() to _find_next_bit(), so totally 5.
 
Yury
