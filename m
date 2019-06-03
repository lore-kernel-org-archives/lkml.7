Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DDC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBBF25AD5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWLAfhXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfFCPF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:05:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33868 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbfFCPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:05:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so1990146pfc.1;
        Mon, 03 Jun 2019 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7cPfH6CN5ZWoHauFHa+oHBBt2+qLXBp4PMNQADA6LA=;
        b=rWLAfhXpVLln/lubNqoXn/QRQeUiKOXjzHubpwNo/E3/V+eqzLFiwV0HaK4WNewTZz
         7uLkXbzkUClJfX2E04SDT1fj7NB7W5uu/lHglZtjxnij4BAUCXU9kl7mba2CUbc458EH
         074UmFfNkloro/8gz6bp1jOqO+De7pssVG+2Va+E3VJd+3hGuMHU8/9HONvTcCbhapHK
         AmfyYV6C5vn/0wjXM8WJKhe5GwOYZpzPqNa3Jk09PTP1GAdA0FZL/um3CwbnDqkLOghN
         8fE+S5mG3J30+eqj+Ba3jojGBLq1lKeni3LATUDRuYOCygPeZfIkzYaF53Kn9ly92BDe
         2lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7cPfH6CN5ZWoHauFHa+oHBBt2+qLXBp4PMNQADA6LA=;
        b=tI35iPJW74L8SlHxwERzNQkfDBdx01QfsLF8+ahp9FReI1CqUjFnmLQyfA0qmsaEpO
         BBm1WP7m7TKPHRyn7epUxxofmJmuhRkOVseQ4SOBX7AR16MyDqAL1z4wQjm5b/1c3LWn
         V2Sn3L4Y39TKiCXYu4Sk/tZj9Pf1K6/EFGD0CuDcDWlI2C/rvH2rg61vezaUwuhpDpBl
         PTYaAbcd6sldbUSInzx1IjbAWeaZHS8fI8ob55phktTGBHs4/fwG7ulCmnYjBNMicygG
         VPHNnNi5UI5ADIjvZAfupD2xjawJs+1yarZZw5LaSlfeM3OquBqhDNAdSouCTFsxjWdO
         7MWg==
X-Gm-Message-State: APjAAAVfgD0TpDMjWbCprN+RzPbg8XTQjxaSFXBWcjgp3RSTz6Y1cZIA
        p1xEg3Crir5MgFuSzpWBhz8=
X-Google-Smtp-Source: APXvYqzMyTUIHX4B4Li5YRabAbu9JUnmTxekoDuTk6vd7QCe1pDYEWpjaIoXjuWONofkIOINn2TUYA==
X-Received: by 2002:a62:304:: with SMTP id 4mr31779269pfd.186.1559574324979;
        Mon, 03 Jun 2019 08:05:24 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id l38sm13393466pje.12.2019.06.03.08.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 08:05:24 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH] usbip: Replace unused kvec array with single variable in vhci_send_cmd_unlink()
Date:   Tue,  4 Jun 2019 00:02:11 +0900
Message-Id: <20190603150211.24926-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhci_send_cmd_unlink() declears kvec array of size 3 but it actually
uses just one element of the array. So, remove kvec array and replace
it with single kvec variable.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_tx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 9aed15a358b7..2fa26d0578d7 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -144,16 +144,14 @@ static int vhci_send_cmd_unlink(struct vhci_device *vdev)
 	struct vhci_unlink *unlink = NULL;
 
 	struct msghdr msg;
-	struct kvec iov[3];
+	struct kvec iov;
 	size_t txsize;
-
 	size_t total_size = 0;
 
 	while ((unlink = dequeue_from_unlink_tx(vdev)) != NULL) {
 		int ret;
 		struct usbip_header pdu_header;
 
-		txsize = 0;
 		memset(&pdu_header, 0, sizeof(pdu_header));
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
@@ -169,11 +167,11 @@ static int vhci_send_cmd_unlink(struct vhci_device *vdev)
 
 		usbip_header_correct_endian(&pdu_header, 1);
 
-		iov[0].iov_base = &pdu_header;
-		iov[0].iov_len  = sizeof(pdu_header);
-		txsize += sizeof(pdu_header);
+		iov.iov_base = &pdu_header;
+		iov.iov_len  = sizeof(pdu_header);
+		txsize = sizeof(pdu_header);
 
-		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, 1, txsize);
+		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, &iov, 1, txsize);
 		if (ret != txsize) {
 			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
 			       txsize);
-- 
2.20.1

