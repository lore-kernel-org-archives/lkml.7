Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C115CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0779622474
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436602;
	bh=3fIb/XpE5v/FmqlNuybYCPwnbwJAl3gVKkv+KO2OZGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=caQ2HLjfJmDXj4Ctp/Oql8Fz9wki8nHcz4XncqAlvT25L2sjpiFCKplCAeIAa/lVA
	 izuaNatUYQsvm+2aRjK5sMjw8AiiBl/iIquApJlFdJO3+NzwNPHbT9r/sHjr8v+icl
	 ZXGCQRJUbLclTv/lh3uWqJYDj6VkvG7rUfDRxLt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbfJRWKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389049AbfJRWJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA3F22468;
        Fri, 18 Oct 2019 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436577;
        bh=3fIb/XpE5v/FmqlNuybYCPwnbwJAl3gVKkv+KO2OZGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+7r/xosIiGmb/zp1zW18pp99Cch0VBJQlJCXl8sl7AA6HiyLvXsFd54WetQhpfHF
         gHsg9ufzVcU3IRsuU0PR+nG2nCkkBFgEDjalDoW0+ikh2MF3UUbNCRC+hlDNlGSp//
         7TpXPQCz2vLHhSLWhj2BvdabqNtkIHSu0gM/d1AY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/29] exec: load_script: Do not exec truncated interpreter path
Date:   Fri, 18 Oct 2019 18:08:59 -0400
Message-Id: <20191018220920.10545-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220920.10545-1-sashal@kernel.org>
References: <20191018220920.10545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit b5372fe5dc84235dbe04998efdede3c4daa866a9 ]

Commit 8099b047ecc4 ("exec: load_script: don't blindly truncate
shebang string") was trying to protect against a confused exec of a
truncated interpreter path. However, it was overeager and also refused
to truncate arguments as well, which broke userspace, and it was
reverted. This attempts the protection again, but allows arguments to
remain truncated. In an effort to improve readability, helper functions
and comments have been added.

Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Graham Christensen <graham@grahamc.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_script.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index afdf4e3cafc2a..37c2093a24d3c 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -14,14 +14,31 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 
+static inline bool spacetab(char c) { return c == ' ' || c == '\t'; }
+static inline char *next_non_spacetab(char *first, const char *last)
+{
+	for (; first <= last; first++)
+		if (!spacetab(*first))
+			return first;
+	return NULL;
+}
+static inline char *next_terminator(char *first, const char *last)
+{
+	for (; first <= last; first++)
+		if (spacetab(*first) || !*first)
+			return first;
+	return NULL;
+}
+
 static int load_script(struct linux_binprm *bprm)
 {
 	const char *i_arg, *i_name;
-	char *cp;
+	char *cp, *buf_end;
 	struct file *file;
 	char interp[BINPRM_BUF_SIZE];
 	int retval;
 
+	/* Not ours to exec if we don't start with "#!". */
 	if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!'))
 		return -ENOEXEC;
 
@@ -34,18 +51,40 @@ static int load_script(struct linux_binprm *bprm)
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
 		return -ENOENT;
 
-	/*
-	 * This section does the #! interpretation.
-	 * Sorta complicated, but hopefully it will work.  -TYT
-	 */
-
+	/* Release since we are not mapping a binary into memory. */
 	allow_write_access(bprm->file);
 	fput(bprm->file);
 	bprm->file = NULL;
 
-	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
-	if ((cp = strchr(bprm->buf, '\n')) == NULL)
-		cp = bprm->buf+BINPRM_BUF_SIZE-1;
+	/*
+	 * This section handles parsing the #! line into separate
+	 * interpreter path and argument strings. We must be careful
+	 * because bprm->buf is not yet guaranteed to be NUL-terminated
+	 * (though the buffer will have trailing NUL padding when the
+	 * file size was smaller than the buffer size).
+	 *
+	 * We do not want to exec a truncated interpreter path, so either
+	 * we find a newline (which indicates nothing is truncated), or
+	 * we find a space/tab/NUL after the interpreter path (which
+	 * itself may be preceded by spaces/tabs). Truncating the
+	 * arguments is fine: the interpreter can re-read the script to
+	 * parse them on its own.
+	 */
+	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
+	cp = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
+	if (!cp) {
+		cp = next_non_spacetab(bprm->buf + 2, buf_end);
+		if (!cp)
+			return -ENOEXEC; /* Entire buf is spaces/tabs */
+		/*
+		 * If there is no later space/tab/NUL we must assume the
+		 * interpreter path is truncated.
+		 */
+		if (!next_terminator(cp, buf_end))
+			return -ENOEXEC;
+		cp = buf_end;
+	}
+	/* NUL-terminate the buffer and any trailing spaces/tabs. */
 	*cp = '\0';
 	while (cp > bprm->buf) {
 		cp--;
-- 
2.20.1

