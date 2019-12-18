Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2862DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8676206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 03:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7683Xhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRDa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:30:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40538 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLRDa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:30:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so585918oto.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qr1/j+fdN8RUPF3Ke+iWBk1FIjTHPDLsVp5XYEGSUAA=;
        b=r7683Xhg9KugjM0gda6HdDLcmF/7mlakOgAevQOXeQ2AZclXt3/Sj1gul1s3hLVPXa
         qSkdW7TKlmL+f2wJw7Rpl+PMMSpLQJRFMxDBV7C7UFs5lGQRGepG41koa1g+VU6u/myw
         DABbhxOUGGZkdOYp6yveV5FRBCcDcWs/1gESUYqH3XK4MpFEOx6ekH7z7K23bS3nKJWX
         mpPHVAKE0r2Q0zFFeBJlLJaPz8t5348xZfipRumjBrF+VkSwsatfOPi9k8FpLjcNPklx
         /Uk5WqlRhABInBbeIkFAQ+UrGnd2wzCFJFK9UrC8VzmCJBurUZOxlJcs8o9oSbSLbiM8
         kpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qr1/j+fdN8RUPF3Ke+iWBk1FIjTHPDLsVp5XYEGSUAA=;
        b=UY3Tyy6fxOvODw3SO7QVKnjJSPr1PjcWwwzh0+X5sRzLpQZh73eFO35jweVgKKyyoq
         IXHJ0tvDj//pRtnaK5wcidqEYSDShOcormm8IIwLdJMi0lTSh74AOcG2ElASO1DE7OOh
         PDYUDJ4kCptpjUTyKl/DCDrlo6G138XGHcbFXUZwdIIjj8MhtMceJTz7qsC0HS+FULhu
         QoxmuK9JtM83MGzwNgwGZ7OFyJhHv/XX6nN3YpQh9aoh1KumxXEWay0zJ8kdjzTA6sHo
         mgb0TKfLec9naHbJbmV9VHpD83rBZ0YWYu9vPfm238Tynyp60yJCbQ25Bp7hbtN+jPQV
         Rc6Q==
X-Gm-Message-State: APjAAAU9g3+J/UAThhvQp0SUw5gKKQ4BhWZCU8VdZu1K4JG/rlDKXDRC
        v1HnLkLEJ0vehRFITH2eoUU=
X-Google-Smtp-Source: APXvYqyqG++bstgfOIWt8w9Txd9nI0roI4RPI5uFXAJ7FX//F0JBxK1+MULO0zQP+He/A4RuC6GeEg==
X-Received: by 2002:a9d:3f06:: with SMTP id m6mr188385otc.268.1576639827663;
        Tue, 17 Dec 2019 19:30:27 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id f142sm348395oig.48.2019.12.17.19.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:30:27 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Lu Shuaibing <shuaibinglu@126.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ipc/msg.c: Adjust indentation in ksys_msgctl
Date:   Tue, 17 Dec 2019 20:29:34 -0700
Message-Id: <20191218032932.37479-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../ipc/msg.c:621:4: warning: misleading indentation; statement is not
part of the previous 'if' [-Wmisleading-indentation]
                 return msgctl_down(ns, msqid, cmd, &msqid64.msg_perm,
msqid64.msg_qbytes);
                 ^
../ipc/msg.c:619:3: note: previous statement is here
                if (copy_msqid_from_user(&msqid64, buf, version))
                ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/829
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I assume this will be squashed into the offending patch since it is
still in -next:

https://git.kernel.org/next/linux-next/c/658622e448a6e6a6a69471daeff7e95e98d34ed1

 ipc/msg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 22ed09ded601..caca67368cb5 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -618,7 +618,8 @@ static long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf, int ver
 	case IPC_SET:
 		if (copy_msqid_from_user(&msqid64, buf, version))
 			return -EFAULT;
-		 return msgctl_down(ns, msqid, cmd, &msqid64.msg_perm, msqid64.msg_qbytes);
+		return msgctl_down(ns, msqid, cmd, &msqid64.msg_perm,
+				   msqid64.msg_qbytes);
 	case IPC_RMID:
 		return msgctl_down(ns, msqid, cmd, NULL, 0);
 	default:
-- 
2.24.1

