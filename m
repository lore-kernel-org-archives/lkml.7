Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CCEC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E8721773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA/5THbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbfEXSND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:13:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36575 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfEXSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:13:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so2849151wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w4aq75m0l1tw9tA8/0+sCX4bioCRlGyWir4CZV+DPO0=;
        b=fA/5THbk3ENmZGXlI5FHc7o2G8j2dmoZhHvYA76vVvdAS8oys36o2R1+nbbJPCiDU9
         E0QZ9eaCwl1gWNBpuAbmXSQ9nD04yQyj6NP4Vd80tmyX73vr98LOoV1uBAShQOP/G20r
         KD23YyL53Lkk+HkGMTWdQgF8dU5jJdQWdHxwCb/cNsyk0I9gYghbS8lcjk25iWVbYPyx
         00ID/ldljPmVYVytroPOSF5HhtNeuYu5CkRmlpzpEPSwfSnIpynpkuRhXKEuJULlUoyU
         vT5yHOXiUMHbhvaw21tU5VTtTRjPCQVPwiZ5r2tEqzcW8/KrQMNknJRl57K66dJT4e9H
         DeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w4aq75m0l1tw9tA8/0+sCX4bioCRlGyWir4CZV+DPO0=;
        b=csNICWEb27nTF0Po9zNVC44D7UB5TISVaLznUJp5Jyv+HFUVHgfqBJ8aWqVHWFmOo4
         wnAY6eWFblV4oJ1tx6XngObtdbsY34AMzIHWMFOMp5U+zow3YtZrm4EhqK+nMJVCZKi5
         NMBZGrAs4IHEL0SJf94aCm9xhurQeIHLCCxqzMsUyXtAYRAHaF86ym6vdOAZn9lWVXtx
         zicEPn6X7buNnR8UmG3MeagwqNTyQbEBwT6TWR0caX34x2mG/6eUzHrOgLAVvff8Fgj0
         KgZDKp9cp2CrksEGY9hy1NqyRWVgFqbzZaHR2zWMta0Ms9aYpXjjbq4pst8egIN/mvuE
         dS+g==
X-Gm-Message-State: APjAAAXqgVd3aLhnDcWZPLGgOGSYI1PELEW8BLU5a4XZLWFdVo/dMk0m
        o2jdAiG+FvleX1nxknQZ9GwZ3/w=
X-Google-Smtp-Source: APXvYqyOhmb3KTv9YwhRl1oa2dwlHjCpZIGtQmZEyeT4tKvxxCzF1FHDDDmSZJEcTYiw5VkWGHyilQ==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr16913695wmb.118.1558721581064;
        Fri, 24 May 2019 11:13:01 -0700 (PDT)
Received: from avx2 ([46.53.250.220])
        by smtp.gmail.com with ESMTPSA id r4sm2025722wrv.34.2019.05.24.11.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:13:00 -0700 (PDT)
Date:   Fri, 24 May 2019 21:12:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: hide "segfault at ffffffffff600000" dmesg spam
Message-ID: <20190524181256.GA2260@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test tries to access vsyscall page and if it doesn't exist gets SIGSEGV
which can spam into dmesg. However the segfault happens by design.
Handle it and carry information via exit code to parent.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-pid-vm.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -215,6 +215,11 @@ static const char str_vsyscall[] =
 "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
 
 #ifdef __x86_64__
+static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
+{
+	_exit(1);
+}
+
 /*
  * vsyscall page can't be unmapped, probe it with memory load.
  */
@@ -231,11 +236,19 @@ static void vsyscall(void)
 	if (pid == 0) {
 		struct rlimit rlim = {0, 0};
 		(void)setrlimit(RLIMIT_CORE, &rlim);
+
+		/* Hide "segfault at ffffffffff600000" messages. */
+		struct sigaction act;
+		memset(&act, 0, sizeof(struct sigaction));
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = sigaction_SIGSEGV;
+		(void)sigaction(SIGSEGV, &act, NULL);
+
 		*(volatile int *)0xffffffffff600000UL;
 		exit(0);
 	}
-	wait(&wstatus);
-	if (WIFEXITED(wstatus)) {
+	waitpid(pid, &wstatus, 0);
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
 		g_vsyscall = true;
 	}
 }
