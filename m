Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6720B21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N9cq1ZKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfH0TCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:02:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39752 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfH0TCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:02:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so13171236pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=5J5ALFJFkpv7Xs4w8D18Z1Cn1zrt1Xws6/fBk8kZfIE=;
        b=N9cq1ZKagXv/qFb0Zp04dquOjBGdS+OZo912oiF3DrRIaW7/QgM3OaS785bVYHJulY
         P8kvZNKvEpQJIYFFRLCgg/N2dY4ccV0yCa9D+CAlyuJ+ODXMK5JVWdqcQar7rN27qbhz
         LO60YlB8QKon0WNBnt/iwWOBTZdMYnMu75hVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=5J5ALFJFkpv7Xs4w8D18Z1Cn1zrt1Xws6/fBk8kZfIE=;
        b=ArZGFf0uYx+16kVoAiG9rGiokI1VncgTghN47gBch2qR0eUFj5ccvMXQL4HXFUWi9P
         pOagbWLDtyVSwiqc3AWVeDxJmGXYg09N4MAuf67kwAlopHNctRCxXqtwCr8/lf9CIrcU
         zvttPqoKWSnhLx0gFQHGxoJD8vI8sOdnQ6/QcjPdZ8rSCOKV5Yn7Smo+g35EIo5ic6ep
         xbXnAlyVL5kRM1lW35V8kWm/RyUcgp6A17uTtzBygB17hmI+2sG6PlF7D19rwB1GuMoc
         2ESfEPAIAAQsChjoo+/CYesz/wGsXl1+d5BPf9bkbBa6AcOIbCABA3Yb9f01KJ2CFfPR
         Eaeg==
X-Gm-Message-State: APjAAAX+4zKKhzvyVrraPslaLtWJOMuizPy3rTbIKL0Qg4on8052XOC1
        Y6LfSUTkrz5SHkwcjJLjVcT2RBOnBIk=
X-Google-Smtp-Source: APXvYqxBT+d283gfCpdPxzoqArn/obPfgyEpcu41H5D/uIJsObZOcwEz5IH3noZjFM5pE2Q4pX305Q==
X-Received: by 2002:aa7:946d:: with SMTP id t13mr28543476pfq.121.1566932529765;
        Tue, 27 Aug 2019 12:02:09 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k14sm33196pfi.98.2019.08.27.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:02:08 -0700 (PDT)
Message-ID: <5d657e30.1c69fb81.54250.01dc@mx.google.com>
X-Google-Original-Message-ID: 156693247224727@cam.corp.google.com
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Subject: [PATCH 0/5] kfree_rcu() additions for -rcu
Date:   Tue, 27 Aug 2019 15:01:54 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a series on top of the patch "rcu/tree: Add basic support for kfree_rcu() batching".

Link: http://lore.kernel.org/r/20190814160411.58591-1-joel@joelfernandes.org

It adds performance tests, some clean ups and removal of "lazy" RCU callbacks.

Now that kfree_rcu() is handled separately from call_rcu(), we also get rid of
kfree "lazy" handling from tree RCU as suggested by Paul which will be unused.
This also results in a nice negative delta as well.

Joel Fernandes (Google) (5):
rcu/rcuperf: Add kfree_rcu() performance Tests
rcu/tree: Add multiple in-flight batches of kfree_rcu work
rcu/tree: Add support for debug_objects debugging for kfree_rcu()
rcu: Remove kfree_rcu() special casing and lazy handling
rcu: Remove kfree_call_rcu_nobatch()

Documentation/RCU/stallwarn.txt               |  13 +-
.../admin-guide/kernel-parameters.txt         |  13 ++
include/linux/rcu_segcblist.h                 |   2 -
include/linux/rcutiny.h                       |   5 -
include/linux/rcutree.h                       |   1 -
include/trace/events/rcu.h                    |  32 ++--
kernel/rcu/rcu.h                              |  27 ---
kernel/rcu/rcu_segcblist.c                    |  25 +--
kernel/rcu/rcu_segcblist.h                    |  25 +--
kernel/rcu/rcuperf.c                          | 173 +++++++++++++++++-
kernel/rcu/srcutree.c                         |   4 +-
kernel/rcu/tiny.c                             |  29 ++-
kernel/rcu/tree.c                             | 145 ++++++++++-----
kernel/rcu/tree.h                             |   1 -
kernel/rcu/tree_plugin.h                      |  42 +----
kernel/rcu/tree_stall.h                       |   6 +-
16 files changed, 337 insertions(+), 206 deletions(-)

--
2.23.0.187.g17f5b7556c-goog

