Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54DD218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOAMerO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfIRWqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:46:20 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39940 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:46:19 -0400
Received: by mail-qt1-f201.google.com with SMTP id x3so1820723qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MMbo7IIaE45HFgWdH+A2eRZAR5+H2wpaQj+LQ4zYRIk=;
        b=BOAMerO+kcAMWUQXs7MtP3XfcdNKy/o4Cyr/P+pN+bzgxIs4qnu/NG74SVVYxsigIu
         bc2/ZI1B1FMPv4qXFw3xeEKuIPYQSPmChvvlrO1NVrFPgRzQKp5eJ9C/iGGzu3jInzv+
         SjF751YALnidr+Dox5l6B9xpcFmAoeRot4Y9M9KI9QLdbDQ89eYirm91BZDJa5IxLoc1
         vNMctYRbzDwaEf+OZBkIIFJdkQLXbadzdCfcYgxY9z2Q+VLc7RRJUW7mYVdQ6y1QuSxX
         0M8W5bRjdpBTQg94IIbcdCw0abjo5pjpmmUS32uPJqQWbmHQkCK7tQVKraZ01hyzczWZ
         +mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MMbo7IIaE45HFgWdH+A2eRZAR5+H2wpaQj+LQ4zYRIk=;
        b=irSWmakOmFiaxs4y/zqcNTWVInwVLMS/CLX0++xpxK9B1QNIqMilsaopKgZs/WMyEJ
         jVP2arE539AR+xfkQcLiwr0LJ/weh/T2ia0gVx0ZjlKdzVZuGnQZvEoLzKTMTp2/0iFS
         fdaGqDvdbGBFw90olQhoGZ3NprQm8wfqX8XXfOetdKpHvFXfpTR+V+NQq0PvvVwC6mG+
         SW2ebdVa5c4WcYhoc542Cz8Qe9/oWo7xTzxUcuinOHlEb2OhFmwv0yCSpXZF/UJmkkC2
         KCmkpDgeSjWwKA+sT+jQo8lzVQ22IUYElcoyHfNIvpNfSHSuKMe0xIGahifw0cGYHnlK
         Plbg==
X-Gm-Message-State: APjAAAXE0KEVIg+YVJvED8komv117+O0GNpiY8cAIxbK5iFVrlkj/WeV
        LS7V0i4Fi/qCXRfLc7H9vRCbkgxoABQTVyl/Vp0=
X-Google-Smtp-Source: APXvYqwOrHdUs8OEIvDvqLOmSa8Rkk6hhV/z70vao1pG+RVSQciVLuQQSVbz5BPcRpgISXfd+TZmAirl3wFd5jI+I/8=
X-Received: by 2002:a05:620a:25b:: with SMTP id q27mr6927937qkn.438.1568846778376;
 Wed, 18 Sep 2019 15:46:18 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:03 -0700
In-Reply-To: <20190913210018.125266-1-samitolvanen@google.com>
Message-Id: <20190918224608.77973-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2 0/5] x86: fix syscall function type mismatches
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set changes x86 syscall wrappers and related functions to
use function types that match sys_call_ptr_t. This fixes indirect call
mismatches with Control-Flow Integrity (CFI) checking.

Changes since v1:
  - Use SYSCALL_DEFINE0 for __x64_sys_ni_syscall.
  - Include Andy's COMPAT_SYSCALL_DEFINE0 patch and use the macro
    for (rt_)sigreturn.

Andy Lutomirski (1):
  x86/syscalls: Wire up COMPAT_SYSCALL_DEFINE0

Sami Tolvanen (4):
  x86: use the correct function type in SYSCALL_DEFINE0
  x86: use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
  x86: use the correct function type for sys_ni_syscall
  x86: fix function types in COND_SYSCALL

 arch/x86/entry/syscall_32.c            |  8 +--
 arch/x86/entry/syscall_64.c            | 14 +++--
 arch/x86/entry/syscalls/syscall_32.tbl |  8 +--
 arch/x86/ia32/ia32_signal.c            |  5 +-
 arch/x86/include/asm/syscall_wrapper.h | 76 ++++++++++++++++++++------
 5 files changed, 78 insertions(+), 33 deletions(-)

-- 
2.23.0.351.gc4317032e6-goog

