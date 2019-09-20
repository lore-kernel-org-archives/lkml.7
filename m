Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAFD217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSEgmE+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbfITCfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:35:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34900 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389457AbfITCfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:35:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id a24so2965578pgj.2;
        Thu, 19 Sep 2019 19:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ugmLODnp5Ju67vMMqqqCIbBOUrUWvgKB0fIc+6F3Yew=;
        b=XSEgmE+qmnjsp3Fqv+LkE3tOM7JSsolwO3n3GSI5vw7pcXTsWsHzldr3CtmbXatwmo
         xOLYY9uUV+KlvLcmhwYMJT/8yYxJngWji4szVyPdCi7cD1h0ErQFTcA1hgtYYM97cAc7
         h0YWOblL30oXjQGo2DtvTmb9gDhcQSmTuMSojY5KrcN7d4TAtjqsFwnool/nDSiNMSaI
         70bToIhSsws3YTRXlFJouaHxEsoHFFyZ2dP4sSEtsxH0o8RnJG6bJD2dsjpNCUl+7+p+
         PWZnb4+KSSUiaTFEVFWu/CNVM7AqsvohkIqmQvRi3tAfKnfZHz5dp5OPAJIhK8sbk9AP
         dTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ugmLODnp5Ju67vMMqqqCIbBOUrUWvgKB0fIc+6F3Yew=;
        b=k2IX9XuBEjnujuBO/RMJQblNO+vKLMZ1pLGiKuqM/ZWu+lCIkZcUFKhT4MAZuj+5D+
         g6AtwXlWytZXWZwqi9C1fHKvTn3FOakIlRRPnhq0pescD7SO8F65Nks+XrGtQRMsDDZI
         AiZrkhD/vHWun95zo1rOyVgXBEQb16EHlgt5BDa8EpGqfi5awc+LslFQBxCoYN2gQFM/
         rVeCbdFVBNag8wSUP7dEL4Q3Y4azQMnErDVC5dAftY8Nc/NliF1h9bs742fu/UC/4bV5
         YNwelc2+rjBvRiYCfuQY4I3Oex/Zd38H1/J97TWFFLz6oyveg8jIfemDpeWVGCxI1EJ4
         MYfg==
X-Gm-Message-State: APjAAAWKolciDE1xgspyl/SNRyVU8s4T1BK+pexfbSeAuU/9erpuosU+
        hribo6j0ZRIWu3+RYgPG6ZU=
X-Google-Smtp-Source: APXvYqw8+hTBufmT3FCfcdY8RIFheJ9AV3Yu1lS7GCkXuvA1OAzRRt7FPjZizHtVo+eTYHEavpL7dQ==
X-Received: by 2002:aa7:8813:: with SMTP id c19mr11714619pfo.101.1568946917962;
        Thu, 19 Sep 2019 19:35:17 -0700 (PDT)
Received: from localhost.localdomain ([106.51.105.17])
        by smtp.gmail.com with ESMTPSA id n15sm230932pgl.80.2019.09.19.19.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 19:35:17 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3] HID: hidraw: replace printk() with corresponding pr_xx() variant
Date:   Fri, 20 Sep 2019 08:05:01 +0530
Message-Id: <1568946901-29752-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190919161613.GR237523@dtor-ws>
References: <20190919161613.GR237523@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit replaces direct invocations of printk with
their appropriate pr_info/warn() variant.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v3:
* Use hid_warn() subsystem specific variant instead of pr_warn()

 drivers/hid/hidraw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 006bd6f..a42f4b5 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,15 +197,15 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	}
 
 	if (count > HID_MAX_BUFFER_SIZE) {
-		printk(KERN_WARNING "hidraw: pid %d passed too large report\n",
-				task_pid_nr(current));
+		hid_warn(dev, "pid %d passed too large report\n",
+			task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (count < 2) {
-		printk(KERN_WARNING "hidraw: pid %d passed too short report\n",
-				task_pid_nr(current));
+		hid_warn(dev, "pid %d passed too short report\n",
+			task_pid_nr(current));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -597,7 +597,7 @@ int __init hidraw_init(void)
 	if (result < 0)
 		goto error_class;
 
-	printk(KERN_INFO "hidraw: raw HID events driver (C) Jiri Kosina\n");
+	pr_info("raw HID events driver (C) Jiri Kosina\n");
 out:
 	return result;
 
-- 
2.7.4

