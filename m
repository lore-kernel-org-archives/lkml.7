Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E4C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B14C2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgG8rQgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfEENiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:38:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46517 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEENiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:38:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so974705pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=goF1yaebOYWv1y2Ep4TYXxP5lSNWUf6+vHv7mxyRHEs=;
        b=kgG8rQgYGYWi/oPgc+XqO6Msm3UldSBs7fcxn/6oX0InkfAbBfrU+Za173U7cZkRAk
         9f7nKY7F/n/v3x+1g3RXYvZgjwC8PjNL0Hhq5Au8dbf1XttvrCZOfr+RmS7dV8UnP5eh
         ScbBXy+PXWW4s5MkWaODHzIkFfCovQhFijbW4S29Y9wdl3nWFX/jKuN4/VXr0B93QYyD
         YWTz/O537KFx66xpUzKlLJGhk9vJ+8UeX2QOkOHOZcMK1MZcSxzrkPg/QrAWcU/vJ8Rn
         1pHEmoAV7IPoHa2x4Fs+r/V7J1tu6h9ZzVqpGSixtv/zzmpOy0HNTaYxugsRqIK/P5Nw
         ytoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=goF1yaebOYWv1y2Ep4TYXxP5lSNWUf6+vHv7mxyRHEs=;
        b=go3ChxnQrBIznZcDTUYKIJP6TjZME+0dq0orHMjBseaXwQJkrWEYtDeP8EZginAFlu
         sR7fqeUv+D/57vCbBCArqvJgdJvzuFTqDwmz08unWY6RbwpRQzR6wiMLnIeyvV4DO2JK
         r1RJAHXmVdu8D35s83b85RC8az8J5T6xc9twHYpOrjpAYpkLybMW6YZ0Vz1uFUGIEct7
         7j3uvmgicPr41Ll/dwa1k/XNe6GnhEajEGhRPy/qCr1eivxRLfzPRiBiRT+zdmhKxpDc
         X3v7NopdPhY8YUEGE43dUSgAUrU3ybzqGJWhgQ+z/QKD+Xe6cQqITqNy+KqJDC3qy9zg
         JJUA==
X-Gm-Message-State: APjAAAWKuowfHrQx+z1yXVJqxdUxqED9a0BN2pxfAtodLTvgKtkuRNWg
        5aJgYsbaTDBRY8G12rVd/Tg=
X-Google-Smtp-Source: APXvYqyPXpGnMquhBiNm0BKzznw7APQHQhBJhGgNlY2s2F6kL1OIAfc8AU+EyXZVzhRiLiI+7jirPA==
X-Received: by 2002:a63:4006:: with SMTP id n6mr25172507pga.424.1557063503288;
        Sun, 05 May 2019 06:38:23 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id p63sm765519pfb.70.2019.05.05.06.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:38:22 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     ebiederm@xmission.com, jannh@google.com, serge@hallyn.com,
        christian@brauner.io, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH] ns: modify function comment for projid
Date:   Sun,  5 May 2019 21:38:00 +0800
Message-Id: <1557063480-4469-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function comments about projid are described
as uid, so fix it.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 kernel/user_namespace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 923414a246e9..6e917fc072d0 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -516,8 +516,8 @@ EXPORT_SYMBOL(from_kgid_munged);
  *	@ns:  User namespace that the projid is in
  *	@projid: Project identifier
  *
- *	Maps a user-namespace uid pair into a kernel internal kuid,
- *	and returns that kuid.
+ *	Maps a user-namespace projid pair into a kernel internal kprojid,
+ *	and returns that kprojid.
  *
  *	When there is no mapping defined for the user-namespace projid
  *	pair INVALID_PROJID is returned.  Callers are expected to test
@@ -526,7 +526,7 @@ EXPORT_SYMBOL(from_kgid_munged);
  */
 kprojid_t make_kprojid(struct user_namespace *ns, projid_t projid)
 {
-	/* Map the uid to a global kernel uid */
+	/* Map the projid to a global kernel projid */
 	return KPROJIDT_INIT(map_id_down(&ns->projid_map, projid));
 }
 EXPORT_SYMBOL(make_kprojid);
@@ -545,7 +545,7 @@ EXPORT_SYMBOL(make_kprojid);
  */
 projid_t from_kprojid(struct user_namespace *targ, kprojid_t kprojid)
 {
-	/* Map the uid from a global kernel uid */
+	/* Map the projid from a global kernel projid */
 	return map_id_up(&targ->projid_map, __kprojid_val(kprojid));
 }
 EXPORT_SYMBOL(from_kprojid);
-- 
2.17.2

