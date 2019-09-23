Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F65C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090CF2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHnglSaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440439AbfIWSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:23:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54291 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438123AbfIWSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:23:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so11084219wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ayq0p6X/ErZzs4hinfPpnJipMcpKRV6Xdv93NSXWlhw=;
        b=UHnglSaR5xTYUh6u8PEkTLlPY47tCqYiYn4IHYLGLfS8EY8PsHRrH1CDJnrBYJNtur
         +IZRL1mZKrYDs711H3Y/Vtua56wYSwd2EjDpCC//WFL+n7uIAANJ6Ub5LpdiCRzOFNig
         lG+VERRbz2/3QhvhyR27nT476KTplwKHDDdVWnjg3u+OBhTCidjyP6TAcYMpaATWuNA5
         4FjPOyghNJE2MjBSH9VJqvViszHpQaGXDDgVKQm2tncsdLXNTXHeGh4SAQd1N6emzwKN
         BtCWuRgyw13oz6tafpa0c5B38Kjvc2UCMXKSQB/0bMMdPSCXViiF78bJ8X+C92ZAlMRf
         3Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ayq0p6X/ErZzs4hinfPpnJipMcpKRV6Xdv93NSXWlhw=;
        b=lSo5MaBFk2hSVVg/o/k4scOdUuXeohtA4ARHNIgdUw6XcDsvVwnobnY6+/IubRBmUP
         LCm+Qt5H4MFCsLlminkZhmEEQqYA5H+j3g0rhWdx6k/fpjj6CKPrT2moRDfUoQDxG8CC
         aNwWpkSd2LG80Z25thj8w6b3Fdnf1XCAGPK4wn/UNpXqF0PhrqfY8QVop2bfh8lCRPlA
         ZxvBldhw+s0FCp78G9xB5e/fq+LwLtl4JTHeuLNplBoe8lm0u6DoJn5mAiFr0OYg6yXJ
         RHIws++/FnZqg6ftqteXG1p8twIEyo5ZwC06SVcEhhD+3vnXVWUQortbF1wy5oUphzzB
         zrdQ==
X-Gm-Message-State: APjAAAXwMDg3H/+2cYxg4wRug9bFbb00395HflJ6gid2SsZzhc3S27k8
        e153Tz3h/zgsq9eBKeWang==
X-Google-Smtp-Source: APXvYqySSJxjMUbOQGW9MPHwsn7DPJhlEiwLZfauDT+NUFbYPOv7XvnZQ1fV3xvzKy9bXOXmp09Ycw==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr778134wme.92.1569263003383;
        Mon, 23 Sep 2019 11:23:23 -0700 (PDT)
Received: from nitro5.fritz.box (business-24-134-37-65.pool2.vodafone-ip.de. [24.134.37.65])
        by smtp.gmail.com with ESMTPSA id t123sm15679861wma.40.2019.09.23.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 11:23:22 -0700 (PDT)
From:   Gabriel Craciunescu <nix.or.die@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        crazy@frugalware.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
Date:   Mon, 23 Sep 2019 20:22:56 +0200
Message-Id: <20190923182256.11062-1-nix.or.die@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting with default_ps_max_latency_us >6000 makes the device fail.
Also SUBNQN is NULL and gives a warning on each boot/resume.
 $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
   subnqn    : (null)

I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
To be sure is not a Laptop issue only, I tested the device on
my server board  with the same results.
( with 2x,4x link on the board and 4x link on a PCI-E card ).

Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6b4d7b064b38..f5767741838b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3088,6 +3088,9 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.23.0

