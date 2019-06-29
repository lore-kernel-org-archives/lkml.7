Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39011C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE2208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1kvil0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfF2AuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 20:50:13 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34828 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF2AuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:50:12 -0400
Received: by mail-pl1-f201.google.com with SMTP id bb9so4417982plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 17:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vSxjyz8/Y66kdNcGUJPUp9YY6x8Dlodo2RCaJcNaxWE=;
        b=a1kvil0Uurkh8ryMBknOl4EOiPy96BleAu30jePEV9yCS2lDjrioTiEHkwN5c+jeLU
         cJErJwo3MXBTDBW0uWyM0w+CAx8IFuYIeON0BI1UvUxFpQAZFnUXx1BYd2rJs1QzSYcW
         HMIgdGSMk6LUQVYKcImg2JJBgtF69IEH4KZtQP2URqauc9ZlbU2eHewCWRAmdBeUHgtv
         bbgjONt43GGU44rsTyafGKFEiy8vpPfytVoCDqFxhJCkZnkyKv8k/V9MJJgYU5hdywo4
         VkADiKxbmoHro5FN9jb/DZchD3SMf5LEW+kqJggepNjPjVVDl+Ft/DMV9WLvXPg5m8dg
         4oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vSxjyz8/Y66kdNcGUJPUp9YY6x8Dlodo2RCaJcNaxWE=;
        b=sTZRIJCeyjVpfVjffK54EfsnX/l8UqeBDLPNaY+y9YnBy2caboZb2aN982EoIrWpJW
         MTt9bYLaeUf/pKyew9mMWhP0d6Zr6UwT1HbtU9uTueH248xm8XdigXE3BJF+PcotYfwY
         nsWgpVLYSg7KfHX8CiRAL6z5OXGmsoyT7iHzeC0A8HbTAnRbYxHJr1wW5IqT7fo2A/bX
         GHjM90L0SXhUZb4btPoOFCLilAryUqxTN+lQlKlmf+C3jYqd4oeecr4rGDSVZ0c0o99q
         lZhFH6YObGvZhhz8DaGpKPI7YTlXlyXxPrI5WLB5ck7/BIKXZTjPnQqx2kxObFBvNE81
         PZ1w==
X-Gm-Message-State: APjAAAVoTqqkGJ5t5j7AKznmVUM+aJcQYZw+EkwndzcOwOcTyWUyarpa
        Qg2sr9XQic55pgLwj9g3uAsImONQfAo=
X-Google-Smtp-Source: APXvYqwNCPW4fVIUeur2SLcaWPyR9LAx2fuEY9Xmz2qvKwRvq72EaIvnVtvykvmjDLdkiNMgv3ltNNXj5Lk=
X-Received: by 2002:a63:6143:: with SMTP id v64mr11701873pgb.407.1561769411766;
 Fri, 28 Jun 2019 17:50:11 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:49:50 -0700
Message-Id: <20190629004952.6611-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 0/2] make RB_DECLARE_CALLBACKS more generic
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are intended to make the RB_DECLARE_CALLBACKS macro
more generic (allowing the aubmented subtree information to be a struct
instead of a scalar) and tweak the macro arguments to be more similar
to INTERVAL_TREE_DEFINE().

Michel Lespinasse (2):
  augmented rbtree: add comments for RB_DECLARE_CALLBACKS macro
  augmented rbtree: rework the RB_DECLARE_CALLBACKS macro definition

 arch/x86/mm/pat_rbtree.c               | 11 ++++--
 drivers/block/drbd/drbd_interval.c     | 13 ++++---
 include/linux/interval_tree_generic.h  | 13 +++++--
 include/linux/rbtree_augmented.h       | 51 +++++++++++++++-----------
 lib/rbtree_test.c                      | 11 ++++--
 mm/mmap.c                              | 26 ++++++++-----
 tools/include/linux/rbtree_augmented.h | 51 +++++++++++++++-----------
 7 files changed, 107 insertions(+), 69 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog
