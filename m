Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0552FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DA820857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TJeYQcGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TskFMf6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfCBEaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:21 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57233 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728106AbfCBEaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:30:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AF9EE22155;
        Fri,  1 Mar 2019 23:30:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XJA11nR7CLJ9T
        4EliiutwRMHPS8CdG6OgOIvQtL5T+o=; b=TJeYQcGkao3E926Sdw2Biek9x9q6M
        OBtPb/T6zM0bBmIPF1zrcQYQY2lTwXsXPj0SC1o774UDTU6fIKJB/yTW9BaG70QY
        G+ydk6/qT/f97Yuf4P6tQVuLlFGFGsEzpkz81Io49iVNNcF0ZxXkkRAF5wvdpWKW
        3++skSnDE2u2Btfk1Q4Pp+tGjiqCK3gZWkARvNUTOavwthsufDyAXEwQX/Y1wFLK
        t8s3KgQHgopzbSbFV2sPFDm80Kg2n/1UQKDYdGuX0Ac9qonixDWCm0GlNos2hnUh
        EfCh4TB59B8lpnVMjPVjy0xy5UiNQrrq+WwLsNdqIWlG1snzuuq+j8p4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=XJA11nR7CLJ9T4EliiutwRMHPS8CdG6OgOIvQtL5T+o=; b=TskFMf6f
        tr7CsuVpin2sheE2LaqMUMTBxjVDGkLCqy4JU6hoLXxvUKoMAsHkClGqPEMNCAbe
        uDFOwJyoSBBIZAvsDDXpHimLW5Kug8FouMjyUGfZ3q5b9qTkrh6Ty/YIYnhCq5VA
        GneIIHp1jtx5p8DoVeuD/UZ4rote2gH3/+aCeoHYDS+ouLdciVCVRJ4imtXoveWE
        Sw54B3AtwoMqnTqAMguTdKpK6hIxkSnIa218lFWLJOsbWnAFk0Em2Sxzv7eJmIvA
        r1rq+XPG4f3UJb7sttJc36ocyJ/1+aJR4XSoYs7CYAYXpcZTVu67EQtFa0ZABK6s
        UUCdtTM3vzqjaA==
X-ME-Sender: <xms:yQZ6XLAda1d3Q-kmtg1QBdEUNXKa39vNd5eueiCQMLYa95vqTnv_zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:yQZ6XL_RID3TCSQCVLTgzqsMDgH7CtY3jvr1JBQxfLL1h2Oxm31S1Q>
    <xmx:yQZ6XOFm6dPVht1gFmM4o3sprtHQCtruI0kD6AunUMPfCTdcNHSLwA>
    <xmx:yQZ6XFQVK1-lG6ZA0OJjFost0MFkt_I0sZtCsBYIyC_cPyK8KdV44A>
    <xmx:yQZ6XCFjDnzx3Wardj8-3mR7FUpNEAp_XMbPM2y_rr8bzwN2geK0pQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB28510312;
        Fri,  1 Mar 2019 23:30:00 -0500 (EST)
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
Subject: [PATCH v3 15/15] [NOT FOR MERGE] arm64: dts: allwinner: a64: Remove unused r_intc
Date:   Fri,  1 Mar 2019 22:29:51 -0600
Message-Id: <20190302042951.53671-16-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that r_intc is no longer used directly by Linux, it can be removed
from the SoC device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 63e33215dea0..163ee3576329 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -989,15 +989,6 @@
 			#clock-cells = <1>;
 		};
 
-		r_intc: interrupt-controller@1f00c00 {
-			compatible = "allwinner,sun50i-a64-r-intc",
-				     "allwinner,sun6i-a31-r-intc";
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			reg = <0x01f00c00 0x400>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun50i-a64-r-ccu";
 			reg = <0x01f01400 0x100>;
-- 
2.19.2

