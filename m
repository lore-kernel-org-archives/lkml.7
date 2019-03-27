Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000220811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663907;
	bh=Tf0fLCRIucO/bgq+ffSfXSQ3jbF80qkq2BDQ/w9EJ10=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xIuM5JwNqPHS0YpzRcMIYAkL5fskJgGGwt2fg/aOJSNbRUyo440AshBJCAw2TkuPl
	 6S1SOUBUh9M/NoHgocmAgTmQ6aCHc04oi1HD65CmETcpVH7WgdgI0pOPaatRvcHwIw
	 gQWLP8LWQ/pxH5nhp/1RTD5ee5Ine8qI5ZOloLIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfC0FS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:18:26 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44827 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfC0FSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:18:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6732321F01;
        Wed, 27 Mar 2019 01:18:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AFqwcYzJS1aN7d9JN
        cmL/YjKfe1J3esykvtIwaX8WSY=; b=tymcvK91kqURnLQBQe7qdObilZWtQLzOG
        bFEzVqFqVbfhkmVWm18Q8t6ejgbn3dqvAPSod+3L7Wr1sokCco7bm+rTuwPCp1rG
        DywfTIroJipjH1/YExftb9Bfi/wwpKdZ8k83rOq6AaCiKhrnE8md7vnj0OfCQS6k
        sLPjofcWKPcYsdDYbgIhsnwfdQlpPc/lfvWqyyHhVfx8M8Vtdt4l1fwBs/GgvNkC
        jymKWScxKDYncXDZnjQIYDZz+TFJ1erVc+OmSu2aatgxgBzq+alR2SSu6xDuBVKz
        Gg/JXkuF9j7Ui+KmsUtL9DVjatEIAeu3KrFSsbFJii4J4LxBKz3PA==
X-ME-Sender: <xms:ngebXIjalHo_89u90f7i_Xc8vDsbJFX0pTqQB_TjXSQOjfiP7usamg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ngebXOYTNa8QNzkQ5LDZ-L8wy3626PRvuH4WG-U4w_vi2CqEaa257w>
    <xmx:ngebXHaUhO4JkbZKT5AZDMUcsUslb3iMlrQjW3kGl3m9u1ZZ-E3Gzg>
    <xmx:ngebXDyjXXDExv0KPU62Bjh-meSFiWf1StcUEWvgNzZcwQWWS0VxaQ>
    <xmx:oAebXMPk0hwe9Uik03DaoaxhJrvDi5lE2Q6ZWoZmd5MksmdI-wyeGQ>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94C34E415C;
        Wed, 27 Mar 2019 01:18:19 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Date:   Wed, 27 Mar 2019 16:16:53 +1100
Message-Id: <20190327051717.23225-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

This series converts the VFS file Documentation/filesystems/vfs.txt to
reStructuredText format.  Please consider taking this series through
your tree as apposed to Jon's tree because this set makes a fair amount
of changes to VFS files (and also the VFS tree and docs tree are out of
sync right now with the recent work by Mauro and Neil).

Excluding patch 2, this set is whitespace and documentation fixes only.

Why 25 patches to convert one simple file?  There is a bunch of clean up
to VFS docs in here.  I have attempted to make review easier by breaking
changes into very discreet patches favouring a single 'type' of change
per patch, even more so than usual with code changes.  By doing so I
hope reviewers are able to parse the diff without having to think too
much.  I also try to state in the commit logs if a patch makes extra
trivial changes to further ease the review process.  There are however a
couple of patches here that make considerable changes to VFS files
(particularly include/linux/fs.h and include/linux/dcache.h); these will
likely require a little more attention when reviewing please, there are 3:

 vfs: Clean up VFS data structure declarations

Adds function names to VFS ops methods (i.e. sturct members that are
function pointers).

 fs: Copy documentation to struct declarations
 dcache: Copy documentation to struct declaration

Along with the final patch these two patches make up the meat of this
series.  They add docstring comments to the core VFS data structures
declared in the headers mentioned above.  The docs used are based on
those currently present in vfs.txt if available or collected by reading
the source code.  Unfortunately various members remain undocumented (and
marked TODO).  I am new to the VFS, I lent towards leaving a 'TODO'
rather than writing wrong/vague documentation.

Of note also is that Sphinx doesn't currently really support documenting
'methods'.  The docs added in this series parse (in my opinion)
reasonable well in both text and HTML.  The layout is however very
slightly different from other places in the kernel documentation.  I
have CC'd Jon (for obvious reasons) and Jani (because of previous
discussion on this topic on LKML) on the relevant patches.

This version is considerably different to v2 because it was not
until after posting that I realised that we could put the docs in the
header files along with the struct declarations.  The justification for
doing so is that documentation far away from source code tends to go
stale, currently the vfs.txt documents core VFS data structures with
some references as old as v2.6 kernel.


Patch 1 - fs.h preparation
Patch 2 - Adds some parameter names to ops struct methods and fixes
          whitespace issues withthe struct declarations.
Patch 3-7 - Fix Sphinx warnings in preparation for working on VFS docs.
Patch 8 - dcache.[ch] preparation.
Patch 9-10 - Minor grammar fixes.
Patch 11 - Cleans up docstring for d_drop(), __d_drop(), and ___d_drop().
Patch 12 - Does [minor] comment clean up in non-docstring comments.
Patch 13 - Improves the docstrings for the dcache.

I recently posted an RFC set attempting to make slab objects movable,
hopefully we can use this to make slab dentry objects movable.  This
series was motivated by trying to grok the dcache in an attempt to do
so.

Patch 14 - Does (possibly anal) cleanup of docstring function
           parameters.  Done as a separate patch to reduce the thought
           required to review the previous patch.  Should, hopefully, be
           trivial to review.
Patch 15-21 - Does preparatory fixes to vfs.txt ready for RST conversion,
              these are as they were in v2 including tested-by tag from
	      Randy.
Patch 22 - As mentioned above, adds docstring documentation to the
           core VFS data structure struct declarations in fs.h
Patch 23 - Does the same for struct dentry declaration in dcache.h
Patch 24 - Does the actual reStructuredText conversion.

Building on top of Mauro's work updating
Documentation/filesystems/index.rst this includes the new vfs.rst at the
top of the current index.rst.  This is justified since vfs.rst is an
overview of the VFS.  This does however mean that some types are
included in the rst doc books more than once.

I got a little confused by the iopoll() method of file_operations while
checking this series against different trees.  If I got it right, iopoll
is _gone_ from the VFS tree so it is _not_ in this set.


Thanks for taking the time to read this.

					Tobin


Changes since v2:
 - Rebased onto Al's VFS tree
 - Fix Sphinx warnings for fs (these were done against the tip of docs
   tree before rebasing on the VFS tree).
 - Clean up dcache docstrings
 - Add docstrings to struct declarations (include/linux[fs.h,dcache.h])

Changes since v1:

 - Re-base onto commit 9834857754ff ("doc:it_IT: translations for documents in process/")
 - Add 'Tested-by:' tag for Randy (thanks!)


Tobin C. Harding (24):
  vfs: Remove trailing whitespace
  vfs: Clean up VFS data structure declarations
  fs: Update function docstring for dio_complete()
  fs: Add docstrings to exported functions
  fs: Guard unusual text with backticks
  fs: Update function docstring for simple_write_end()
  fs: Fix function docstring for posix_acl_update_mode()
  dcache: Remove trailing whitespace
  dcache: Fix i.e. usage in coments
  dcache: Fix e.g. usage in comment
  dcache: Fix docstring comment for d_drop()
  dcache: Fix non-docstring comments
  dcache: Clean up function docstrings
  dcache: Clean up function docstring members
  docs: filesystems: vfs: Remove space before tab
  docs: filesystems: vfs: Use uniform space after period.
  docs: filesystems: vfs: Use 72 character column width
  docs: filesystems: vfs: Use uniform spacing around headings
  docs: filesystems: vfs: Use correct initial heading
  docs: filesystems: vfs: Use SPDX identifier
  docs: filesystems: vfs: Fix pre-amble indentation
  fs: Copy documentation to struct declarations
  dcache: Copy documentation to struct declaration
  docs: Convert vfs.txt to reStructuredText format

 Documentation/filesystems/index.rst |   6 +
 Documentation/filesystems/porting   |  10 +-
 Documentation/filesystems/vfs.rst   | 426 ++++++++++++
 Documentation/filesystems/vfs.txt   | 502 +++++++-------
 fs/dcache.c                         | 469 +++++++------
 fs/direct-io.c                      |   4 +-
 fs/file_table.c                     |  23 +-
 fs/libfs.c                          |  27 +-
 fs/posix_acl.c                      |  16 +-
 include/linux/dcache.h              | 272 ++++++--
 include/linux/fs.h                  | 993 +++++++++++++++++++++++++---
 11 files changed, 2112 insertions(+), 636 deletions(-)
 create mode 100644 Documentation/filesystems/vfs.rst

-- 
2.21.0

