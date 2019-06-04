Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777DBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BD923FF6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFDMWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:22:18 -0400
Received: from verein.lst.de ([213.95.11.211]:35756 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfFDMWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:22:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 29D6468B05; Tue,  4 Jun 2019 14:21:50 +0200 (CEST)
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Add anx6345 DP/eDP bridge for Olimex Teres-I
Message-Id: <20190604122150.29D6468B05@newverein.lst.de>
Date:   Tue,  4 Jun 2019 14:21:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ANX6345 LVTTL->eDP video bridge, driver with device tree bindings.


Changes from v1:

* fixed up copyright information. Most code changes are only moves and thus
  retain copyright and module ownership. Even the new analogix-anx6345.c originates
  from the old 1495-line analogix-anx78xx.c, with 306 insertions and 987 deletions
  (ignoring the trivial anx78xx -> anx6345 replacements) 306 new vs. 508 old...

* fixed all minor formatting issues brought up

* merged previously separate new analogix_dp_i2c module into existing analogix_dp

* split additional defines into a preparatory patch

* renamed the factored-out common functions anx_aux_* -> anx_dp_aux_*, because
  anx_...aux_transfer was exported globally. Besides, it is now GPL-only exported.

* moved chip ID read into a separate function.

* keep the chip powered after a successful probe.
  (There's a good chance that this is the only display during boot!)

* updated the binding document: LVTTL input is now required, only the output side
  description is optional.

 Laurent: I have also looked into the drm_panel_bridge infrastructure,
 but it's not that trivial to convert these drivers to it.

Changes from the respective previous versions:

* the reset polarity is corrected in DT and the driver;
  things should be clearer now.

* as requested, add a panel (the known innolux,n116bge) and connect
  the ports.

* renamed dvdd?? to *-supply to match the established scheme

* trivial update to the #include list, to make it compile in 5.2

	Torsten
