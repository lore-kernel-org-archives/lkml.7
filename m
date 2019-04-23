Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB6C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8847A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556043781;
	bh=gtk6cJW3O1/O6x/j2ecHHClStItcbmry26/pT4Fy8VM=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=SediWqs4h+z5bAYVe8UDdy840BRXZTig8StE/6b1ma53aZ3ZyIj0f6GddpgZwTFfx
	 bfpzCdv+A2k6zg8JHGKk0HKezY5AxvT9WarQrl0CVq0ebarW76lvcg3Vlt9/zg9nSv
	 lbhZJSRw4zGb2OSQR/jPQsjH05IQlfwQj3xDMLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfDWSXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWSXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:23:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEADE208E4;
        Tue, 23 Apr 2019 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556043778;
        bh=gtk6cJW3O1/O6x/j2ecHHClStItcbmry26/pT4Fy8VM=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Gwc7dvzQe+22GYK5oBif2bBXMexIh1mCuP3sGydjDx/4jP71gRxhqb6iap9cfF0cJ
         d9NyHz8tJwLrT8U4iLs6oxfhTfv0PH5q7x1WzymBGDMcMa+6QqVZBw2NTYu1mgpHQX
         6TMvPhbJzKw/wGycx/hl0HRbQ5F55rprPbMfAHLM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190423180922.GA3463@roeck-us.net>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-10-sboyd@kernel.org> <20190423180922.GA3463@roeck-us.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 9/9] clk: fixed-factor: Let clk framework find parent
To:     Guenter Roeck <linux@roeck-us.net>
Message-ID: <155604377791.15276.4869998549466063176@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 11:22:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2019-04-23 11:09:22)
> Hi,
>=20
> On Fri, Apr 12, 2019 at 11:31:50AM -0700, Stephen Boyd wrote:
> > Convert this driver to a more modern way of specifying parents now that
> > we have a way to specify clk parents by DT index. This lets us nicely
> > avoid a problem where a parent clk name isn't know because the parent
> > clk hasn't been registered yet.
> >=20
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> This patch causes a substantial number of crashes of qemu boot tests in -=
next.
>=20
> Failed tests:=20
>         arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:versati=
le-pb:rootfs=20
>         arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:versatile-pb=
:initrd=20
>         arm:versatileab:versatile_defconfig:mem128:versatile-ab:initrd=20
>         arm:beagle:multi_v7_defconfig:sd:mem256:omap3-beagle:rootfs=20
>         arm:beaglexm:multi_v7_defconfig:sd:mem512:omap3-beagle-xm:rootfs =

>         arm:overo:multi_v7_defconfig:sd:mem256:omap3-overo-tobi:rootfs=20
>         arm:realview-pb-a8:realview_defconfig:realview_pb:mem512:arm-real=
view-pba8:initrd=20
>         arm:realview-pbx-a9:realview_defconfig:realview_pb:arm-realview-p=
bx-a9:initrd=20
>         arm:realview-eb:realview_defconfig:realview_eb:mem512:arm-realvie=
w-eb:initrd=20
>         arm:realview-eb-mpcore:realview_defconfig:realview_eb:mem512:arm-=
realview-eb-11mp-ctrevb:initrd=20
>         arm:integratorcp:integrator_defconfig:mem128:integratorcp:initrd =

>         arm:mps2-an385:mps2_defconfig:mps2-an385:initrd
>=20
> Most of the time the crash happens too early to generate a log,
> but here is one:
>=20
> [    0.000000] [<2100bd59>] (unwind_backtrace) from [<2100b11f>] (show_st=
ack+0xb/0xc)
> [    0.000000] [<2100b11f>] (show_stack) from [<211b2d27>] (Ldiv0_64+0x9/=
0x1a)
> [    0.000000] [<211b2d27>] (Ldiv0_64) from [<21038e87>] (clocks_calc_max=
_nsecs+0x1d/0x62)
> [    0.000000] [<21038e87>] (clocks_calc_max_nsecs) from [<21038fb1>] (__=
clocksource_update_freq_scale+0xe5/0x11c)
> [    0.000000] [<21038fb1>] (__clocksource_update_freq_scale) from [<2103=
8ff1>] (__clocksource_register_scale+0x9/0x40)
> [    0.000000] [<21038ff1>] (__clocksource_register_scale) from [<212a871=
3>] (mps2_timer_init+0xaf/0x29c)
> [    0.000000] [<212a8713>] (mps2_timer_init) from [<212a85b1>] (timer_pr=
obe+0x49/0x80)
> [    0.000000] [<212a85b1>] (timer_probe) from [<2129d639>] (start_kernel=
+0x1c5/0x2f4)
> [    0.000000] [<2129d639>] (start_kernel) from [<00000000>] (  (null))
> [    0.000000] clocksource: mps2-clksrc: mask: 0xffffffff max_cycles: 0x0=
, max_idle_ns: 0 ns
> [    0.000000] Division by zero in kernel.
>=20
> Reverting the crash fixes the problem. Bisect log attached.
>=20

Thanks for the report. This was bisected yesterday by kernelci.org (see
https://lkml.kernel.org/r/5cbe596c.1c69fb81.e252.b9d0@mx.google.com for
more details). Can you try the latest version of clk-next and see if it
fixes the early crashes? The one-liner patch I attached in that thread
should be all you need.

It would be even better for kernelci to find the offending patch like
you've done here and reply to the patch on the mailing list.

Finally, can you share your qemu recipe? I can pull it into my testing
and integration workflow so that this doesn't happen again.

