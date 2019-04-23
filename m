Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B7C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECD120859
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPKPpRCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfDWCUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:20:24 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42033 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfDWCUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:20:24 -0400
Received: by mail-yw1-f68.google.com with SMTP id y131so2406175ywa.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=28XRunKZqk302aWQvnGDqHbIv4f3LZqkkzFgLwUiH68=;
        b=cPKPpRCRXvn1m0JbaAyFsGAdgTV2t16TjPQrMFdwHDpU8V3uWSvfgCMRH3HG0VEWxL
         gzO7xgmxQyx5ztcqoDnU/j0e00DsCmT523p+nxKuvWrCOTIqyaYJ9nvRhLbHqogxonPu
         G3UZFFDyjsg9o/f+S9tOdtGgGRJNtbh91OLY6Si34UJJ6FqJxQGRJR1u4Dh+PLh1jSG9
         e1l1bZErI56CHPPvmQz9SbLkrXmGbH21Sh/4rJ18kAs00CKseTWDsnTZTe8wg99nTIA8
         j7HXluqYPVw/fP5bywovbodztbc6qD3lVVqdf3/Kk9WRwvI3oB8sidrRy3Ql2p3WFeE0
         5FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=28XRunKZqk302aWQvnGDqHbIv4f3LZqkkzFgLwUiH68=;
        b=PCWOslW9h6UmNuRDlAfwvJoolj3SVDdtNVmuFKSM9Qr9lMJe3QLZ6KCpjNcte1YDrw
         i9WHvwIUkcaj6qt4cYJkceMel/kPi763Fy/XZSTRnGwg/Xt39N3WL0iBxuI/o4uOctnx
         bDn7wYkvoGMLq76P5MPEevKSNHS1sLB9eMVfY7iru2DzrPpDw4HqyaNVLSDNTULlPccf
         cJGv3Mz+a9ESW3wjlRSai4Ut+ZbnVEnN0GjNp/kC2+qUyttcrTHFZCwyRi2EgC+seqss
         NTT9H/bolACOINCrkKyGxpmCIPqmNXtlw1o5/6DUCFxnfOEbNqhOJTOidc4up8D4zEMl
         BwTA==
X-Gm-Message-State: APjAAAWkwdXirV9B3kYGDvNKdzrunysvQG2hB7SS2v3USuAB7aOb4uab
        kRBbDEnjrDbgDhH0y37J5+0=
X-Google-Smtp-Source: APXvYqxvZ8UNAhAZPyutRAQ2m9Y91XaBrOKrL1/ltQcAl6liv47Xi4iAnSWh7qMfjujyXlh6t6c0hQ==
X-Received: by 2002:a0d:c745:: with SMTP id j66mr19238750ywd.258.1555986023664;
        Mon, 22 Apr 2019 19:20:23 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id k189sm4744066ywa.48.2019.04.22.19.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 19:20:23 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, andrey.shvetsov@k2l.de
Cc:     Bo YU <tsu.yubo@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: protect potential string overflow
Date:   Mon, 22 Apr 2019 22:20:18 -0400
Message-Id: <20190423022018.12214-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There maybe cause potential string overflow issue due to use
strcpy without checking the length

Detected By CoversityScan CID# 1444760

Fixes: 131ac62253dba:(staging: most: core: use device description as name)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/staging/most/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 956daf8c3bd2..0f26cebac91a 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1431,7 +1431,7 @@ int most_register_interface(struct most_interface *iface)
 
 	INIT_LIST_HEAD(&iface->p->channel_list);
 	iface->p->dev_id = id;
-	strcpy(iface->p->name, iface->description);
+	strlcpy(iface->p->name, iface->description, sizeof(iface->p->name));
 	iface->dev.init_name = iface->p->name;
 	iface->dev.bus = &mc.bus;
 	iface->dev.parent = &mc.dev;
-- 
2.11.0

