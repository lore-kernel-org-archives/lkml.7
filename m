Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEDB20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265928;
	bh=thOplidLrcLQBHwrOFsWjBHC0J1mmvMldPTOQvZGZuE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bKMuE5BTeodg9qEd5c0zKfabykDZEsg39c1GDWtfF3P95QRhwkcc8dgLLMqzxT5X0
	 YQSEfu5ACVZpsnNgmDZJ0C5ey7rnS0wDActcuZqTvsGRopP6NzrYqydn/VgwxY6VpK
	 8bN237cLJwuoMzOkNDbwyFtyNSjQfgsO91WF2LpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfDCEcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:32:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40143 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbfDCEbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E95921B10;
        Wed,  3 Apr 2019 00:22:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5hYI8b2F/hMNndGsu
        IPxlYyfuOY04PDt4MqicmCvTbs=; b=IIfhAZBQeDc9DxpDfTu9PVqYMIbSDcGCG
        s7kMZuvPb4QScrIRMGAZmQQfmTqKzlZwWsMJT8PCuWMbz5OLpltDzKuIL/uITi1D
        sIrtot4H/D9S7S7CTK7vhxzTC1sDaNyN3HHUvFMAGRxTs444UZ/4FT2ZGBQiqBP3
        R00cauuLdcrcQVsRmkdJ5wL5/csX8fcAXYIgnfaIvksmD6xgnuLLDoruRHzq5nTh
        SPYyZsmu1+w/++V6E+vPnbY21OHB+YfEqq6fNWctuEdV6pW0CPCz064t3rk8k1pQ
        mzD+k/g7vymzsG1yEUlfL+coFhH+fsUSu/iX7DBlEz8eG/rg5dAOQ==
X-ME-Sender: <xms:EzWkXHSCUlBPTPtVdDwRBd3KwFa7FEZJ_IHTvUr-VzyKNh2DhD6hWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfh
    rhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvg
    hlrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdegrddu
    ieelrddvjedrvddtkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:EzWkXOxi2Qc38QyiSAgHn9gpRjM1tXvMeXkuNYJliTY6jY7f56zD8A>
    <xmx:EzWkXKccSLSc1A1dUeF5En6prLVAELe_QH1tBajG7bv2QO3l94JhAA>
    <xmx:EzWkXCKGQPCJ4kYhRSsiC-SVE-W0BNTkklzhVb71kVfNqSX25xKbcQ>
    <xmx:FjWkXKrafd-T_cD3OOZ00l8I4DTXFp_qjozQ9Pv2dUMNbdSOow6NKw>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id E728710319;
        Wed,  3 Apr 2019 00:22:36 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/14] Slab Movable Objects (SMO)
Date:   Wed,  3 Apr 2019 15:21:13 +1100
Message-Id: <20190403042127.18755-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 2 re-structured to better follow the structure of Chirstoph's
original patchset (linked below).  Functions renamed and other suggestions
on v1 from Roman implemented.

This version also adds an attempt at implementing object migration for
the dcache, appropriate filesystem folk CC'd.  Please see comments
below in 'dcache' section.

Applies on top of Linus' tree (tag: v5.1-rc3).

This is a patch set implementing movable objects within the SLUB
allocator.  This is work based on Christopher's patch set:

 https://lore.kernel.org/patchwork/project/lkml/list/?series=377335

The original code logic is from that set and implemented by Christopher.
Clean up, refactoring, documentation, and additional features by myself.
Blame for any bugs remaining falls solely with myself.  Patches using
Christopher's code use the Co-developed-by tag but do not currently have
his SOB tag.

The core of the implementation is now contained within the first 4
patches (primarily patch #4).

Patches 7,8,10 add test code including a test modules to play around
with this.  With the series applied one can see functionality in
action by using the slabinfo command on the xarray slab cache

	slabinfo radix_tree_node -r

The NUMA stuff works as claimed with the radix_tree_node slab cache.

dcache
------

The dcache patches are my best effort on top of Christoph's original
work.  The dcache has changed a lot since then (2009).  FTR one month
ago was the first time I have ever opened fs/dcache.c.

I have been playing with this for at least two weeks without any
functional changes to the dcache patches - I do not think me playing
with it more is going to improve my understanding of the dcache so I am
asking for help here.  I've been testing in Qemu (both using ramdisk
filesystem and a disk image filesystem) as well as on bare metal.

Shrinking the dcache with:

	slabinfo dentry -s

produces _more_ partial slabs than before and repeated calls continue to
increase the number of partial slabs.  Although the initial calls do
decrease the total number of cached objects.  I cannot explain this.

During development I added a bunch of printks and the majority of dentry
slab objects are skipped during the isolation function due to the
following check from d_isolate():
	
	if (dentry->d_inode &&
	    !mapping_cap_writeback_dirty(dentry->d_inode->i_mapping))
	    ...
	    /* skip object*/
		     
I cannot explain the large number of dentry objects skipped by this
clause.

Any suggestions no matter how wild very much appreciated.  Tips on files
I should study or anything else I could do to better understand what is
needed to understand to work with this.  So far I have been primarily
trying to grok the VFS and the dcache in particular via:

fs/dcache.c
include/linux/fs.h
include/linux/dcache.h
Documentation/filesystems/vfs.txt

I also tried using the cache shrinkers

	echo 2 > /proc/sys/vm/drop_caches

Then shrinking the dentry slab cache.  This resulted in a bunch of
things disappearing e.g. sysfs gets unmounted, /home directory contents
disappear.  Again, I cannot explain this.  Should this be doable if this
series was implemented correctly?

Thanks for taking the time to look at this.

	Tobin.


Tobin C. Harding (14):
  slub: Add isolate() and migrate() methods
  tools/vm/slabinfo: Add support for -C and -M options
  slub: Sort slab cache list
  slub: Slab defrag core
  tools/vm/slabinfo: Add remote node defrag ratio output
  tools/vm/slabinfo: Add defrag_used_ratio output
  tools/testing/slab: Add object migration test module
  tools/testing/slab: Add object migration test suite
  xarray: Implement migration function for objects
  tools/testing/slab: Add XArray movable objects tests
  slub: Enable moving objects to/from specific nodes
  slub: Enable balancing slabs across nodes
  dcache: Provide a dentry constructor
  dcache: Implement object migration

 Documentation/ABI/testing/sysfs-kernel-slab |  14 +
 fs/dcache.c                                 | 124 ++-
 include/linux/slab.h                        |  71 ++
 include/linux/slub_def.h                    |  10 +
 lib/radix-tree.c                            |  13 +
 lib/xarray.c                                |  46 ++
 mm/Kconfig                                  |   7 +
 mm/slab_common.c                            |   2 +-
 mm/slub.c                                   | 819 ++++++++++++++++++--
 tools/testing/slab/Makefile                 |  10 +
 tools/testing/slab/slub_defrag.c            | 567 ++++++++++++++
 tools/testing/slab/slub_defrag.py           | 451 +++++++++++
 tools/testing/slab/slub_defrag_xarray.c     | 211 +++++
 tools/vm/slabinfo.c                         |  51 +-
 14 files changed, 2303 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/slab/Makefile
 create mode 100644 tools/testing/slab/slub_defrag.c
 create mode 100755 tools/testing/slab/slub_defrag.py
 create mode 100644 tools/testing/slab/slub_defrag_xarray.c

-- 
2.21.0

