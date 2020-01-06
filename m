Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39FC246A5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUApBLrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgAFUIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55732 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgAFUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so16357303wmj.5;
        Mon, 06 Jan 2020 12:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W/9ml2m6aRpS+eY1h72K+WTUbcufXSmAh2zav3wFul0=;
        b=nUApBLrT12dtHzBUNW+91GkYJNT8CMoxqT6CZfQ6hT3D5Xu3l1HapCJ/LVD4uGsIYF
         5+ztFq90u8miuaFu9lVcXJN7TMn36B7k19GsMlXr4JyGqCSonUb7zrsfb28jYiD6iPq8
         DEbE6g2dOZ3hoef34k8NUevnE53Met8iP7gwsiSNIaGQdo9AdD40gg9WYTF2z9/jeu/2
         U0t2m9qH0Ac+DrPR9HEHa5bg8qwPECWlwjg8pNGphxVtWAWK9TI3galS6z40byot2PX+
         0goj5Xvjg0DzAXI6YNoqmOM8V2Sz4X8QzowAag4Q02Oppg+z3CevDcDOttj9VY0e6bhd
         AZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W/9ml2m6aRpS+eY1h72K+WTUbcufXSmAh2zav3wFul0=;
        b=FX32suJtO0to5XgOJGjuScHUPQdgwF7a1ve+v1yxUb9f/8MaV0cwjMkthHn2l/v209
         7y1RtLDs2oY5J4YwP3g4+yZ67ol2VBaWBFJll00xEiMETJyB6ARkmLvLy4DgxXyG0kN2
         Mm7BB2cGAw8f/liMrsYcmz9cf01vmJt57s252uVgRC6zBOqE9fz4BWpYw3J9NPuDNuOY
         zoaReixsLj2sciwUDUWPNw0+dgDjgLX16K31ZCVmRBxgMLvlGPagcwXBSHFrXoDzEVQC
         vBNtpem2tpM59nUnhlnD7Mr9RMdpM0ZjjAyiYS7dJURisTmGwL6WNQYXdYWGT6PxIT3Q
         0x0Q==
X-Gm-Message-State: APjAAAXT4HYrpkfwSnrdfyOJdxrbVnyfy9WzCAVNknjTt05F83dystTP
        L1wV8U94MbmKfmpxAOYXcjV5A36n
X-Google-Smtp-Source: APXvYqwlEqXwLCLQB4um5FHFxB2RkVGTjlKq/bBgJWzR3DeyURufoWFCOkdmbSHYh9SLy04LVr4iow==
X-Received: by 2002:a1c:a513:: with SMTP id o19mr33785682wme.156.1578341306881;
        Mon, 06 Jan 2020 12:08:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:26 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 3/7] doc/RCU/listRCU: Update example function name
Date:   Mon,  6 Jan 2020 21:07:58 +0100
Message-Id: <20200106200802.26994-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
References: <20200106200802.26994-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

listRCU.rst document gives an example with 'ipc_lock()', but the
function has dropped off by commit 82061c57ce93 ("ipc: drop
ipc_lock()").  Because the main logic of 'ipc_lock()' has melded in
'shm_lock()' by the commit, this commit updates the document to use
'shm_lock()' instead.

Reviewed-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/listRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index e768f56e8fa3..2a643e293fb4 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -286,11 +286,11 @@ time the external state changes before Linux becomes aware of the change,
 additional RCU-induced staleness is generally not a problem.
 
 However, there are many examples where stale data cannot be tolerated.
-One example in the Linux kernel is the System V IPC (see the ipc_lock()
-function in ipc/util.c).  This code checks a *deleted* flag under a
+One example in the Linux kernel is the System V IPC (see the shm_lock()
+function in ipc/shm.c).  This code checks a *deleted* flag under a
 per-entry spinlock, and, if the *deleted* flag is set, pretends that the
 entry does not exist.  For this to be helpful, the search function must
-return holding the per-entry lock, as ipc_lock() does in fact do.
+return holding the per-entry spinlock, as shm_lock() does in fact do.
 
 .. _quick_quiz:
 
-- 
2.17.1

