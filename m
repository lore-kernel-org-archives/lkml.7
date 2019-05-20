Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BA9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583D62173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkXe6QhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfETVo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:44:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35111 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfETVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:44:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so18166630qtk.2;
        Mon, 20 May 2019 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG1n+V7lSXkpzMqb+/8NjtbCanwIJGBK36IxMqbY4ZA=;
        b=XkXe6QhYdB4VBaHnd+Hw8wN/Y+0TnpYdFKrmo7hcj8rXBZprke7XLaK3o3kjb2kgII
         j8UeywVY7urhYKlNbdkNrisExeeYR2xQJPSOpGgrqfTYBaAEWCnaCmdo8AiaPWv7iky8
         TKrDBNg4VRgJxLzmStjdthSSQM4CzG6ZFNyDyUZ5VLPvxLHg+0yKOb3mqVyQ2HSnlUCz
         krxFDiDb2gn4D5HYqQaMquOvI4KwJKJGYwFF1EKwFXWrZ0eRsXGjZNqclF326YWKIekA
         u5Ps3Xb/NG2ylkcveyfWCxc3NYegXkTOed9HSQRaNegXv0ZVVOYhK0358avCV1oI1zWE
         /SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG1n+V7lSXkpzMqb+/8NjtbCanwIJGBK36IxMqbY4ZA=;
        b=LO6pokbNOlGDaG9i3X/XcI3+z8mjkl6bUKf49Jm9FwVsX8K5ZjB0J6At0U5yeqRMmH
         1OeSabDPR0+gS+g9pUYhsuN94I+kbQU99iXC9Wei5tBmS/2UsxcV69NMy9WDPjShgw3K
         1R21IB2zDpHWKiZ5IUYirwzkJi1jLq9dp5yZnCUgcfBse/gShJqSHGvyhjuEMN76MsL7
         MRMpO9hrDiNvb+rPAr0JdFQ3s057w3ncjczlk0/+i5YlasrZ143ZO1Z60hAHwX2EEcCa
         8w+nwbTkK8inc0sd2Fk5eP7PkHri+7Fd3QjO3XDD78Fx6hvcfXr8g+736Djp3IV2U9w+
         XjqQ==
X-Gm-Message-State: APjAAAVCEpFmzm/g0TT4pkH90qSko+ycxJ2sS3aUb0WDFbIcItd/D1uZ
        b/WPn45u9pUbQ+7VP1JH7KzINK0Y
X-Google-Smtp-Source: APXvYqzt4IDFt1AZwTag4af5BRZAFJpMQsCgSRKuwLRjSHrIKwRouZR8/szIXmPOeVaOtguKBbtThA==
X-Received: by 2002:a0c:b0e7:: with SMTP id p36mr24385686qvc.25.1558388692707;
        Mon, 20 May 2019 14:44:52 -0700 (PDT)
Received: from localhost.localdomain ([179.185.210.219])
        by smtp.gmail.com with ESMTPSA id t30sm11427530qtc.80.2019.05.20.14.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:44:52 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH 4/4] md: raid0: Make ret local in raid0_run
Date:   Mon, 20 May 2019 18:44:27 -0300
Message-Id: <20190520214427.18729-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520214427.18729-1-marcos.souza.org@gmail.com>
References: <20190520214427.18729-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret variable is only used in a specific situation, so make it local
instead of global.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/raid0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index e72255464c09..b28dbb797f76 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -364,7 +364,6 @@ static void raid0_free(struct mddev *mddev, void *priv);
 static int raid0_run(struct mddev *mddev)
 {
 	struct r0conf *conf;
-	int ret;
 
 	if (mddev->chunk_sectors == 0) {
 		pr_warn("md/raid0:%s: chunk size must be set.\n", mdname(mddev));
@@ -375,7 +374,7 @@ static int raid0_run(struct mddev *mddev)
 
 	/* if private is not null, we are here after takeover */
 	if (mddev->private == NULL) {
-		ret = create_strip_zones(mddev, &conf);
+		int ret = create_strip_zones(mddev, &conf);
 		if (ret < 0)
 			return ret;
 		mddev->private = conf;
-- 
2.21.0

