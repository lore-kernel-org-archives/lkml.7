Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D73720665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdbAFnW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLPVbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:31:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726646AbfLPVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576531889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gf2ricw+onYr0gm+AR6+k5HSEyYMCtkMzHEny3QS9g8=;
        b=WdbAFnW4zXr6qmGNd4ljKoqB/yIfIWc6OxwpBvxDmACl2fP0WrFbnYQnG9gPMz0wqbe4Ti
        PBGSmpLWSOOkjL/xaYdZCHrIggQnnKSKzVRHrkSslbsWw5vdd+lcoKrXCqRPapHvviamwb
        5up4GRGbkG4yCTWSSjnLJqgRkkR+YWI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-6x9gTAy3MpqRDqrfms42Rw-1; Mon, 16 Dec 2019 16:31:28 -0500
X-MC-Unique: 6x9gTAy3MpqRDqrfms42Rw-1
Received: by mail-qk1-f199.google.com with SMTP id a6so5540133qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gf2ricw+onYr0gm+AR6+k5HSEyYMCtkMzHEny3QS9g8=;
        b=QptSQaYlAQ71pjW/DYfEXlvygfmOss8+STlAb5YFfWBFE3/PZjfi/yTIaN4jrohN2u
         Gx4GSmh2YwVWuLfwG73y7TeN2vz5+Tbg883/3DrR+qTFxlEZbzEeD4UWwNys6nxFpRCF
         XUfugqPmxwpATI6pceGHUS7nZ3PpViB0ems74SGwbgTw+WFyT5B0Ul/Qda9SxPbeItUw
         fFAnjLp+OKkLPIZAzUh1bA7FijGtxJnph+fWQyH1F3TmG47dF23MoZAroSsKGzqSl/YL
         i4zXpFwHmYrgyYWCtBbrxB+R+bFZXyPCgGHLcKEkM3atFUBVP7GXP0OlBxJO+qtly0oS
         4PDw==
X-Gm-Message-State: APjAAAX7Ub4lO+HgekYFbBSsTh2ctINRcGXL6SVYv9/d54dQ8pxA4oVW
        N2fEEKfF1TEs+EexWqbWJlOKq1oy7m5GKo8rE2P9L40gwpzFK6etg1x4qIEP+n80f8fQNcaGyBL
        2QP1C5BgZGRxo5daKI9Ua5n8q
X-Received: by 2002:ac8:7109:: with SMTP id z9mr1447527qto.233.1576531887603;
        Mon, 16 Dec 2019 13:31:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmkOClnLDiNaNQg+55Xs47xPBnhGiLFn5D+m3t+yLEvJAqK5TLM3f+g2F98MHsFzifajYp4Q==
X-Received: by 2002:ac8:7109:: with SMTP id z9mr1447500qto.233.1576531887357;
        Mon, 16 Dec 2019 13:31:27 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y184sm6321943qkd.128.2019.12.16.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:31:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, peterx@redhat.com,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/3] smp: Allow smp_call_function_single_async() to insert locked csd
Date:   Mon, 16 Dec 2019 16:31:22 -0500
Message-Id: <20191216213125.9536-1-peterx@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v2 introduced two more patches to let mips/kernel/smp.c and
kernel/sched/core.c to start using the new feature, then we can drop
the customized implementations.

One thing to mention is that cpuidle_coupled_poke_pending is another
candidate that we can consider, however that cpumask is special in
that it's not only used for singleton test of the per-vcpu csd when
injecting new calls, but also in cpuidle_coupled_any_pokes_pending()
or so to check whether there's any pending pokes.  In that sense it
should be good to still keep the mask because it could be faster than
looping over each per-cpu csd.

Patch 1 is the same as v1, no change.  Patch 2-3 are new ones.

Smoke tested on x86_64 only.

Please review, thanks.

Peter Xu (3):
  smp: Allow smp_call_function_single_async() to insert locked csd
  MIPS: smp: Remove tick_broadcast_count
  sched: Remove rq.hrtick_csd_pending

 arch/mips/kernel/smp.c |  8 +-------
 kernel/sched/core.c    |  9 ++-------
 kernel/sched/sched.h   |  1 -
 kernel/smp.c           | 14 +++++++++++---
 4 files changed, 14 insertions(+), 18 deletions(-)

-- 
2.23.0

