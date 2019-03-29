Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE47C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54325218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O1+9x8z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfC2W6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:58:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52712 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfC2W6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:58:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so4084496wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AbYcJ8DH6nLuqJUtYFNn6epLSrCdfxCkTbk1Rsz2IkE=;
        b=O1+9x8z15LbHJIhGHnrXuH0mgSS7u6SUXyhCAJZS/5qsn/1pT31WszOjeLHbvPL0HQ
         fc3H95FB08kndVgvCKi8f5v4RFVV5vHtmk6Q+WDCd0Ukkxm1rmriXP8xKrTvdlrm6yIw
         eCdp3h+p9hfsrbAb/rb4kIo40gZjSOkj/TqwSN+RyCFiB6plL0l7m97e4VFiIEakchLI
         1RVH44NJDVZd2YxbjgsxzCx9J63fYYLgxm0pg1btYRx7pdY4VR1D+Ow1/9Q0TgxwK/4e
         FlNkGW+a46r2SlvrL/SDIgEuUMsjJ7XMZa5RKTLSLqysY0I3q0RY55QUja7kqNtaMV/l
         T6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AbYcJ8DH6nLuqJUtYFNn6epLSrCdfxCkTbk1Rsz2IkE=;
        b=l4kr6ZDgakheEq6Gqs6RukKKPGmEGhLfhdZzUZQvVTlP86CuINBhRHPglO7pklqLE0
         ZcuGEuy8ZoQg9CET5HUesHXXLnquCzzBlriGTnVpzk/ro7G6XzyNmiqiUZhh69FoAxS7
         /TcnYyM0K6c5JvbfNXJzin6vuQVTvVVwpV73q1/lSfKe67rmcMjxmW88Mz4DwXBKcze2
         l5OAxA4LJkFLOexz8+wuiAsYlASHGsFFmjc7rw0sbiyws8ljQeSsxDF4IpJJyH/0i2UF
         XKDCU6lG99vCwJ5CwtFDN9vUno/Iz6O2vxPRrMbDeXODXgG+ZGe9eeHaiqzEJmE4oyrS
         T8aQ==
X-Gm-Message-State: APjAAAU0EHd9TAm01Xcu7EftAh+Jo2YEeOXIMq4j1n4l5Hob45ydcK/A
        dt92ZkgbYameeyYr/Bo0lix1qw==
X-Google-Smtp-Source: APXvYqxh/CnUJ0IzIgJQ8XJFuV7DZQQxrck6TbKAen/kt4PLyG41r3KGuHKaKheF1cFEPxcaqbKGVg==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr5023420wme.54.1553900322601;
        Fri, 29 Mar 2019 15:58:42 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id r196sm3355854wmf.22.2019.03.29.15.58.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 29 Mar 2019 15:58:41 -0700 (PDT)
Message-ID: <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 23:58:39 +0100
In-Reply-To: <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com>
         <20190325111200.15940-2-jbrunet@baylibre.com>
         <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com>
         <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com>
         <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 15:14 -0700, Stephen Boyd wrote:
> > > We actively discourage using init callbacks. Can you do this some other
> > > way?
> > 
> > Yes I'm aware of that but init it the right place to do this.
> > To be clear, this is not initializing the clock to some particular rate, the
> > rate is preserved.
> > 
> > It just applies the necessary settings that needs to be done only once to make
> > sure the clock is in working order and that the rate calculated is actually
> > accurate. 
> 
> Ok, but can you do that in your driver's probe routine instead of
> attaching to the init callback? We want to get rid of "init" at some
> point so throwing the init sequence stuff into the driver probe around
> registration is a solution. Or we should think about not discouraging
> the init callback

Is is callback really a problem after all ?
I think we should actively prevent using it to set a particular rate.

Here, the goal is put the clock in working order. The bootloader does not
always do that for us. I could put this in controller driver, but I would have
to repeat the init pattern for each instance of the clock...not nice 
Using the callback clearly shows the relationship between the init and the
clock. I think it is a lot better.

In the same series, I have added some init for the controller. In this case
the init target a group of clocks, so having the init in the controller makes
sense for that



