Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A5C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEDA20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="OcBwh7RV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCBOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 09:19:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfCBOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 09:19:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so815230wrw.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 06:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qynex949vXyvX1qbDlraseLAAAK3bz5TwXaIWnv3VdA=;
        b=OcBwh7RVCSfIhcZXB+NtQFRnKwcxg5zWyHYkPCTyylS0bU14H1EsS7Ccg3ZXNfjTw8
         cFSv9m3uRxg45E4tbQapBlt6ji8SfO2Ud/jRO/0xik53Kkt55XQYD5FkCsk0MLDRtqE8
         WbRqzxy0NZrxDCzRQgFSpwIiLUiSJsf0CK3kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qynex949vXyvX1qbDlraseLAAAK3bz5TwXaIWnv3VdA=;
        b=thrtcVvNsAgwl3Wrx91lGJkkxK8vJbqHAtqIZy7vAKTireNY82lrdAO2Nr4Jd0ebJb
         P4yeoGogJ1X7MX5LoN6AR0ZkkVdiZjatmwlTr3WarfL4U/YMV/fZY5fNnT7YYdXGDTX3
         2JLSVdWXPa6ZJblzt6Dixzm8vC6RmbM9Wrp+51Xj9BsFH09Rcm17RisXRtaDD6/IhzCU
         YUlt4yaSzemWMamneO6PXOQy70yL5AcPG6RX/s5j2Z8JS2MMtajJRIaNSFmcGk8mhC9W
         J7ZTdJLLHYEA7ikg3XOMI/hkaPVvjIpkAov2e3T14FkgZPCM+4OouDVeZLCEM5xOWbQo
         gZIQ==
X-Gm-Message-State: APjAAAVYrfXR9/3juh7khzfQd+QoLbmpVB3ErkT4e+zOBVyLZgcDvDIu
        idgES9mOKOsUcj/8VGzl2WxNgA==
X-Google-Smtp-Source: APXvYqzXZ+UP7MvOu3+x+w6ldCyi1on9U4plp6VdzUAoslATh38zjNqoAR5rLyKUJE2xeXsdpJxvKw==
X-Received: by 2002:adf:9d13:: with SMTP id k19mr7288059wre.82.1551536384687;
        Sat, 02 Mar 2019 06:19:44 -0800 (PST)
Received: from localhost.localdomain ([95.149.160.3])
        by smtp.gmail.com with ESMTPSA id o12sm4338413wre.0.2019.03.02.06.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 06:19:43 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     jdelvare@suse.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] i2c: sis630: correct format strings
Date:   Sat,  2 Mar 2019 14:18:36 +0000
Message-Id: <20190302141836.24638-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wformat, clang warns:

drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                        smbus_base + SMB_STS,
                        ^~~~~~~~~~~~~~~~~~~~

drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                        smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
                                          ~~~~~   ^~~~~~~~~~~~~~~~~~~~

This patch fixes the format strings to use the format type for int.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 drivers/i2c/busses/i2c-sis630.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 1e6805b5cef2..a57aa4fe51a4 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -478,7 +478,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
 			    sis630_driver.name)) {
 		dev_err(&sis630_dev->dev,
-			"I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
+			"I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
 			smbus_base + SMB_STS,
 			smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
 		retval = -EBUSY;
@@ -528,7 +528,7 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	sis630_adapter.dev.parent = &dev->dev;
 
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
-		 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
+		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
 
 	return i2c_add_adapter(&sis630_adapter);
 }
-- 
2.20.1

