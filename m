Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B06CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2312C21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcjjzGQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfDWSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:09:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47015 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDWSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:09:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so7874704pfj.13;
        Tue, 23 Apr 2019 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ERw7NIJ+ptMNrBfiUwed7OyDh+IrMNglMGWQyOspveQ=;
        b=HcjjzGQxXXW1iLkBwtizoPqkaXig7FEz0+2F7CsuGMkVlVBqyHP6DYQ4Ve7679pnBg
         hVSxzlbzVPQOklrpGVVdUl3+3dyBBLSu0uXof9y4DMDdZnxTCDP//56i5wUPPZxzImpK
         YszRJChexlt/x4rriDO3CCsYArAwwIcYadwGUFi9WRyrO4Yy/GqGx3tZvgqGtUPvUVvC
         6leG80F+VWZffZYpwsLI6WBMZxHxIi6YrYAuBMskszl1RIXBm3mHXPOHfPOswz4VNkYg
         SE8lYRR4kZK0TB3J05Cx9A1Ljfdycj/jP9VrnWPcgLaQ3Gd/GQNGmnP/qiOcj4K/hqn7
         yovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERw7NIJ+ptMNrBfiUwed7OyDh+IrMNglMGWQyOspveQ=;
        b=h+E8NBr/n0klu4Au5Zu2Tde/Day+Wktfbb76lFqLqLLCzOVxR48Vtge5CAMgXY36Q6
         oV7iwLMuKJMIHAosrozl+aVRc6dW9VKeK6/tvUQp/jlnvGkjLG8wqUpC3ph6Ic9AOftT
         Tzl3QL0bUnLfMoe1qGIKuMHT3kOWZsobUDKRJiDWsFeRxB7UW2huEjk93/hBunQduTKC
         NV3Gz8ltURhcBlsul6q/eo4O5q2e7e3fPbv02cfLgk8toWVvWIKG0cydxPRki4UbKQVf
         PDHebwvg4mid6bj09fGJZYs48WZLITF+hg5M3/gVoQscAVw3zrYYfk7HBhSo0Q+Ckhi+
         MuRA==
X-Gm-Message-State: APjAAAVSQp+/x+yl676HsZ2L1ZsTqbvK+pd3/vee5GPcqcSc89iO0Qvw
        5gDpNSaqiVHW4HVf8Q03gw4=
X-Google-Smtp-Source: APXvYqz7gWJsr/rL5moA9A4F68kPx/UbmKsT14/WNMuNFm7Rx4L5/AB6pqUlXF9OwXXfP3w+ElMOrA==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr25608816pgh.86.1556042966767;
        Tue, 23 Apr 2019 11:09:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p26sm37442451pfa.49.2019.04.23.11.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 11:09:25 -0700 (PDT)
Date:   Tue, 23 Apr 2019 11:09:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 9/9] clk: fixed-factor: Let clk framework find parent
Message-ID: <20190423180922.GA3463@roeck-us.net>
References: <20190412183150.102131-1-sboyd@kernel.org>
 <20190412183150.102131-10-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412183150.102131-10-sboyd@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 12, 2019 at 11:31:50AM -0700, Stephen Boyd wrote:
> Convert this driver to a more modern way of specifying parents now that
> we have a way to specify clk parents by DT index. This lets us nicely
> avoid a problem where a parent clk name isn't know because the parent
> clk hasn't been registered yet.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

This patch causes a substantial number of crashes of qemu boot tests in -next.

Failed tests: 
	arm:versatilepb:versatile_defconfig:aeabi:pci:scsi:mem128:versatile-pb:rootfs 
	arm:versatilepb:versatile_defconfig:aeabi:pci:mem128:versatile-pb:initrd 
	arm:versatileab:versatile_defconfig:mem128:versatile-ab:initrd 
	arm:beagle:multi_v7_defconfig:sd:mem256:omap3-beagle:rootfs 
	arm:beaglexm:multi_v7_defconfig:sd:mem512:omap3-beagle-xm:rootfs 
	arm:overo:multi_v7_defconfig:sd:mem256:omap3-overo-tobi:rootfs 
	arm:realview-pb-a8:realview_defconfig:realview_pb:mem512:arm-realview-pba8:initrd 
	arm:realview-pbx-a9:realview_defconfig:realview_pb:arm-realview-pbx-a9:initrd 
	arm:realview-eb:realview_defconfig:realview_eb:mem512:arm-realview-eb:initrd 
	arm:realview-eb-mpcore:realview_defconfig:realview_eb:mem512:arm-realview-eb-11mp-ctrevb:initrd 
	arm:integratorcp:integrator_defconfig:mem128:integratorcp:initrd 
	arm:mps2-an385:mps2_defconfig:mps2-an385:initrd

Most of the time the crash happens too early to generate a log,
but here is one:

[    0.000000] [<2100bd59>] (unwind_backtrace) from [<2100b11f>] (show_stack+0xb/0xc)
[    0.000000] [<2100b11f>] (show_stack) from [<211b2d27>] (Ldiv0_64+0x9/0x1a)
[    0.000000] [<211b2d27>] (Ldiv0_64) from [<21038e87>] (clocks_calc_max_nsecs+0x1d/0x62)
[    0.000000] [<21038e87>] (clocks_calc_max_nsecs) from [<21038fb1>] (__clocksource_update_freq_scale+0xe5/0x11c)
[    0.000000] [<21038fb1>] (__clocksource_update_freq_scale) from [<21038ff1>] (__clocksource_register_scale+0x9/0x40)
[    0.000000] [<21038ff1>] (__clocksource_register_scale) from [<212a8713>] (mps2_timer_init+0xaf/0x29c)
[    0.000000] [<212a8713>] (mps2_timer_init) from [<212a85b1>] (timer_probe+0x49/0x80)
[    0.000000] [<212a85b1>] (timer_probe) from [<2129d639>] (start_kernel+0x1c5/0x2f4)
[    0.000000] [<2129d639>] (start_kernel) from [<00000000>] (  (null))
[    0.000000] clocksource: mps2-clksrc: mask: 0xffffffff max_cycles: 0x0, max_idle_ns: 0 ns
[    0.000000] Division by zero in kernel.

Reverting the crash fixes the problem. Bisect log attached.

Guenter

---
# bad: [76c938fcaa4b4a5d8f05fa907925d5043834964e] Add linux-next specific files for 20190423
# good: [085b7755808aa11f78ab9377257e1dad2e6fa4bb] Linux 5.1-rc6
git bisect start 'HEAD' 'v5.1-rc6'
# bad: [ed04f675fa2c22316d7b57bea1258a18a47537ea] Merge remote-tracking branch 'crypto/master'
git bisect bad ed04f675fa2c22316d7b57bea1258a18a47537ea
# bad: [f66d30ddc658fb37848e8e6297b1e658fa297e79] Merge remote-tracking branch 'hid/for-next'
git bisect bad f66d30ddc658fb37848e8e6297b1e658fa297e79
# good: [24523334fd0feef03f3dc42487c158c233455676] Merge remote-tracking branch 'tegra/for-next'
git bisect good 24523334fd0feef03f3dc42487c158c233455676
# bad: [4d5d5f95d0ef4ba470287a941d06600889760ab7] Merge remote-tracking branch 'btrfs-kdave/for-next'
git bisect bad 4d5d5f95d0ef4ba470287a941d06600889760ab7
# bad: [c8040e3c8ab0870b3dfa502cc931258fc04709c6] Merge remote-tracking branch 's390/features'
git bisect bad c8040e3c8ab0870b3dfa502cc931258fc04709c6
# bad: [4209fc3374cfa572aa2defb8ecafe94a9db3c7d4] Merge remote-tracking branch 'csky/linux-next'
git bisect bad 4209fc3374cfa572aa2defb8ecafe94a9db3c7d4
# good: [21eb35a1ae4db08d32e2b5a8d9fe476c16056511] Merge commit 'tags/clk-fixes-for-linus^0' into clk-next
git bisect good 21eb35a1ae4db08d32e2b5a8d9fe476c16056511
# good: [3f644cdb2351fe21cded6ee1e5c13ea7905c3a64] Merge branch 'clk-zynq' into clk-next
git bisect good 3f644cdb2351fe21cded6ee1e5c13ea7905c3a64
# bad: [0db9597d81d918605d4d36c87ab140228fe14150] Merge remote-tracking branch 'clk-samsung/for-next'
git bisect bad 0db9597d81d918605d4d36c87ab140228fe14150
# bad: [e04cb6e358cbcdce56cda317725131252ecf6ccd] Merge branch 'clk-parent-rewrite-1' into clk-next
git bisect bad e04cb6e358cbcdce56cda317725131252ecf6ccd
# good: [89a5ddcc799d5d7dbcf6197b79dafc1dc9f997f5] clk: Add of_clk_hw_register() API for early clk drivers
git bisect good 89a5ddcc799d5d7dbcf6197b79dafc1dc9f997f5
# good: [dde4eff47c82c52a72af333d9e55370eee6d95d6] clk: Look for parents with clkdev based clk_lookups
git bisect good dde4eff47c82c52a72af333d9e55370eee6d95d6
# bad: [ecbf3f1795fda56122632c1d024cfd0d3f4fe353] clk: fixed-factor: Let clk framework find parent
git bisect bad ecbf3f1795fda56122632c1d024cfd0d3f4fe353
# good: [601b6e93304a65f8f7c37168763ab9ba5b195ce5] clk: Allow parents to be specified via clkspec index
git bisect good 601b6e93304a65f8f7c37168763ab9ba5b195ce5
# first bad commit: [ecbf3f1795fda56122632c1d024cfd0d3f4fe353] clk: fixed-factor: Let clk framework find parent

