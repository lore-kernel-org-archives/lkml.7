Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20FD2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102778;
	bh=kYBIYi0EgYgnvb+nZ/NT0lsk7oySlc+EQDfS2wuGHoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hcwkYz70I498GtFlhdjlrUZrnHR0B4bqTIZur8+OZFcT3UB180AFqKeG9GIq7oOMs
	 CTVcBexcMcCbsTsOwQhMQeu5RwdFMuHRTX5Val1AKzHZeAEQvN+9Ps0QmAD5skwVo1
	 EDCr2WoO86/VR+MTkK15zZBo/Z98D5LFXfMJanCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfH2STi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfH2SSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:18:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B20233FF;
        Thu, 29 Aug 2019 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102686;
        bh=kYBIYi0EgYgnvb+nZ/NT0lsk7oySlc+EQDfS2wuGHoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jni8shvrzjenX6CkvvakE7FAg3NKyXzqPcHQRzJQCw57pGhJTh1Blv9DOxl6003/s
         moowR9KouQZnIUkC2yt99JHPsuOr3ET8yRiFy7ixZtqZKUZK7H2/7WSOOVB2DHISf+
         +kzMUF4Da4+YtPHY3tNn8MwRcIYCwdYYmjDqYbKM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/15] Bluetooth: btqca: Add a short delay before downloading the NVM
Date:   Thu, 29 Aug 2019 14:17:50 -0400
Message-Id: <20190829181802.9619-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181802.9619-1-sashal@kernel.org>
References: <20190829181802.9619-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit 8059ba0bd0e4694e51c2ee6438a77b325f06c0d5 ]

On WCN3990 downloading the NVM sometimes fails with a "TLV response
size mismatch" error:

[  174.949955] Bluetooth: btqca.c:qca_download_firmware() hci0: QCA Downloading qca/crnv21.bin
[  174.958718] Bluetooth: btqca.c:qca_tlv_send_segment() hci0: QCA TLV response size mismatch

It seems the controller needs a short time after downloading the
firmware before it is ready for the NVM. A delay as short as 1 ms
seems sufficient, make it 10 ms just in case. No event is received
during the delay, hence we don't just silently drop an extra event.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 4a62081688501..593fc2a5be0f9 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -363,6 +363,9 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 		return err;
 	}
 
+	/* Give the controller some time to get ready to receive the NVM */
+	msleep(10);
+
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
-- 
2.20.1

