Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C3C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E30A206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip0gzmIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfHADD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:03:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34965 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfHADD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:03:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so26904177pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TAjCCY+MnNm3bAQV+sku+55nC00gim2fx0DJZfcK32Y=;
        b=Ip0gzmIBtGQeUlQXPX5CfoUZNX074QfEugeFGLSesdRKDWJ7UrZKK+QkZymYdw8neY
         QVv6HgnPvYwq9dsikN4XaC4OjF0A9cUJ0vPJ9rwl/MTnN+3CNfQMg8Uo6g4ylwL6LRfd
         +YMKm+kKuX9Jvv0N8XnwKQR7pI/2Bgr1gJstAf00ohhzea9rh/I9T3ICmI9IwgYmRWVa
         wB1m/V0pknZshxfyuaR116QwnjE+fg2nvSrpaFlvVKi7nxy/ItE4zG4mYDLMfd7x9CYo
         he6uE9YcqM3/jSMjPX+i1V2eetuhCvivEgeh/BtHuauHckb3CDfJq/0l2m6K1yBI1D+a
         cBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TAjCCY+MnNm3bAQV+sku+55nC00gim2fx0DJZfcK32Y=;
        b=bMxgWVwXIlKxTKf+qaqfoZCdYfX7r5Y0o1/Gg9UP0OHBMXMmKXN42zV0ErtGEl2Zo+
         Z9CPvgzrRjAI6cNAYC3AmoMQ29hD8FHrzhv4xKVVmlnv3XI2Ep3Mu7RxHGeqdeZsCym+
         78yy0hWrN5hLxEF6zkNU5xEdqBs7vIlqeJLiM0xdwc6KUDwJsTG1qXnd/xxwMBbrTZjf
         XW90uS+cFzhM6Veh7S+7hHMmmT/fAmjUhH8VKhGKlvA9WGXEnaRtBLvGLtKD83SEZb7q
         /H6QrpBJ0PimaNNdvkMOkGeo8Tjopx7GCYaFLmITTk1DqZH5vCetC5mFRa79NLzbqS9M
         2o5w==
X-Gm-Message-State: APjAAAXP8UYBDfYg1Qg3KGqoMBFsZtR/4WJyTObe0UsDjWOhrdlGznXu
        oSQ9DkBkaWJT0XG2MtlfJQ==
X-Google-Smtp-Source: APXvYqxEyPgfT853iahgSeBQNfZkuDrwAobLCmjXfNRRyyJrlMORPPJEkkCg/8RgiNWqHQGRp96q7Q==
X-Received: by 2002:a63:2cc7:: with SMTP id s190mr104110464pgs.236.1564628607725;
        Wed, 31 Jul 2019 20:03:27 -0700 (PDT)
Received: from DESKTOP (softbank126075164154.bbtec.net. [126.75.164.154])
        by smtp.gmail.com with ESMTPSA id z24sm122184991pfr.51.2019.07.31.20.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 20:03:27 -0700 (PDT)
Date:   Thu, 1 Aug 2019 12:03:23 +0900
From:   Takeshi Misawa <jeliantsurux@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tomoyo: Fix incorrect return value from
 tomoyo_find_next_domain()
Message-ID: <20190801030323.GA1958@DESKTOP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When filename exceeds PATH_MAX,
tomoyo_find_next_domain() retval is not ENAMETOOLONG, but ENOENT.

Fix this by retuen kern_path() error.

Signed-off-by: Takeshi Misawa <jeliantsurux@gmail.com>
---
Dear Tetsuo Handa

I found unexpected return value from TOMOYO and try to create a patch.
If this is not acceptable for security reason, please discard this patch.

Regards.
---
 security/tomoyo/domain.c   | 7 +++++--
 security/tomoyo/realpath.c | 9 +++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 8526a0a74023..3d8034701344 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -723,8 +723,10 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	/* Get symlink's pathname of program. */
 	retval = -ENOENT;
 	exename.name = tomoyo_realpath_nofollow(original_name);
-	if (!exename.name)
+	if (IS_ERR(exename.name)) {
+		retval = PTR_ERR(exename.name);
 		goto out;
+	}
 	tomoyo_fill_path_info(&exename);
 retry:
 	/* Check 'aggregator' directive. */
@@ -870,7 +872,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		s->domain_info = domain;
 		atomic_inc(&domain->users);
 	}
-	kfree(exename.name);
+	if (!IS_ERR(exename.name))
+		kfree(exename.name);
 	if (!retval) {
 		ee->r.domain = domain;
 		retval = tomoyo_environ(ee);
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index e7832448d721..d73e66be05ef 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -332,10 +332,15 @@ char *tomoyo_realpath_from_path(const struct path *path)
 char *tomoyo_realpath_nofollow(const char *pathname)
 {
 	struct path path;
+	char *buf = NULL;
+	int err;
 
-	if (pathname && kern_path(pathname, 0, &path) == 0) {
-		char *buf = tomoyo_realpath_from_path(&path);
+	if (pathname) {
+		err = kern_path(pathname, 0, &path);
+		if (unlikely(err))
+			return ERR_PTR(err);
 
+		buf = tomoyo_realpath_from_path(&path);
 		path_put(&path);
 		return buf;
 	}
-- 
2.17.1

