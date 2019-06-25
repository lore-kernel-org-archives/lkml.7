Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5AC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DBF205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRb4vx3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfFYUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:51:07 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56646 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:51:07 -0400
Received: by mail-pg1-f202.google.com with SMTP id x13so62515pgk.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O2BCMpSMEUD0uhCoQvAWHcPzht/NlDspltjq1bPuhdc=;
        b=wRb4vx3aIVQVt2j91i64tCYnQ5TwC56Jm4PrWR/96O24vu+sntbEj7x/O6yj+t9+UF
         ygA+2i8VlmntXNhLo2DoMu4crB6GkQT+JY/9kDeO9vT+Cuc3Pi6z632n9j0DJxWLOLH/
         ZxusVmb+l8X0O+Xa9LseGchVhhUSveU3l6VtYdo1SMlIPy3JC/HUpGW5jwHDe6uLL38I
         sHFscSchwkkoXnPISnQpCPB9+3ogtuLmH2/NMqHW/TsvzpgDxSSwXJC3JxDvFbxO059r
         g7OleLBjUsiDd9Ru2qZCKlBTGzh3JYHwl33oZYoUDYYfc0H/HjpFmKUryg7GxNIKKjR8
         wjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O2BCMpSMEUD0uhCoQvAWHcPzht/NlDspltjq1bPuhdc=;
        b=iWgn7l5nWJIupmZeE8LoH+9aK7ETKVClr55FkFuxc6J6zgXiet/70ykxIUIoxT5GQO
         1WeSCKPmXZsA6jNKDkOArPYTEMtbgebIimW0xhXTKMJS5WbsS8WoYe8g2G76Szf8U1jk
         329QgxvpI70J58iQ+0lfy3vMrsp4cBzw54yk7GT8TcALLvcokbE+PjtLi0IE8Ud8K18A
         TvzPqo8jdlb2SjD0hmKYn3B+ZwJSxcmJEk0tqwINJ8JVtfgrgYSve8MmBy2+81tZ+iyx
         n/XGvOicKXVLBinXPKImzSQCthGq5kYXBzm+aWT3ZSABov8IxV6yubvRyMkkUAOpWzIV
         uiSg==
X-Gm-Message-State: APjAAAX6nBokibtCyxycULabVFsDWIgTd+2IXmO+wHeUrJFx/KrbtGdE
        cWmFrFzN+7undbv2dr+DSOp+cd6TtL5J
X-Google-Smtp-Source: APXvYqw7pxc6tVVhNSTwXwdD1tM1MdfS2hR0gclE8UfWYwwLqf0tr7Tx/969EybRYrk5wxiVEx8rnUxHEjzq
X-Received: by 2002:a63:4f07:: with SMTP id d7mr39888140pgb.77.1561495865969;
 Tue, 25 Jun 2019 13:51:05 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:51:01 -0700
Message-Id: <20190625205101.33032-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] platform/chrome: lightbar: Assign drvdata during probe
From:   Rajat Jain <rajatja@google.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     evgreen@google.com, rajatxjain@gmail.com,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lightbar driver never assigned the drvdata in probe method, and thus
causes a panic when it is accessed at the suspend time.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/platform/chrome/cros_ec_lightbar.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index d30a6650b0b5..98e514fc5830 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -578,11 +578,14 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
 
 	ret = sysfs_create_group(&ec_dev->class_dev.kobj,
 				 &cros_ec_lightbar_attr_group);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to create %s attributes. err=%d\n",
 			cros_ec_lightbar_attr_group.name, ret);
+		return ret;
+	}
 
-	return ret;
+	platform_set_drvdata(pd, ec_dev);
+	return 0;
 }
 
 static int cros_ec_lightbar_remove(struct platform_device *pd)
-- 
2.22.0.410.gd8fdbe21b5-goog

