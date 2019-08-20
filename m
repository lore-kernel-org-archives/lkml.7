Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC1AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB1C22CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="jDjyJVXQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pn/xqiUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfHTDXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:49 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:45611 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728777AbfHTDXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F4FF3502;
        Mon, 19 Aug 2019 23:23:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=1bTgcqlsu9ruH
        8kJHnZDaejSO4xUiFvUU7vOgzOA59c=; b=jDjyJVXQnF5DMKdAcIhzmDTVBG/mJ
        cHYEVutQUlCboPOHk4AYtL3ZprsaaBx5k+OFrJ3gBXuSLu420AeB6XWpt5nqn4eD
        xSfiFljZgllymQr1Ea8nxmW6MhOv6QJbLOA+tQhBmDQMijBmqP0KD/p0pMr9BwjD
        w0mWSBRC5v6HApjPzYxjmVUXb98/h5jkQLlIMMteQgSFczmS9OghJyjlrLu4ipKo
        BWlbLokydlczb57M9L3lnGDfYOAn/2CZ8mBwdlMcBFsIAf7P/+GChjRxI72Ek2w5
        Qgjqh+yPTYQQjM7mmYEZgDhWmMOyUguVjMZyUqMY2u1wMwEIxJ1FMCg9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1bTgcqlsu9ruH8kJHnZDaejSO4xUiFvUU7vOgzOA59c=; b=Pn/xqiUR
        gvC/o7107tBCxiY5ujMNPkdkbTkY8KAk0lqgiKLfG4rslbEaGUSWTeNokk4iHgic
        oJh6tIBz3/QvXZUrbNQwulgvn1vpzA++97mMmzGreKge0hgb4EJD1qjnelviR+zP
        m8fH8s6+FCrCfRIBrW5xaVjbKR5ysjBIxZ7V/y77AlHhnWoITH6qsJ4DdfV41xLa
        f/x78UuVbMTp1lO9s2s/Bh5blkcPG00e422rDdvCDDgPhUYZc5mJj10OnP8KeVnJ
        s4898vajZ1jj1EZC9x2dJBOn1vJ8WgvHclWfJ431rI+w8mzNWzEvk+g0hoiCl239
        bS2khjVk6rhE5g==
X-ME-Sender: <xms:oGdbXYF8qFebC4h13liLssfXdgbzTsQnHLwaWJk19YvF2_bpigVNYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:oGdbXeSmEevUMGOlsJ_hy0T41Avoqga3lH5EnnKMAUzq4N1FX0NxGQ>
    <xmx:oGdbXdwEjvkeJF5hgMzvA7fnkJnmUfWENW1wG38ksxjUDRtvUO4cKw>
    <xmx:oGdbXSdI5ETRtMUK7JOEq8gXST2wowuKnX47mU4xqBAOJpBhVm43RQ>
    <xmx:oWdbXUho7ZSRdqMUvezImy5FEsjGvKvgG7uw7OUNEKG8MBR36e3suQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E193C80059;
        Mon, 19 Aug 2019 23:23:11 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 02/10] clk: sunxi-ng: Mark AR100 clocks as critical
Date:   Mon, 19 Aug 2019 22:23:03 -0500
Message-Id: <20190820032311.6506-3-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sun8i, sun9i, and sun50i SoCs, system suspend/resume support requires
firmware running on the AR100 coprocessor (the "SCP"). Such firmware can
provide additional features, such as thermal monitoring and poweron/off
support for boards without a PMIC.

Since the AR100 may be running critical firmware, even if Linux does not
know about it or directly interact with it (all requests may go through
an intermediary interface such as PSCI), Linux must not turn off its
clock.

At this time, such power management firmware only exists for the A64 and
H5 SoCs.  However, it makes sense to take care of all CCU drivers now
for consistency, and to ease the transition in the future once firmware
is ported to the other SoCs.

Leaving the clock running is safe even if no firmware is present, since
the AR100 stays in reset by default. In most cases, the AR100 clock is
kept enabled by Linux anyway, since it is the parent of all APB0 bus
peripherals. This change only prevents Linux from turning off the AR100
clock in the rare case that no peripherals are in use.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 45a1ed3fe674..adf907020951 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -45,7 +45,7 @@ static struct ccu_div ar100_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("ar100",
 						      ar100_r_apb2_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_IS_CRITICAL),
 	},
 };
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 4646fdc61053..feef4f750943 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -45,7 +45,7 @@ static struct ccu_div ar100_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("ar100",
 							   ar100_parents,
 							   &ccu_div_ops,
-							   0),
+							   CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.21.0

