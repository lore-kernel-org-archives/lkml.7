Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397D7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FDB206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560439694;
	bh=z3Dn3El1yjq4ZvN1Ri3867ZpWWj2G37nsF3RYxODv08=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zJ6nDEahOkFlCRnAQdqoBSbV2DFthzMI7vqLEM83hGul5crt7cOyA5vblUZCKQUo5
	 xT9kH2AGHOKY4xDiISTiFIQWC28Tsf9TXMO5K6KbW2egMxdOs8jjh1ceI8W5IVbnqT
	 9K7VbWcgZNiWaEmf43c/dxBREx/gD5jYhBHTTQo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfFMP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfFMLbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:31:50 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC31208CA;
        Thu, 13 Jun 2019 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560425509;
        bh=z3Dn3El1yjq4ZvN1Ri3867ZpWWj2G37nsF3RYxODv08=;
        h=From:To:Cc:Subject:Date:From;
        b=GFYVhGQ3k33CajiXZk+jbxVz7EZ3Rz+ks8Pa5+6chQG+Btl/GPCbJoELkp/mAXOHi
         bTV8mobxXxFEM5yKFgRgfVZ9W05srC52Od/N7jzgg5NhmGqAZptmHahcxgCRTAMQyo
         0hF15okOvub9atx5RxaZDDDIDD8T8E426aBTEVWg=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv6 1/2] dt-bindings: cadence-quadspi: add options reset property
Date:   Thu, 13 Jun 2019 06:31:37 -0500
Message-Id: <20190613113138.8280-1-dinguyen@kernel.org>
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
v6: no change
v5: document reset-names
v4: no change
v3: created base on review comments
v2: did not exist
v1: did not exist
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index 4345c3a6f530..945be7d5b236 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -35,6 +35,9 @@ custom properties:
 		  (qspi_n_ss_out).
 - cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
                   and first bit transfer.
+- resets	: Must contain an entry for each entry in reset-names.
+		  See ../reset/reset.txt for details.
+- reset-names	: Must include either "qspi" and/or "qspi-ocp".
 
 Example:
 
@@ -50,6 +53,8 @@ Example:
 		cdns,fifo-depth = <128>;
 		cdns,fifo-width = <4>;
 		cdns,trigger-address = <0x00000000>;
+		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
+		reset-names = "qspi", "qspi-ocp";
 
 		flash0: n25q00@0 {
 			...
-- 
2.20.0

