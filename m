Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0C820717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CR/JDBPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfIMVAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:00:24 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48063 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:00:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id t65so22187729pfd.14
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vQ1OlAR95jmzoCSZdOdCu1NNKndyQKJhQ8jwbWUdhBw=;
        b=CR/JDBPOK6ofra6XcSAq0KFcONHnY8D3ebJHzPcTTqVz0Hl+YAIwzanUg2JEHEJDVV
         Fltt49vvj8DudYMSi1mkKlBjX64fFcEBJRxyU9ShbWZaMVs2QnxVJJqjL33G61xgOkti
         UGUf7NSyo9ci8q3fIob+3dCnXyqx/e8YYIUGTIIO/AEr7JYPzIHq0Yr5wMjs8E7SC09C
         GdYvElTUCVcEwxWLmUrSwe5Y9aAPckHiV2rzN4xvDdfl2b0ernpcPXnW7MIL5lL5CBSW
         JTgdZ9kb6AousoEkHzXKSZmIqDdrbn27XTcbCRHH+TEFjXtwkU9QGSpcvBH1NR+YfYEC
         /k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vQ1OlAR95jmzoCSZdOdCu1NNKndyQKJhQ8jwbWUdhBw=;
        b=XzSwRlUpUdvfaJPJKLfHPTZpIpjPwtJux0kzYPQMaiz04/cFYe6c4fLr5F85n1hq9P
         0+RY2uurDW6+QIXU9V0pRpFAtC5iNrVcfw8URsq+NiuxGHGpzre6LTf+nIVtKAAaPLLP
         alaFHkSnI+BrwohkSaJh7MI8UWH7DH9DoUMWrC9SeyxwYVqYc2Jk0kYJzyGQpf2tZSpG
         54lj6knbBmpmJNV6JaTZDHKUoCVAl9TfXrzbV7qbIZR0bfWeLOUNRhKCqPSlwcTmzCeE
         19TE8feocXGZYcx42NcBckAEVNjtsRuWk/l4SYLw6i4Z+Bt5i1owNzmlBWWnMEVWlHqN
         Fz6Q==
X-Gm-Message-State: APjAAAVX7V3UmWGI9GuEqf2HW244Y67Mx46N7zDRbgJYb5orECWJm+tA
        L1dkY3a4ZL3tLXkaCe29+8WbAaJmFz/33FKSkmI=
X-Google-Smtp-Source: APXvYqwFD5FdZj/NS5YTUmw/Bbcz267SXFg4DbITcfg6xTWWbQs8W9uFj4tNeF2AuGV7vvXNxO9yCwaTNLqhZnvwKKU=
X-Received: by 2002:a65:5348:: with SMTP id w8mr44918626pgr.176.1568408422925;
 Fri, 13 Sep 2019 14:00:22 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:00:14 -0700
Message-Id: <20190913210018.125266-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 0/4] x86: fix syscall function type mismatches
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

This patch set changes x64 and ia32 syscall wrappers and related
functions to use function types that match sys_call_ptr_t. This fixes
indirect call mismatches with Control-Flow Integrity (CFI) checking.

Sami Tolvanen (4):
  x86: use the correct function type in SYSCALL_DEFINE0
  x86: use the correct function type for sys32_(rt_)sigreturn
  x86: use the correct function type for sys_ni_syscall
  x86: fix function types in COND_SYSCALL

 arch/x86/entry/syscall_32.c            | 13 ++++++--
 arch/x86/entry/syscall_64.c            | 12 +++++--
 arch/x86/entry/syscalls/syscall_32.tbl |  4 +--
 arch/x86/ia32/ia32_signal.c            |  4 +--
 arch/x86/include/asm/syscall_wrapper.h | 44 ++++++++++++++++----------
 5 files changed, 51 insertions(+), 26 deletions(-)

-- 
2.23.0.237.gc6a4ce50a0-goog

