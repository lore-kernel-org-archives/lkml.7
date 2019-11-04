Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963ACA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36952080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906516;
	bh=3fIb/XpE5v/FmqlNuybYCPwnbwJAl3gVKkv+KO2OZGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8Bmsha6yu6D1m6ugfcadVTbmfr+xruLco1gomj9L5Rp4PnMawri+MTohIW8kmcjD
	 p0k1sL4rJikvwZmrtSaRN2IlwzqsWtjtCJvglUCtKNEMuy8JrbIYz1/Okv4Hzg/EEt
	 iyS6njVCwr4+5wyduGObFZW5Otnobofp/I3htfsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbfKDW2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:28:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbfKDVs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:56 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5758221929;
        Mon,  4 Nov 2019 21:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904134;
        bh=3fIb/XpE5v/FmqlNuybYCPwnbwJAl3gVKkv+KO2OZGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPRqKzo7yk8v2QgW61CclCOyM28xzgLJ7UXl2ndddFEopIWx5dt2ykdOg2kuUSDCE
         DpcZuVQ77zfTxpBjHXXu+kQzj5T67wzo1+bZxgX4LsVjO/IchhyR0LtgrJW/L8JlsO
         bAT/atPL9mwL/XOTfRn73inUtN/Mx+QuGbggEmos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 09/46] exec: load_script: Do not exec truncated interpreter path
Date:   Mon,  4 Nov 2019 22:44:40 +0100
Message-Id: <20191104211839.848088730@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



