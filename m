Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C45C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913122085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552894464;
	bh=NR5fA426N6ri7El5Amha0pSFo/RnlLKqNKjOwMAKwrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N4ioslcqnJtGblP65fnM8lkpLnO1hQNFj28ECNf9L1oDbNkkqNDljtvr7d5aSON/A
	 WKVdYiZFrcVf6RWAGjeCT9l4JVZVIz0qdg7ezQa/4VXrqUyiOw+2StzSLgQLNQDAlq
	 36MP3NyD1JVexhc3cAmXmAbh7BGjWj2fjsxhoVtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfCRHeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:34:19 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:40894 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfCRHeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:34:14 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id F3F3C5FD69; Mon, 18 Mar 2019 15:34:11 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nvmem: sunxi_sid: Optimize register read-out method
Date:   Mon, 18 Mar 2019 15:33:50 +0800
Message-Id: <20190318073354.12151-3-wens@kernel.org>
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

SID cells are 32-bit aligned, and a multiple of 32 bits in length. The
only outlier is the thermal sensor calibration data, which is 16 bits
per sensor. However a whole 64 bits is allocated for this purpose, so
we could consider it conforming to the rule above.

Also, the register read-out method assumes native endian, unlike the
direct MMIO method, which assumes big endian. Thus no endian conversion
is involved.

Under these assumptions, the register read-out method can be slightly
optimized. Instead of reading one word then discarding 3 bytes, read
the whole word directly into the buffer. However, for reads under 4
bytes or trailing bytes, we still use a scratch buffer to extract the
requested bytes.

We could go one step further if .word_size was 4, but changing that
would affect the sysfs interface's behavior.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/nvmem/sunxi_sid.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 704c35edf796..15fbfab62595 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -115,36 +115,34 @@ static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
  * to be not reliable at all.
  * Read by the registers instead.
  */
-static int sun8i_sid_read_byte_by_reg(const struct sunxi_sid *sid,
-				      const unsigned int offset,
-				      u8 *out)
-{
-	u32 word;
-	int ret;
-
-	ret = sun8i_sid_register_readout(sid, offset & ~0x03, &word);
-
-	if (ret)
-		return ret;
-
-	*out = (word >> ((offset & 0x3) * 8)) & 0xff;
-
-	return 0;
-}
-
 static int sun8i_sid_read_by_reg(void *context, unsigned int offset,
 				 void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
-	u8 *buf = val;
+	u32 word;
 	int ret;
 
-	while (bytes--) {
-		ret = sun8i_sid_read_byte_by_reg(sid, offset++, buf++);
+	/* .stride = 4 so offset is guaranteed to be aligned */
+	while (bytes >= 4) {
+		ret = sun8i_sid_register_readout(sid, offset, val);
 		if (ret)
 			return ret;
+
+		val += 4;
+		offset += 4;
+		bytes -= 4;
 	}
 
+	if (!bytes)
+		return 0;
+
+	/* Handle any trailing bytes */
+	ret = sun8i_sid_register_readout(sid, offset, &word);
+	if (ret)
+		return ret;
+
+	memcpy(val, &word, bytes);
+
 	return 0;
 }
 
-- 
2.20.1

