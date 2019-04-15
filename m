Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2943320825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDOFWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:22:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41845 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOFWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:22:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so11993955lfd.8;
        Sun, 14 Apr 2019 22:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wAcsf0wOxTH+Mt/WXogNO8tVzfvRlR57HDInWFiJx8=;
        b=G27v/5BqVLYlrGJBgqU/dXHMitDlrMpQ32fRYUWbHJWY1grUajgKXwHB/z8xAd4xVZ
         lSBGwGK4fiWxamuQV7rh/5P5k5XLxI3Hab+YbjgZrDdMY3gA79JFV/PHrGABKcjEW1Vr
         cjsuH8q4ZR539sXi7TS9jxfyHsF6roSGKiK2hzWFeItTBmum0T9yC0Al0f1yKPE3qfOm
         sm6LlPCEvrMMLP5x4mjgXTJtSY6n8MVzvu+j7dCDtDYEZVDq9P/2m3rJuAt1YmGkJBZ9
         ToNyg7s33mLqyjn6EtT/CxpZtWNEddzAJzob+3IXxF7OgZnSqeaZDULT8g+3HU+xDT7Y
         laZg==
X-Gm-Message-State: APjAAAUWzqftsNDW7C9dJ8NONZUmu6X7IureaGQFqjswsoC3siAGDCpr
        O7VGznoS+Avc3Q6ARA9HohI=
X-Google-Smtp-Source: APXvYqx0h4FkERuF1NmoVIJCeiBL3A3v8uDlfMCHKk3wx5Opn5sv/LYxHiRFqiN0vR1CvxA2FudPXg==
X-Received: by 2002:a19:3845:: with SMTP id d5mr4456759lfj.77.1555305742304;
        Sun, 14 Apr 2019 22:22:22 -0700 (PDT)
Received: from localhost.localdomain (dyttpvnw7fb6wy5z8v7dt-4.rev.dnainternet.fi. [2001:14bb:420:c8ae:5b20:7520:669c:8ec7])
        by smtp.gmail.com with ESMTPSA id c17sm2630765lfm.42.2019.04.14.22.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 22:22:21 -0700 (PDT)
Date:   Mon, 15 Apr 2019 08:22:14 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 1/9] clkdev: Hold clocks_mutex while iterating clocks
 list
Message-ID: <20190415052214.GA31948@localhost.localdomain>
References: <20190412183150.102131-1-sboyd@kernel.org>
 <20190412183150.102131-2-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412183150.102131-2-sboyd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:31:42AM -0700, Stephen Boyd wrote:
> We recently introduced a change to support devm clk lookups. That change
> introduced a code-path that used clk_find() without holding the
> 'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
> list and so we need to prevent the list from being modified at the same
> time. Do this by holding the mutex and checking to make sure it's held
> while iterating the list.
> 
> Note, we don't really care if the lookup is freed after we find it with
> clk_find() because we're just doing a pointer comparison, but if we did
> care we would need to keep holding the mutex while we dereference the
> clk_lookup pointer.
> 
> Fixes: 3eee6c7d119c ("clkdev: add managed clkdev lookup registration")
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
