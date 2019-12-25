Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF8DC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78F62072A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="Sawr3RJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLYJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 04:58:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39109 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLYJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 04:58:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so22543867lja.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 01:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BimAE/wzLaoJ+Q76OTXF2tSOsXH3zuFfkC4OKhHyt4M=;
        b=Sawr3RJ0XQ4kFSYodnBYQ2C4OYnmS+dTU+GADcUfRFioyeQiYpsoojrV+bcKjvKhkr
         l5dBEP+1n70Gzok8JpiiQwOAZWyZN7V5YQeRXeSuBekS2vKw4/Zxn14sGbGYe6g8nYqt
         v8l8Rn/pmzy+OZuKWPrGBBbT4tyAe4GXN5bOSWIZ1Za4RNOlmEOYKsaaEKrl1bOG+Cpr
         AjrHMzLWPRePRZi4XsrgxD7ngKSSbETAa8A/oQg+/iiIBaqXioTP5j1+JeYe86C6QXxb
         BcIECzCTzgUgS4BC9DngU5jnB78k7UkDKW4Xsynzc++yrPCVw6RiMO7Mlzhu3VsY/epv
         pDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BimAE/wzLaoJ+Q76OTXF2tSOsXH3zuFfkC4OKhHyt4M=;
        b=fbauhgWH7hdRGWLJqw60fyd+FeLckn8Rhnt7kDKSKjRbGuWYNPwfyxDHq9+NFGmjet
         kAeFXEHOux7f89eAGZ1VVakMtrJdhlNLb2HXWVq91/Sin+mZYs6pUcCLe5BmB1f9/ZCg
         O5tCIZLhRMJJkTszwGUY+avaNj+qaV9vroalYmcVkH2BST0ksWtp+K5H2p9orl8MyCJm
         pd/ZEUCFAv5IW4u+WxW4FP3XRZvsFltaG6hHcm0DOSvf5aLx8WwrVX5llrEP92QqvUNX
         FHbjzKdpKUJhs/U0eUrAI6ZksHBJJG6RkA8wOSvFMnRNm6ZwVQAxRPfmkSlqa1PFCVN9
         x5CQ==
X-Gm-Message-State: APjAAAXjhCOsxwMxF2Ip3rjPMycTjCUxxeFi1W6ywRT4wzsyTuFjJhPQ
        UzMmHfRKrR4WUiDFJ6gN+GwuLA==
X-Google-Smtp-Source: APXvYqyVCaK3RhWsqGk8ogHzgSadR0YNeuWFjHPQK3y6zRy7veQsw5x+SJ1Znlr403nf6FVtEcldXA==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr22412615ljg.149.1577267929007;
        Wed, 25 Dec 2019 01:58:49 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id t9sm11127171lfl.51.2019.12.25.01.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 01:58:48 -0800 (PST)
Message-ID: <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 25 Dec 2019 12:58:47 +0300
In-Reply-To: <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
References: <20191223040020.109570-1-yuchao0@huawei.com>
         <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-23 at 09:41 +0100, Geert Uytterhoeven wrote:
> Hi,
> 
> CC linux-fsdevel
> 
> On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> > As Geert Uytterhoeven reported:
> > 
> > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> > 
> > On some platforms, HZ can be less than 50, then unexpected 0
> > timeout
> > jiffies will be set in congestion_wait().
> > 


It looks like that HZ could have various value on diferent platforms.
So, why does it need to divide HZ on 50? Does it really necessary?
Could it be used HZ only without the division operation?

Thanks,
Viacheslav Dubeyko.


