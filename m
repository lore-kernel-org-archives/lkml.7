Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B0C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA06F21882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NLQ6dNGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKITSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:18:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44639 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfKITRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:17:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so7356001pfn.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdlwD0l05r56537ZBZYEooUnd8vbBxRtlaKpE7fqAgY=;
        b=NLQ6dNGBL5ct6UJg2zXevzC9R85rhjVpEA/eT4radmFPIgj37/pjxfoV34DQie4lTh
         TE4+U3wNwWf4Ci2oq0z1pRyZ7I7ZfIheiQWvUXZopwXMO8fYuFLiGtXNCXjOOTOdD7mX
         rESo8a7OKHr6CB4kPC5aiR1O8Qig+P5oawiuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdlwD0l05r56537ZBZYEooUnd8vbBxRtlaKpE7fqAgY=;
        b=S5C9um2VzP0EqJqh6GyYd9yYhcuvlpIRs4Ak040BoI4I4rEKwfgws9aqm1nPSEwOVT
         CpwFVDPiLgyxWJJMK4ZiD2Z+fWn0zsRENQdz/Jtqs3Vy7AvTdHRTd5sHZ5WwZDATmWR2
         KxJRvDdMECzuuDVb899tZ2VKrf0pVr2TJ+6Gcalm/Eh0PDZwKbE9rT9Dj9UbNK1rMb8v
         S3zSXc5T/TvN/63hlbxoc3cXoktOvu29D6zRVvGMwtHPRd3o35K/KTW1WE57GXi5AZkl
         ca6gAxgjEj0mWR89hzWPbnuLlP9heF8d7MYiAsEfHFhXZMexV0njjK0NXLDdc+u918yX
         e6Pg==
X-Gm-Message-State: APjAAAW1Iymmxb7uQGnXsO+OrhPv4Nzb8H8NOAowvnfMYTutgZWWtUYg
        8I/iu4nsWE9P+6XbITmRrxp/hQ==
X-Google-Smtp-Source: APXvYqyTjqH2ukN5+R/IrhRSCm7VfIfTxcGx/J78VEuTMSsmPKQJE+5BxRcNcYkWSBUKVLBqE+l7Nw==
X-Received: by 2002:a63:555b:: with SMTP id f27mr19571417pgm.66.1573327071863;
        Sat, 09 Nov 2019 11:17:51 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i11sm9193577pgd.7.2019.11.09.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 11:17:51 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     qiaochong@loongson.cn, kgdb-bugreport@lists.sourceforge.net,
        ralf@linux-mips.org, Douglas Anderson <dianders@chromium.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3/5] kdb: kdb_current_task shouldn't be exported
Date:   Sat,  9 Nov 2019 11:16:42 -0800
Message-Id: <20191109111623.3.I14b22b5eb15ca8f3812ab33e96621231304dc1f7@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191109191644.191766-1-dianders@chromium.org>
References: <20191109191644.191766-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kdb_current_task variable has been declared in
"kernel/debug/kdb/kdb_private.h" since 2010 when kdb was added to the
mainline kernel.  This is not a public header.  There should be no
reason that kdb_current_task should be exported and there are no
in-kernel users that need it.  Remove the export.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 4567fe998c30..4d44b3746836 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -73,7 +73,6 @@ int kdb_nextline = 1;
 int kdb_state;			/* General KDB state */
 
 struct task_struct *kdb_current_task;
-EXPORT_SYMBOL(kdb_current_task);
 struct pt_regs *kdb_current_regs;
 
 const char *kdb_diemsg;
-- 
2.24.0.432.g9d3f5f5b63-goog

