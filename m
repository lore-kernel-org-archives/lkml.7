Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF5C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33812223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9weTodO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfGWM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:26:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41330 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGWM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:26:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so19082525pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d+pnG65HXsnRmlzhaNNzk6y1yw6MWg2lSfilUvi/rLw=;
        b=V9weTodOYCYaFd7X60mM2I0iNT2dJQddnTuM96ykARlIZO67gGvp+UQa2YlwCxGAaF
         Uk+SHoks11jMp8cTcExW76F8m+UwjFNGkT639eWlWP0AmGb5c13LsC8p9rx+1LMac0JX
         cj/teAaKGGjSunYWoqBM4aD8BpXrJ4vZVkErEJAVlzZi7E2+ieYK6hIwC6GSDfniTuu+
         /yyf1+SDD2Yj5F8v/ZdaFgdMFyFHBE9DHRHPe3VGLxh1FQCyhdgANw8O7wFYNF+z9hyU
         ZdisoYQHQu/NPOt4wd346std2iUJ2Qzph4fOv1kiEiTfWTAdCHUmtdS4lxDfyBYjQeCb
         vzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d+pnG65HXsnRmlzhaNNzk6y1yw6MWg2lSfilUvi/rLw=;
        b=Q8hVCMLnHXO6njzoWFYasruOK5KRZecbJ1oGolJlQEIb48rV9wrfNeB+WE21C4WfWS
         mpl6O+ErYXbNzjb+ZZw6uEvhCgBj0ctHH9VIQks24akCqdVJODTWpiNJ33+lyuIeVwU5
         vfr4pT1pFBSCrieEHKu6HnP9Q92zvR3IVGyo2b/ylBPb2O+gCIHA3UL84uQk+5xag9BU
         S0zr18wws33G4zCaBtxkj2paHlJy310Jilor9GVxk5Lv/U+gX1s3mixWcMybTIRu0Wtd
         /cIEtfyo9Rn6fiHRYyHiEO7tRJyU1GGx8NBj+y5KTxbSVDpLrSEatyYTt3tsMmVkBUjl
         y1SQ==
X-Gm-Message-State: APjAAAUWNkPdWUH10gHKXfZ/XeqD55/psP5or9Lqt+rhJ2tHvMnUYhOd
        NeB/9jNmrCAQ53CIc4HDbYY=
X-Google-Smtp-Source: APXvYqwsAvz00r+/iJSmZPzm8Ll2VIOWh2HmWmohM5cYcM4y9UywSWl2Dd7u7Nbtl+V7bw2okgG3TA==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr84704034pjr.113.1563884760953;
        Tue, 23 Jul 2019 05:26:00 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id g18sm75138115pgm.9.2019.07.23.05.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 05:26:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: afs: Fix a possible null-pointer dereference in afs_put_read()
Date:   Tue, 23 Jul 2019 20:25:53 +0800
Message-Id: <20190723122553.14565-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In afs_read_dir(), there is an if statement on line 255 to check whether
req->pages is NULL:
	if (!req->pages)
		goto error;

If req->pages is NULL, afs_put_read() on line 337 is executed.
In afs_put_read(), req->pages[i] is used on line 195.
Thus, a possible null-pointer dereference may occur in this case.

To fix this possible bug, an if statement is added in afs_put_read() to
check req->pages.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/afs/file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 56b69576274d..dd3c55c9101c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -191,11 +191,13 @@ void afs_put_read(struct afs_read *req)
 	int i;
 
 	if (refcount_dec_and_test(&req->usage)) {
-		for (i = 0; i < req->nr_pages; i++)
-			if (req->pages[i])
-				put_page(req->pages[i]);
-		if (req->pages != req->array)
-			kfree(req->pages);
+		if (req->pages) {
+			for (i = 0; i < req->nr_pages; i++)
+				if (req->pages[i])
+					put_page(req->pages[i]);
+			if (req->pages != req->array)
+				kfree(req->pages);
+		}
 		kfree(req);
 	}
 }
-- 
2.17.0

