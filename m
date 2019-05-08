Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA40D21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557323033;
	bh=XrfOkBwkQE73zyZSkSTLIh9IBVtJ+5CvdEGAlS+U8uc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qtXrnPEHIXLxcofEoi7ReQZB0AbFleAUcyhwEoT9fFVQXwmxzJYIBiSXTJhi3+20u
	 jEGBOXd1E3QnLrc/mt+fuq3o6RsZxQ5iGp0f+nmIjm17D66KrcNZL9IY+3o4cwRlFC
	 UB8xBfTmrTEJV6t7T1LPkNbqZ+Gj97jSbWBGI+KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfEHNnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfEHNnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:43:52 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A64214AF;
        Wed,  8 May 2019 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557323031;
        bh=XrfOkBwkQE73zyZSkSTLIh9IBVtJ+5CvdEGAlS+U8uc=;
        h=From:To:Cc:Subject:Date:From;
        b=xxE1PGDbYNid+aUL75GhE1JvSM+eFv3neeeFpPiJVFn1qvTY+CYHdghmwferpn9Hr
         j+wT5zSBSgaFKtwCi2kNkwKov9f2RFjyewIW1bWziq9hWh8ARiTyqPkGB+/T08a2Jf
         HWrnTPAaqmaRmlFolycDWyRIxxEhl1/OdwrbAAlw=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-mtd@lists.infradead.org
Cc:     dinguyen@kernel.org, marex@denx.de, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv4 1/2] dt-bindings: cadence-quadspi: add options reset property
Date:   Wed,  8 May 2019 08:43:37 -0500
Message-Id: <20190508134338.20565-1-dinguyen@kernel.org>
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
v4: no change
v3: created base on review comments
v2: did not exist
v1: did not exist
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

