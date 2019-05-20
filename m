Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D9CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8678D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DjNSp4lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392874AbfETRYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:24:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390374AbfETRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:24:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so15528350wrl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7LbX7/z+bisBuM3O8ak5+z3BuUk6en/MivkC0gbDgxE=;
        b=DjNSp4lojmcK2g1PVajzcFlfNrlToCK/xjzFKGxX9JQq+TDujuvkljDlYUdKSGxtbD
         /R2DKMwS9JJ40Q4Ux5Vlyi0pzb/LKXAg6GjQxGkghC12Eg6SfJub9N94aZq4G2Opo120
         FAcW3+Vbq+IMNYaSfB674/4dTXfQMrTymeSP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7LbX7/z+bisBuM3O8ak5+z3BuUk6en/MivkC0gbDgxE=;
        b=rB0Rmbq9KuqKMrqj2jjBWnwKrlTq1+puKgg1BAM/l/tysZ/Hadav3sJLvMcxAeRFAn
         irn1OyW0sd3+j0P30REifJKV87H5m51ZSG0CfZfYbZz2X1KkQCRaOe5ShA0HPv7QQ1LN
         rtr2GXOoYC09ZEOW1xTF5JZlqBYfzZbvTNUpX9ZSBkriGcuqMm5vkBrOaus9uPEkrtaV
         oCjMyasw86dN19K6LUj7Yxx2Z9mf/Tr/NmaeBdCy7MrDJoOY4fXz9t1eG38yo4Psk3jJ
         /FaRbYvPdducbO1G+1pC0m6ukt9CbbK7mbrSdNV/TnIGYY7ulBy4TBChyWxRouvhwyOX
         nq0A==
X-Gm-Message-State: APjAAAUjWaHyvEAiIv6cdTzsUpYAEhfHxSpC1YI6MR09+ozQy13nb6+h
        SEZGcW+vBUWpvKw2fEg5pPakXaolCYmtKQ==
X-Google-Smtp-Source: APXvYqwICtHIm3x3PfRANDb6zb7fck4xdWyV0iu7xBdZDSzuoFJXcNozCO12MS2A3fHbOREYG8Ztng==
X-Received: by 2002:adf:e908:: with SMTP id f8mr15340099wrm.124.1558373068389;
        Mon, 20 May 2019 10:24:28 -0700 (PDT)
Received: from localhost.localdomain ([91.253.179.221])
        by smtp.gmail.com with ESMTPSA id b12sm180021wmg.27.2019.05.20.10.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 10:24:27 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] Fix improper uses of smp_mb__{before,after}_atomic()
Date:   Mon, 20 May 2019 19:23:54 +0200
Message-Id: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this is a respin of:

  https://lkml.kernel.org/r/1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com

which includes the following main changes:

 - add Reviewed-by: tags (Ming Lei)
 - add inline comment (Zheng Yan)

(Applies to 5.2-rc1.)  Remark/Disclaimer:

  https://lkml.kernel.org/r/20190430164404.GA2874@andrea

Cheers Andrea

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>

Andrea Parri (4):
  drm/msm: Fix improper uses of smp_mb__{before,after}_atomic()
  bio: fix improper use of smp_mb__before_atomic()
  sbitmap: fix improper use of smp_mb__before_atomic()
  ceph: fix improper use of smp_mb__before_atomic()

 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 4 ++--
 fs/ceph/super.h                           | 7 ++++++-
 include/linux/bio.h                       | 2 +-
 lib/sbitmap.c                             | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.7.4

