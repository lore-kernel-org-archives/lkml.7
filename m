Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ED7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE62054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257868;
	bh=98K35g9c2xarOfvm1FDLEJI3S3EZR9qLgmJocNaIwhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nj9WQg5twBihkskZUX3xSHUVB106NRrI7dYdKqVIOCIsOE5IVTdWnkKNVJA+56/nX
	 ugqLmUhOumi/cc4wz11mhp3hxwjdU5Fb113YgAHohaUu35s1hFVNLtXcefKiXA8Lj5
	 cqMXmI5RiC48E0wFriUECvadh+MKngp4qjWEXAwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfCVMbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390160AbfCVMRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF86621900;
        Fri, 22 Mar 2019 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257059;
        bh=98K35g9c2xarOfvm1FDLEJI3S3EZR9qLgmJocNaIwhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKFC0MUS/2GFt95SAvDkDztnG/3Q+/ggJ5EII++HtnCakbA2FK7Z5XBGR6HfxmhHY
         g9kFLSEWxdENcoMhKberGRxVJIEK0RXLtb8i1YA5ouj2LLKDB/ubrhaygeqvFoyAnn
         TFLI8/TjGUHvGVSosy4MHGCOwvQ4Hy/BGFs8Ku8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.0 118/238] i2c: tegra: update maximum transfer size
Date:   Fri, 22 Mar 2019 12:15:37 +0100
Message-Id: <20190322111305.478168444@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowjanya Komatineni <skomatineni@nvidia.com>

commit b03ff2a23359d0dd6f0a1516c6a9e9c4760ed230 upstream.

Tegra194 supports maximum 64K bytes per packet including 12 bytes of
packet header irrespective of PIO or DMA mode transfer.

This patch updates Tegra194 max write length to account for packet
header size for transfers.

Cc: stable@vger.kernel.org # 4.20+

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-tegra.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -118,6 +118,9 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -836,12 +839,13 @@ static const struct i2c_algorithm tegra_
 /* payload size is only 12 bit */
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
-	.max_read_len = 4096,
-	.max_write_len = 4096 - 12,
+	.max_read_len = SZ_4K,
+	.max_write_len = SZ_4K - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
+	.max_write_len = SZ_64K - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {


