Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2394C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9B218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320326;
	bh=mLUlze+gMcTfrFw943XwzcNdnDZRFYKLJbSjHmQx4po=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G5lVdcjePyRqfnHBwUD9Tk8MhyRJa2fxckvjCTgPv7ymSWDa9S0WD5IHbi2ziKBbm
	 5r6Kn9iH/jd32N+5estRpMRDHYZcSlvzkHHjY4egDhvO62aoAD2zd9zHo0Yf3aG8Be
	 dc4ge06A88ZOgKJ1PbH67TeUZaVeWbSYqGgE26Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfB1CSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:18:44 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:32820 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1CSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:44 -0500
Received: by mail-qk1-f172.google.com with SMTP id x9so11231398qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AYoc/PM0O7RXeXdYPsnMgGnnG9KkzoC78/ddtavKcnM=;
        b=l/ITi30g7n9hxcvJcq2tjW9RKoKBopo+9LSS0UPzQKVEhMtlwxb+D0zh6XBw63E7/f
         Mdz/RW+2+f/i4SqfLWmlXEd42ebryZDi3XdKbKztBI7xXSbFER48vH/fxAcVS4Gh+DCI
         zdrzVJUAXUpjZaOd5RoJML4n1ltVyHhj0//ZLlt+HahgJPmp/B+cGaWCv09zy/uafW+V
         /zLo29Z+q3teyKXs6iI1K8tErTI3G7sSYVHfrOv+hrl3y17cBd4W4aHOrI+BzxmQFrx+
         w60n4J5gJ5B6g+hGiPmFGP5V6HWHNcHx7btKsKYVUR/otw+JEYK4Mbi0cQJoGtuOeUeJ
         bC4A==
X-Gm-Message-State: AHQUAub1+y87FA23HQvhOxWJCyqy3DLo+JcTISXEWxEOs8TyA9GhgYf8
        3vyDtbxZNeG2c/GMxQq4JnQ+g1EglE0=
X-Google-Smtp-Source: APXvYqy0mzil+0zAVGSelr8mB4+l9uSMHs6jlOK7HfpNiP0KJg3N3BKUDnO1DFvo/+/hEq/+Rm8MIg==
X-Received: by 2002:a37:e10e:: with SMTP id c14mr4525046qkm.317.1551320323146;
        Wed, 27 Feb 2019 18:18:43 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:42 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] introduce percpu block scan_hint
Date:   Wed, 27 Feb 2019 21:18:27 -0500
Message-Id: <20190228021839.55779-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

It was reported a while [1] that an increase in allocation alignment
requirement [2] caused the percpu memory allocator to do significantly
more work.

After spending quite a bit of time diving into it, it seems the crux was
the following:
  1) chunk management by free_bytes caused allocations to scan over
     chunks that could not fit due to fragmentation
  2) per block fragmentation required scanning from an early first_free
     bit causing allocations to repeat work

This series introduces a scan_hint for pcpu_block_md and merges the
paths used to manage the hints. The scan_hint represents the largest
known free area prior to the contig_hint. There are some caveats to
this. First, it may not necessarily be the largest area as we do partial
updates based on freeing of regions and failed scanning in
pcpu_alloc_area(). Second, if contig_hint == scan_hint, then
scan_hint_start > contig_hint_start is possible. This is necessary
for scan_hint discovery when refreshing the hint of a block.

A necessary change is to enforce a block to be the size of a page. This
let's the management of nr_empty_pop_pages to be done by breaking and
making full contig_hints in the hint update paths. Prior, this was done
by piggy backing off of refreshing the chunk contig_hint as it performed
a full scan and counting empty full pages.

The following are the results found using the workload provided in [3].

        branch        | time
       ------------------------
        5.0-rc7       | 69s
        [2] reverted  | 44s
        scan_hint     | 39s

The times above represent the approximate average across multiple runs.
I tested based on a basic 1M 16-byte allocation pattern with no
alignment requirement and times did not differ between 5.0-rc7 and
scan_hint.

[1] https://lore.kernel.org/netdev/CANn89iKb_vW+LA-91RV=zuAqbNycPFUYW54w_S=KZ3HdcWPw6Q@mail.gmail.com/
[2] https://lore.kernel.org/netdev/20181116154329.247947-1-edumazet@google.com/
[3] https://lore.kernel.org/netdev/vbfzhrj9smb.fsf@mellanox.com/

This patchset contains the following 12 patches:
  0001-percpu-update-free-path-with-correct-new-free-region.patch
  0002-percpu-do-not-search-past-bitmap-when-allocating-an-.patch
  0003-percpu-introduce-helper-to-determine-if-two-regions-.patch
  0004-percpu-manage-chunks-based-on-contig_bits-instead-of.patch
  0005-percpu-relegate-chunks-unusable-when-failing-small-a.patch
  0006-percpu-set-PCPU_BITMAP_BLOCK_SIZE-to-PAGE_SIZE.patch
  0007-percpu-add-block-level-scan_hint.patch
  0008-percpu-remember-largest-area-skipped-during-allocati.patch
  0009-percpu-use-block-scan_hint-to-only-scan-forward.patch
  0010-percpu-make-pcpu_block_md-generic.patch
  0011-percpu-convert-chunk-hints-to-be-based-on-pcpu_block.patch
  0012-percpu-use-chunk-scan_hint-to-skip-some-scanning.patch

0001 fixes an issue where the chunk contig_hint was being updated
improperly with the new region's starting offset and possibly differing
contig_hint. 0002 fixes possibly scanning pass the end of the bitmap.
0003 introduces a helper to do region overlap comparison. 0004 switches
to chunk management by contig_hint rather than free_bytes. 0005 moves
chunks that fail to allocate to the empty block list to prevent excess
scanning with of chunks with small contig_hints and poor alignment.
0006 introduces the constraint PCPU_BITMAP_BLOCK_SIZE == PAGE_SIZE and
modifies nr_empty_pop_pages management to be a part of the hint updates.
0007-0009 introduces percpu block scan_hint. 0010 makes pcpu_block_md
generic so chunk hints can be managed as a pcpu_block_md responsible
for more bits. 0011-0012 add chunk scan_hints.

This patchset is on top of percpu#master a3b22b9f11d9.

diffstats below:

Dennis Zhou (12):
  percpu: update free path with correct new free region
  percpu: do not search past bitmap when allocating an area
  percpu: introduce helper to determine if two regions overlap
  percpu: manage chunks based on contig_bits instead of free_bytes
  percpu: relegate chunks unusable when failing small allocations
  percpu: set PCPU_BITMAP_BLOCK_SIZE to PAGE_SIZE
  percpu: add block level scan_hint
  percpu: remember largest area skipped during allocation
  percpu: use block scan_hint to only scan forward
  percpu: make pcpu_block_md generic
  percpu: convert chunk hints to be based on pcpu_block_md
  percpu: use chunk scan_hint to skip some scanning

 include/linux/percpu.h |  12 +-
 mm/percpu-internal.h   |  15 +-
 mm/percpu-km.c         |   2 +-
 mm/percpu-stats.c      |   5 +-
 mm/percpu.c            | 547 +++++++++++++++++++++++++++++------------
 5 files changed, 404 insertions(+), 177 deletions(-)

Thanks,
Dennis
