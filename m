Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAABC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2F22133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Anfhow4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbfEXUSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:18:40 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:55379 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403923AbfEXUSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:18:39 -0400
Received: by mail-ot1-f73.google.com with SMTP id f18so5004938otf.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kiqJqxPa9FMe/un09kYlU9XPk6LJGKycCrLcq9tmZfQ=;
        b=Anfhow4oytGvhechQ9zPhynVUXijYqC90xGhkZDEgzZrQtziN47vmJAFkY94UCCIlA
         E3qo07I2DuK8VltI8krl/Mr380pl9cVobAYKmPCQ8fX8j1oOllILv+h8K5OlKVThjhQF
         TYSW7SHHMtlyDYgMrLILBQWOFLnGHQqi59qGRQlissn8Zrdz1UcQTFNRTRMWTzhda2kY
         jhmhOf2/lrgpO2q1kI6LDYQ42Y1PjL1IOMK1qscDlGQghyyI22DkZpOb+IdpvJWvkhHt
         aZVl3QpJRqrdcWDJ+9apVpJxVpnt7P5DLhApX2wc2H+XwVkS1Ap2zKuruVCdYtnN/Yas
         ptng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kiqJqxPa9FMe/un09kYlU9XPk6LJGKycCrLcq9tmZfQ=;
        b=MVROEqnyVyHgVZ1uKLNrXd7GD0/DG6/KC9FdXuzg9Ae4X3onEWG1l9cW8DOPbSX4pC
         XuXswjuR6FnZNBzd8IR5CLdP3IlAVBInmDsTV6kyDL2orRnByuZw1KSkDebNmOWdl/X+
         3/vBjeP65HTO5IsdpO/5ETgAz87By+VRXCUgQTPwWP1XMtVAqxiReAxBaqI9aRR1NPa+
         CkMqZyp1vTvUDyOjKjdWUxStq14KfIiYuEbkqRQawiob3f2QcCQpMO5hwPthyZJe43KM
         BQx5g5zK2YQG65uUDIGS/N490MYWlncxg+WjBu5NSlQXkSKJ+CoT2sQLNky96LddWxFu
         m6ww==
X-Gm-Message-State: APjAAAXkYCVMhwGZQYbpXIaacuofLI6aLFnm1yg5QW1G/KUkh0RlA/W3
        8JHGYwMnmgmDlKLprc05V7rVrgDkZA==
X-Google-Smtp-Source: APXvYqyxUrB2uWTPtatgkJdyTUHWio2wNv9xxBoB86a//J6xgGeH5e//FZbxRkGNMNApVpTcG5ZuCsGfTQ==
X-Received: by 2002:a9d:7987:: with SMTP id h7mr2154729otm.284.1558729118905;
 Fri, 24 May 2019 13:18:38 -0700 (PDT)
Date:   Fri, 24 May 2019 22:18:17 +0200
Message-Id: <20190524201817.16509-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] binfmt_flat: make load_flat_shared_library() work
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_flat_shared_library() is broken: It only calls load_flat_file() if
prepare_binprm() returns zero, but prepare_binprm() returns the number of
bytes read - so this only happens if the file is empty.

Instead, call into load_flat_file() if the number of bytes read is
non-negative. (Even if the number of bytes is zero - in that case,
load_flat_file() will see nullbytes and return a nice -ENOEXEC.)

In addition, remove the code related to bprm creds and stop using
prepare_binprm() - this code is loading a library, not a main executable,
and it only actually uses the members "buf", "file" and "filename" of the
linux_binprm struct. Instead, call kernel_read() directly.

Cc: stable@vger.kernel.org
Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
Signed-off-by: Jann Horn <jannh@google.com>
---
I only found the bug by looking at the code, I have not verified its
existence at runtime.
Also, this patch is compile-tested only.
It would be nice if someone who works with nommu Linux could have a
look at this patch.
akpm's tree is the right one for this patch, right?

 fs/binfmt_flat.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 82a48e830018..e4b59e76afb0 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -856,9 +856,14 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 static int load_flat_shared_library(int id, struct lib_info *libs)
 {
+	/*
+	 * This is a fake bprm struct; only the members "buf", "file" and
+	 * "filename" are actually used.
+	 */
 	struct linux_binprm bprm;
 	int res;
 	char buf[16];
+	loff_t pos = 0;
 
 	memset(&bprm, 0, sizeof(bprm));
 
@@ -872,25 +877,11 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	if (IS_ERR(bprm.file))
 		return res;
 
-	bprm.cred = prepare_exec_creds();
-	res = -ENOMEM;
-	if (!bprm.cred)
-		goto out;
-
-	/* We don't really care about recalculating credentials at this point
-	 * as we're past the point of no return and are dealing with shared
-	 * libraries.
-	 */
-	bprm.called_set_creds = 1;
+	res = kernel_read(bprm.file, bprm.buf, BINPRM_BUF_SIZE, &pos);
 
-	res = prepare_binprm(&bprm);
-
-	if (!res)
+	if (res >= 0)
 		res = load_flat_file(&bprm, libs, id, NULL);
 
-	abort_creds(bprm.cred);
-
-out:
 	allow_write_access(bprm.file);
 	fput(bprm.file);
 
-- 
2.22.0.rc1.257.g3120a18244-goog

