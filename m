Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4642C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780C8217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYU3pZEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfEJRs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:48:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfEJRs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:48:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so3586106pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ba+OFE4wADrqdhyYH6+TIYWIg/S9KnHVbFH0H13zsEg=;
        b=MYU3pZEgiE53ih3bb0zbEGz+f5/4taT4mmqyua+dSsI9A16rySGYyjdg9ci4hbJpAM
         QUUttqrVlyCKnw0P34ySrxBWOB7Bi7I+g5B/9oXrEtXsJNqY/q1KBYNqkcUtzz3OL+qf
         moK+LezPCtDLkAYk7pYS+c1AK0OJ9oR2RMTshTt+tjNhlAGAwZgFuezi5XIOB9TM9tNB
         pAxGjtKhRrzYgxPxzds2J+hfaR105cyEIz92pZ3jJFOA1db22p9S5T+A2kAXuIxB1pyO
         7TM6ts2jql68cfFdbGTkaYA0wWioqXQiD18m3nE+A+A1A4xvKT1Cokm05MWLC2otpDH2
         S6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ba+OFE4wADrqdhyYH6+TIYWIg/S9KnHVbFH0H13zsEg=;
        b=FSH/In/VReygv2Oj6tOPC18kdhwhTANN1l6sBuemD1llcRmcCqMj+zfAD9guHRGP8P
         cmxI3EmInQXNTYJ8B2LY3IkJh+EphW67rokTarBoR4rbJI5II3xWwNcfsRSz+R8ophpy
         zfpxx5hbMIQrQzniFGyvncVQUHBswQ8yX9fPhpc/nekcTOmaGr8VHpliElJLAP4Sc5u/
         AJMzmK7A7b3BVxhaReJjeyvhG2uQxCFePWq00ieI8WuzQUQYzmAygJCVBybGz+vAwmdJ
         xE3Vtnz0+PXKMAYUioDo637CI6KeS/SGOtSCMxnOGUHFyQKU4Xds5OjXhp3Df4obrDV7
         W9ow==
X-Gm-Message-State: APjAAAUadZ5GxC69AHoq1UMPpeDu7GzRZ5efFdGN9NtlnA5O/TIf1HJe
        uoKb2SL82EsTT5i/e+fnMZo=
X-Google-Smtp-Source: APXvYqzksanKEkJoZ5Q6d4CvQ+jWvY2Zb9lvhIBTJpeove44FZfS+5UbdAAPI2GxU0pWVaSkyEVd9A==
X-Received: by 2002:a63:61cf:: with SMTP id v198mr15550958pgb.29.1557510538143;
        Fri, 10 May 2019 10:48:58 -0700 (PDT)
Received: from localhost.localdomain ([183.82.23.62])
        by smtp.googlemail.com with ESMTPSA id n64sm12323447pfb.38.2019.05.10.10.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 10:48:57 -0700 (PDT)
From:   Sheetal <2396sheetal@gmail.com>
Cc:     person@a.com, Sheetal <2396sheetal@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] md : dm: Fixed a brace coding style issue
Date:   Fri, 10 May 2019 23:18:37 +0530
Message-Id: <20190510174838.1968-1-2396sheetal@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.
---
 drivers/md/dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 043f0761e4a0..2a8820bd581d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -781,7 +781,8 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 }
 
 static struct table_device *find_table_device(struct list_head *l, dev_t dev,
-					      fmode_t mode) {
+					      fmode_t mode)
+{
 	struct table_device *td;
 
 	list_for_each_entry(td, l, list)
-- 
2.17.1

