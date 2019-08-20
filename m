Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC280C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C178923A85
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SmZ/pRAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfHTITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:19:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34675 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfHTITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:19:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so5355670edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2z56NGRuBwQ6OtJWWZ+ElQlv8Da6Bh+gCKkp4IYR4I=;
        b=SmZ/pRArK01I8lgnLa49hGHl9IbRlO4jooOekpAQLUww/NtZzFbMdIf6NslU/Y3SKc
         gCLvUacj0TPK72ol8Q8Xy9ZgNWfki0+DDeENUyIK5fHcnRb+guPbzkfvrrpI3BAbNMmh
         SzIkH2ny+RAPMFrNxXmq4QZ6VxH2OOupC75XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q2z56NGRuBwQ6OtJWWZ+ElQlv8Da6Bh+gCKkp4IYR4I=;
        b=USV/LlcaW54ZrHF/CHaUXpaZjPywpLty51NQQQzCXhC574vmjWIf8yRcwGfPI1sIkN
         dbO5MkvkmJkICmAilEmNtKfwGiDzJKWovZW7QZft8SEHjDxxTboqRnYofI+VKtuWY/VQ
         qUD1kcxFNC+8c10s7GtRfmN4NcmRzL5w8Q/aLKnKx3XJpHIvswNzkfi+XcRA36PrFbHy
         arj/mcxVNCgfu5CvqBhVHvaapufPjPL3HbvpyuJnGPRpAL/8jLSKNPV1oDloPpEv2R0y
         X0PyajUQPJzAGcfNn55G2CDv/mWVQUW+J9l3PNFdvIcfcQ3johoiq+8UDOBX/g1qWmRh
         3nNg==
X-Gm-Message-State: APjAAAVwXSbm+EQ+P4WOHLVD9ysY8U8vbZgVX/b8WdG83u4W4og+su3o
        j/EepufSDfRmSEmrkr+g5WN4niQu30s84A==
X-Google-Smtp-Source: APXvYqzDZ+XSiJaUiLyBO6xryISbkppFw3Ap9Zd0Y3Zq1bsN8EUYkCC3bk1FyxoLEsheLO+r1k3c9A==
X-Received: by 2002:a05:6402:155a:: with SMTP id p26mr30221294edx.9.1566289148256;
        Tue, 20 Aug 2019 01:19:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id fj15sm2469623ejb.78.2019.08.20.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:19:07 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/4] mmu notifier debug annotations/checks
Date:   Tue, 20 Aug 2019 10:18:58 +0200
Message-Id: <20190820081902.24815-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's the respin. Changes:

- 2 patches for checking return values of callbacks dropped, they landed

- move the lockdep annotations ahead, since I think that part is less
  contentious. lockdep map now also annotates invalidate_range_end, as
  requested by Jason.

- add a patch to prime lockdep, idea from Jason, let's hear whether the
  implementation fits.

- I've stuck with the non_block_start/end for now and not switched back to
  preempt_disable/enable, but with comments as suggested by Andrew.
  Hopefully that fits the bill, otherwise I can go back again if the
  consensus is more there.

Review, comments and ideas very much welcome.

Cheers, Daniel

Daniel Vetter (4):
  mm, notifier: Add a lockdep map for invalidate_range_start/end
  mm, notifier: Prime lockdep
  kernel.h: Add non_block_start/end()
  mm, notifier: Catch sleeping/blocking for !blockable

 include/linux/kernel.h       | 25 ++++++++++++++++++++++++-
 include/linux/mmu_notifier.h |  8 ++++++++
 include/linux/sched.h        |  4 ++++
 kernel/sched/core.c          | 19 ++++++++++++++-----
 mm/mmu_notifier.c            | 24 +++++++++++++++++++++++-
 5 files changed, 73 insertions(+), 7 deletions(-)

-- 
2.23.0.rc1

