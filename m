Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBDC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1099A20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="U19Yy44d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0UzCjnkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfCBEaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57233 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728072AbfCBEaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:30:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E24F22148;
        Fri,  1 Mar 2019 23:29:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=jYp+ycn1UzPzl
        xBONZFtfT7KW34dUxVmR4eWWrPmRKU=; b=U19Yy44dJkZznMu5F6hMcIJ++5yEE
        NK4Vpp5Y/rXdz0caYJ39xBuCinDBPy8UTTwD6xvaswTyxmpsSwwq0ySjp6z7CBGO
        NjHV4Z+xNTaUjiaxDmspdl6VOWnuMbDL3ILmqtQKoxd1BoMcAyjObtZvpkQqDjm1
        T5G5l8kQYh1RB9X7LlghNyr/zOJ9IZWESSk2wxLy4JbMkEe+Jd1a/JVETGb7kJjm
        P6itnsgAfp8mPdHfNMwuFsQaZbkyko+pxQwD8lBWtXjRs2SQi9Q3CHjZQmfLeILm
        zq/h6fYchaiXpzYMHRnwjRXbutE+BBnKg+7jz+eEYPZiCprRfJmOj/pAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jYp+ycn1UzPzlxBONZFtfT7KW34dUxVmR4eWWrPmRKU=; b=0UzCjnkN
        eBMSp5r4qrY+EsHy+mr1idD+e7JMm46fjGxl7FsXv5qthRbG/VxoHAcNGeTHUuTN
        YzliprCS/rTFCHdOXjKlsyaMKAsy6HDZj/n7PG2O4e+9JUnj6iVJXFvua5lstfG6
        fgLs3Pwc/OYcnlAVINO2iqPd/PJSsVlFBqGDCVQGfsaAlzhDLwRLMvbDa93cPvy5
        aJwYp+GXuIp8bkSa56r+6Uf+HyaJmQa0DFnkxcMWa0bBeGTUi+c8/WJY3GUO2Oba
        rcxpaxCk3D+unfhGwoJVfTN88J9H1UGm63vmJPzYkfPYPir66330pAt6O0DMG9BU
        BgvgfGBW0fR6dA==
X-ME-Sender: <xms:xwZ6XGpG013EGgkBBIy2GFEPjqFl4Z_TXFDPIcSCH1Y04bgG7iD26A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:xwZ6XFZAY9ugVlTcMv1ZQ5D3h7QfXS2n39uUmDlkFJ1wnhMTaZ_uzw>
    <xmx:xwZ6XEHYHKbI8wSuLDiEkEWUhXGEHfo9hTFAHDOFuV4-8blP2vYSVg>
    <xmx:xwZ6XNwPHaS4BDxUpTrr3KEr1OqfDBg7Lwa7CTE-d_JbdBv6VVcfsQ>
    <xmx:xwZ6XGK_2ii0HsMhMqHhFyEejuy8MIIbid0OQMr-5ZmM_WJdYFiumQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 730B910312;
        Fri,  1 Mar 2019 23:29:58 -0500 (EST)
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
Subject: [PATCH v3 11/15] [NOT FOR MERGE] dt-bindings: Add a binding for a mailbox-backed interrupt controller
Date:   Fri,  1 Mar 2019 22:29:47 -0600
Message-Id: <20190302042951.53671-12-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a somewhat generic binding for an interrupt controller/forwarder
implemented in firmware and communicated with using a mailbox.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../interrupt-controller/mbox-intc.txt        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt
new file mode 100644
index 000000000000..a0eb7904ca83
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt
@@ -0,0 +1,33 @@
+Mailbox-backed Interrupt Controller
+===================================
+
+This binding represents an interrupt controller implemented in firmware,
+that uses a mailbox channel to signal and acknowledge interrupts.
+
+Device Node:
+============
+
+Required properties:
+--------------------
+- compatible:		Must be one of the following strings:
+			- allwinner,sunxi-msgbox-intc
+- interrupt-controller:	Signifies that this node is an interrupt controller.
+- #interrupt-cells:	Must be 1.
+- mboxes:		phandle for the mailbox controller and channel
+			specifier. If the mailbox controller has unidirectional
+			channels, two entries are required (see below).
+- mbox-names:		Only required for unidirectional mailbox channels. In
+			that case, it must contain the strings "tx" and "rx"
+			(where "tx" and "rx" are from Linux's perspective, not
+			the direction the interrupts are traveling).
+
+Example:
+--------
+
+	msgbox_intc: interrupt-controller {
+		compatible = "allwinner,sunxi-msgbox-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		mboxes = <&msgbox 6>, <&msgbox 7>;
+		mbox-names = "tx", "rx";
+	};
-- 
2.19.2

