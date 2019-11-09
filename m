Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D917C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430C421882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YPrLHNng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKITRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:17:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34024 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:17:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so402479pgb.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkFL+O4AgYFx1OONXesexHJ5CbtF3Jn1N0Qya4xrddw=;
        b=YPrLHNngmS1tJAvcSMsgJEZh8HdBQEwSw0bJ8S5ojIqaCdtTh7y7x/8xvEXf2Z00n6
         p++6Y/urc8Z88qhr3eCTXqqZmdpWySEgIEww+jNkXaRb+J2epcucNuHiJuFiHlxW0uKk
         AHYlELgxTqUl9pjpfsdumyOeWgfzdZSuHm8vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkFL+O4AgYFx1OONXesexHJ5CbtF3Jn1N0Qya4xrddw=;
        b=DvLoB+AyYk5CBVznz9oyNJVulVF2k3RiNlKoRgvz364YqApL/9YhCGKZy1mcdQNym7
         PtC5jjB9B8Uxu8YLNsjrc3NSrrCj/y8dy0J/u+YLHlZmNL7XCMmjC6M/uPjDpR5CokeY
         pSdZGL2sXl1qhxDNHbNpdm5hmL2MpreacpxR3++U3rG6Xd0xvJYCHtdd4RNsgi7xHUbw
         xNltAt0y9VHqkM52LUBzmbx3mQJCZHcLlrSyE7IAlGcLnRlDjGYFwvlVmMaDzQxmkOHP
         lcqKdBZ5BxPVXm3HvhTd/KhyLO4zOU8vmfD07JPgV7H2ak41gChHN2+adpA9b44tC1Nc
         /UlQ==
X-Gm-Message-State: APjAAAVMsYVsKKiqK3/ZUf/PZaVt+trWvw5tusviPmitPB70IiZgTGGr
        RbenqdwnDfMuGVTyDDILfXI+ow==
X-Google-Smtp-Source: APXvYqyTQDUg289HvMjCfRmb7zKuKPtAOHS7ULkRiIVT4D+AHpNRRfK1XQJS7vZzBBWOsf2O8cIF9A==
X-Received: by 2002:a62:1c8:: with SMTP id 191mr20604153pfb.152.1573327068017;
        Sat, 09 Nov 2019 11:17:48 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i11sm9193577pgd.7.2019.11.09.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 11:17:47 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     qiaochong@loongson.cn, kgdb-bugreport@lists.sourceforge.net,
        ralf@linux-mips.org, Douglas Anderson <dianders@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-mips@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        James Hogan <jhogan@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 0/5] kdb: Don't implicitly change tasks; plus misc fixups
Date:   Sat,  9 Nov 2019 11:16:39 -0800
Message-Id: <20191109191644.191766-1-dianders@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started out as just a follow-up to Daniel's post [1].  I wanted
to stop implicitly changing the current task in kdb.  ...but, of
course, everywhere you look in kdb there are things to cleanup, so
this gets a few misc cleanups I found along the way.  Enjoy.

[1] https://lore.kernel.org/r/20191010150735.dhrj3pbjgmjrdpwr@holly.lan


Douglas Anderson (5):
  MIPS: kdb: Remove old workaround for backtracing on other CPUs
  kdb: kdb_current_regs should be private
  kdb: kdb_current_task shouldn't be exported
  kdb: Gid rid of implicit setting of the current task / regs
  kdb: Get rid of confusing diag msg from "rd" if current task has no
    regs

 arch/mips/kernel/traps.c       |  5 -----
 include/linux/kdb.h            |  2 --
 kernel/debug/kdb/kdb_bt.c      |  8 +-------
 kernel/debug/kdb/kdb_main.c    | 31 ++++++++++++++-----------------
 kernel/debug/kdb/kdb_private.h |  2 +-
 5 files changed, 16 insertions(+), 32 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

