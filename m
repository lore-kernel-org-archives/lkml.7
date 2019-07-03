Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A9EC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7274F20673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUSp5/cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfGCECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:02:00 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38144 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfGCEB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:01:59 -0400
Received: by mail-pg1-f202.google.com with SMTP id w5so769765pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gqg9vEUEQjamw+U2TDRVFbfZNKD/ycSs0XHiqhxGFk8=;
        b=DUSp5/cDhcH68bi+Nqh/3cwTIsuqcpNTJ4KruX+YPcQUSWG+/5hPHGNhqwkWJb/ah2
         eJ5HtglThdDRbB5I8iYw5/D69dYJppppopzOO2mSI+BbI92ZgW+wCLu8Xv+h3LRowhz3
         razdXHDpi/pPWZA2RqaczdEZYVtlzHeYLehQeXztClJk0ylLisPmM9e0hPPOC9ps2vOj
         NBZcMd8FE0B/tXSKkgo789bUh9lo8LXpT7m8MJCDS17/ksAy/Ql3vLUZ7UdlYbEmPyF8
         XcIP2jw9ou9HOm3326ze3aPAFnH04OmhJkLwpTTkIP2D4mlEQ2uimSPp+VTY/vyzt2I4
         M8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gqg9vEUEQjamw+U2TDRVFbfZNKD/ycSs0XHiqhxGFk8=;
        b=Kh2Cb1SfJVWmnLInqc4eN0tAZ9n6ZdFOQ+TFC35LMlEjxjNOlFizqHf6KTsJWEoqEC
         q2ggESClsQSWDVGC6eIB9mtX9tMiLrbpHAZ+6yTAiQWSacwrtRM2aMhRTVlsDHseg2qA
         dImWiRHORdrdr9LUlrzQVUH2n0k6y11g0mwM7/hW+JchD38s1FXBGsNahrC8V9mqrspH
         qhq2csChNoDaeBSoKdgFEnGioeX1X83JxopJ4MQBbKggzdZElB/bOz65OfcxjfXMQRDP
         ykfQV4Chy43mqGuf28CzKlnKNE10/ZC8gfbP0KiKG/Wn1W0sDF2cmrkFOcm3IWoXRTft
         yweQ==
X-Gm-Message-State: APjAAAU5rgb3WtDcIu2FEjt8OCVw3MFZ3hNk3/ugSIa+hAxXMqWhDID4
        KVO35Khr1ha96D1xhZy3hq/DSyMBIEg=
X-Google-Smtp-Source: APXvYqz8itvyzvB1Vq0/P0tWAt+xsWqpGwm8HIcCNWK36t77P21Vj55S/U3vpny77Lo89mae91rO0A++5zY=
X-Received: by 2002:a65:43c2:: with SMTP id n2mr15101876pgp.110.1562126518698;
 Tue, 02 Jul 2019 21:01:58 -0700 (PDT)
Date:   Tue,  2 Jul 2019 21:01:53 -0700
Message-Id: <20190703040156.56953-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/3] make RB_DECLARE_CALLBACKS more generic
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
instead of a scalar).

Changes since v2: Left the RBSTATIC and RBNAME arguments first in the
RB_DECLARE_CALLBACKS and RB_DECLARE_CALLBACKS_MAX macros as suggested
by Peter Zijlstra.

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

