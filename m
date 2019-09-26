Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123ACC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4136217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iaxv69CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfIZTJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:09:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45899 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:09:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id z67so2708488qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ks2qVspm9S/bXYCJdT4jwYVVbHkHmD7QB8KapjaLnAw=;
        b=Iaxv69CZcIcyG7EwEus9/I/xlHQUby/BE2EbJS2l2fcXlakWErmSTtYz7w+E6mYWDV
         SqhSHQGIyib04+gHbn3dQ+0sIUsx4BPNtpsOLb+aVh3vx5SMULvM6tvZURQ+6F0Toif+
         Y7my90KmnJaHAZeLv6cCtmGsTxPR//RMdgdt6MDbh7ycJCDShquXT1jkcc9+3XRbzzTy
         FBaMhjQuCh+k0/Kex4/jb0YLDAUWH28gue68Bi1VdAli2vQ5xYctT72h11KCnzNJpCj4
         WDKvBJqoVqXXgUthcR+p8y79exm6faFKC0tNGXDs3HDNdAO4deX/5zZ6Z6J2gIDtX2Zv
         Xdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ks2qVspm9S/bXYCJdT4jwYVVbHkHmD7QB8KapjaLnAw=;
        b=aqHlEGqTWXv3SZoQpnCb6fUYSNdFpfxkSKTVaQoDUB6EVsY683GSD/miCdMi5e+kyz
         cgHbvy0xho76vivjdMnB4DFKBQ92j7/Y9/qqvqbQ5de2rzpoav/pZrTHwxBvuuI0F9BS
         VF7jpOJpbe6Un0AEN6xY2maXmkyoVqLRxw503QLH9cbgNuOhipbRkKumjU4HNOapCdQc
         pxAVKr1I0NpP1WIPlJwT2xZApGWjIs/gkA+eajN901shf2VTNGuIIkqvWGe4Jwfhlrgr
         M3WzpoTt3cqRhm264pStzShbJW15HzziWZSPEaPBvTYG/KPYeORg49WifqF26xG5+gco
         thZA==
X-Gm-Message-State: APjAAAXrJDJpFwQvJDgeEiwUG35/W3Jy/K+D0ztpG+VTzbzzGv5hHM/3
        KnY66Gx5wKPYRcaZnWyKXA==
X-Google-Smtp-Source: APXvYqyUNH4PmpmnAlPG7lHr+XylC8WTej2L1fcD7O8z5oH8pAI08MnC1IlwdU/AGqTD7psSTve1HQ==
X-Received: by 2002:a37:4549:: with SMTP id s70mr426189qka.143.1569524964545;
        Thu, 26 Sep 2019 12:09:24 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f144sm40062qke.132.2019.09.26.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:09:23 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] arm64/sve: Fix wrong free for task->thread.sve_state
Date:   Thu, 26 Sep 2019 15:08:45 -0400
Message-Id: <20190926190846.3072-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

The system which has SVE feature crashed by unknown
reason. According to the memory dump, the panic happened
because the memory data pointed by task->thread.sve_state was
destroyed by someone.

We tried to reproduce the crash, however, it's hard to do that.
But, we found a potential issue by reviewing the code.

In copy_process(), the child process has the pointer of sve_state
which is same as the parent's because the child's task_struct is
copied from the parent's one. If the copy_process() fails as an
error on somewhere, for example, copy_creds(), then the sve_state
is freed even if the parent is alive. The flow is as follows.

copy_process
        p = dup_task_struct
            => arch_dup_task_struct
                *dst = *src;  // copy the entire region.
:
        retval = copy_creds
        if (retval < 0)
                goto bad_fork_free;
:
bad_fork_free:
...
        delayed_free_task(p);
        => free_task
           => arch_release_task_struct
              => fpsimd_release_task
                 => __sve_free
                    => kfree(task->thread.sve_state);
                       // free the parent's sve_state

To fix that, add a flag in task->thread which shows the fork
is in progress. If the fork is in progress, that means the
child has the pointer to the parent's sve_state, doesn't
free the sve_state.

Masayoshi Mizuma (1):
  arm64/sve: Fix wrong free for task->thread.sve_state

 arch/arm64/include/asm/processor.h | 1 +
 arch/arm64/kernel/fpsimd.c         | 6 ++++--
 arch/arm64/kernel/process.c        | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.18.1

