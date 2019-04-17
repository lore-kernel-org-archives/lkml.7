Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CCC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E5E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNHc8dyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfDQTkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:40:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41032 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfDQTkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:40:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so12492067plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gT/T9M0R5/BEi6TIlhU+Am5U1UIgoVTtygo47LRkjIc=;
        b=eNHc8dyn4U1XUlujtETs9A87f/6hUOrjt2MNGw93IXp8wvLubty2kvBZFdWrzuvyOJ
         zZw/1esaU+7NJFHlcbG8G5HSxtxenOcwOq+plPF3AMaGm5g8rnUmvefqVzZx3TEzt3fD
         KN9oUT2wYMS4kQ4PTNQ19uBRHK1QCEaYcC1g/5M9eRu2FsdxTMP3iVfnd4UbKa9H7NFL
         BdYxdoXTOXnQq7L84AugDtiQnrQWCnMQEmKq8b19tOUj7AKU7ilUEqAOeHDBs98QdCwq
         SL92Og5JDgI8zqqj2qncqqsGewBaLugHaBRssqE86Isc7s9WU6P54CdAlUh73s1joWZA
         3Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gT/T9M0R5/BEi6TIlhU+Am5U1UIgoVTtygo47LRkjIc=;
        b=dm+rG61Oi6SS9cATa+O0azBdfZYXs8gQcZB/LmAMgpOhMeqbp1IrDepm4AagMBBPC8
         qz4XMtVuYziwoIP69iLc3X8KZZR3NL5fyOwEEySPjM7BbvbuYLBMmvjUX3azf7lC8SYP
         Fmo0f43KSWI4UAu+1vVKixjhHZXZmGsrwdHnbF7PgF95yai4+0mhTjoQiwtIORm8m1w5
         /xixTpTdmxDf4Zwj2NEQ5kU4TtbvHflDcJlB/CVkgaO4YjSLAt2CSHkLUKlQX8QZffoX
         Snpo/cwPD4PEV3iOA09gZ18FHQHJbibjZi0SeU9PjmHl/ldE6PtOoZIu0oCr9Eh5dZGd
         nWvQ==
X-Gm-Message-State: APjAAAXLYJTc+s//PSY+Oke8JvWRRa34VEB1lWZQ+R5QlcDMginlrxto
        4H/Tbx+Z89chw753+oe6gtvJjhj5W44=
X-Google-Smtp-Source: APXvYqwvUKyOhiajy/fe1naJTzh7wzopFZ54w9JSFUM32mfLpFPHYOwHHyl9Ryr0EZcdmvxZyf0xvQ==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr51333883pls.302.1555530006246;
        Wed, 17 Apr 2019 12:40:06 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::3:856])
        by smtp.gmail.com with ESMTPSA id v9sm8625949pgf.73.2019.04.17.12.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:40:05 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 0/2] vmalloc enhancements
Date:   Wed, 17 Apr 2019 12:40:00 -0700
Message-Id: <20190417194002.12369-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset removes a redundant operation in __vunmap()
and exports a number of pages, used by vmalloc(),
in /proc/meminfo.

Patch (1) removes some redundancy on __vunmap().
Patch (2) adds vmalloc counter to /proc/meminfo.

v4->v3:
  - rebased on top of current mm tree
  - dropped alloc_vmap_area() refactoring

v3->v2:
  - switched back to atomic after more accurate perf measurements:
  no visible perf difference
  - added perf stacktraces in commmit message of (1)

v2->v1:
  - rebased on top of current mm tree
  - switch from atomic to percpu vmalloc page counter

RFC->v1:
  - removed bogus empty lines (suggested by Matthew Wilcox)
  - made nr_vmalloc_pages static (suggested by Matthew Wilcox)
  - dropped patch 3 from RFC patchset, will post later with
  some other changes
  - dropped RFC


Roman Gushchin (2):
  mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
  mm: show number of vmalloc pages in /proc/meminfo

 fs/proc/meminfo.c       |  2 +-
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 57 ++++++++++++++++++++++++++---------------
 3 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.20.1

