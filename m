Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68839C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4921D218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfGaHPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:15:16 -0400
Received: from olimex.com ([184.105.72.32]:46116 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfGaHPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:15:15 -0400
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:15:12 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/1] nvmem: sunxi_sid: fix A64 SID controller support
Date:   Wed, 31 Jul 2019 10:14:47 +0300
Message-Id: <20190731071447.9019-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731071447.9019-1-stefan@olimex.com>
References: <20190731071447.9019-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in H3, A64 SID controller doesn't return correct data
when using direct access. It appears that on A64, SID needs
8 bytes of word_size.

Workaround is to enable read by registers.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a079a80ddf2c..e26ef1bbf198 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -186,6 +186,7 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
+	.need_register_readout = true,
 };
 
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
-- 
2.17.1

