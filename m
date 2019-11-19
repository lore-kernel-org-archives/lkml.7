Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B66C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAF5222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574201955;
	bh=MkBK4V4XJ2UbKTyAEVwQZfH84XS3fxTqTa5v36KtTOE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=AbeMk+8kJd0V0kdKdIC9WkRsOitMfsYNQvqeXROIrTTvdFMdWBSGrt3HWN0b+nquM
	 NopEFwRbNpcSe9SP8FmjYj+S29uYMWk3HYp+R+ZeqrU791OF0hzON0Psj/XAvutWwo
	 t76VIMsFpHdlRZNjw1stBZDAltknt8GUCOuUoZYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKSWTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfKSWTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:19:14 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4132E222DC;
        Tue, 19 Nov 2019 22:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574201953;
        bh=MkBK4V4XJ2UbKTyAEVwQZfH84XS3fxTqTa5v36KtTOE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a/X9tiGRlpiVsbV7s8hyDYCZeKjgCuZM2NXUrGuYaHGv5tf2Y1tMBy38zZr7G9ujy
         IOZS8IeANV25ii3/sxArbGG33XVHmnNJFPCGrLVFKZHfWLfbNE/mCaiOhCRmd9KN2Q
         S2iTOZvUM2sxM9EaWTgG8H6tMQsFCtLJEr4jEYyo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191022071153.21118-1-kishon@ti.com>
References: <20191022071153.21118-1-kishon@ti.com>
Subject: Re: [PATCH] clk: Fix memory leak in clk_unregister()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 14:19:12 -0800
Message-Id: <20191119221913.4132E222DC@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kishon Vijay Abraham I (2019-10-22 00:11:53)
> Memory allocated in alloc_clk() for 'struct clk' and
> 'const char *con_id' while invoking clk_register() is never freed
> in clk_unregister(), resulting in kmemleak showing the following
> backtrace.
>=20
>   backtrace:
>     [<00000000546f5dd0>] kmem_cache_alloc+0x18c/0x270
>     [<0000000073a32862>] alloc_clk+0x30/0x70
>     [<0000000082942480>] __clk_register+0xc8/0x760
>     [<000000005c859fca>] devm_clk_register+0x54/0xb0
>     [<00000000868834a8>] 0xffff800008c60950
>     [<00000000d5a80534>] platform_drv_probe+0x50/0xa0
>     [<000000001b3889fc>] really_probe+0x108/0x348
>     [<00000000953fa60a>] driver_probe_device+0x58/0x100
>     [<0000000008acc17c>] device_driver_attach+0x6c/0x90
>     [<0000000022813df3>] __driver_attach+0x84/0xc8
>     [<00000000448d5443>] bus_for_each_dev+0x74/0xc8
>     [<00000000294aa93f>] driver_attach+0x20/0x28
>     [<00000000e5e52626>] bus_add_driver+0x148/0x1f0
>     [<000000001de21efc>] driver_register+0x60/0x110
>     [<00000000af07c068>] __platform_driver_register+0x40/0x48
>     [<0000000060fa80ee>] 0xffff800008c66020
>=20
> Fix it here.
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

Applied to clk-next

I also added a fixes tag for the best I could guess.
