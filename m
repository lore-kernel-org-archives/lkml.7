Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6664FC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E466218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946683;
	bh=P8Yd1Sc/SPvquJKLyFn26fzA2S+zk+6qu6FEiDUmT5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E67IAaV34ny7//T+HX3eG/fyz5UQx9bJoWpuyTHRh13koGFFhZPIJBGpWJkOCKXWU
	 vcStvoM0r8OHZiK3gZI3Kfv6AXOW32stx4o2vX01b7CXTBF9ATvEMRnp6PKCl7Ohgs
	 Xd3zN969ap7By2LJaFAzHKvMT/Dr+0YlIkuNCsAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfIHMom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbfIHMok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:40 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FCE218AE;
        Sun,  8 Sep 2019 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946680;
        bh=P8Yd1Sc/SPvquJKLyFn26fzA2S+zk+6qu6FEiDUmT5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKoiPh4VZb8eFWr+P9FokfcYuaR/x3yTnHqU4DCyrzbV1t+VZtNMf4l0rL+Ns05cw
         sZ3O7ugO5J+i+UjSXD1tI0rn33/vApyKL01mgFY6fGydAn8S+VPoaknD6+v8B3T05I
         91swHz5FAIRSDD+3uAmHA/MVQqoIMSadN2dI5k+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/26] Bluetooth: btqca: Add a short delay before downloading the NVM
Date:   Sun,  8 Sep 2019 13:41:42 +0100
Message-Id: <20190908121058.173792870@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
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
index 28afd5d585f95..b7dfa4afd5169 100644
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



