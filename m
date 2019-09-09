Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCB8C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FE3222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eJ1w8LF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390603AbfIIKXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:23:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39827 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390550AbfIIKXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id q12so13993928wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7Bzmc8unRj2o3NCWa0+dcZGFlGvmP3kCEEVnSXhkOA=;
        b=eJ1w8LF2MYSOvsRCvj7XcfJA5lhEO87R1bLBeu65GW2j/DGqZqPprE6kQ/hoghBzbS
         w6IdbZv33BK7k8oJg6WhQJ6q45RWIDsL9J4I4lmQeSytRwscjSdlC1vPe0up/jQedywO
         ozLkAMFRLRFb272kZZBTRLL+klZgN6S6NvqmWL2zm4s8aU7nI6u7NRc01CFL+L4mhfAq
         13ec60iL8+uugHfNqWE9jgWn4GLDuRC4ysdNh03NZwYyadGN2ZTHGbRzb+wzh1HI8hEf
         RWxOlKkMMFrrMbl/ZDjywr90FbmUdRl8ZatAWFuhFYCT3A9SCDF+Qy7Us1qtVzMPfVr+
         5ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7Bzmc8unRj2o3NCWa0+dcZGFlGvmP3kCEEVnSXhkOA=;
        b=Aze8nQO0qTQ6zFcQGMGO/kZsL8lGlXm97VYCLKKgwKxcg5CFJH1ICyhCmmHywl/tZd
         cJYi7FBiUnGNC3l84YMTDkU9j9KgLtVGKwvwHUnLOj0kuxYjtVAF1jIMCRzEhYLxG+2d
         GIDgAST+RwmaV07SkAsnHjcRLbHRap60byr8sGAIOncvcPGustaRJFfqO07fGZLlyOAK
         zRIyKfIyvlnkV72c8edIVklZibeEmqPhXpKPZvxskBYjU+TzxbwOtwVfamZ731zF4zjp
         hy4A0uU3+OTylG8ws0e72E82TaT/GxK5Ei6YOn9OUj3vuvsBIU64OjvEo/fkvKqCY5q+
         2ZrA==
X-Gm-Message-State: APjAAAUBsFm4OL+0oNpcrNLGvOTeYFWHV6vX537XujceWhRpIoXS7oHN
        txsLN06Hx3HcFq5IeBWKfYzPmglhwHpUiQ==
X-Google-Smtp-Source: APXvYqzmxzn7Fo/gtLbCgxCJksmoaFbMVNn7wj0/OSQx0ISZVsTWLDyDCK67zQsOMozuUO5BCkL7Zg==
X-Received: by 2002:a1c:1acc:: with SMTP id a195mr18081713wma.106.1568024624900;
        Mon, 09 Sep 2019 03:23:44 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:44 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] futex: Remove unused uaddr2 in restart_block
Date:   Mon,  9 Sep 2019 11:23:32 +0100
Message-Id: <20190909102340.8592-2-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used since introduction in commit 52400ba94675 ("futex: add
requeue_pi functionality").
The result union stays the same size, so nothing saved in task_struct,
but still one __user pointer less to keep.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/restart_block.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920e9c05..e5078cae5567 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -32,7 +32,6 @@ struct restart_block {
 			u32 flags;
 			u32 bitset;
 			u64 time;
-			u32 __user *uaddr2;
 		} futex;
 		/* For nanosleep */
 		struct {
-- 
2.23.0

