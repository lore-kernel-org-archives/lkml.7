Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0321C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C607C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SFWnq2eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfFURyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:54:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43818 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFURyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:54:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so3719059pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a5yiDbT8MVSdZIc2KfFVpg6BKB4IieuBTb1pHUhvRI=;
        b=SFWnq2eghvTe1iwSkujW45VCBIXhB+yUedma3hkhUXA//kvQ0CCJxRKcl0GvTeDzv4
         hMmhFoZUgAGbqGbNR0mwoy9q77igvy0l8/dC5RDkYI0uC/RxGZPRxfgEoj1+kKQDj2aB
         9xXgxiStwoURXbUGVn07kbUo61pPg0Lqiwl8GhdJh81QUqmz17xtgK8epu2S9T6coGT6
         T7cMF6l9C2bHBR4KFXno8basKcQ+cL/9jW2o30rxvG9ejzpGMdXVYagfco8tB2zRf8XO
         sX6+gpBAoreGJ+0tczOBUGPckFJ1Jhm1/I5l6kLBQUJv0JCLnaOdUinQuNIObUThdF7v
         llqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1a5yiDbT8MVSdZIc2KfFVpg6BKB4IieuBTb1pHUhvRI=;
        b=e/O7uBqy9eqnS76mdEPrE/o+u5DlU1p03BVQcw9HZaSk4NhqBVbkdiO8r+wd0pd1+k
         6fjKbQzJgU118x07qdWZcGj20FuWxiu2l+M7AWGGD6t8H02YnA2u4nlIK3J3M6XQnPC9
         0hEjFjPdjTi/gG4xt9qp0HrBZvJAdQH50BeTAO6vEuJy91xljNFPAIY95DVn16rFXVzI
         8kCaxAJmd11cMxYJAD/37mnQDjpEgrT774r/XMd/IBQ+Ng/Zi4RozmzsiwjHvWfgt2qp
         tKCGBjoZvVR8p5CTUt6fuwkhRVPg+CiVZYZNmK2dQKEYmle546u8k17AeMN+b0GlD3rc
         KB8w==
X-Gm-Message-State: APjAAAViBFnhGL1Qsxv+tYdM4PPCN2V9PLzVqpbw6Jo9VI2X5ziVAjA9
        rXih9kYdujr7QloI/Lknd7Cn2A==
X-Google-Smtp-Source: APXvYqwGNzkF0Mu5F/YRh9UNf59UqXo8AFlR0RG/2kuuHyyUh2AYvpVseMyZZKARTpZyPEhcMoYMCA==
X-Received: by 2002:a63:ba08:: with SMTP id k8mr4368113pgf.378.1561139671255;
        Fri, 21 Jun 2019 10:54:31 -0700 (PDT)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id n98sm6290343pjc.26.2019.06.21.10.54.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 10:54:30 -0700 (PDT)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com
Subject: [PATCH] binder: fix memory leak in error path
Date:   Fri, 21 Jun 2019 10:54:15 -0700
Message-Id: <20190621175415.80024-1-tkjos@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzkallar found a 32-byte memory leak in a rarely executed error
case. The transaction complete work item was not freed if put_user()
failed when writing the BR_TRANSACTION_COMPLETE to the user command
buffer. Fixed by freeing it before put_user() is called.

Reported-by: syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bc26b5511f0a9..8bf039fdeb918 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4268,6 +4268,8 @@ static int binder_thread_read(struct binder_proc *proc,
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_inner_proc_unlock(proc);
 			cmd = BR_TRANSACTION_COMPLETE;
+			kfree(w);
+			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 			if (put_user(cmd, (uint32_t __user *)ptr))
 				return -EFAULT;
 			ptr += sizeof(uint32_t);
@@ -4276,8 +4278,6 @@ static int binder_thread_read(struct binder_proc *proc,
 			binder_debug(BINDER_DEBUG_TRANSACTION_COMPLETE,
 				     "%d:%d BR_TRANSACTION_COMPLETE\n",
 				     proc->pid, thread->pid);
-			kfree(w);
-			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
 		} break;
 		case BINDER_WORK_NODE: {
 			struct binder_node *node = container_of(w, struct binder_node, work);
-- 
2.22.0.410.gd8fdbe21b5-goog

