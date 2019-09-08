Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FEDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF152067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947355;
	bh=1Hz3gvQ0f2YPPR+1FUpI7H+4HAKYesWoaGOm0olvD3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZ9SsoLvYHfzrA7eFzcJbtmHl3dtraeJNg8H9RrQlp5MP208bVaBUUYxpTpStX46d
	 K5soUdCO6ET3dCx/CgDSexDHod5V+nKH2KEkKAS37PDmpZLiPDdEMj1r/ipEkIJNVc
	 SOuXiw2vyEVBVpp0aUyXmdoHcDv3WCMxZtA8xsts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbfIHMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732193AbfIHMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:38 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FB8218AC;
        Sun,  8 Sep 2019 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947037;
        bh=1Hz3gvQ0f2YPPR+1FUpI7H+4HAKYesWoaGOm0olvD3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCn5zNkwhq28bmhIPWkZOShqr7jwWttqgb/TpJJ8zCW9wyVobtyQuzniBJmBZA5ey
         odcHBUDSR8RNIPsM62dqPGCQ0o870UU8QZYAshEYORVKfxjcQhgjN9QKl47V8PmHnj
         Z4iE/Bf9W/7y4wGy8NraJOMXyLCrEoe6JkWy8e44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 36/94] Bluetooth: btqca: Add a short delay before downloading the NVM
Date:   Sun,  8 Sep 2019 13:41:32 +0100
Message-Id: <20190908121151.472382621@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



