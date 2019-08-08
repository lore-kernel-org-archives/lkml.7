Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9255C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8B217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfHHDyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:54:54 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41060 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727950AbfHHDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:54:54 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x783sqKq007192
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:54:52 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x783sl0V001184
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:54:52 -0400
Received: by mail-qk1-f197.google.com with SMTP id k125so81052101qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=q2nGPK82s1cp/sIyRqneqDyvBd25RJ9/6d60OSvlzDM=;
        b=aI9xY7Vq911PZqwnQnTAv4A72WnrIny/wc2XfVp8oolqHa1tDEe5N1uIXAsPhfJeQF
         V6yjGRnCj7XzZnU7vg9b6bP2vojCIhOO7llVlnzAFu9ZpPqcWyx+wifISKKOID9aGo99
         ayleARP9QuZfe5Gyzj7mrCG2pyZicWz8Lxdakq9U6oyTidi6Ncs3DeaIi2EmyMW3WDwH
         jw6JzMFSvwsh+A3wYFMuuxvAQeBWYbCNPW/f+L3B9SwKl5zCIz8HixJ6oY2aZH3I8PBo
         voqCyu4fB1ctYAmm916pt0sVMJNCEuxd6TurrTPVgK1Dobl334MZxNNUjkKhPNjXUACf
         KsHA==
X-Gm-Message-State: APjAAAUpKMU1uPcPM/K5wAFDiODqJyIb1zmtzSfm49h9baBWgU1rMMhh
        U+v0HFMDlpwLOSVuahBsFQBoNSFG+ZpR/EOoGoSXpOQ2tjkQDwzP8vChydNGIET0L+NjfdexdCz
        e6OxGnXsufumd5HRr13qhPQ7X6llVEd/iUuc=
X-Received: by 2002:ac8:7a9a:: with SMTP id x26mr11532043qtr.251.1565236487050;
        Wed, 07 Aug 2019 20:54:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxI3KwgRWvJ6jURkvIKISsvzBuspMT1VhHTDRe+P5fLNHfbfcljt7OEdLjK3d0DiuXLEizclg==
X-Received: by 2002:ac8:7a9a:: with SMTP id x26mr11532033qtr.251.1565236486827;
        Wed, 07 Aug 2019 20:54:46 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id m27sm45970877qtu.31.2019.08.07.20.54.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 20:54:45 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/generic-radix-tree.c - make 2 functions static inline
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 23:54:45 -0400
Message-ID: <46923.1565236485@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, we get some warnings:

l  CC      lib/generic-radix-tree.o
lib/generic-radix-tree.c:39:10: warning: no previous prototype for 'genradix_root_to_depth' [-Wmissing-prototypes]
   39 | unsigned genradix_root_to_depth(struct genradix_root *r)
      |          ^~~~~~~~~~~~~~~~~~~~~~
lib/generic-radix-tree.c:44:23: warning: no previous prototype for 'genradix_root_to_node' [-Wmissing-prototypes]
   44 | struct genradix_node *genradix_root_to_node(struct genradix_root *r)
      |                       ^~~~~~~~~~~~~~~~~~~~~

They're not used anywhere else, so make them static inline.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index a7bafc413730..ae25e2fa2187 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -36,12 +36,12 @@ static inline size_t genradix_depth_size(unsigned depth)
 #define GENRADIX_DEPTH_MASK				\
 	((unsigned long) (roundup_pow_of_two(GENRADIX_MAX_DEPTH + 1) - 1))
 
-unsigned genradix_root_to_depth(struct genradix_root *r)
+static inline unsigned genradix_root_to_depth(struct genradix_root *r)
 {
 	return (unsigned long) r & GENRADIX_DEPTH_MASK;
 }
 
-struct genradix_node *genradix_root_to_node(struct genradix_root *r)
+static inline struct genradix_node *genradix_root_to_node(struct genradix_root *r)
 {
 	return (void *) ((unsigned long) r & ~GENRADIX_DEPTH_MASK);
 }

