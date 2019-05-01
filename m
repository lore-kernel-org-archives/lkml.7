Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC6C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A2C20651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtpE+O46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfEAUFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:05:05 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36550 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:05:04 -0400
Received: by mail-qk1-f201.google.com with SMTP id a12so241436qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j1UWHDT4a3S43XmXoocO/8/QcdoleiLleSM+fFU5j3U=;
        b=mtpE+O46RBE22iwEhucexJJgTrsWylAuSBqpI5XhAI2/MeOj7YRLypQhc67Y+v3/5L
         q80eU0MCTyAnnU7g51a1M+L88zcMYhjx4P8giwZ7qTvDeO8YeKRoKJEeAMmZ3181NlzP
         mSHNS9cnwDT/g7HBzdYXNphlRoy6lq5icoPfSiF8p1gelb1vx4vK7rHCLzrvM9LK9jYO
         JMFwXyN1F5T28Y0cA837E9SuXW9smPtVeGTLGyf1iYj+nOzV/mFcKi0DlJb+saUyvU1b
         IikDOanxDREBARGqKRsOs5FHl1AQSCDEGd1UdFeUvzMzV1CysMm0eN4ulhoKzeyEa3dF
         yLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j1UWHDT4a3S43XmXoocO/8/QcdoleiLleSM+fFU5j3U=;
        b=PWNXcDJGkbkg5jgXDDtYgioeqUPUBmGDm0BtnfYaQqFd7ZFCRDMDXpBD8Wl3L/UNJ2
         zBInArf1x778xeWHBDD5PcfqqTE39MMCkTba4+JahAtUF7uQfGKrmYvaGxcNXcONva+o
         jziruKT/wPp58VHnkiFX1sofr3+L5dLbTKRU8pARY+4zr0zLP1f41RHBMbBOzqYOFWBk
         Rc09ka1V+Tcix7F6jp8GSPCkDpCJohkKrl9k8YPT5ampT/HYGXEQVcQko+3wKKqM2eG/
         MIGlS4q50GksAYKujlPOsSjKY1rdOZT1I7keH1Urh/DnswKHKD5hMy0BR4QAa32vQhcf
         2x0Q==
X-Gm-Message-State: APjAAAW2j+Eq+Mx8CUPhBcAi6naBVBQF+HF/Pe7BNj33Qh9O6dmdsCbO
        vmMhPGF84+oLQkLId4iACQMUvy1800swcyz57Gg=
X-Google-Smtp-Source: APXvYqwcmhUFSe0z7HnkFa2sbWE1j+IB2dn0B0YnDnOj177FZGCi3JFg2JIbv4Tt1UYGkEqVWbyRaVUYx0Dd0E4fsH4=
X-Received: by 2002:a0c:8183:: with SMTP id 3mr71929qvd.206.1556741103412;
 Wed, 01 May 2019 13:05:03 -0700 (PDT)
Date:   Wed,  1 May 2019 13:04:49 -0700
Message-Id: <20190501200451.255615-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 0/2] fix function type mismatches in syscall wrappers
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix type mismatches in arm64 syscall wrapper
definitions, which trip indirect call checks with Control-Flow
Integrity.

Sami Tolvanen (2):
  arm64: fix syscall_fn_t type
  arm64: use the correct function type in SYSCALL_DEFINE0

 arch/arm64/include/asm/syscall.h         |  2 +-
 arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.21.0.593.g511ec345e18-goog

