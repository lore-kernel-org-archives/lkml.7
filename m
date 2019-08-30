Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3A02342C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ca4lqlr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfH3Qgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:36:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37751 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3Qgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:36:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so3808518pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eiTpGNQSkx9ZgNGAr1zGvClHVvsS/CM6xJvw5Wr6Zs=;
        b=ca4lqlr1vdsHU1dQm4AsP65WqLqWQETwpTVm1fDI2LNNFCm2YTDfFwdZg8tlsP9YYs
         oG6dG2gEGropzz+pVsq03bQGLx7D/6jRVwwzuNS7cqO1pSKktP7TeQ1XOzSX4kpV65yB
         uX3jchBo1ZSZKf6lZXX4ABFUyyQaj4jSQSCY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eiTpGNQSkx9ZgNGAr1zGvClHVvsS/CM6xJvw5Wr6Zs=;
        b=CG0TaUnevKMy4d3rp1ojGvVOCgd3WjNKImNibU1cFVX3/liPpM1Y8MUh1dtctlx8OK
         YZqysr+oFWKwmQwob/KSSaVvnxh5B37K1LKsBvQk85/Ntb1cAXwnoSd+dlCrFFJep4+/
         mjhQB9h/w/uhtTRTW4HjUaSb4lfEgZoHC57x3gPrNuQaxAsQIBdQ2asm7XViI4nvME7z
         CvM68fiojpglgLpyicbepdKbpi2FyDAFOtaUlV0lqAel1UEbO65CCwKQHD+pNVCltNjq
         t+LXDnIJZ/ohHiirWgQ+bQQIUYiL+TFk9jV5v6w6B07EFV3d9QwYluUp7NRlgGMKu7I/
         yq4Q==
X-Gm-Message-State: APjAAAW5DyH3/6y3eLAOfMH74L88+w0eFnhT00SchAgavvJqUKCTkrBd
        GnFdXDWpGDJx64OBNovl0NEMw0+WIHk=
X-Google-Smtp-Source: APXvYqxoOhkJ0TDYONOgUk9+Gi3RYif+56yCvEtVd+LRIQCMk6OWqnu/7VYuA72JktgkoyyS6PTuBA==
X-Received: by 2002:a62:4e09:: with SMTP id c9mr19914284pfb.130.1567183002219;
        Fri, 30 Aug 2019 09:36:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j74sm6114080pje.14.2019.08.30.09.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:36:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 -rcu dev 0/5] kfree_rcu() additions for -rcu
Date:   Fri, 30 Aug 2019 12:36:28 -0400
Message-Id: <20190830163633.104099-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a series on top of the patch "rcu/tree: Add basic support for kfree_rcu() batching".

It adds performance tests, some clean ups and removal of "lazy" RCU callbacks.

Now that kfree_rcu() is handled separately from call_rcu(), we also get rid of
kfree "lazy" handling from tree RCU as suggested by Paul which will be unused.

Based on patch:
Link: http://lore.kernel.org/r/20190814160411.58591-1-joel@joelfernandes.org


v1 series:
	https://lkml.org/lkml/2019/8/27/1315
	https://lore.kernel.org/patchwork/project/lkml/list/?series=408218

Joel Fernandes (Google) (5):
rcu/rcuperf: Add kfree_rcu() performance Tests
rcu/tree: Add multiple in-flight batches of kfree_rcu work
rcu/tree: Add support for debug_objects debugging for kfree_rcu()
rcu: Remove kfree_rcu() special casing and lazy handling
rcu: Remove kfree_call_rcu_nobatch()

Documentation/RCU/stallwarn.txt               |  11 +-
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
kernel/rcu/tree.c                             | 155 ++++++++++------
kernel/rcu/tree.h                             |   1 -
kernel/rcu/tree_plugin.h                      |  48 ++---
kernel/rcu/tree_stall.h                       |   6 +-
16 files changed, 343 insertions(+), 214 deletions(-)

--
2.23.0.187.g17f5b7556c-goog

