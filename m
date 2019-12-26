Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B68C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7282080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBwFBgYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLZWCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:02:23 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:60236 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:02:22 -0500
Received: by mail-pj1-f73.google.com with SMTP id s19so6021442pjp.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZxaT1ejKkfEiSvkWCbdUpX7avE1ATSBJk0Dhet6KAck=;
        b=lBwFBgYCbPHUBi8Pc/xTG88po2tdDR6XBwLJA5MsdXnApKzDoi1GjbjP/KfZU83wJS
         jpMW1ZQ9RDSNHiBBcUfs3RYp4ODJHlZklPoAH0o23ql8OwPyQnxGDMp9peydg6urfQPz
         lpJFJ30dgt6WSJqAz10Bmqt3QNZ+/Nx25iTlwA5rRZYv5+/0E7GZDQTs/6ClbVGEYF4O
         0RFGlpWsQIxIqcw8LfFI/YTNSOKwxHVYQJmH6d9LXJsB4HanNSgQAw2Vnma+mCc1qr3x
         wmeFfjAuXUmo4xp5lUu84o48mQbO+AnBvstgJaYKuKDEwrIOIhNcNxD05rkLojdhzRBM
         CSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZxaT1ejKkfEiSvkWCbdUpX7avE1ATSBJk0Dhet6KAck=;
        b=OBBgpxejCcb/kEXxbfJS9vNZO0BduzkzCnRzU7h4AoKuB9cgZ+OeRyWRS5uYpK589x
         0SDEPlXrbzl22zhwzTZw7qrs8EVdy//sXpj0YGkFedvUO4UqcvlIpkiTpbm/pnQH0mXP
         u8yg0Df6ktWGm5R53JSRk1FVf8WNDENlX1akIio3YNQO8CiYQhD3oJRzGPNewXNfu6AW
         oCne8Q54q+/KoI3CUdKmN+HQKS17Vjc/Xalobv9aKkylNd0flWqY2phAZg6QseB6nx+n
         hegArPXKSnSoorcvqnbxHUT67WBUsuELJXKzhFc7JHJzYoF9prcgMae1SS9f72A3lE/V
         WZuA==
X-Gm-Message-State: APjAAAXT0QStehS66De2IS9TthwURuzbM+QkIOScF+lwIMztYASn72N7
        zSok4lxz65ndM15tvCPgPnpOVVPwivmIE5I=
X-Google-Smtp-Source: APXvYqyoOERJqnNs8xqN0U8/4BTUdj3ldFp/RDVDcgJwGutNT5106xeO7hnDXIEnut75JzjeuURqDM0y8cKo+RM=
X-Received: by 2002:a63:fe50:: with SMTP id x16mr33100629pgj.31.1577397740721;
 Thu, 26 Dec 2019 14:02:20 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:02:04 -0800
In-Reply-To: <20191226220205.128664-1-semenzato@google.com>
Message-Id: <20191226220205.128664-2-semenzato@google.com>
Mime-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH 1/2] Documentation: clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, akpm@linux-foundation.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entering hibernation (suspend-to-disk) will fail if the kernel
cannot allocate enough memory to create a snapshot of all pages
in use; i.e., if memory in use is over 1/2 of total RAM.  This
patch makes this limitation clearer in the documentation.  Without
it, users may assume that hibernation can replace suspend-to-RAM
when in fact its functionality is more limited.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 Documentation/admin-guide/pm/sleep-states.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
index cd3a28cb81f4..fd0072eb8c03 100644
--- a/Documentation/admin-guide/pm/sleep-states.rst
+++ b/Documentation/admin-guide/pm/sleep-states.rst
@@ -112,7 +112,9 @@ Hibernation
 This state (also referred to as Suspend-to-Disk or STD) offers the greatest
 energy savings and can be used even in the absence of low-level platform support
 for system suspend.  However, it requires some low-level code for resuming the
-system to be present for the underlying CPU architecture.
+system to be present for the underlying CPU architecture.  Additionally, the
+current implementation can enter the hibernation state only when memory
+pressure is low (see "Limitations" below).
 
 Hibernation is significantly different from any of the system suspend variants.
 It takes three system state changes to put it into hibernation and two system
@@ -149,6 +151,20 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
 configuration option is set.  However, this option can only be set if support
 for the given CPU architecture includes the low-level code for system resume.
 
+Limitations of Hibernation
+==========================
+
+When entering hibernation, the kernel tries to allocate a chunk of memory large
+enough to contain a copy of all pages in use, to use it for the system
+snapshot.  If the allocation fails, the system cannot hibernate and the
+operation fails with ENOMEM.  This will happen, for instance, when the total
+amount of anonymous pages (process data) exceeds 1/2 of total RAM.
+
+One possible workaround (besides terminating enough processes) is to force
+excess anonymous pages out to swap before hibernating.  This can be achieved
+with memcgroups, by lowering memory usage limits with ``echo <new limit> >
+/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
+operation is not guaranteed to succeed.
 
 Basic ``sysfs`` Interfaces for System Suspend and Hibernation
 =============================================================
-- 
2.24.1.735.g03f4e72817-goog

