Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AC9C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D402921019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557278265;
	bh=xprzQNXnjgl0sRF9o5r/xzeUA1KdsH6ymcebTYGISB4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CavQ/1LPfyYqp/tvbKECLv3rVWA6IetQw/nruqlyh1mkEkEULH4DUDSNsf4UMql0/
	 N0WcTsciJbKQ/QwWka0scn9bw1zWdFCpH1iBnvnj+dq4foL+3HtR/V8w9ApbgaYw9j
	 JkAHt4xKsHZhvUE+uku5Z7LvaDZ5G/LG+bKyMmBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfEHBRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHBRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:17:43 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4956220656;
        Wed,  8 May 2019 01:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557278263;
        bh=xprzQNXnjgl0sRF9o5r/xzeUA1KdsH6ymcebTYGISB4=;
        h=From:To:Cc:Subject:Date:From;
        b=AHOQf7dBy/Ju9H9H2/XBl64k5L0GkH5hqk1CX2ZcfzlAoPJgeLUpXKwSU/FrNDvT5
         jq+zgAdBF+9bx/wB6zrt4p/4yo2cMHKH7lcILnjng2ZdjiQq7xxM6enZsRqJROJmrF
         ZILE4hrd4yz/x2CTiNM+IpUqb8oPO7gD/n1YlNdA=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 1/2] dt-bindings: cadence-quadspi: add options reset property
Date:   Tue,  7 May 2019 20:17:33 -0500
Message-Id: <20190508011734.14966-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QSPI module can have an optional reset signals that will hold the
module in a reset state.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index 4345c3a6f530..b6264323a03c 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -35,6 +35,8 @@ custom properties:
 		  (qspi_n_ss_out).
 - cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
                   and first bit transfer.
+- resets	: Must contain an entry for each entry in reset-names.
+		  See ../reset/reset.txt for details.
 
 Example:
 
@@ -50,6 +52,8 @@ Example:
 		cdns,fifo-depth = <128>;
 		cdns,fifo-width = <4>;
 		cdns,trigger-address = <0x00000000>;
+		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
+		reset-names = "qspi", "qspi-ocp";
 
 		flash0: n25q00@0 {
 			...
-- 
2.20.0

