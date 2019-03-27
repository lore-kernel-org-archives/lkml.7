Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339CFC10F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF98B21773
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="CaEjIReK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfC0KlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:41:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32902 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbfC0KlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:41:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so17948772wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qFkdipLvAOzvp9UX1M13KrLvA0RZOI2Li6BJyQGxx8=;
        b=CaEjIReK4LdueeY8+JKyiQ3LvD/lKcEixeubAMzvY0PIidQaKn7zVkywg1gL7Qh0/k
         23G8XggogdYa5nwL8nD+RZ3kKFeRt+p5AwapQgfGzDC9YP+z3/HRFXC0/RUeEDTM0wkh
         catYbqdC6F5we8CnKtZFrHEUsmWwNhHkorRo8TvvNzjqu5WK4SXZi6qRjgD8fT8fBv9w
         Ce2SdO/fUPJb2V7I8Gwkv4yxgY1N6LI0/Kug0fKZG84Pszkj8mHFdvRSdtYLsAJiswJZ
         Pk5detIuhNCQC4oI0vAtZ/rK9w5a+oT8SC/x3UG/hOB4xZs9RmaENWhknBjp+zoN/bt3
         e9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qFkdipLvAOzvp9UX1M13KrLvA0RZOI2Li6BJyQGxx8=;
        b=C/VOkPr11v2LIV5nPTj2HW/WUSb2xP5Hs77OwWH1wjaBvZmHD7Tq5olabgELAOCZYB
         7N3KUQ/tOh/LQtjSieCJjDi1ReDti6WQxfkxEWWuL0/ctzMmPsOucyuZoZv4g5iCJ+Ee
         nqASByVm0IxJO0JJi5mrlqcCtm6lnIYDZqlgAbMu1o7PrsBWrtO8aKTl0cP32lwwXXRT
         Ebe7iYCmKOSE5zS+kkLCUFINOyXtBlcoPKjBMD/ObaYdMA0TLliJCaTi2LyaSzXS+bsv
         1uI0vsCOhl0QwH9IUn0m9+ynZB+w1K+TA8bt9sk+s5htXuH9ZOR9g9K+D9Sogdsm61mv
         18mw==
X-Gm-Message-State: APjAAAW0u07RgV2tFAOfXmfnwPvCRuafg5eKBEH6yynUKVbpQ/DWxgDa
        sqEGyEOSY41xco1uptaYC8z43w==
X-Google-Smtp-Source: APXvYqyL9b7PHdEbkiwkqTAyXJ8nmMW4TJ6DEA495funXK9wR2EPVthhbDpw2qdShO3srjpRbolLZQ==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr23543509wrp.241.1553683274916;
        Wed, 27 Mar 2019 03:41:14 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id 132sm41410250wmd.27.2019.03.27.03.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:41:14 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:41:13 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/22] ethtool: support for netlink
 notifications
Message-ID: <20190327104113.GF6979@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <3578e5f334acf11b84e75d0ee41c072340a7b085.1553532199.git.mkubecek@suse.cz>
 <20190326163400.GC4958@nanopsycho.orion>
 <20190326181720.GO26076@unicorn.suse.cz>
 <20190327093843.GB6979@nanopsycho>
 <20190327095148.GE15396@lunn.ch>
 <20190327100441.GE6979@nanopsycho>
 <20190327101628.GG15396@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327101628.GG15396@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 11:16:28AM CET, andrew@lunn.ch wrote:
>> Wait, what do you mean be "kill the machine dead"?
>
>panic()

I see panic only in net/ipv4/tcp_metrics.c.


>
>	Andrew
