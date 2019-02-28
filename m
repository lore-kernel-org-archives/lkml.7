Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB199C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B4214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLGPic+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfB1Lhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:37:40 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38085 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732576AbfB1Lhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:37:39 -0500
Received: by mail-qt1-f202.google.com with SMTP id 35so18302319qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=P9AOSoYowIslO+pnAMhidstJ6sO3eTHSC856Ya9OGrA=;
        b=tLGPic+zVtJmMW0cpqjQHiDmayJcNYM1hNKUasQ9X/KuPVcRVqMHGX2dkFWpaj6Kqq
         ZDH0bpul1mTPNtgqOy67gKLPxgkZSnBZG4KQ7PivLO/nodtYA8pdkbRY17jTuBH9oPzo
         1YcKJAeR+HyuBEr37ypdo0BEKAz64oTzZ5a6v1adWv8im1QUwWzAI1pI6MdhyTZERr2m
         MKBb8fYOVPClE3MU5P2Qvdg1ycGBgzrlP0ITcNQmYaiFOsoXA8hB/34jiRC0l34oCi8x
         JJXKmU5/Lr4IXu5Jya3elFrXQqdSlwfrZ0YZOohxkuPuC0E6idfpldYT50HBiuPfBJh9
         m6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=P9AOSoYowIslO+pnAMhidstJ6sO3eTHSC856Ya9OGrA=;
        b=KMAf+WreKV8R7lnC8HTD7qD4e+Mnzk5Sf5oA64Tan9hg+6JjZHqx8NgYPwqiY9E2fs
         ZvaMxUbFqwHaPDtVGOt0YVcT9SmQXeAJ5Yhmro6gyMwBbtUvhU/jDs7kQxFfu+fEy5d5
         CWJBTeTNVQwfwJR+DTICi4cFD1ADCh1hzhW9f2BNfoa/6QKz39yofDaTtUJEdFqYQMgN
         wI6/MCcawwGHR7DdFcLgNV5CUrwTeaTCC6dB6zJC+3kEfLOTW3sQsho4cw+W3uamOTA1
         FFI/qx6ZcgDTH3aTI81GBY3rJB9HXQ1kIYXS/srirePN/VPb8rZ7RBjMcUvHcBLEUb/M
         wUNw==
X-Gm-Message-State: APjAAAXqWmPyxsdLA7t8jHF28+iz46JZqosE3ILXTxBgkXMnEZfmLhBC
        jwkzWkOv0704Zc/a1LyX37nw6VVoL7seFQ==
X-Google-Smtp-Source: APXvYqx1rTOm0C/0ZVXv1bPJsQbs1e7E+4y7YhXrNuKYHcdQujJV1L13fNtB0nJsZnc4owuYqfiCYf/tqLBATg==
X-Received: by 2002:a0c:869d:: with SMTP id 29mr3796631qvf.34.1551353858270;
 Thu, 28 Feb 2019 03:37:38 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:36:52 +0000
Message-Id: <20190228113652.55552-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH] sctp: chunk.c: correct format string for size_t in printk
From:   Matthias Maennich <maennich@google.com>
Cc:     Matthias Maennich <maennich@google.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/core-api/printk-formats.rst, size_t should be
printed with %zu, rather than %Zu.

In addition, using %Zu triggers a warning on clang (-Wformat-extra-args):

net/sctp/chunk.c:196:25: warning: data argument not used by format string [-Wformat-extra-args]
                                    __func__, asoc, max_data);
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~
./include/linux/printk.h:440:49: note: expanded from macro 'pr_warn_ratelimited'
        printk_ratelimited(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
./include/linux/printk.h:424:17: note: expanded from macro 'printk_ratelimited'
                printk(fmt, ##__VA_ARGS__);                             \
                       ~~~    ^

Fixes: 5b5e0928f742 ("lib/vsprintf.c: remove %Z support")
Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 net/sctp/chunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/chunk.c b/net/sctp/chunk.c
index 64bef313d436..5cb7c1ff97e9 100644
--- a/net/sctp/chunk.c
+++ b/net/sctp/chunk.c
@@ -192,7 +192,7 @@ struct sctp_datamsg *sctp_datamsg_from_user(struct sctp_association *asoc,
 	if (unlikely(!max_data)) {
 		max_data = sctp_min_frag_point(sctp_sk(asoc->base.sk),
 					       sctp_datachk_len(&asoc->stream));
-		pr_warn_ratelimited("%s: asoc:%p frag_point is zero, forcing max_data to default minimum (%Zu)",
+		pr_warn_ratelimited("%s: asoc:%p frag_point is zero, forcing max_data to default minimum (%zu)",
 				    __func__, asoc, max_data);
 	}
 
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

