Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0506C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B4920835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUXYnPJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfK0Rup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:50:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44390 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Rup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:50:45 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so12334870iln.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPQmr4Gy2qdgWTqBpMzYGw3HanW+MuNpIpNa1l5uMF4=;
        b=aUXYnPJGTfhmmdmRXkhRssANa3FP4VNSyxHaauee/olzYY1Eb2AKfpz/lHdzElh+Ke
         ofXA9TwbPPG7QQC4kO7BuhFXW0r8K4h7ftZWd0FbszzawhTR+MYHu0gm4mqSo8eu3gej
         fMie+82APTO9sT5M9XIp5tnqxwBz0+Rqxi36OK05FtVt+DEu1jO5rBdA54u2tW4UqxVg
         mv/nSW74a0WVHZWiU/bmhMisInhtHmU9UP5QeyFnZFHtM30ZFA7hR2Gd3AzSt9mzcKu3
         Att+n2HeT2IuTjX6saSu91Uzecmqz2nBmvaS5ifgq7xaNzWVany4px9ddc5eIOFJ+dU9
         Tsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPQmr4Gy2qdgWTqBpMzYGw3HanW+MuNpIpNa1l5uMF4=;
        b=Gw/1UHQIuuTUlW90XNf19LMHkXSmj4udMLI0Lj33Ct4RDljduuzCw4SIv5/zrM2quu
         PTGfDeZKpLgHnfkxu8gPBkY4G2DVTylocWQBgid/hN4SV4lUtMe7zDPzLiii4TJH/o9N
         3vHwpuK8tsM1HQ6QDpVm14S/JHeVzeI88wJkUpkq+13UIZum5bPLoLducVPtmfLmcG0D
         ElsBDntT8gkFPJunDjlOODEZlQH/7HLH5tHSqIa88llM0KvcKz6ccStk+RqON+GndKcT
         hWNHBPPIcpSJSN5iy2V/Sl4YyBwH3WmnZCtDm8O6hxEtFvkNsJOmXQoxvc87u1rML4/Q
         +zww==
X-Gm-Message-State: APjAAAVaeAEKUwg+oVGuiJGZkqQI+4ph3Z0bLuzJPI14XiUJZZH4R9IE
        tDcjaZwKEvGNzTLbI5KVVoM=
X-Google-Smtp-Source: APXvYqwNA+u2ncyGleHE6ttKjoY9mlO1t4Fh+Zsrqv8sgPsP7cZI2YYaHVmhlhXxEJuj1S3uIrdveQ==
X-Received: by 2002:a92:3984:: with SMTP id h4mr2462992ilf.36.1574877044279;
        Wed, 27 Nov 2019 09:50:44 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id d8sm3791783ioq.84.2019.11.27.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:50:43 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 02/16] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Wed, 27 Nov 2019 10:50:36 -0700
Message-Id: <20191127175036.1351226-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4bad78c55002 ("lib/dynamic_debug.c: use seq_open_private() instead of seq_open()")'

The commit was one of a tree-wide set which replaced open-coded
boilerplate with a single tail-call.  It therefore obsoleted the
comment about that boilerplate, clean that up now.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..6cefceffadcb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -853,13 +853,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 	.stop = ddebug_proc_stop
 };
 
-/*
- * File_ops->open method for <debugfs>/dynamic_debug/control.  Does
- * the seq_file setup dance, and also creates an iterator to walk the
- * _ddebugs.  Note that we create a seq_file always, even for O_WRONLY
- * files where it's not needed, as doing so simplifies the ->release
- * method.
- */
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
 	vpr_info("called\n");
-- 
2.23.0

