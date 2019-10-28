Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B6DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E90214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/IpsRc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfJ1WtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:49:19 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38416 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1WtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:49:19 -0400
Received: by mail-wr1-f49.google.com with SMTP id v9so11592944wrq.5;
        Mon, 28 Oct 2019 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A2jEsBOs5Fgq1k1SUjS53cvLXGYRrdoo13cMo5AIHyk=;
        b=i/IpsRc5S8qtvd4Hd2Jajl2muQJLkQ9Z8YMjvk6JZSa68F2SqLABksVza3TMROQk1l
         /4QBiNY1iKt19N2BdTTsYSNeafJcDTRO2E4QtC+5aruM0hW4mtc5ftJT2S5L8GFlPVO6
         YKMW91bU1FKH8m7wjlo0qMRlZEa5yscXWnOT5TtkxhV6uvyZw6int+SGf31E8CCgtgK/
         +PnCW1FPhrNJnrlSQzaig+42FGFhZKigWWA1U5aJGoTzmzNKFNpQRyc3dJn4Eh6uVJle
         kVA2eUWPyplVvIfzyavyLQm4lpmFVVkZvdSAmIfbVaktYI6/5+jFr0jbVFruWSb1RxEh
         +Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A2jEsBOs5Fgq1k1SUjS53cvLXGYRrdoo13cMo5AIHyk=;
        b=DOrr8kb/MjohnRRbaqHcEszxolytGIe8Dgei8oQL1LUrA3Nff//Mxuf5qNwQxA0nBS
         xWxojUwDCOKhrHjhWThGDZTEr/kfdW8XkZGc/5YTIk5nWlSq0gyMC6zurDNAwoabSCXC
         U3l27oaFPvOs65VVKUg8CcEx7mvB9JTDFQ4NQTSFEhbfFJyXYrBHPyj/xaA21wELXaz+
         QMIa1AsxYTtH20yqWcBcPQ+12sCEP8ZnKHJZKXEl+ISnczRuO9PPgwD1K1rpFQ/9UAJk
         0+rqcdSAS847FnL6IxOra+VK9IsNCRrf1HaOWO7BWSLspaj4yPeekfr6KS0J8kUw/o/x
         ZxTA==
X-Gm-Message-State: APjAAAUld68BVZGsIO9kwDqZGaTytTsHKb6Y7shLIUpugWCzg05ViHpe
        x3Ky8nPzqOFpaLpa5JTXKaIA5eXI
X-Google-Smtp-Source: APXvYqxkisLhWG9uNXHLiB27lzGZOriN/QcZjrQazkEnS+bedp3Okzy6CzZwUI/6m/n3bBjwuOviOg==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr16228477wrp.56.1572302957156;
        Mon, 28 Oct 2019 15:49:17 -0700 (PDT)
Received: from desk.local ([2a02:a03f:40ac:ce00:6dcd:e18f:2cd1:7611])
        by smtp.gmail.com with ESMTPSA id u7sm14094078wre.59.2019.10.28.15.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 15:49:16 -0700 (PDT)
Date:   Mon, 28 Oct 2019 23:49:15 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: detecting misuse of of_get_property
Message-ID: <20191028224914.enpqjkcvbxyeexnl@desk.local>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:32:42PM +0100, Rasmus Villemoes wrote:
> Hi,
> 
> I just spent some time trying to convert some so far PPC-only drivers to
> be more generic. One of the things I had to do was convert stuff like
> 
>   u32 *val = of_get_property(np, "bla", NULL);
>   do_stuff_with(*val);
> 
> with
> 
>   of_property_read_u32(np, "bla", &val);
>   do_stuff_with(val);
> 
> (error checking omitted for simplicity). The problem is that
> of_get_property() just returns void*. When the property is just a
> string, there's no problem interpreting that as a char*. But when the
> property is a number of array of numbers, I'd like some way to flag
> casting it to u32* as an error - if you cast it to a (pointer to integer
> type wider than char), it must be to a __be32*. Is there some way
> sparse/smatch could help find such cases?

If I understand you correctly, you would need a kind of 'soft'
bitwise pointer?
I guess it shouldn't be too hard to add a new flag which would
allow cast of bitwise pointers to pointers to char/void (see
at end of evaluate.c:evaluate_cast()).

Note: casts from bitwise pointer to void* are already allowed.

-- Luc
