Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C8DC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF1A21721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565974912;
	bh=kRQdySEFfbNhYV8BmidHDQ/rtgeMqFr1JW9v/ifI7XE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gQpO5yGKjegO5dSmL3irWnnLPvHtxGrfUbWNBCPaWqcREzmv6tyIa4mDJXsFjnhXH
	 6lGKe/u4SZuMknllQEYyOqM5Y0elzvBbSLIaX9ef/VuLGhXhmuPzdcqGhDZbHGMEL6
	 uLDi80ko0jZ0v/D7M/auu+gXvYkOeqC6OQ+aVvUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfHPRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHPRBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:01:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6772077C;
        Fri, 16 Aug 2019 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565974910;
        bh=kRQdySEFfbNhYV8BmidHDQ/rtgeMqFr1JW9v/ifI7XE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uuNsX+znuy1DGYakmALpmy1BjPJyfebQMKl5cBSg1KfNGFTK4JURmOCy6NOGLk/Pa
         6skHQhX+mLXaBjvLbzf7UA+lXmkjY0gzheppmOmslj5fbi0UwBo1UPOW7B3EnXL9ak
         0AQLcfUjw1WUbRc4bq6cyYukdgAcQj91AePbHmAE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816155806.22869-2-joel@jms.id.au>
References: <20190816155806.22869-1-joel@jms.id.au> <20190816155806.22869-2-joel@jms.id.au>
Subject: Re: [PATCH 1/2] clk: aspeed: Move structures to header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:01:49 -0700
Message-Id: <20190816170150.4E6772077C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-08-16 08:58:05)
> diff --git a/drivers/clk/clk-aspeed.h b/drivers/clk/clk-aspeed.h
> new file mode 100644
> index 000000000000..92d384367c25
> --- /dev/null
> +++ b/drivers/clk/clk-aspeed.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Structures used by ASPEED clock drivers
> + *
> + * Copyright 2019 IBM Corp.
> + */

Please include reset.h (or whatever defines reset_controller_dev),
clk-provider.h, kernel.h (for container_of and types), and forward
declare struct regmap and clk_div_table here.

> +
> +/**
> + * struct aspeed_gate_data - Aspeed gated clocks
