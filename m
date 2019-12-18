Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5491EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE0206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="JNCjZmNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLRTlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:41:24 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:48716 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLRTlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:41:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47dQNz08nDz9vcq7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kzMQNEJxxKlG for <linux-kernel@vger.kernel.org>;
        Wed, 18 Dec 2019 13:41:22 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47dQNy6CVTz9vcpq
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 13:41:22 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id w201so2231384ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SiDmZNoQXFEcl7yVDXM3R0M8H/sqVHoG7bdcTP5j+64=;
        b=JNCjZmNWMKST0iiCgw7dEan9ld1P1h656d1BeUgNF9wrOPH5HetsBoVCzUV/sgySIa
         TOBiVx1H66NfY85gMwosAwDW8D3bk/Xaq1nfsXooNg/KpakfE3ncr54l4Vev7HPSFlS0
         lELNz5D+/n39G/fkaZpGfJoXrawPM4JCwZfIHrKECZCqwo0WhFu5KvqBdh8709OpDFu5
         wSJgG2L2vJHISVky072ODNM2wLwCK9MhK/vULAtLmLw7f8emliFqEeCvQWVZyeVs8czi
         xj7B0H//5noSy4UbaXWGjFJBromlUNHSUfkbVGE++YY9iDiVv6fTLIyiRMpGPSmNriE1
         AyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SiDmZNoQXFEcl7yVDXM3R0M8H/sqVHoG7bdcTP5j+64=;
        b=B2JtTW4UNxTNJu/8zu9L6Pipe5wV5paxrk91gHIdm8M0lL4FTHfVHd9YcOb2Dyy1Jh
         UMnPIzH6s1SSvq+dZYpZ4QoVa+nkUl3rmG2vxWagpPC1njO2BaVMry29q+YeTqZD57jy
         g6gGqLavgaIsMEZ9ZkvM70BD6Mz01P0LkEhEs6tBOtKodpCIAZbP2u0RhD3FxV6R2P8t
         8MeJK3/xEY05gibBlH7oseQBIQKbSMP3+gLdlDdp5q9dwmgQu0zChrJ7j0R5iZ/pJfrD
         Do2wHA10IiyQ+e5FIM9JKlFDOyWhMJDqgJPuGqyMoHyMH/xgXcLgJwMm2UpFPX+cBjmD
         85dg==
X-Gm-Message-State: APjAAAUanhltDEwjlQgXQKwfntOFzkbkHGb0ANSmamuVysA2j3utrIvQ
        AhZjG7j1jB/GguVI2r5VyLKaJDzfyBTl8DOuKQ0zw8pjUNgZq49VcBs4HBSwmvov/vSaPYIAset
        QYS506/DvkSj+Sz5mGaC8JnYuYXOP
X-Received: by 2002:a25:df84:: with SMTP id w126mr3398814ybg.387.1576698082267;
        Wed, 18 Dec 2019 11:41:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqxufG1FJND97H7MEWHxU0UN3M1YrANV55Ca7YalOSOFtNRH/G2rXv697I6cXXfOtLCnlSjw==
X-Received: by 2002:a25:df84:: with SMTP id w126mr3398799ybg.387.1576698082023;
        Wed, 18 Dec 2019 11:41:22 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id n142sm1350146ywd.26.2019.12.18.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:41:21 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        ChenGang <cg.chen@huawei.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ocfs: remove unnecessary assertion in dlm_migrate_lockres
Date:   Wed, 18 Dec 2019 13:41:08 -0600
Message-Id: <20191218194111.26041-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the only caller of dlm_migrate_lockres() - dlm_empty_lockres(),
target is checked for O2NM_MAX_NODES. Thus, the assertion in
dlm_migrate_lockres() is unnecessary and can be removed. The patch
eliminates such a check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/ocfs2/dlm/dlmmaster.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 74b768ca1cd8..3b239637f884 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2554,8 +2554,6 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
 	if (!dlm_grab(dlm))
 		return -EINVAL;
 
-	BUG_ON(target == O2NM_MAX_NODES);
-
 	name = res->lockname.name;
 	namelen = res->lockname.len;
 
-- 
2.20.1

