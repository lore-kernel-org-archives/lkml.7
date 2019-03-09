Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45869C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F437207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 06:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GE9NBVjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfCIGEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 01:04:20 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56958 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfCIGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 01:04:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 9DD6ACE5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 06:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NKB9cux2UNEp for <linux-kernel@vger.kernel.org>;
        Sat,  9 Mar 2019 00:04:18 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 6C5D2C8C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 00:04:18 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id a9so17169155iol.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S1WWEVNKEuoBCxpQFSA9u5EyfataTRVhovdmrNkOjAQ=;
        b=GE9NBVjoNlcSTMTLDoJ4BrYm+aqx117kEMCtxO6EKSNNKKfqAsbe4/0biFgOpTY4qM
         c9QdSV0inb1xsleVoH5RPqIIqJ0IOo1T7eMngLqYvC5s9Mm2JUy0pDCkFI3jWYP3AY1o
         Fm1iLyzQ4LuaUG81s6qX5j/OsWNjUaoeeMbGYXfsYA2U7dUyxwtZLUhdyx47x+zhyPdz
         oPQY74Dcv6CIqlRsWnC1ekALjPgUMCPBQwH20vN1X/cvuqSEwOFjP6Kp5hRuTRNkJ/Ms
         HDFIspuqSGqpMMmLMw1oPYXwIDrFs6B8GtnVbVxeEAK9ejMiccK3WXwM0rK1fRIMr1MS
         sbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S1WWEVNKEuoBCxpQFSA9u5EyfataTRVhovdmrNkOjAQ=;
        b=hA2tMUNxlJz9Oce+XYmheWV++vfVL4tGqJXM+9wgH1lwRJgKYMgxWk7W8iSWrit4oe
         VxsZ84ysGbjR16eGsl/ua+FiWm5VDzInjeqDp15fcgC+UNfMxGi2NCuM+Ttb7iR4UBKc
         kcFswyd/mLp0omRK5WIisxSGUmALVWoTmWz0d5Mjp5i1WRfA3nfhNbzZqRcgl7X2X5mD
         HBG/nlgY+eZAspjRR/1oppJitrfcrWQOLkn+NhPER6JT9nTBU4v/0leVZoYddBqAgYUh
         unQk8Da3TU2+MDcb2AEQax/nMe0gR6xUztKfSRiavu91trzCkhQvdBlLvMQADXAZHgbb
         +O8w==
X-Gm-Message-State: APjAAAU6UdlBFF3t7VDpouHm3MzNzkMb+WjvmBHobJFsr582L+WMErpA
        5ELV9ukJKMkoYcKCQCWbjHb7HhwHMmEApUWYC+dXuma0wc/9GYZpu+vxdR3F9JlBbwHxxMAO2Ec
        QYyCmtm+abG3STUIe5KRrRz5+ZW24
X-Received: by 2002:a5d:9157:: with SMTP id y23mr11703391ioq.129.1552111457640;
        Fri, 08 Mar 2019 22:04:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyg30LRVtQ+HlIoy45Pn8SbGrArhpjMlyYY1v0bLr+DJiS7B4dRHSX37xLf/44jyBRXcuPJRw==
X-Received: by 2002:a5d:9157:: with SMTP id y23mr11703385ioq.129.1552111457417;
        Fri, 08 Mar 2019 22:04:17 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s26sm4200941iol.41.2019.03.08.22.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 22:04:16 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Riku Voipio <riku.voipio@iki.fi>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: fix a potential NULL pointer dereference
Date:   Sat,  9 Mar 2019 00:04:11 -0600
Message-Id: <20190309060411.29074-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of_match_device cannot find a match, the fixes returns
-EINVAL to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/leds/leds-pca9532.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index 7fea18b0c15d..4b0335591728 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -513,6 +513,7 @@ static int pca9532_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	int devid;
+	const struct of_device_id *of_id;
 	struct pca9532_data *data = i2c_get_clientdata(client);
 	struct pca9532_platform_data *pca9532_pdata =
 			dev_get_platdata(&client->dev);
@@ -528,8 +529,11 @@ static int pca9532_probe(struct i2c_client *client,
 			dev_err(&client->dev, "no platform data\n");
 			return -EINVAL;
 		}
-		devid = (int)(uintptr_t)of_match_device(
-			of_pca9532_leds_match, &client->dev)->data;
+		of_id = of_match_device(of_pca9532_leds_match,
+				&client->dev);
+		if (unlikely(!of_id))
+			return -EINVAL;
+		devid = (int)of_id->data;
 	} else {
 		devid = id->driver_data;
 	}
-- 
2.17.1

