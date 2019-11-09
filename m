Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0916CC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82F221882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/eGJl9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfKITR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:17:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40295 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfKITRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:17:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so6320227pgt.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY/VtRKwYYhLwNyDqkkRR3WLEh0rigRGo+K8ilv6++I=;
        b=g/eGJl9U1jxbmYciVtsfJlQad5WJ9yjfHBla5ZFyS8bkdypSn6QJNcS+QzONHVDmxz
         c3bkKkAA9KmJyZdaBb/uS1OAnpIVOPuWkOHCwaNST4/PMCibEJWbUj2oec78TJVoaXAh
         ZbYGWvn9nzwcN52NfDz5SD0MvWzK4S78iTyQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY/VtRKwYYhLwNyDqkkRR3WLEh0rigRGo+K8ilv6++I=;
        b=Eca2NgC9Fc0kFJVWQI1/WrChMC2yWvZeXt0nNCH0bGiVmDtXcdfPYUFUFEuGW3Q98n
         SZ0KAOjpAv4Bkl1gtTe7G1JZkf5HhTBjQzk+wudKxGvWFgldMnUp//M5mS1c4ht0SeuW
         Is1CrAi50Z83xLzw4VIpkByGF1RHZUZq7PJ+ebirend1nmdJXtRbuzoKN3m9ShrJpwho
         jhiMIRUVTevgT4Mibu7q4/6OPocsSLwkxjGXVpOKTlIrwcds6t3g2LPYk/AtmuHo+Rie
         +IPiXSFBuNc3EB6Uq4qC1bjx30CJ4Hd/VEl+SnGD5qasB9mURxeIlkmiPPq/xJPjH0bj
         FeFg==
X-Gm-Message-State: APjAAAVsMdNXuKsvS7WbNuGNkq/8sa2GZyy4qyPG/zS7ANU5/4oyTtT2
        s8Wkm1QvIS9valkb7g6wuCnl5Q==
X-Google-Smtp-Source: APXvYqwLoettSe3c6USEi+mt/ICgOC1tLDB2bnaxht2vYq9Nq+Ctfo+iismzUSyrS1z789xLf+LMZA==
X-Received: by 2002:a17:90a:ba89:: with SMTP id t9mr22462463pjr.138.1573327074178;
        Sat, 09 Nov 2019 11:17:54 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i11sm9193577pgd.7.2019.11.09.11.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 11:17:53 -0800 (PST)
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
Subject: [PATCH 5/5] kdb: Get rid of confusing diag msg from "rd" if current task has no regs
Date:   Sat,  9 Nov 2019 11:16:44 -0800
Message-Id: <20191109111624.5.I121f4c6f0c19266200bf6ef003de78841e5bfc3d@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191109191644.191766-1-dianders@chromium.org>
References: <20191109191644.191766-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you switch to a sleeping task with the "pid" command and then type
"rd", kdb tells you this:

  No current kdb registers.  You may need to select another task
  diag: -17: Invalid register name

The first message makes sense, but not the second.  Fix it by just
returning 0 after commands accessing the current registers finish if
we've already printed the "No current kdb registers" error.

While fixing kdb_rd(), change the function to use "if" rather than
"ifdef".  It cleans the function up a bit and any modern compiler will
have no trouble handling still producing good code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index ba12e9f4661e..b22292b649c4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -543,9 +543,8 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,
 		if (diag)
 			return diag;
 	} else if (symname[0] == '%') {
-		diag = kdb_check_regs();
-		if (diag)
-			return diag;
+		if (kdb_check_regs())
+			return 0;
 		/* Implement register values with % at a later time as it is
 		 * arch optional.
 		 */
@@ -1836,8 +1835,7 @@ static int kdb_go(int argc, const char **argv)
  */
 static int kdb_rd(int argc, const char **argv)
 {
-	int len = kdb_check_regs();
-#if DBG_MAX_REG_NUM > 0
+	int len = 0;
 	int i;
 	char *rname;
 	int rsize;
@@ -1846,8 +1844,14 @@ static int kdb_rd(int argc, const char **argv)
 	u16 reg16;
 	u8 reg8;
 
-	if (len)
-		return len;
+	if (kdb_check_regs())
+		return 0;
+
+	/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
+	if (DBG_MAX_REG_NUM <= 0) {
+		kdb_dumpregs(kdb_current_regs);
+		return 0;
+	}
 
 	for (i = 0; i < DBG_MAX_REG_NUM; i++) {
 		rsize = dbg_reg_def[i].size * 2;
@@ -1889,12 +1893,7 @@ static int kdb_rd(int argc, const char **argv)
 		}
 	}
 	kdb_printf("\n");
-#else
-	if (len)
-		return len;
 
-	kdb_dumpregs(kdb_current_regs);
-#endif
 	return 0;
 }
 
@@ -1928,9 +1927,8 @@ static int kdb_rm(int argc, const char **argv)
 	if (diag)
 		return diag;
 
-	diag = kdb_check_regs();
-	if (diag)
-		return diag;
+	if (kdb_check_regs())
+		return 0;
 
 	diag = KDB_BADREG;
 	for (i = 0; i < DBG_MAX_REG_NUM; i++) {
-- 
2.24.0.432.g9d3f5f5b63-goog

