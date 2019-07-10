Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4195C73C7E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD57C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBYkAkyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGJH0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:26:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41989 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfGJH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:26:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so657125pff.9;
        Wed, 10 Jul 2019 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdSf9Bk39d2jsEwtirbUFvZR6WuTUDxY23e5Q3Gyu54=;
        b=KBYkAkycZiz8DZ1DdXQ09DtirV6eaCKk3fmVFyIBKxbjrT7BHk2fATKnvMqjuFKqtL
         2VVWpAxLUOf2sFvSR1Ki+Vto7jYVcUKMF6E0/b9zXN1h6LCaQx5xuVlomf8/omMtm2et
         J61gvJfNmZcJkmMt3N3ZhKRPU0TPtsG97ISH+wksw7N8TBZF4MOFBRuJ4ONbmbjlBl9S
         IWZfsW+wyHljkFz3b4S9mOX+bA0Z5/byG4Ds6TrkkqZ2FZiJ6MkQHhyZLyZN4Q4riLMN
         3XRZrOR5pnbAlhfcgRX7/z1bIYZR8JEbt7v3quprl6EpQwiiRneIx6UXRrL7tZSYOhwO
         oWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cdSf9Bk39d2jsEwtirbUFvZR6WuTUDxY23e5Q3Gyu54=;
        b=HhVGBsKUrHWhGdLJgz736QeIEdkx3HJC64L45FnOtJQI13VUhy86Qxeb+YdkPC1jkZ
         WSjJdIT7qMUSl0+Kzl3cPoucBU+vT/UoVebyFlLgI2hexr1aHD7wegm13cFzqFIH/n+v
         pt4urQogTviJrS+OlYaOyzP0iVg8qumJgQK+KX4Cnx3/KFILruHmtW0PIvQbEh3c4ChI
         vj+4fF073ZmEw+6oI/o5nxcK0z0yrHi/w61LOrMioGP7XW5Gp7XQdZuFYuNY9Rr9qHUg
         yoN6VxkXBoCeR0M+V7dCKs2mJa0HIjoMjG5R6PbMIcBEsOWWiRqmXYnpmdq0b5fZs6GB
         tzhg==
X-Gm-Message-State: APjAAAVIX32zucHmmR+7zZgeizk+DSc2lADambnQzx50qCj12/JknSrh
        MHh1va+2QGs9SJl0/SkfEJMPnhvv
X-Google-Smtp-Source: APXvYqyA6lkiug68fbXg2b3s/HCFJWhdOBMdkW5CUmBV9eiZBbo2xrJFzH3CGhvgc5LdiqbxL0WpEw==
X-Received: by 2002:a63:da52:: with SMTP id l18mr35850153pgj.131.1562743577006;
        Wed, 10 Jul 2019 00:26:17 -0700 (PDT)
Received: from voyager.ozlabs.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id o130sm2802358pfg.171.2019.07.10.00.26.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 00:26:15 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Eddie James <eajames@linux.ibm.com>,
        Alexander Amelkin <a.amelkin@yadro.com>,
        Lei YU <mine260309@gmail.com>,
        Alexander Soldatov <a.soldatov@yadro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon (occ): Add temp sensor value check
Date:   Wed, 10 Jul 2019 16:56:06 +0930
Message-Id: <20190710072606.4849-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Soldatov <a.soldatov@yadro.com>

The occ driver supports two formats for the temp sensor value.

The OCC firmware for P8 supports only the first format, for which
no range checking or error processing is performed in the driver.
Inspecting the OCC sources for P8 reveals that OCC may send
a special value 0xFFFF to indicate that a sensor read timeout
has occurred, see

https://github.com/open-power/occ/blob/master_p8/src/occ/cmdh/cmdh_fsp_cmds.c#L395

That situation wasn't handled in the driver. This patch adds invalid
temp value check for the sensor data format 1 and handles it the same
way as it is done for the format 2, where EREMOTEIO is reported for
this case.

Fixes: 54076cb3b5ff ("hwmon (occ): Add sensor attributes and register hwmon device")
Signed-off-by: Alexander Soldatov <a.soldatov@yadro.com>
Signed-off-by: Alexander Amelkin <a.amelkin@yadro.com>
Reviewed-by: Alexander Amelkin <a.amelkin@yadro.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/hwmon/occ/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index cccf91742c1a..a7d2b16dd702 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -241,6 +241,12 @@ static ssize_t occ_show_temp_1(struct device *dev,
 		val = get_unaligned_be16(&temp->sensor_id);
 		break;
 	case 1:
+		/*
+		 * If a sensor reading has expired and couldn't be refreshed,
+		 * OCC returns 0xFFFF for that sensor.
+		 */
+		if (temp->value == 0xFFFF)
+			return -EREMOTEIO;
 		val = get_unaligned_be16(&temp->value) * 1000;
 		break;
 	default:
-- 
2.20.1

