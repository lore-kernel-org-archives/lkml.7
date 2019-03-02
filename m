Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF14C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A6020857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="K50d1HyP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HRCCY0W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfCBE3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:29:55 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57657 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbfCBE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B42E22101;
        Fri,  1 Mar 2019 23:29:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=bADvv49nXnLPt
        pW614Ubn0XGjHhOdyRTQa2gb7Gflf0=; b=K50d1HyPpvpTEjvzWX5dR1s0dSMJT
        LAlxolW8MyvZ52EOMPnd1Ya3L5d/VhuAPc/1KWaSrCuk5lDXvilCWjPUoiYWhIb0
        IrqweSGPcPUxVt8DcwcI2dQ4gWv7DUk3wHMqu5E7cdESQk2eq882V9PV916Jc58E
        NmxDLdoKlL0uVvwco1A6bXydp9BkyC7QxRS0h471sqeuL5ET0Ux8vXh7eAuj6Yiu
        3lQohhPg417zaGe/JJh5AIw7YN9giX/G4tX0n9JUFpuS/+vq+RNKTfDAdjKorrmk
        SRKdB268yPzdQjZthA9Kqejw0C8CQqu9Ez2VbWyKk/siC/JeClUcuufXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=bADvv49nXnLPtpW614Ubn0XGjHhOdyRTQa2gb7Gflf0=; b=HRCCY0W7
        Uym4gSN0f944OKlxytTMGQXKPJRkx8bIHe45yQVo4CmV6ileBE8jUCiXPb1LTK82
        4Ma4YdJ6j23+ZS3yBUT96lLIgaO1GjycPqT7eFtFbx97h+PRVMPD80BKoAyxAJJu
        7Y9f+ElHXEFrXgEVr6qzk6GBetvhnCJSoFy8bVYInI9TBP5TPQ9tqObPVfcylzQC
        +jQzI+mn/l/fZuqSS7uGU0DfoYOqXDeT4H/BoxMZtOqsXbBhuyibafnZYrXV3+9y
        4hl+gO0reh46oy0dGsoHegKVqNyjBW0yKxAS2JceFRtbVg3J1ebJqxf5M9n/cVQ6
        c3HFa106rfUh8A==
X-ME-Sender: <xms:wQZ6XCDgzddpLC1N8Z446tWGa7TCT_yHFYTZA62YBG7LE5JYvuFe9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wgZ6XMsjzmtv3DMr6lyeYz0m4snfv7va2F3ZQ1pimD_8Mqnbm6bu4A>
    <xmx:wgZ6XHbo60uwKnBBkubPjb41C-IVyRB_ujRDHwpZBkQ--3_eCFguWw>
    <xmx:wgZ6XPV72tBRstFhsziV_GusAJgHjNLkMrAZgm7gkIzLFcMZ3Rtgaw>
    <xmx:wgZ6XPHBKUnvAAoLJCJOdaxTPkjlwPKa8WGScS-6p-a_zAlzMkDQ2w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41B7210318;
        Fri,  1 Mar 2019 23:29:53 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 02/15] clk: sunxi-ng: Mark AR100 clocks as critical
Date:   Fri,  1 Mar 2019 22:29:38 -0600
Message-Id: <20190302042951.53671-3-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
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
index 27554eaf6929..4f822b598ade 100644
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
index 71feb7b24e8a..90b3530e2c18 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -50,7 +50,7 @@ static struct ccu_div ar100_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("ar100",
 						      ar100_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.19.2

