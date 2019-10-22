Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10475CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7DA21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571770312;
	bh=JLKY4p3jHs9fqd4jxmjrvPPbmVC1gbK3HhHdLaqS7us=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=XCFHAXpepic3/Ehwrbl23XPuZUckKNUArEUqme765F7PZWPgaAiuryBhbS5UC2Owt
	 p7FckliS7QNfS0C8LnZWqR0dIkT8L30K5T0Pv7QgZtMTFMv1wOPmbmcFRf6j+vWJYW
	 4iv7RYoC0N0bt/m6SppVRG7grcz5tVcrP+e4yfz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbfJVSvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732322AbfJVSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:51:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B09B20B7C;
        Tue, 22 Oct 2019 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571770310;
        bh=JLKY4p3jHs9fqd4jxmjrvPPbmVC1gbK3HhHdLaqS7us=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=LcUNPao93iqN1tG14CLpe1QxgcGEB4ySV+YwReDsToMIPy39TaU2mnTaoM4f/eOnM
         2I1hb9GB05J4u2Ty11jYwWrtPI4ERZWcaB3X3eu2c0CZDj6rsakZHc9qLeQBfyj0CT
         cbhTLUNjpXYjMo8gouX+mI/0E0BzWWaykWSvBRes=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191022071153.21118-1-kishon@ti.com>
References: <20191022071153.21118-1-kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: Fix memory leak in clk_unregister()
User-Agent: alot/0.8.1
Date:   Tue, 22 Oct 2019 11:51:49 -0700
Message-Id: <20191022185150.9B09B20B7C@mail.kernel.org>
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

Do you have some Fixes tag for this? Looks OK to me, but I wonder if we
should also assign hw->clk to NULL after unregister frees it. There are
probably other problems around unregistration and reference counting
that we haven't found so far so I'm worried this doesn't solve all the
problems by just freeing the clk pointer.

For example, anything referencing the clk pointer freed here will now
start trying to dereference freed memory. For most cases we've replaced
struct clk with struct clk_core in the clk framework so I hope this
pointer isn't used very much at all. A quick grep shows that it is
returned from clk_get_parent() and __clk_lookup(). We really need to
kill off __clk_lookup() and replace it with something else, and
clk_get_parent() needs to generate a different clk and have callers call
clk_put() on the returned pointer. Long story short I think this is OK!

