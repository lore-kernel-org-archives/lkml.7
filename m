Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AFB2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYYqfaxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLJC2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42493 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJC2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:03 -0500
Received: by mail-io1-f67.google.com with SMTP id f82so17105055ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPQmr4Gy2qdgWTqBpMzYGw3HanW+MuNpIpNa1l5uMF4=;
        b=MYYqfaxx7amuvodVkBYoxleUyRqC1pfVbXXs6vA78zeNMaCMVokY5XNvz7um9vR73v
         x7f1VDPu9sk0VH8rjVjvc+il7QkCS9UuGbf/oLI17Kp1MXqba07WFcc0lmzRcOQc9J7q
         n3zyA7RFd6tcjOhb3SkBQZcP4UZbP5bnA8CzAhGq7VElw+/DNIcmboNOlLw40PQXtTqH
         apHGqf3a47qfKN7VJUqf5vslAuu4MWW29R/Qv7lXjyLFHOyx/8KOV/UpChBgS32QoVYg
         ClJYVGA+8Czbqb5k4pZUo5bEGUslq5hee/zxiW6plEd/q+oz2SHpGEoyDskV9nxzsDKJ
         +tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPQmr4Gy2qdgWTqBpMzYGw3HanW+MuNpIpNa1l5uMF4=;
        b=dAS0iEBKPETlGykAUg9mP9C2VtSH5XH7TCT3TZ4wMzeLF8D260zDSNAVC6K92QlHk0
         AsQGP3FelfrwBIvvs82hvb9ZaJBoSgwrL8vbOS3ELf46KnUsgLzIE2CK01oRmP2kcapu
         GB/WuGq6A309BdNaf2whSkMeq1clX6FfaY1kbGG3t6nt9V5xUYXglOEUvuaN3LaTbIuZ
         9WrO4VnswUzM0qTevmHISfbqzxqFjmWnL49wVzyaz50C/TgnQOAZoF56f2MM86pp8IVz
         UWZ2sp5VJemaawa7okdqkDO7g7vwHfadhsLwsby4GgcYTUiUS/1Gx5bLUh+EmexY11KS
         4mXQ==
X-Gm-Message-State: APjAAAXDfWBgN7MfrUEbH9npo8zDYD7ufcbCrxo0B3ejXiG25kCLmxSP
        SX5UFR0+gi8FlQtlabmoQs8=
X-Google-Smtp-Source: APXvYqycyNVWdtY9UJzlAuGvgSsBafeNbAI4+XjnmsrZ8M3cccL8/OhzgmZwUFg+TCHW/LRZhEeKqQ==
X-Received: by 2002:a6b:6b16:: with SMTP id g22mr24611269ioc.192.1575944883102;
        Mon, 09 Dec 2019 18:28:03 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:02 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 02/16] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Mon,  9 Dec 2019 19:27:28 -0700
Message-Id: <20191210022742.822686-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

