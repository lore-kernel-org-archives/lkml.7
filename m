Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CC9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4D4217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946544;
	bh=IaUabbSzr6dxlVu2NLLVm9rlFlNVXhGnb93yFEkHLw4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zkNoieP8sW9FKcodt8US+BpertAYeUch1MDcX/GDuJreK95Z/SuA3KKp46KJox32V
	 aS/SxQZDuL8jXqpWtsp9ZCrz1XZRIfO48tTlZKMmUeMQno4Z19Vn6x2JVY51qGeJCT
	 7/j8tropoH3Cyv89ach7bBZWoOm4VYtdpRYQ7+vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDKBfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:35:42 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39153 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfDKBfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:35:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9285413D7F;
        Wed, 10 Apr 2019 21:35:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Apr 2019 21:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rQf4zwsfnCSSf3OBX
        v6d9238qkoNFZ1PhFX05pcE+KE=; b=L289Jprqg9xt7pBLCD/lry8TD+HTFgERS
        T/2dxrgPnD9PE0kpTD7CWgWyRB57ozSNbx01SepmvLvNhVSUAaApOdqAulFd5LeR
        HxM62e1eVNPOogozsO80LyZCxUa+c+QgtlCck9JR/ZVogIFG48WW8nOCeI5wpZGW
        z2GtlEutZpX/vej7K2oWNbnuYxs9lB8Jm5/KdvsQ2VsyaClh/7B1n1/BJlYu9EoU
        ABMRDIv6wlgzpwN+NZUWtjxjXv/0GCJSz7mfDvAnkxf0nfF3MY/0RZJfalOC4iWf
        MDmwov4cEs3yV6v2AI3JDXpmedBNUt4WizPprTlfp54eSCmanz7qA==
X-ME-Sender: <xms:6pmuXH8DZOQmgswxL9Ptbyur3HsK2YzRXYHaG7GZpSAl5wm41Mk-Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdegrddujedurdduledrudelgeenucfr
    rghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:6pmuXLcamF3_OA_bpi8ISNaHLeDG46dpQ8_mF3mCGPDzx8DQXEZNBA>
    <xmx:6pmuXIFF2T60Akxn9lXaRmvhQNmt5iH4ps9qdvDrKrYyXaFmbvIjOg>
    <xmx:6pmuXBf_cfJ30SlWLYDYB4KAWi_bRHiX5nHctcD92zldzzOEvJ4Rzw>
    <xmx:7JmuXIC8B8hcYM7LbU53A9H_JtyhJeVKlgZtan7DCrZnOMJ3jmctYw>
Received: from eros.localdomain (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id E3B01E41C3;
        Wed, 10 Apr 2019 21:35:29 -0400 (EDT)
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
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 00/15] Slab Movable Objects (SMO)
Date:   Thu, 11 Apr 2019 11:34:26 +1000
Message-Id: <20190411013441.5415-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another iteration of the SMO patch set implementing suggestions from Al
and Willy on the last version as well as some feedback from comments on
the recent LWN article.

Applies on top of Linus' tree (tag: v5.1-rc4).

This is a patch set implementing movable objects within the SLUB
allocator.  This is work based on Christopher Lameter's patch set:

 https://lore.kernel.org/patchwork/project/lkml/list/?series=377335

The original code logic is from that set and implemented by Christopher.
Clean up, refactoring, documentation, and additional features by myself.
Responsibility for any bugs remaining falls solely with myself.

Patch #9 has changes to the XArray migration function as suggested by
Matthew, thank you.

The only other changes to this version are to the dcache code.

dcache
------

It was noted on LWN that calling the dcache migration function
'd_migrate' is a misnomer because we are _not_ trying to migrate the
dentry objects but rather only free them.  As noted by Al dentry (and
inode) objects are inherently not relocatable.  What we are trying to
achieve here is, rather, to attempt to free a select group of dentry
objects.  The dcache patches are not intended to be a silver bullet
fixing all fragmentation within the dentry slab cache.  Instead we are
trying to make a non-invasive attempt at freeing up pages sparsely used
by the dentry slab cache.  This may be useful for a number of reasons
e.g. we _may_ be able to free a page that is stopping high order page
allocations.  This would be a useful capability.

Since this is only something that _may_ help the aim is to be
non-intrusive.  This version of the set adds a config option to
selectively build in the SMO stuff for the dcache.  Without this option
the only change this set makes to the dcache is adding a constructor.
With the constructor doing a spinlock_init() it is hoped this will at
best be a performance gain and at worst NOT be a performance reduction.
Benchmarking has found this to be the case, results are included below.

Patch #14 and #15 can be rolled into a single patch if #15 is found
favourable.

Changes since v2:

 - Improve the XArray migration function (thanks Matthew)
 - Fix the dcache constructor (thanks Alexander)
 - Rename the d_migrate function to d_partial_shrink (open to
   suggested improvement)
 - Totally re-write the dcache migration function based on schooling by Al


Thanks for looking at this,
Tobin.


=============================
dcache SMO patch benchmarking
=============================

Process
=======

We use 5.1-rc4 as the baseline.  We benchmark the SMO patchset with
and without CONFIG_DCACHE_SMO.  SMO patch set without CONFIG_DCACHE_SMO
just adds a constructor to the dcache, no other code added to the build.
Building with CONFIG_DCACHE_SMO adds code to enable object migration for
the dcache.

cmd = `time find / -name fname-no-exist`
drop_caches = `cat 2 > /proc/sys/vm/drop_caches`

1. Boot system
2. Run $cmd
3. Run $drop_caches
4. Run $cmd


Bare metal results
------------------

Machine: x86_64
Kernel configured with::

	make defconfig


- rc4 kernel (baseline)::

	time find / -name fname-no-exist dentry 

	real	0m29.799s
	user	0m1.519s
	sys	0m10.825s

	echo 2 > /proc/sys/vm/drop_caches 

	time find / -name fname-no-exist dentry 

	real	0m6.828s
	user	0m0.952s
	sys	0m5.824s


- rc4 kernel with SMO patch set and !CONFIG_DCACHE_SMO::

	time find / -name fname-no-exist

	real	0m30.075s
	user	0m1.480s
	sys	0m10.754s

	echo 2 > /proc/sys/vm/drop_caches 
	time find / -name fname-no-existproc/sys/vm/drop_caches 

	real	0m6.626s
	user	0m0.917s
	sys	0m5.661s


- rc4 kernel with SMO patch set and CONFIG_DCACHE_SMO::

	time find / -name fname-no-exist dentry 

	real	0m30.637s
	user	0m1.516s
	sys	0m11.603s

	echo 2 > /proc/sys/vm/drop_caches 

	time find / -name fname-no-exist dentry 

	real	0m6.886s
	user	0m0.932s
	sys	0m5.907s


Qemu results
------------

Host machine: x86_64

Qemu kernel configured with::

	make defconfig
	make kvmconfig

Qemu invoked with::

    qemu-system-x86_64 \
      -enable-kvm \
      -m 4G \
      -hda arch.qcow \
      -kernel $kernel \
      -serial stdio \
      -display none" \
      -append 'root=/dev/sda1 console=ttyS0 rw'

- rc4 kernel (baseline)::

	time find / -name fname-no-exist

	real	0m0.929s
	user	0m0.096s
	sys	0m0.168s

	echo 2 > /proc/sys/vm/drop_caches 
	time find / -name fname-no-exist

	real	0m0.249s
	user	0m0.112s
	sys	0m0.133s

- rc4 kernel with SMO patch set and !CONFIG_DCACHE_SMO::

	time find / -name fname-no-exist

	real	0m1.018s
	user	0m0.095s
	sys	0m0.151s

	echo 2 > /proc/sys/vm/drop_caches 
	time find / -name fname-no-exist

	real	0m0.191s
	user	0m0.083s
	sys	0m0.105s


- rc4 kernel with SMO patch set and CONFIG_DCACHE_SMO::

	time find / -name fname-no-exist

	real	0m0.763s
	user	0m0.091s
	sys	0m0.165s

	echo 2 > /proc/sys/vm/drop_caches 
	time find / -name fname-no-exist

	real	0m0.192s
	user	0m0.062s
	sys	0m0.126s


I am not very experienced with benchmarking, if this is grossly
incorrect please do not hesitate to yell at me.  Any suggestions on
more/better benchmarking most appreciated.

Thanks,
Tobin.


Tobin C. Harding (15):
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
  dcache: Implement partial shrink via Slab Movable Objects
  dcache: Add CONFIG_DCACHE_SMO

 Documentation/ABI/testing/sysfs-kernel-slab |  14 +
 fs/dcache.c                                 | 106 ++-
 include/linux/slab.h                        |  71 ++
 include/linux/slub_def.h                    |  10 +
 lib/radix-tree.c                            |  13 +
 lib/xarray.c                                |  49 ++
 mm/Kconfig                                  |  14 +
 mm/slab_common.c                            |   2 +-
 mm/slub.c                                   | 819 ++++++++++++++++++--
 tools/testing/slab/Makefile                 |  10 +
 tools/testing/slab/slub_defrag.c            | 567 ++++++++++++++
 tools/testing/slab/slub_defrag.py           | 451 +++++++++++
 tools/testing/slab/slub_defrag_xarray.c     | 211 +++++
 tools/vm/slabinfo.c                         |  51 +-
 14 files changed, 2295 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/slab/Makefile
 create mode 100644 tools/testing/slab/slub_defrag.c
 create mode 100755 tools/testing/slab/slub_defrag.py
 create mode 100644 tools/testing/slab/slub_defrag_xarray.c

-- 
2.21.0

