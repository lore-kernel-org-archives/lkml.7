Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA36C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05C320863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aajAgIPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbfETP3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:29:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40042 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbfETP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:29:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so15117383wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R09/KmbxD/tQQhd6oxu0ukeGEfAA87AXC1YxNhNR3sU=;
        b=aajAgIPwyYhsD+tdEyvZeY3SP+gY1IDYVhHL/ZjYBCwKrpyvhSF82VHrgf1kzEA0ky
         L8+6Zh3cppRrcsHeWX6I9TpY57vYdCo9xbOddAtGjqArx5Bp06dzgTBCSwZoQQ4lgDrD
         I+U8CqwC47LbRv8nyRJxWoe5xvSwinQUFQPGsU1gTagDCATwzkIDEGG6IYgJKJIqUUyf
         oRLNJi5i0hW79Kxg0ZwAqism3tTA+ZNVbTQ4cDoE2VZPyFztciKpS4Oj1JOlhZq2hphU
         72Romsq+woC+G8CP3B8RVzHkoRTMyXFnqEXXdKh7VmEFZS9KN/FGdMaBoJ7XFX78pxs+
         K9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R09/KmbxD/tQQhd6oxu0ukeGEfAA87AXC1YxNhNR3sU=;
        b=dAJjJEp9gUH0RJN7scIO+L/Ik+OoWZ3LvsuledcpayTvb4fye5a+9AEw2ksSDHm3D1
         rmnSWYMgnf5wsPm5FLQJYrxAIPXWqnP4uUYMw8A1hTdH7hZrmi1EIqUZ8ZBrI8Z0D1mk
         ybgNW97Iff7rRX1112WAUwhQlcH/bUneT/leDq0git5Ly1eXjl/Ft0r2Dk7HiYLy2gy6
         e+MttPAZxfwJGVDxdh1lwtdxM9I3/nEtrkLrh48bJ4+qAZlueSxjit4VUbrXWazw1sbp
         n8nRSWf/DewgE7xiTvG1zTu/6Zv6/lPNxTasjhpWqrgRKZHGXgtDOOxNAB/F+xlTL/Pi
         qSiQ==
X-Gm-Message-State: APjAAAWfYpZn9+1MnP8N+RdwfJECosCtyEwPJg2MtLOkv7JNQW0up0D/
        yFcORV8f3Ige9lvfeGrY/zw=
X-Google-Smtp-Source: APXvYqx2+r1DZV1br2Ag4BktpDHSY0O/7iWH1Zle1AkOcU4/LIyAOoVob07VTzqO5Ef967ldQR3WtA==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr10373508wrj.230.1558366170546;
        Mon, 20 May 2019 08:29:30 -0700 (PDT)
Received: from lab-pc05.sra.uni-hannover.de (lab.sra.uni-hannover.de. [130.75.33.87])
        by smtp.googlemail.com with ESMTPSA id y18sm14035176wmi.37.2019.05.20.08.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 08:29:29 -0700 (PDT)
From:   Yannick Loeck <yannick.loeck@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Yannick Loeck <yannick.loeck@gmail.com>
Subject: [PATCH] staging: pi433: fix misspelling of packet
Date:   Mon, 20 May 2019 17:28:52 +0200
Message-Id: <20190520152852.12420-1-yannick.loeck@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the misspelling of packet in
<MASK_PACKETCONFIG1_PAKET_FORMAT_VARIABLE>

Signed-off-by: Yannick Loeck <yannick.loeck@gmail.com>
---
 drivers/staging/pi433/rf69.c           | 4 ++--
 drivers/staging/pi433/rf69_registers.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 4cd16257f0aa..7d86bb8be245 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -722,10 +722,10 @@ int rf69_set_packet_format(struct spi_device *spi,
 	switch (packet_format) {
 	case packet_length_var:
 		return rf69_set_bit(spi, REG_PACKETCONFIG1,
-				    MASK_PACKETCONFIG1_PAKET_FORMAT_VARIABLE);
+				    MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
 	case packet_length_fix:
 		return rf69_clear_bit(spi, REG_PACKETCONFIG1,
-				      MASK_PACKETCONFIG1_PAKET_FORMAT_VARIABLE);
+				      MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
 	default:
 		dev_dbg(&spi->dev, "set: illegal input param");
 		return -EINVAL;
diff --git a/drivers/staging/pi433/rf69_registers.h b/drivers/staging/pi433/rf69_registers.h
index f925a83c3247..be5497cdace0 100644
--- a/drivers/staging/pi433/rf69_registers.h
+++ b/drivers/staging/pi433/rf69_registers.h
@@ -395,7 +395,7 @@
 #define  MASK_SYNC_CONFIG_SYNC_TOLERANCE	0x07
 
 /* RegPacketConfig1 */
-#define  MASK_PACKETCONFIG1_PAKET_FORMAT_VARIABLE	0x80
+#define  MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE	0x80
 #define  MASK_PACKETCONFIG1_DCFREE			0x60
 #define  MASK_PACKETCONFIG1_CRC_ON			0x10 /* default */
 #define  MASK_PACKETCONFIG1_CRCAUTOCLEAR_OFF		0x08
-- 
2.17.1

