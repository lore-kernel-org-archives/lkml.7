Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07077C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7B206CD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHklITN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfIKULL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:11:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33511 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfIKULL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:11:11 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so48951035ioo.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AaoYh6FCL48C0R8R/wQ/0i195JUsJd9aoZEgjtS/br0=;
        b=rHklITN4LJr5H01xXlNHodUsQvBy61D2d6Ki4fuu4CCfTSrTTqhlHScSIPzzX7/+JH
         4M2+FYVswyuU+J5zkNQv2gt4RWbpwFnGTMOwa4SwHRXl0rZr649ggWZeRy7Hb1YjYGqX
         nccd1hTgxNhVcSHn7SzWd5pemJnlKIXKil3o1jqkx6SwrKsgRksJPp9p9tlWyKkQvIuR
         /Shi0XcCG2dV4gjgDslIgs6OJpkeMLHeDyhGmfo6DARxu+afJZQSTnFE60zSZSsUlWIM
         9FsTuBUxGCBmlhnCeiWxNc84AV3BDKamJneOT+Kt3iwfwdC3borsXvHaaUSCCVJxHK/I
         9h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AaoYh6FCL48C0R8R/wQ/0i195JUsJd9aoZEgjtS/br0=;
        b=OJCiFMafybIYNF2/ysKlrh7njdrhKXUWqPJDfcilkvjyOC2/tKYh7S/kH24OfMJn43
         r6wFVr08jrWACu9ozIyOzwPCSAR6zLTlLnxBE2PmMdLGbcr6yvD26n33DDaMgrouYlK/
         MbPZ+28uguLXxDlRiT49fxpbPocsRrRNV7fl6k4pNUQ4W/HWUJIXeQRgeAOtZdhHjGRR
         txCy/3LJ/yXTX05LexslPZ4BT3xBtt4X2tSzzfjqaWgSsk2fMNuysg9CFm7K62NZYea1
         WsA6FpKdPH9KKV5wc41ct6uN/w9wtBdKsai1Wg6xF+3SnpnP3GR5yisE/Dyr4dUyQYHh
         FSiA==
X-Gm-Message-State: APjAAAWlpHITaff+EjOk6tPh6XaHTFzqORMxx4ri+xozgP83HffAdd1J
        CcMAGId/si5CMAmQVSQClek=
X-Google-Smtp-Source: APXvYqxQY8nl3lOx5d6jelT15hsEk1rIHHexz0keOnFjgqy476CmR9qmgJAEQI4QE3W1ASZQeLq/qg==
X-Received: by 2002:a5d:9856:: with SMTP id p22mr8271529ios.231.1568232669164;
        Wed, 11 Sep 2019 13:11:09 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id l1sm9837ioc.30.2019.09.11.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 13:11:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: null check create_singlethread_workqueue
Date:   Wed, 11 Sep 2019 15:10:59 -0500
Message-Id: <20190911201100.11483-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cros_usbpd_logger_probe the return value of
create_singlethread_workqueue may be null, it should be checked.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/platform/chrome/cros_usbpd_logger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 7c7b267626a0..c83397955cc3 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -209,6 +209,9 @@ static int cros_usbpd_logger_probe(struct platform_device *pd)
 	/* Retrieve PD event logs periodically */
 	INIT_DELAYED_WORK(&logger->log_work, cros_usbpd_log_check);
 	logger->log_workqueue =	create_singlethread_workqueue("cros_usbpd_log");
+	if (!logger->log_workqueue)
+		return -ENOMEM;
+
 	queue_delayed_work(logger->log_workqueue, &logger->log_work,
 			   CROS_USBPD_LOG_UPDATE_DELAY);
 
-- 
2.17.1

