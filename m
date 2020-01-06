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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D1FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF3D207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmJWfdwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgAFTTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgAFTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so16488547wmj.4;
        Mon, 06 Jan 2020 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EY+zZvmDa2mHk6GedD4Ps5Jyzy5pn8SVTKFDxsd6ff0=;
        b=UmJWfdwy/gRN6EbMwlCS5xB9VW7LvAZHfsXDqtC+PNsYo7u5xN/TEinGNu3d42K0Ae
         RW9LPAO71wNMLHXSQkQ2J4Bz61psDxVYGc1UHeWRUWYisdZcAY95CGdEa7zJ2SIUsMPl
         0wblJinu0vJLiWKp0FevjlT3vrNfcozB38b1ARE9OkS4PiQcmDMLxmzEnmIV6JdTaaYd
         /Uh7ArNzK+h5ianwZklkq5JWPxqcv8rv23FWoDPDp0OnRRge8yhTZ4eMC4V6H+37fHxo
         +z6lG7OZPTXUFG68CvtOQy52Bd4qPklPZdW9ney85lJLu5qdJyU3UsPf0ge9qj+GA6DD
         +2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EY+zZvmDa2mHk6GedD4Ps5Jyzy5pn8SVTKFDxsd6ff0=;
        b=AvwEsaZS8v24b6sS6vB9hKqkEnOI2Q96/nKllnv2o8yh44sRZXjLwBxUjkygRyn215
         ihrghJXyzpnPDluDhbdZnm5dI5UknPsBLXcoKBrWdV5NvcIyUhbADBFPHpyZ/hmuhugg
         44RTEojm+iOeXx7MlEmRiBkFb0/sKO6068WFO1dYNXe64Y1IvXyQYAlxgnL1CcmCcidL
         z7t5tTRBVrsoYXp/4p4SGrvAzwQqcKnvpsEXssR53cvVMgrMCmQuFYxp0XaTsE76ITDn
         /3EhnTfllMFt/sPihFvPoeZxSbqMR+kNX3RpIPMEeB6KFW8EVIAVdV38ij18aPtHJflD
         KatQ==
X-Gm-Message-State: APjAAAV8/rCR5Es7qcNZfEy60sW+vv4UqD5cHfxVevitSl/BuOB5pzpO
        0z44pJBSQC1mK/wu7CPAFIY=
X-Google-Smtp-Source: APXvYqwSEKFcz+d2s4gNXu6k1YCzZ4/cB93QjBpJLHU67sQk7Nw6naVxc0iYNJbzIlSCyIOzuwJQnw==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr34942562wmc.168.1578338353730;
        Mon, 06 Jan 2020 11:19:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:13 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 3/7] doc/RCU/listRCU: Update example function name
Date:   Mon,  6 Jan 2020 20:18:48 +0100
Message-Id: <20200106191852.22973-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

