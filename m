Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4697D20830
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C7jTYPeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbfIWApc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 20:45:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46701 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfIWApc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 20:45:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id q24so5720180plr.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wBHZ7zM9MXX6vAa5xiClSfeozP2w4j+/6pxwIyNuhqc=;
        b=C7jTYPeFAbIbaL5ADjIqF9fdD2IepbODMzxIU5MuN1WOhRRWcGtS+MbLhqN+eRDK4A
         onM2qCoHTVwTR3E5SIs75A2NQqB6+EATximTQCQOD3c3VzTIhyRNhkKU+JzVMdLsRLTW
         2UzRJopPvdmEJGkXebL7tPxmCxP7ksuVf3q6/PJGcI6zrZvNv9MHzjT/vmMwRGzLZijF
         4t0/SentLUt/3pKKAuvB1dCXVy1UIYzThsysj9U8G3B13cWoPciVuwQ3Pe6ZKTZRUGLh
         e4scPzR6bUJZ6fxsjDBXGRVwVctGrHNQVhrjWORjE2sijRN0KT/ZPBD1r5ITXhmpBtYW
         6bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wBHZ7zM9MXX6vAa5xiClSfeozP2w4j+/6pxwIyNuhqc=;
        b=EYQ2C/HGoqSZcGKAEdZjNtu98BlS+1k/rR1bPfe/+vzVEJzvng5mXXMKFhAYi4ycVF
         Sk88xYWxomtvezUFig9mcDzUlKOS3JJQdKW4O78uBldmO4zwAa8fYm2B4+s7tRWNH7FX
         MDSYSCQ40wI1mt54A1eQUl6R+8/D/OqkOkGFr+NqJF2F11Kks7itAeMhbuKsqkPLxRoW
         irzeGSY4mqK/ioWftbYPc7MNX3LY8/0ZigEuH6Mu4gYemyM4N5rx6Lr6krhgIWx9T7bI
         nW2GptX7mAuAPLQaOjg+YVonJZceT5n7OWqQItXrDpkHgVdKtaSGuDxjCN/fN8AbYpMO
         xxPQ==
X-Gm-Message-State: APjAAAXPQAM3qx/XrhjONCjUabvZNplgSRQkg8KrbTOhMs2VoWVg1tdT
        1YC5bnY+7wmvRaYeU2LVRNwtvA==
X-Google-Smtp-Source: APXvYqzNPplEeS/iK1Hs/mYsLPurLGP8THxAyivT2BgkccBkoLr/z6Q4+rBcVrDGe93pO8fC50fLsw==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr29298899plj.309.1569199529599;
        Sun, 22 Sep 2019 17:45:29 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l7sm9139392pjy.12.2019.09.22.17.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 17:45:29 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, vincent.chen@sifive.com
Subject: [PATCH 0/4] riscv: correct the do_trap_break()
Date:   Mon, 23 Sep 2019 08:45:13 +0800
Message-Id: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following three situations may occur in the current implementation of
do_trap_break().
1. When the CONFIG_GENERIC_BUG is disabled, if a kernel thread is trapped
   by BUG(), the whole system will be in the loop that infinitely handles
   the break exception instead of entering the die function.
2. When the kernel runs code on behalf of a user thread, and the kernel
   executes a WARN() or WARN_ON(), the user thread will be sent a bogus
   SIGTRAP.
3. Handling the unexpected ebreak instructions is to send a SIGTRAP
   to the trapped thread. However, if a kernel executes an unexpected
   ebreak, it may cause the kernel thread to be stuck in the ebreak
   instruction.

This patch set will solve the above problems by adjusting the
implementations of the do_trap_break().


Vincent Chen (4):
  riscv: avoid kernel hangs when trapped in BUG()
  rsicv: avoid sending a SIGTRAP to a user thread trapped in WARN()
  riscv: Correct the handling of unexpected ebreak in do_trap_break()
  riscv: remove the switch statement in do_trap_break()

 arch/riscv/kernel/traps.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.7.4

