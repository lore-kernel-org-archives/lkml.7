Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C10C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CA121734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894481;
	bh=YehLGyacMjUiIhNC8gzeS0zc4IaJV1WIyZ6K1OlrZLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fxUmiUrgz6Vn6YCJvLiGjPtGvw3f0IC6gszGz0MQeaUWefqsoVei/NeyctPIRbTBK
	 g47pscUpldlBXq7fAJQu1YxTDFlPHsxzzCBPYduwZfsBYntI+eT2GyMcIP9UTj2pr5
	 RD1wd5PRGyKigUjODpxa0sMYd73mzZ83IXsCG0hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCRHek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:40 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40906 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfCRHeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:14 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 0C6CD5FDF9; Mon, 18 Mar 2019 15:34:12 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] nvmem: sunxi_sid: Read out data in native format
Date:   Mon, 18 Mar 2019 15:33:52 +0800
Message-Id: <20190318073354.12151-5-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318073354.12151-1-wens@kernel.org>
References: <20190318073354.12151-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Originally the SID e-fuses were thought to be in big-endian format.
Later sources show that they are in fact native or little-endian.
The most compelling evidence is the thermal sensor calibration data,
which is a set of one to three 16-bit values. In native-endian they
are in 16-bit cells with increasing offsets, whereas with big-endian
they are in the wrong order, and a gap with no data will show if there
are one or three cells.

Switch to a native endian representation for the nvmem device. For the
H3, the register read-out method was already returning data in native
endian. This only affects the other SoCs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/nvmem/sunxi_sid.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 75c1f48cb3d0..14c114620ed6 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -46,33 +46,12 @@ struct sunxi_sid {
 	u32			value_offset;
 };
 
-/* We read the entire key, due to a 32 bit read alignment requirement. Since we
- * want to return the requested byte, this results in somewhat slower code and
- * uses 4 times more reads as needed but keeps code simpler. Since the SID is
- * only very rarely probed, this is not really an issue.
- */
-static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
-			      const unsigned int offset)
-{
-	u32 sid_key;
-
-	sid_key = ioread32be(sid->base + round_down(offset, 4));
-	sid_key >>= (offset % 4) * 8;
-
-	return sid_key; /* Only return the last byte */
-}
-
 static int sunxi_sid_read(void *context, unsigned int offset,
 			  void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
-	u8 *buf = val;
-
-	/* Offset the read operation to the real position of SID */
-	offset += sid->value_offset;
 
-	while (bytes--)
-		*buf++ = sunxi_sid_read_byte(sid, offset++);
+	memcpy_fromio(val, sid->base + sid->value_offset + offset, bytes);
 
 	return 0;
 }
-- 
2.20.1

