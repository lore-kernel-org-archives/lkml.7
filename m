Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6094BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A344218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARAXen5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCPDsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:48:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCPDsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:48:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so7633891pfn.5;
        Fri, 15 Mar 2019 20:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3vF3w329yZiGanrm2XG6dfUHLHdfW1+NmuMyxv7ab54=;
        b=ARAXen5lYt9n+kHiUC577Kk/GfmjUjdQA7hwNYBFrqctQ5EaKNPmr6Q2YzjBt54E3j
         Q+5apPc2RPEWjbzu++Ddr+DnPb8zLfWAw2LSG4erT5QBVpmO55VaCypuyGUZIpdESIqD
         fhcuMdc4RBrM2UMTw2TuDsdCEMjjMvW5naHhbGqmKDrbyGniXa2EDcl/hnAJla3pTY/c
         14ClXYJiCQaJmmDeSKHzmaXdTrE5Z8B57OjKzMZtKDXpoJkNoJedfx3v53aTbhm7VH+h
         ANthd+dT2byHRzXWJZukeCjx0r2O3G4IfH5VR8dtPJvxdFZmc9QfGyW4DRpsft2VzQtE
         IozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3vF3w329yZiGanrm2XG6dfUHLHdfW1+NmuMyxv7ab54=;
        b=U9U3Clxbn4sZV0ObDw9H20Q661NWnJ+/z0yLxZ7zKIoXyZy6pTuTfv1QO+COqUo1SV
         M9WzbSlu3AM2ADTgn1jw6EnizX5wXaV/1aGy/wld6bN24toU2cZqi8C7q9R+UWOaEGKK
         lCspx6WXZcm3d8cizdUJneRQUUr3T/nbyPDJFDD1dWuveg+euF9gbRweqvHPPWnR/FsS
         2XD8jFbckaIICp/uwOjm1t8A+SBbSK7kKqj4ERN+RYU69lRC+62bo/chicMlz0Oi2dbJ
         Ts8p77/5b/GgKbwCUUiVKzudXlVogt13/TRg1kQC+xev9VATfXvm6pAKS2zkNaZzIFBN
         TGRA==
X-Gm-Message-State: APjAAAVpxNlFuJXt1dE/z+F3mKqjYl4ep3srq/N4KPuiFvdbUvqOTaOS
        XubzdZ2voffzHp0APiEMCZA=
X-Google-Smtp-Source: APXvYqziBKo9stUe0BQZ1eq8rvCOIqICGK0sXYASdRhCZ2GhmlrcHTKz+Ow98IBvJgsqDISwLa/9Iw==
X-Received: by 2002:a63:4e4e:: with SMTP id o14mr6876761pgl.254.1552708124695;
        Fri, 15 Mar 2019 20:48:44 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x19sm4621376pfm.108.2019.03.15.20.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 20:48:43 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / core: fix kerneldoc comment for device_pm_wait_for_dev
Date:   Fri, 15 Mar 2019 23:48:41 -0400
Message-Id: <20190316034841.31451-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange comment to make the comment style consistent, the previous
function parameters are described first.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 0cff68bd7b4b..eddb54057ed6 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -2069,8 +2069,8 @@ EXPORT_SYMBOL_GPL(__suspend_report_result);
 
 /**
  * device_pm_wait_for_dev - Wait for suspend/resume of a device to complete.
- * @dev: Device to wait for.
  * @subordinate: Device that needs to wait for @dev.
+ * @dev: Device to wait for.
  */
 int device_pm_wait_for_dev(struct device *subordinate, struct device *dev)
 {
-- 
2.17.0

