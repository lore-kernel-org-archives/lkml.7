Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F887C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D338A20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567521920;
	bh=A2H7bLqGQXEC3wP/QXWCh0icNwEcL6lHEjPWqPFtu8w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=M6NizA1wph58Uexezbsl8ILOW4+nPPuMRazWrOzQErFaoZY1znMY3IUFdvIYpfxv0
	 i/f2m/b7StFcv9hEB4HNrnqoKN8Eh8naLT8G67C/5TOC2AOtEP0hwhV1UXWFCBA2D2
	 gFkHJvDAeXqUn3L1MDCzeAvDYX46PSD0rICLCVVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfICOpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:45:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34331 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:45:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so18817524edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPLrKpMAKQl0z6IHiX3iRCTMRmBL1dJ+Y1ig1WZUOzQ=;
        b=qflrWzyCfc7bijg4qM3w7+J/ctV/oru7J6m1fohkg43MdaL7uoc0+Py9kMHLWpSQy5
         lvCHe+YjMWgpSP6A2im/6u7k42kvaXmUiUe9EaGpQtDiaop6lYmL+e+boEPKsF1mzOKh
         UpLh7XO0qu68TTTaTPt1eJfNeWIosv8HQXH53dvF3I0TRX6FNuOLYLAUyfjgM0RvCoPZ
         k+ttyVY2kQYgDd02ViIuCZjjYRS1rYtTEqiXldgR4vCPGgWVQ66EuVr6TJgWhs02apCp
         Em/ye5jhw1AwhzYkODZZteiQOZ3v81GlmFrU3yNcBwwIvRYfNx+IWHaLLPqjvD9ut9fl
         4yEQ==
X-Gm-Message-State: APjAAAUCt0NaK1ArKoNZRxMRsYOUeX/5IaSi2KrHfJF3OtV4M8HNVDfV
        nUOMp4YBOnHxFRaZ6pyXCJ31SuN/
X-Google-Smtp-Source: APXvYqzTogOw7QyxRitlg/CEOmeVi6TOyvu0Hhp6N18xrpDDkkPan96Nm1T/IuUg38GBBjdXGh0kBw==
X-Received: by 2002:a17:906:4d82:: with SMTP id s2mr12474357eju.94.1567521918154;
        Tue, 03 Sep 2019 07:45:18 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id ga12sm132304ejb.40.2019.09.03.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:45:16 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH] mm, oom: disable dump_tasks by default
Date:   Tue,  3 Sep 2019 16:45:12 +0200
Message-Id: <20190903144512.9374-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

dump_tasks has been introduced by quite some time ago fef1bdd68c81
("oom: add sysctl to enable task memory dump"). It's primary purpose is
to help analyse oom victim selection decision. This has been certainly
useful at times when the heuristic to chose a victim was much more
volatile. Since a63d83f427fb ("oom: badness heuristic rewrite")
situation became much more stable (mostly because the only selection
criterion is the memory usage) and reports about a wrong process to
be shot down have become effectively non-existent.

dump_tasks can generate a lot of output to the kernel log. It is not
uncommon that even relative small system has hundreds of tasks running.
Generating a lot of output to the kernel log both makes the oom report
less convenient to process and also induces a higher load on the printk
subsystem which can lead to other problems (e.g. longer stalls to flush
all the data to consoles).

Therefore change the default of oom_dump_tasks to not print the task
list by default. The sysctl remains in place for anybody who might need
to get this additional information. The oom report still provides an
information about the allocation context and the state of the MM
subsystem which should be sufficient to analyse most of the oom
situations.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a0bdc6..d0353705c6e6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -52,7 +52,7 @@
 
 int sysctl_panic_on_oom;
 int sysctl_oom_kill_allocating_task;
-int sysctl_oom_dump_tasks = 1;
+int sysctl_oom_dump_tasks;
 
 /*
  * Serializes oom killer invocations (out_of_memory()) from all contexts to
-- 
2.20.1

