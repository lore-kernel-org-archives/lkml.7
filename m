Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15125C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E6520862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGnLzbHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEOPKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:10:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfEOPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:10:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so926495pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RE3rROYrnRy9dzJlfq5HaPSGvEaqruy6o+oeyqIs+KA=;
        b=sGnLzbHVXINa3w12ryeASVNrqBd5j3WAzT4wyHj6YXCdAOIJpfuKw4QD+uHoB2isJb
         JpS0qKctF9ltax6iUA/F/L61XZchWjSYC3r6cvS/4bJN+sQ2qb2gLnSpcEShH3JPHtZR
         8UfxpWeUtfa4qUWO6w/GxaCi4kCy43DceI8FFieNAqcPmgcf6wRmeDrnzmhQlxjemG4p
         Ex1mJOU8yhSLNfNtYAnahaOuvmNa29tKORcxQ+uLN2CL04Bs3yDPoZfSK34MMS0KTf+5
         Yr5R/nt/z+y8/qjZuA93JqyykgMQR8nbWFyGVJl1fhlr9qnLZfcmOZtAUW8bcQhsrDR1
         ANRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RE3rROYrnRy9dzJlfq5HaPSGvEaqruy6o+oeyqIs+KA=;
        b=E0pHKGh7Vhu3Jlk4OWFO0wl42Y9yiJWR2B7d1gvtkwtqxZtkjY+UufPjAz9CgBFHwb
         FSdvEni5u5PUsWe6cEYZaXjn1uHkje1xaulsYHdoCXkhLOZX91h8Oza+spzK5LzFSMVx
         V8hVwERy4A/wAkq4p4HBy1mAeue1fYewx3Aaa/3U9iHrRPQfqgx0NPnb7O9+OvuB8ZpB
         +O9Iwx4m3E3l2sOB2t7ro0N6OISDcxfC2y01Mh4eSvNrxlDgCOLfTqLpLJb0pePcsG7l
         IxoN/h2YRVihvHHVyf4+2AOxahw7EVjm4WQpZlT/MzIb1JlCYEY7Bx3j/yLxYuLO2m0t
         IJRw==
X-Gm-Message-State: APjAAAWd8OWtUjk26eHr3PZLMRitzxVjCZRcZylHftJrjqbLXzBElYI/
        p8n+zcvm23JgNdIJzwUkQNI=
X-Google-Smtp-Source: APXvYqwkwOw18KoYBR+A/eVE+22Tiuv1k3qXYKDA0ZryVt9c6F1EpPZ58BAgsSclyxpi30Tv2rKoDw==
X-Received: by 2002:a63:ed16:: with SMTP id d22mr43684184pgi.35.1557933003530;
        Wed, 15 May 2019 08:10:03 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id f28sm5939059pfk.104.2019.05.15.08.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 08:10:02 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH v2 1/1] bsr: do not use assignment in if condition
Date:   Wed, 15 May 2019 20:39:52 +0530
Message-Id: <20190515150952.28570-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

checkpatch.pl does not like assignment in if condition

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/bsr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index d16ba62d03a0..935d4b300340 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -322,7 +322,8 @@ static int __init bsr_init(void)
 		goto out_err_2;
 	}
 
-	if ((ret = bsr_create_devs(np)) < 0) {
+	ret = bsr_create_devs(np);
+	if (ret < 0) {
 		np = NULL;
 		goto out_err_3;
 	}
-- 
2.17.1

