Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B073720830
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7KEP9QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfDHSCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:02:13 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:45608 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:02:13 -0400
Received: by mail-lj1-f172.google.com with SMTP id y6so12091684ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6bbuR8C3x8MUlfeHcaWD28nd2nJbIahx7Rl+ufwOamU=;
        b=F7KEP9QKv7v1o44kC959NumzGP76m5rMCwBwsTlbvmKgQ+G8tgTWR+bd83Xyjm/fPD
         HKdVxunhdQqhdz28Z/HRhZueEihudwtfukSePZk1/H3S9SenwqwG6SJDW6/g8Jm14qX3
         FqX/y6ArZjLAR3sbaL0Eat/haEpKRMp3CKV8l8CfW1+5RAzrRs8dTv3vk3SrnqvlOnQR
         v3FUP6HR36YiU9GAqrfpQC6ZNV+QLuyOwI+5BHats59VHhZjx0Yvx2jMOWJrbF2g39qJ
         GQvnInFDY4ffKlukVUvUqiyhOzc2C5Oc1E5wnU/cpkzR5ELcpgLaIumXYrp7OgYgTL5K
         b3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6bbuR8C3x8MUlfeHcaWD28nd2nJbIahx7Rl+ufwOamU=;
        b=K03sLItFUEfWZGks9oUf9j03qqhWHNRDaYtkAPL1YFemvKZUz7Sr0cTv9SVHiMWyQQ
         IpsRCaltWZybAPazuYPIdCXqeAC+16VNlJ5xr/1meR1IZfdQNcQ4mxgGkdB+RNCb2juh
         vDbt6K5NReS+zKFMSs9KZ2LZUvR4a6n8ak5jsPoh912y/ibxKrsS0+W5Uvu6ongj1Tww
         0DLSnnUhtiP6M2d0lmqHq26T8IqHBGC8q0fvq1H53nqhFZI9gIJFARCEtnIZJQYSjItk
         dzPRyxlaEBlceXkN7U7klKfl3+6voffb2va5l9GLj5SoL49e+mW/8+NWwhEEouE1S8cD
         Yplg==
X-Gm-Message-State: APjAAAWCuTyM6vWaNUecw2UwbRBxeu7vuGnIWr5M6S66u1IU8RjA3DTo
        mvOaRaD39zovLresgcPHBrwbTXC8
X-Google-Smtp-Source: APXvYqyaQcu0ZnzMYCoTh9XeDoSqz1ouYa5Q3uOzQrcsxesbJN0ZVicUW9RSJw9eTCwWmKPE5qiZFQ==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr16437684lje.22.1554746530923;
        Mon, 08 Apr 2019 11:02:10 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id n2sm6130051lfe.71.2019.04.08.11.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 11:02:08 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/4] xtensa fixes for v5.1-rc5
Date:   Mon,  8 Apr 2019 11:01:46 -0700
Message-Id: <20190408180146.20202-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of fixes for the xtensa architecture:

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190408

for you to fetch changes up to ecae26fae15abb7d433557afbd15467ce1c444f5:

  xtensa: fix format string warning in init_pmd (2019-04-04 18:45:55 -0700)

----------------------------------------------------------------
xtensa fixes for v5.1-rc5

- fix syscall number passed to trace_sys_exit;
- fix syscall number initialization in start_thread;
- fix level interpretation in the return_address;
- fix format string warning in init_pmd.

----------------------------------------------------------------
Max Filippov (4):
      xtensa: use actual syscall number in do_syscall_trace_leave
      xtensa: fix initialization of pt_regs::syscall in start_thread
      xtensa: fix return_address
      xtensa: fix format string warning in init_pmd

 arch/xtensa/include/asm/processor.h | 21 ++++++++++++---------
 arch/xtensa/kernel/entry.S          |  6 ++++++
 arch/xtensa/kernel/stacktrace.c     |  6 +++++-
 arch/xtensa/mm/mmu.c                |  2 +-
 4 files changed, 24 insertions(+), 11 deletions(-)

-- 
Thanks.
-- Max
