Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2EC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999BC206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXVwJfrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfLOSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:54:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41785 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:54:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so4291483ljc.8;
        Sun, 15 Dec 2019 10:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrLXQiunwz8b9R35WMY7vgXLgGdJzweun8Zx2EMy+44=;
        b=RXVwJfrqRF6KV8qbDwmeI26Z8tkGcSqZ3zW6piuXS/LZmwdlhh5npFoAwM7lmT7pYc
         crFQ6s349AGmvfYIBiARtpI8noPk2AacVGE/wz2bpDh+cnuIR5DWNKHRD+gL5xIveVOF
         AFyQpPyRDb9GmMzzPIWfES2uFCTKZL23vBCg3Dy2oKZN08T3qy4zwBov8ATUb/hQMOgM
         1jHDG+ck6KTpnGanFcWigeoUkxOazGfq7p8H3sKuLmvm0VvO+9tC64Pd1S2Hpqoetlfg
         Cg9Jyl1xoUkOGdZS3tSND9UUa6cDbsi03pS8buJYW9LIQMfhs4EF3MV4LeIvnCZlEV79
         JcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OrLXQiunwz8b9R35WMY7vgXLgGdJzweun8Zx2EMy+44=;
        b=ZshXMMWLihEklvfpWLe2KEePgwR2tl4doTa4oiS9uozqftpMKf8rDBIadkhXBlOKSK
         fI2SXX1MgpmkNZHuQ6zkpySe0wEw5g5NCC7xPeLNbuSXagIRlMG9LI2UTd8yTFTS5MJo
         QYNql/zcIkjOhoElkztuSVaApJvN/qxtbtObQ2Y/De9fUF+3ETJrc1H0/2anZErfwIRV
         Q/9yqI7+ZlhwvQ895LuVT6HbNHqnr+PxILw2lZrNco0N8jkf7PJJJyKGYoRoKMrXrKv+
         vifngKVx7kvNslE1qrEI+hMuvN9v4ZTZW60MhGN4OLxq82bnptrd4ZQpWZ0puCQte3lE
         h9tQ==
X-Gm-Message-State: APjAAAWM+1Y7l4GOngDfAZ6y1e/Dh5A5v251SDPi7gmZYg3/wSGqqfre
        Guae4hZ4CsaYqYfo1hTelaiY/+Ph
X-Google-Smtp-Source: APXvYqz3x7IxBS3M8edy7coA1w9EnIAIA/TK60zuUOWLE1Qco7mjDpL4g7LbhNWvrXpgWKgEuYzVBQ==
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr16595353ljg.93.1576436070356;
        Sun, 15 Dec 2019 10:54:30 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id t2sm8738514ljj.11.2019.12.15.10.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:54:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: hci_bcm: Add device-tree compatible for BCM4329
Date:   Sun, 15 Dec 2019 21:52:52 +0300
Message-Id: <20191215185253.14024-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver supports BCM4329, but there is no device-tree compatible for
that chip. Let's add it in order to allow boards to specify Bluetooth
in theirs device-trees, in particular this is useful for NVIDIA Tegra20
boards.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 9f52d57c56de..6f9d7c0e0061 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1470,6 +1470,7 @@ static struct bcm_device_data bcm4354_device_data = {
 
 static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm20702a1" },
+	{ .compatible = "brcm,bcm4329-bt" },
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
-- 
2.24.0

