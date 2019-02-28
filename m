Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7BC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XuAtCfvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfB1Qak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:30:40 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45992 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbfB1Qak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:40 -0500
Received: by mail-yw1-f67.google.com with SMTP id r188so11393526ywb.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r8ZvTCXRT2zhzdpNdKlPpMAbuU1N2QujZ8hztSmYHqE=;
        b=XuAtCfvAHvwTNFMx0qa1F9819pfkkTzHRKOpVaq3vLzhJJZC5lnmioCoV1xfLmgkpJ
         dUDLdfUT4PSmGDHSEcRyAbTij36xsmu5kZSwyjfKZJaAemf6Nbsl6VsdV2r7ap0+WDaQ
         YeOgPqmKIuQpdHTdijMZXbriMUePvgXWfVccv3ivtj43bnZYtbkhClWW1EPrqHeSPisz
         eT80DHEtMFihomuG7eX6Ia1aWE2lXirpvQlmhq3SKiQyN+IljLh2hhi3TEkTJ+u7+Fqg
         v67gmTMwN7XQbZDsN65N671ZQ9Ej1pqoyH1IfvfoZ8BGby5L3JOkc952FiSNY9U8dvb+
         Ut1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r8ZvTCXRT2zhzdpNdKlPpMAbuU1N2QujZ8hztSmYHqE=;
        b=obxedpa+zrqin+6eF5ORuks58bALWbbaS7X20iqzEQ0vrC6vItqPNo/g6mvoeKEg0m
         fgdgNUSQUbTsNfFqrgqotJU/trrmJegNjDVusOH92+HnbcltTBM7K8OBdesjR9aDanJI
         itttieg4EdtawEm/QxbDtjiqnC7B0sWsrte0FdgOCdogBx7G+vJLxqsjGnxS0TAI+6uh
         88CJjQ6vd9C5T8keEzaOmZ58StnK0l2XFydruXFRjOA44cuQLMhykt11yK2quwQaA0RN
         hgVBizqUn3etnv5hMJ6Y0UtMMZZ+aeqwiSb00ASJC7mE48NBVsOB3zFAaWZjeFmRvMfa
         2gbw==
X-Gm-Message-State: APjAAAUqTjqfMIJlSPU6jZ1Lj2lz5NpzRzckcDvue0t7RbIIm/vb69rE
        1zCNpUz/RusTuF8E0ein2yk0vou9lGw=
X-Google-Smtp-Source: APXvYqxB0gH055GPX2oHz+gUwTQnv6YveWOjsj5yriVXg0OXYCP3vvJLY2OFO3TWYjgjYe/vFCCB/A==
X-Received: by 2002:a25:7508:: with SMTP id q8mr227611ybc.158.1551371439265;
        Thu, 28 Feb 2019 08:30:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id 142sm5053877ywl.31.2019.02.28.08.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:38 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/6] mm: memcontrol: clean up the LRU counts tracking
Date:   Thu, 28 Feb 2019 11:30:14 -0500
Message-Id: <20190228163020.24100-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resend #2: Sorry about the spam, I mixed up the header fields in
  git-send-email and I don't know who did and didn't receive the
  garbled previous attempt.

  Resend #1: Rebased on top of the latest mmots. ]

The memcg LRU stats usage is currently a bit messy. Memcg has private
per-zone counters because reclaim needs zone granularity sometimes,
but we also have plenty of users that need to awkwardly sum them up to
node or memcg granularity. Meanwhile the canonical per-memcg vmstats
do not track the LRU counts (NR_INACTIVE_ANON etc.) as you'd expect.

This series enables LRU count tracking in the per-memcg vmstats array
such that lruvec_page_state() and memcg_page_state() work on the enum
node_stat_item items for the LRU counters. Then it converts all the
callers that don't specifically need per-zone numbers over to that.

 include/linux/memcontrol.h | 28 ---------------
 include/linux/mm_inline.h  |  2 +-
 include/linux/mmzone.h     |  5 ---
 mm/memcontrol.c            | 85 +++++++++++++++++++++++++-------------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  5 +--
 6 files changed, 54 insertions(+), 73 deletions(-)


