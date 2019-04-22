Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564302064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963885;
	bh=zcXJdbVkQ9dCRjuZ4c2PifO78xgR1cg0tfG5s/ThGjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNEGZufougoHlqsTkn67YlVEdTfttRimD5J8a3SpBNPwoff/VXzP/0+mjOirX1yxK
	 QgG9OPHyHYNOfVhoi+vJLlCJ7bL3+VcFfmiARoQtz+uiNdI8GRIgE9Lbe9lIDi7xRA
	 M/NEIrynVp+QDLuahKJkcKEAINv6tJljNLtngiCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbfDVULY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbfDVTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB94214AE;
        Mon, 22 Apr 2019 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962139;
        bh=zcXJdbVkQ9dCRjuZ4c2PifO78xgR1cg0tfG5s/ThGjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMUYKBRsiqqDSjV/ZiBpgDVCnChSWszGYUVIMWkdHWg3faV+YCC3Oo8GvKjPLB3FK
         8po/Vg5Phunpc8ajw/ovsUL3+fkxkHdC9Cf6LrqQ8cbpJSwmqqyi4+Fr1ywfnQ8jVq
         V4bA2Dr89GP252JeOoweQfQWqP7ah5mZyPfhtaAw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 14/98] staging: axis-fifo: add CONFIG_OF dependency
Date:   Mon, 22 Apr 2019 15:40:41 -0400
Message-Id: <20190422194205.10404-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 1beea6204e2304dd11600791d8dad8e7350af6ad ]

When building without CONFIG_OF, the compiler loses track of the flow
control in axis_fifo_probe(), and thinks that many variables are used
without an initialization even though we actually leave the function
before the first use:

drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_probe':
drivers/staging/axis-fifo/axis-fifo.c:900:5: error: 'rxd_tdata_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (rxd_tdata_width != 32) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:907:5: error: 'txd_tdata_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (txd_tdata_width != 32) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:914:5: error: 'has_tdest' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (has_tdest) {
     ^
drivers/staging/axis-fifo/axis-fifo.c:919:5: error: 'has_tid' may be used uninitialized in this function [-Werror=maybe-uninitialized]

When CONFIG_OF is set, this does not happen, and since the driver cannot
work without it, just add that option as a Kconfig dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/axis-fifo/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index 687537203d9c..d9725888af6f 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -3,6 +3,7 @@
 #
 config XIL_AXIS_FIFO
 	tristate "Xilinx AXI-Stream FIFO IP core driver"
+	depends on OF
 	default n
 	help
 	  This adds support for the Xilinx AXI-Stream
-- 
2.19.1

