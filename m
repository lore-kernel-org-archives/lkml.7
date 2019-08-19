Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE13C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795F21852
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfHSASl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 20:18:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35299 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHSASk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:18:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id c9so41762ybq.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 17:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7J6zazvwWXJHLLGTA9d2Z5bIVQ61P1OZdxnYyH/AmRU=;
        b=FNuQ1T8CfIyUV2cuQ05eCFM0Uci1l2fjQ0mrftar/xk+RcMB42rXUe5y0Nef5Zl59j
         yQ3vAMsBd4y3OgMeq3mGWA0qChziuOdO6jlnuA7B4DhM9fKatNJPlN/fXQgWBikjV6tS
         GPQyUSisY9HhTlCJorNfwpKC5nngXYVhzVYIiL7CX/+GXfTynHvG/qepppDb7AXJ6ooy
         zsIvaqsNwVmXVct1UeMu5eHV2GEAfwh2JS7YWhrR34JmRZCDcsaJ2StqBI6s8jYH0E1K
         i+DQLGeg5JBK2jQ0xvc45cpsYqFkoUrAjRtgJW2lxAQbKhnei8VLBzyo11wORzmaX0UG
         i5KQ==
X-Gm-Message-State: APjAAAV+GLjhsinxjYGigsiNa8dlNvnYFhFDMoGEOsPKrsGy/e4r9hM1
        d1eOYYOOMBfWm3BuM1VhAw0=
X-Google-Smtp-Source: APXvYqzpMpeg5ZYDdaIdaLiIVqUk7tCMN8jbmPiKcFf6wLPPgWKLIyRxVTZGiw+HkMAlqepm9rWNgQ==
X-Received: by 2002:a5b:543:: with SMTP id r3mr9244165ybp.193.1566173919870;
        Sun, 18 Aug 2019 17:18:39 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id w4sm2886984ywa.1.2019.08.18.17.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 17:18:39 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com (maintainer:DEVICE-MAPPER (LVM)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dm raid: add cleanup in raid_ctr()
Date:   Sun, 18 Aug 2019 19:18:34 -0500
Message-Id: <1566173915-5837-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rs_prepare_reshape() fails, no cleanup is executed, leading to
memory/resource leaks. To fix this issue, go to the label 'bad' if the
error occurs.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 8a60a4a..1f933dd 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3194,7 +3194,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			  */
 			r = rs_prepare_reshape(rs);
 			if (r)
-				return r;
+				goto bad;
 
 			/* Reshaping ain't recovery, so disable recovery */
 			rs_setup_recovery(rs, MaxSector);
-- 
2.7.4

