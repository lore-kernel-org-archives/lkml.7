Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5F21874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103601;
	bh=Pz4Kz4xMKzKn93rEbrxC6NhO/2r1MDyu0V05BdXdxNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y1ho7K8rjXv+yV+4XE+PPvGGJXWXumb9mQD9xz5NmQVGaCprE+j9+K6E1U78xSCPM
	 XtmTa7NC/f8bkHVKic+2sJQEgu7AxId82lxiNc0Cs+rjiS55ClidXoJPdZox1mXclH
	 xY68UWyceiDcXMG64RE/IbtGDMe/DWEYmCRa8sZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfH2SdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfH2SNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D332189D;
        Thu, 29 Aug 2019 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102427;
        bh=Pz4Kz4xMKzKn93rEbrxC6NhO/2r1MDyu0V05BdXdxNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvrhxKAE8daqUVUk4RfLduAHJjGXWzZSgZKcI++RNQlU7VN7fE6XtLRgeGd4Ob70L
         eve/0msQuW5RV25saHVAypopTod5Ghxz3RCmgR0hNSmyN+zt3OXprJkhLVP/bd3tCs
         hPCSxgVRaKon3Y3GX7KsG9ZJOeEwcGUk2WQd2tVQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 18/76] Bluetooth: btqca: Add a short delay before downloading the NVM
Date:   Thu, 29 Aug 2019 14:12:13 -0400
Message-Id: <20190829181311.7562-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
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
index aff1d22223bd4..0ee5acb685a10 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -350,6 +350,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
+	/* Give the controller some time to get ready to receive the NVM */
+	msleep(10);
+
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (qca_is_wcn399x(soc_type))
-- 
2.20.1

