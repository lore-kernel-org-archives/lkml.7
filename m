Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A67C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293C208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ/4+68w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfHLUKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:10:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfHLUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:09:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so12829668pgt.13;
        Mon, 12 Aug 2019 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=deC9bypm2a5woLMxu2BTX+DDzR5ih5b4fjPEyHG/r60=;
        b=rJ/4+68w9pWobiIUxhoShphAASwz6SsDyf/ZBZL4nHBmV4qE/qy+mqchknTmclQM7H
         VcOi2knmywYxtXMBkMPHF8CVbzlmkt/mR4nRthMXKsF5uWy588doaGGyL6iJO7olYvLt
         qKuwIc2wfdhUil3A9AdkbOYZ1TRiOuWypNoLsRSnKhQbVozN4hOCAsDmf/mtIbQc0VQL
         idxsP2InQSsjkEOuJhvYD3nJkwk/VFhMEjGOD1xprxNAdjFmY4f9mFmsKsZgXXzbjjfe
         /VYqcm6UwBDovx9NfhnNVe+u8luNP3Esrkjdy+iYaYGbws4yD1qwF8B5RAOoychYE1mh
         FIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=deC9bypm2a5woLMxu2BTX+DDzR5ih5b4fjPEyHG/r60=;
        b=cVDQ+EqaqPs+Bi2tuh0oErScElRBScdugvAthjvGceiV/PEISDCCt1gCa4on6Hp/N6
         PFDyMnqPd+/F82FmrnmlX7JUEsExv47KFoucIGIcQr7RPq1GJtsUY2dL/rDJKkgRgcL7
         Ce7EBfnqpFLr+2Y2FG1SlWq0gi/YZ0t/Ut7WgVK2jWurWyvd1rH1nTjtqUbKtN4wEPnS
         YDEbo2+x+uO8j3gVa3coNP816mHsgh3HpQtWuJElOafL5tOPuckhfkKQe4nWhAZZPy8J
         DAwBo87ERCfYuEnkOwOSb3DqxGiFKMThIWDn2yWag6e2I/ta8oIkKuPD4nriDOI2lKbB
         lBiQ==
X-Gm-Message-State: APjAAAXgMZdsMfRfKaOTf7jmwQqsgwKiLnhLPGgEBWziXrgYkdoG06Ir
        Yi2A9nKSL8+ximetIjq59rPhlzJI
X-Google-Smtp-Source: APXvYqzn5NmBzOWdjj+4sNQujP4hwHHL2qOiWfWaHXT7reQ8xRApvxZ0Fe+CCbKr5TknKgukuzdG7Q==
X-Received: by 2002:a62:b615:: with SMTP id j21mr36345631pff.190.1565640567545;
        Mon, 12 Aug 2019 13:09:27 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id n26sm110286451pfa.83.2019.08.12.13.09.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:09:26 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rick Ramstetter <rick@anteaterllc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/22] watchdog: ziirave_wdt: Check packet length only once
Date:   Mon, 12 Aug 2019 13:08:51 -0700
Message-Id: <20190812200906.31344-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812200906.31344-1-andrew.smirnov@gmail.com>
References: <20190812200906.31344-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to check for packet length more than once, so drop the
extra check in ziirave_firm_upload(). While at it move the check at
the very start of __ziirave_firm_write_pkt(), as to not waste any time
preparing a packet we'll never use.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rick Ramstetter <rick@anteaterllc.com>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/watchdog/ziirave_wdt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index b2d5ff0c22fe..9d9c669b8b47 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -253,6 +253,13 @@ static int __ziirave_firm_write_pkt(struct watchdog_device *wdd,
 	u8 i, checksum = 0, packet[ZIIRAVE_FIRM_PKT_TOTAL_SIZE];
 	int ret;
 
+	/* Check max data size */
+	if (len > ZIIRAVE_FIRM_PKT_DATA_SIZE) {
+		dev_err(&client->dev, "Firmware packet too long (%d)\n",
+			len);
+		return -EMSGSIZE;
+	}
+
 	memset(packet, 0, ARRAY_SIZE(packet));
 
 	/* Packet length */
@@ -261,9 +268,6 @@ static int __ziirave_firm_write_pkt(struct watchdog_device *wdd,
 	packet[1] = addr16 & 0xff;
 	packet[2] = (addr16 & 0xff00) >> 8;
 
-	/* Packet data */
-	if (len > ZIIRAVE_FIRM_PKT_DATA_SIZE)
-		return -EMSGSIZE;
 	memcpy(packet + 3, data, len);
 
 	/* Packet checksum */
@@ -382,13 +386,6 @@ static int ziirave_firm_upload(struct watchdog_device *wdd,
 		if (!be16_to_cpu(rec->len))
 			break;
 
-		/* Check max data size */
-		if (be16_to_cpu(rec->len) > ZIIRAVE_FIRM_PKT_DATA_SIZE) {
-			dev_err(&client->dev, "Firmware packet too long (%d)\n",
-				be16_to_cpu(rec->len));
-			return -EMSGSIZE;
-		}
-
 		ret = ziirave_firm_write_pkt(wdd, be32_to_cpu(rec->addr),
 					     rec->data, be16_to_cpu(rec->len));
 		if (ret)
-- 
2.21.0

