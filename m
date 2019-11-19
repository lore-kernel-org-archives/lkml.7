Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D0F20862
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141814;
	bh=HJKuEjihpRVj7ywHu4OgY4KZpDHLxi5jwLvtGXQc/Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aleUQFyhPJX0bKnwOwyOENTJ+zcjV1Y+m6EtEe67Po6rh6j4QK0YtnCYfekx9nNrP
	 IBirYgXuunSNSa08DugimFQWLmmVMT38XkuESZN+4KM+02EbX8Oq+f2J25KckJ5LFy
	 izwnqtXezxP/aRl9yH2SikDzzLvFYEfVJRKZUkW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfKSFgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbfKSFgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:36:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F6420862;
        Tue, 19 Nov 2019 05:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141804;
        bh=HJKuEjihpRVj7ywHu4OgY4KZpDHLxi5jwLvtGXQc/Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhC7XmxEoqrJwol2Bzfi4TZr2LgUi577uRV7xc3HB+5YkjAIdnOl1ivw0qwiqON95
         RY1nLeNZ1ntRCN5+3Qv2AVtpec4Kh9Kdv8Q4MHZJqcex3HM0uY5bOS2LRBXxQsyeDB
         hkeGxIPQisK75ChHBwfTW3BMqLPWezFnCbm4sBQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 269/422] of/unittest: Fix I2C bus unit-address error
Date:   Tue, 19 Nov 2019 06:17:46 +0100
Message-Id: <20191119051416.418643578@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 62287dce5d0ee207b6a09a0a1abd06b61cee1094 ]

dtc has new checks for I2C buses. Fix the warnings in unit-addresses in
the unittests.

drivers/of/unittest-data/testcases.dtb: Warning (i2c_bus_reg): /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest14/i2c@0/test-mux-dev: I2C bus unit address format error, expected "20"
drivers/of/unittest-data/overlay_15.dtb: Warning (i2c_bus_reg): /fragment@0/__overlay__/test-unittest15/i2c@0/test-mux-dev: I2C bus unit address format error, expected "20"

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest-data/overlay_15.dts     | 4 ++--
 drivers/of/unittest-data/tests-overlay.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest-data/overlay_15.dts b/drivers/of/unittest-data/overlay_15.dts
index b98f2514df4b3..5728490474f6b 100644
--- a/drivers/of/unittest-data/overlay_15.dts
+++ b/drivers/of/unittest-data/overlay_15.dts
@@ -20,8 +20,8 @@
 			#size-cells = <0>;
 			reg = <0>;
 
-			test-mux-dev {
-				reg = <32>;
+			test-mux-dev@20 {
+				reg = <0x20>;
 				compatible = "unittest-i2c-dev";
 				status = "okay";
 			};
diff --git a/drivers/of/unittest-data/tests-overlay.dtsi b/drivers/of/unittest-data/tests-overlay.dtsi
index 25cf397b8f6b6..4ea024d908ee2 100644
--- a/drivers/of/unittest-data/tests-overlay.dtsi
+++ b/drivers/of/unittest-data/tests-overlay.dtsi
@@ -103,8 +103,8 @@
 							#size-cells = <0>;
 							reg = <0>;
 
-							test-mux-dev {
-								reg = <32>;
+							test-mux-dev@20 {
+								reg = <0x20>;
 								compatible = "unittest-i2c-dev";
 								status = "okay";
 							};
-- 
2.20.1



