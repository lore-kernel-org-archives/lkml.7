Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE28DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A9520652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InzJcqTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCGPw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:52:59 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41434 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCGPw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:52:59 -0500
Received: by mail-lf1-f66.google.com with SMTP id y7so12047897lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j2DjH/aV1FFHkAFZz9xIgY7GkGEKFIGoN/8Qv71OJ3U=;
        b=InzJcqTW1ouYnlnInMOMbejjkCdT2aZUV0BCW7UEMwvXfEmwTh3zMktLXo8uh79zwP
         NmGigouBAb/u7KQtO51tfjYDS5J6HXq+xyen/jMuMuHzQhWKnAlai0Fjsz8BXD97ghTF
         VHY2YaicX7phfSkuJOGXfZ4xi2cbsRZwfXMNWS/81u+EIItuYrEs2+0beeKN3dwlVejk
         fXkOeDqrIHeZWO+7ZqfE+asWGXS/6N8KtiMl2fl1byLCQlGcgHT8sMyDCyoRZnJ0AV+i
         8nhEnO63w+JycC0Qo+GEILYXUwRUNr2OWTEqdkWNwhzxB8khtB6C1fd5K8MyujKYK47T
         kaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j2DjH/aV1FFHkAFZz9xIgY7GkGEKFIGoN/8Qv71OJ3U=;
        b=tPzRniyAhZR4uL7rKNDry7av/weJeuFmd51gnOTmctEFUwNeD+oT0K5qeP33cXPaSt
         wCmSZHG/xId3t9HHRH+ajgWYZESLDdu7D6CvpBYP14Tna8j9551WJGj4NDMPMw2tJD6k
         13Tkyhz64CW1VQzzQ0JZN5ZUk7+RVLWdEBAblrAMaBg/+JjCFvThj544+n86w5LzMcH/
         BlwdYyUUOqvWofM3wuMQbZSkMcaLA/o8iBXvnhhz6OKStCILuaBQs4Eq+M6yeuPVs7nI
         AacjU0OUkPvU8iPn/uSdaSpuugJVNpFiX28Yt8zL/vZf3iOTRjh+1KQyfdfCcdDo+1LT
         LePg==
X-Gm-Message-State: APjAAAWHIhVRQJL2g3h2iXHMl7Cev5sUkmS0fPJxrQaUAEWM+Hla6Dqd
        IAg8x2FqRSU4ktovMjp2DyA=
X-Google-Smtp-Source: APXvYqz/coxBvqUBHz73ObvRBc5Ki8aAKtv3anw+fiom+QZl/jH/inH+fexDo+Kamjt8nNOCRxG7Ew==
X-Received: by 2002:a19:8d4f:: with SMTP id p76mr1987112lfd.17.1551973976710;
        Thu, 07 Mar 2019 07:52:56 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net. (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id q1sm895695lfe.12.2019.03.07.07.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:52:56 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/8] xtensa updates for v5.1
Date:   Thu,  7 Mar 2019 07:52:18 -0800
Message-Id: <20190307155218.26272-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following batch of updates for the Xtensa architecture:

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190307

for you to fetch changes up to 60deebe6149a3f02fa6a9fa988dda500effda43f:

  xtensa: simplify trap_init (2019-02-07 12:35:32 -0800)

----------------------------------------------------------------
Xtensa updates for v5.1:

- use generic spinlock/rwlock implementations
- clean up IPI processing
- document boot parameters passing to the kernel
- fix get_wchan
- various cleanups in time.c, process.c, traps.c and thread_info.h

----------------------------------------------------------------
Max Filippov (8):
      xtensa: document boot parameter passing
      xtensa: SMP: rework IPI processing
      xtensa: clean up arch/xtensa/kernel/time.c
      xtensa: provide xchg for sizes 1 and 2
      xtensa: use generic spinlock/rwlock implementation
      xtensa: fix get_wchan
      xtensa: drop unused definitions
      xtensa: simplify trap_init

 Documentation/xtensa/booting.txt         |  19 ++++
 arch/xtensa/Kconfig                      |   2 +
 arch/xtensa/include/asm/Kbuild           |   2 +
 arch/xtensa/include/asm/cmpxchg.h        |  36 +++++-
 arch/xtensa/include/asm/spinlock.h       | 185 +------------------------------
 arch/xtensa/include/asm/spinlock_types.h |  15 +--
 arch/xtensa/include/asm/thread_info.h    |   9 --
 arch/xtensa/kernel/process.c             |   6 +-
 arch/xtensa/kernel/smp.c                 |  38 ++++---
 arch/xtensa/kernel/time.c                |  53 +++++----
 arch/xtensa/kernel/traps.c               |   5 +-
 11 files changed, 113 insertions(+), 257 deletions(-)
 create mode 100644 Documentation/xtensa/booting.txt

-- 
Thanks.
-- Max
