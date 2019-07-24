Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153BEC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FC821743
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA+OZd8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfGXKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:25:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37028 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfGXKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:25:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so21844781plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1/gt9BhlisdGUb5bIZc32HBL4A6Aaa9ZnK24W35108A=;
        b=uA+OZd8OySVziMrPHNJlp60UvU/H1XoCXeIteODI4UVYJH3MAjLo+IOHEXdFNY8h5i
         pr0R/dkOYJgka3vNCqkhoIypXKnICTZllMqAyfGbTtjC/G5OMFRpbveFWnvnN39eoHNj
         X3ZDqCKdtyj8DH/qAyfJ4DpbGmjgw55WrNLNbF9TjeQkrUyH+grXqZTkxWWG0Q3KWy4P
         /jLf1aij38VDEaks4ev0UTdljmO+l/gJHBD226q0t2sILIyYyauDQBDaiuabz5bWrjxx
         A+WwOngLVnh9zt90tY/tUwvlLiF9DzGsVjU01Eb0biJYyC8tRyOi7xRECotdniKsT8AA
         5hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1/gt9BhlisdGUb5bIZc32HBL4A6Aaa9ZnK24W35108A=;
        b=cBqqV1T7ZUjzUWGgoWc0oEWTdITgcPGRoubTMZXCPQUTta/sax09XenV58O9Ge8f/b
         orIr3GWTe5jnWwHmKxomz265sFFC+2CDCGgu3xGZNbDl4KDqAdCbw7yH7Eg/Ic8KH5TD
         wyrbXNZYCXkqCYSrTmc9wCnuaDmeMROG1ARmD9HJzr+ozDbfiRFDHV86+uYhyVLT4f+m
         EHpKPLrkL83gCUivow9WQCwb3mUvce03ykOj2HJpdnYXy41r+JjOkbbLNfS8267Yyuvb
         fgFKAEiAClZ5dWSyOXXH4hHebwSKIJACKqNsEedwPWHcS+EX0s4T3Cl/sIqcwCQgGMJi
         M2tQ==
X-Gm-Message-State: APjAAAUW9SybVw4kEyULurpoJH5clQoOPkqvkYx0vsRG2qqx8mVWWPJO
        opyTudyro/uaX4XLXQi/OMc=
X-Google-Smtp-Source: APXvYqxxGp3flXzVyzWbj/zh0xh6vUqDvte2zaHDbhrC2vAsWVTrHXB8Fgmq7JWlgVdg5McEOzQf6w==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr86081038ple.192.1563963934771;
        Wed, 24 Jul 2019 03:25:34 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id f7sm45390884pfd.43.2019.07.24.03.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 03:25:34 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] char: ipmi: Fix possible pointer dereferences in msg_done_handler()
Date:   Wed, 24 Jul 2019 18:25:28 +0800
Message-Id: <20190724102528.2165-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In msg_done_handler(), there is an if statement on line 778 to check
whether msg is NULL:
    if (msg)

When msg is NULL, it is used on line 845:
    if ((result < 0) || (len < 3) || (msg->rsp[2] != 0))
and line 869:
    if ((result < 0) || (len < 3) || (msg->rsp[2] != 0))

Thus, possible null-pointer dereferences may occur.

To fix these bugs, msg is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 305fa5054274..2e40a98d9939 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -842,6 +842,8 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_EVENTS:
+		if (!msg)
+			break;
 		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
@@ -866,6 +868,8 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		break;
 
 	case SSIF_GETTING_MESSAGES:
+		if (!msg)
+			break;
 		if ((result < 0) || (len < 3) || (msg->rsp[2] != 0)) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
-- 
2.17.0

