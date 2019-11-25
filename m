Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE440C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA8207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574689769;
	bh=6I/0En73vCIUPLV/9/MTj05YMs2DcS8gllGrGk/xdfI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iwV1Xf4Hj36sjM1BL1uDrdGY4e7W3Pl7g3hzTfHIkxKOAk/792HhTazMb5ig3Ot3l
	 clUcs3shzqBnGMcg/hncohU3ynIJ92wRiba2qN1zklymf2kiEOR/ZOuNmx/TvcLRH6
	 tTP2R9BmdD0ALGRBbO616P+okOTvxgAb53ujDTHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKYNt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:49:28 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34461 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfKYNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:49:28 -0500
Received: by mail-wm1-f54.google.com with SMTP id j18so16252849wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tdcShvfZBNbG9okHGeEeaDhrv4mPc06HO+FkdFGO868=;
        b=L84VZD7fT2zMjlo+10BGvtnX6br7LwpOIvdMXoKazepZAE0A7Oc/51UTuy0FeF6brH
         1BZFUcKO1eNHP8tih4Nn+iYUxxgxOHSa1EwNtIDwJwQUsqw7qDNkw0LNWgbva5rJaVKD
         0rAuhi54+rcT0Jg42L4KZhNS91/UxjZ+i8wBgcoV9UNX3FlIsksNALCg/3n+xGGRkkpO
         Yo3xzZPsB+44pOaC95Go06Kjo2kKEcldB9hRxTyYXqGy/aDWQy1VZJYbX/DHYFisLZQC
         DUGJ9vpqrf1zAmk6dhgUd/fvvYJ27FB4y36hRj0aMEKvEwSAHDiPrM/Ajzrlp0AfS4kl
         OjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=tdcShvfZBNbG9okHGeEeaDhrv4mPc06HO+FkdFGO868=;
        b=ns4dZhJdPCJ1sZ0XO6vx5rILUM/qscwbMEdqWTwqnQCZia0I9y3NNLGznc+XIs0gfc
         D+tayrrEdR6FNJN/aCyM5qq6suXxQ7txa1XXHQLMWNMWCXKLCB38BYWwUzgNhdrnNFYz
         oJ06VV5nvhkuchmQw5I7O/91A2E5Xo2n7bA938e7+8akX5tiRKD2LGT3OKRbciXgMLiy
         ldIS8k/2yc2Xwy21EuVthPyEgxopyrKIfHg4zO0WrbobEZzCIXqi3BR3rPk/JnNi/esU
         uiQdpLYeI7VC+0Y6fjJOqA/b+vFunOYTxEQt4DZpACj67papkafZ5cxQRbm7hxVoNSVz
         GAZg==
X-Gm-Message-State: APjAAAXCOCVbyB1GfiewMd9Gg+I8TnlonhrFd6pJhgnfluusJXmIRLQZ
        zhAL2XMG2uV3WZH+/c8xfFw=
X-Google-Smtp-Source: APXvYqyvoE5KM0vMZuPfX8aUkIur7j9qzDjFkRuiwIE7MNMqZEjbbxZKBXRKCmu/pwrmfXDhRaF00g==
X-Received: by 2002:a1c:2e0f:: with SMTP id u15mr28802803wmu.47.1574689765880;
        Mon, 25 Nov 2019 05:49:25 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g138sm8790067wmg.11.2019.11.25.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:49:25 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:49:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/entry changes for v5.5
Message-ID: <20191125134922.GA5532@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-entry-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

   # HEAD: f53e2cd0b8ab7d9e390414470bdbd830f660133f x86/mm: Use the correct function type for native_set_fixmap()

These changes relate to the preparatory cleanup of syscall function type 
signatures - to fix indirect call mismatches with Control-Flow Integrity 
(CFI) checking.

No change in behavior intended.

 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      syscalls/x86: Wire up COMPAT_SYSCALL_DEFINE0

Sami Tolvanen (5):
      syscalls/x86: Use the correct function type in SYSCALL_DEFINE0
      syscalls/x86: Use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
      syscalls/x86: Use the correct function type for sys_ni_syscall
      syscalls/x86: Fix function types in COND_SYSCALL
      x86/mm: Use the correct function type for native_set_fixmap()


 arch/x86/entry/syscall_32.c            |  8 ++--
 arch/x86/entry/syscall_64.c            | 14 +++++--
 arch/x86/entry/syscalls/syscall_32.tbl |  8 ++--
 arch/x86/ia32/ia32_signal.c            |  5 ++-
 arch/x86/include/asm/fixmap.h          |  2 +-
 arch/x86/include/asm/syscall_wrapper.h | 76 ++++++++++++++++++++++++++--------
 arch/x86/mm/pgtable.c                  |  4 +-
 7 files changed, 81 insertions(+), 36 deletions(-)

