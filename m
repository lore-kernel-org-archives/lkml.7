Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB9C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F8D20663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mojWgzFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfGBH61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53491 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfGBH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:25 -0400
Received: by mail-pl1-f202.google.com with SMTP id b24so8627487plz.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u2ErNBZc4tVVKmfAcv1MhDozUn4Eu5YXjnRJ3krxjso=;
        b=mojWgzFnU7tp9b0/JwqZvCHDxNLmXZKy0NVqK8LyP4ccsLQMO4lKXRCj+CdDz17gS5
         b0tXXnF/y4S9r+dr9Um4NEmPi/HljEcYEFhhMOo+2v2dZjTciLi0pY9aYKb8Ge+72kJY
         eLje+/CxVPkanACnDGx6ec2ylTxLiY/NhFEKYJn4dfVdlXVBBE9jAfjzWSXy9xRMUguY
         OjtSjd65lhrwwRFj1/35VTeJ4Y47nlpeiHbSO5r6ifgdmS2RdRF2B8JYZYgVz5Xq4Ngd
         yKd2nc9SzuyG71/mvLXemFRGJqtNOm5GGAcW8Npa4H9JBmflUX8mQ9PCaesFO1jSgFrP
         JQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u2ErNBZc4tVVKmfAcv1MhDozUn4Eu5YXjnRJ3krxjso=;
        b=QdIAOQzznbEnl0iZvy/i0/eyhdkLGW9TFcUDKDlu2br18DXmwY5cNteF2Z8roD9kA3
         6nedkWD06uNA1mXB9oQEtPsJN7QQEen54G+C+Z+5VldDaowfTrZKo0Y46LEdy8pCFbD0
         m/jkJJhFmlkpy9JMuYxLCKS81JXZnts8/fMK035vXzLoozXXCkp4YWaRKt/FQdJDJDjJ
         HZoOKUv0gl+EkuU3cA8jY1BGHZOTyclIkyaUVXobZbovoiyowDHbwhpkZWFg1f4gKGUC
         XqdwCrlBa592iEiyTDrPY9WzwpvUBbwxUHB2ApZADLCd+syHIneubpCp2KoIdEj1hXah
         0f4A==
X-Gm-Message-State: APjAAAW1CFXFxu5OeGrakRF50FVPgn57/5R/1ZYHS5h1liO9rSJWeWE6
        Ax4vqw/4PppjQvsp1B2PNkS/wHe4M7c=
X-Google-Smtp-Source: APXvYqxNoZUwGc+KzK94aXvES0JichA80pDbWeHGfKrZx4gOwPkHs3hQmWXy5ZGU9m7xqqVxPiFxHeBUAzU=
X-Received: by 2002:a63:1310:: with SMTP id i16mr10337257pgl.187.1562054301999;
 Tue, 02 Jul 2019 00:58:21 -0700 (PDT)
Date:   Tue,  2 Jul 2019 00:58:16 -0700
Message-Id: <20190702075819.34787-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/3] make RB_DECLARE_CALLBACKS more generic
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

Changes since v1: I have added a new RB_DECLARE_CALLBACKS_MAX macro,
which generates augmented rbtree callbacks where the subtree information
can be expressed as max(f(node)). This covers all current uses, and thus
makes it easy to do the later RB_DECLARE_CALLBACKS definition change
as it's only currently used in RB_DECLARE_CALLBACKS_MAX.

I have also verified the compiled lib/interval_tree.o and mm/mmap.o
files to check that they didn't change. This held as expected for
interval_tree.o; mmap.o did have some changes which could be reverted
by marking __vma_link_rb as noinline. I did not add such a change to the
patchset; I felt it was reasonable enough to let the inlining decision
up to the compiler.

Michel Lespinasse (3):
  augmented rbtree: add comments for RB_DECLARE_CALLBACKS macro
  augmented rbtree: add new RB_DECLARE_CALLBACKS_MAX macro
  augmented rbtree: rework the RB_DECLARE_CALLBACKS macro definition

 arch/x86/mm/pat_rbtree.c               | 19 +-----
 drivers/block/drbd/drbd_interval.c     | 29 +--------
 include/linux/interval_tree_generic.h  | 22 +------
 include/linux/rbtree_augmented.h       | 88 ++++++++++++++++++++------
 lib/rbtree_test.c                      | 22 +------
 mm/mmap.c                              | 29 +++++----
 tools/include/linux/rbtree_augmented.h | 88 ++++++++++++++++++++------
 7 files changed, 163 insertions(+), 134 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

