Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2931207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fC0cu19w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8zM9Bg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLCMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:36:49 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42125 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbfLCMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:36:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C07C76E64;
        Tue,  3 Dec 2019 07:36:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=8ZlgpTfN5GmTh
        4i624Rlcksvxj54ouDMeKXMopZs1XE=; b=fC0cu19wEM2nuuI5OlavXIp8itYWV
        MAH8uNjjus+ai8C9rm581qD0MGE1MQPfCpHT7k+Xx35iLwXZ2dPFcyj2R5QFVFVK
        r/J3HC1BEhFFf0RuQWMBX8XwNJO3uUhTs/RwIW1QjzrymgrvaUTbgXKLzqTJh2/1
        4FYbS+JLNj84ju6+5VJm/uAXF79suZDe0HAqQBct3qPeQ2T/9C5E0WH8Qea0/doi
        Su8LonezleqcHA7Y6DBaYeucKmUn/6YlAjgtN64z6KdQvRQpwf0gNBDPCMdTPyvj
        qKe7Z9bMdVUNknbT5aZPKfHUI9c5U2xMz8JZfbM4geoZAXOJ+IW1QFymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8ZlgpTfN5GmTh4i624Rlcksvxj54ouDMeKXMopZs1XE=; b=f8zM9Bg2
        5+XdexcX1HdP+Nc0MizFl6zEBAtqnyFjbCDVmk1mFsAHDEvAJgr1gQO2xuSfHJkn
        SivHEtnq1C3wfUzFk/e5r94KjpbN89eUNJhJui596uKZ4zR6e6DzLPRF+6ZoknZr
        aBD7x5basN5cFNZZx7WBM5TpfTDpNE3jrQFmXvGRrb5z7JJR6XJO/vLTwxxF+wKD
        UtaIvBpEnWvVsCK/Mdoona/hpli6E8EkIhMyXnHRpT1ghOlGw9mRCzJyMzHacDs+
        ndM7/f3Gnojt6yep89I7bdsY8EYbtWkDIXCwv5/W54AEU6PAeORXoqvrZ3IfBFPG
        SPx3C9uA3BqhFg==
X-ME-Sender: <xms:3lbmXXS06qAsIh1BD-aS17ZHpW-GEbJiEHKRu2oXaFu-aW0z7zRjfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppeduudekrddvuddurdelvddrudefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgeptd
X-ME-Proxy: <xmx:3lbmXXCTd7ecyAxMLtfyGT24QKHC1-5VqEBO9Mr-W6TJktoEgv5lIw>
    <xmx:3lbmXWKq7o7n15b5OIJLdTrvWZEtXvERoKNQrQAM0mPq52D1awf3HQ>
    <xmx:3lbmXaBq701cVdq9NzQP08T5sOdl2RqeYoADJt6NbxwzN1vp-neKxw>
    <xmx:3lbmXYx9LTKAIt-N3KHwH-c1NkSLOm35M-eWZyFJ3EVsEmSM2KYvSA>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id ABCD5306017A;
        Tue,  3 Dec 2019 07:36:42 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: ipmi: aspeed: Introduce a v2 binding for KCS
Date:   Tue,  3 Dec 2019 23:08:23 +1030
Message-Id: <3da2492c244962c27b21aad87bfa6bf74f568f1d.1575376664.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v2 binding utilises reg and renames some of the v1 properties.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt | 20 +++++---
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
index d98a9bf45d6c..76b180ebbde4 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
+++ b/Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
@@ -1,9 +1,10 @@
-* Aspeed KCS (Keyboard Controller Style) IPMI interface
+# Aspeed KCS (Keyboard Controller Style) IPMI interface
 
 The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
 (Baseboard Management Controllers) and the KCS interface can be
 used to perform in-band IPMI communication with their host.
 
+## v1
 Required properties:
 - compatible : should be one of
     "aspeed,ast2400-kcs-bmc"
@@ -12,14 +13,21 @@ Required properties:
 - kcs_chan : The LPC channel number in the controller
 - kcs_addr : The host CPU IO map address
 
+## v2
+Required properties:
+- compatible : should be one of
+    "aspeed,ast2400-kcs-bmc-v2"
+    "aspeed,ast2500-kcs-bmc-v2"
+- reg : The address and size of the IDR, ODR and STR registers
+- interrupts : interrupt generated by the controller
+- slave-reg : The host CPU IO map address
 
 Example:
 
-    kcs3: kcs3@0 {
-        compatible = "aspeed,ast2500-kcs-bmc";
-        reg = <0x0 0x80>;
+    kcs3: kcs@24 {
+        compatible = "aspeed,ast2500-kcs-bmc-v2";
+        reg = <0x24 0x1>, <0x30 0x1>, <0x3c 0x1>;
         interrupts = <8>;
-        kcs_chan = <3>;
-        kcs_addr = <0xCA2>;
+        slave-reg = <0xca2>;
         status = "okay";
     };
-- 
git-series 0.9.1
