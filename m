Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140882087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552541530;
	bh=8nK8Mf+KXYhOOk9gaSVH/ZCbDArcU4gtXJS7TCy9i7s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xKHDlNpfs9wqXsehcxksgf8FbxxiN8CfP42v3oIcSp8/x9lmn2PMWVtkd79L3d4Qb
	 QzSBpsCmziRaRBR8RnJuVDMvpkZs4V3josrs78dXt7DNuQhc8xn7nAZSdrBVCownMb
	 1wtmdpBRyYr8ZDtPWC6ib2oiYLY6LQ7QmqgD00ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCNFcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:32:08 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41313 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfCNFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:32:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A6DAC213BD;
        Thu, 14 Mar 2019 01:32:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Mar 2019 01:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0As+3Iv3Sxmfep8uK
        sH5/xjkJPw9kSFzNL2pVLlfV7o=; b=nXFyTnSvQ0TXZ5esZxcjU2Z6vcxxfwqmZ
        e4QC8rQzhDCWT/uGYUgxLo6y3GTtFjjfIX6REQiGEwetHoG7K6qpJy1yQZhimGet
        mZO2iZOBRIS+PPIJRbT3m6YK8hFi+CJpaeUcylBhAwk/6rnso8WU1BItuOQ1e6O+
        9u+TU1WG8GYWePLEVSkHO0yaPn+ZThhTTymCL4XaNdJPXo2c+aJbV4oga2ob1U2q
        SfDI7JCRjkWv5mITQHY1+6r4543vxEfIpu9ezTDGcqISFFP3sAHfTjkNsSNqFwZG
        Yx3+KWjweqOMK4G+cfiRZnG+1+xrV0/SG013bqPbQuMtUVk0sRYrQ==
X-ME-Sender: <xms:VOeJXHEmVIIZEg4WNbm1bwpqsXP7F_zvMVSMBPANGfqoBUhfCZ6C0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecukfhppeduvdegrdduieelrddvfedrudekgeenucfr
    rghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:VOeJXN7bV-NvEfa9PkjGrsxsR6vy6e2L8bCLt8lp-0_uOs1oQnYvhQ>
    <xmx:VOeJXEn0Js7yIQgnKaP9ROa3OkngZgF7A6j-8irY3qWjKcVGHw4asw>
    <xmx:VOeJXDzavEaLvm7GKBafZ9D1vpwCUH1yhpFVCR2OPo0DVHAU6wUCtA>
    <xmx:V-eJXGbXgXRLTn8NSz_s3BVNmYx-JZLhuYN3xvjddjiZfER7ZEhEXg>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 811BCE415C;
        Thu, 14 Mar 2019 01:32:00 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] mm: Use slab_list list_head instead of lru
Date:   Thu, 14 Mar 2019 16:31:28 +1100
Message-Id: <20190314053135.1541-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the slab allocators (ab)use the struct page 'lru' list_head.
We have a list head for slab allocators to use, 'slab_list'.

During v2 it was noted by Christoph that the SLOB allocator was reaching
into a list_head, this version adds 2 patches to the front of the set to
fix that.

Clean up all three allocators by using the 'slab_list' list_head instead
of overloading the 'lru' list_head.

Patch 1 - Adds a function to rotate a list to a specified entry.

Patch 2 - Removes the code that reaches into list_head and instead uses
	  the list_head API including the newly defined function.

Patches 3-7 are unchanged from v3

Patch 3 (v2: patch 4) - Changes the SLOB allocator to use slab_list
      	     	      	instead of lru.

Patch 4 (v2: patch 1) - Makes no code changes, adds comments to #endif
      	     	      	statements.

Patch 5 (v2: patch 2) - Use slab_list instead of lru for SLUB allocator.

Patch 6 (v2: patch 3) - Use slab_list instead of lru for SLAB allocator.

Patch 7 (v2: patch 5) - Removes the now stale comment in the page struct
      	     	      	definition.

During v2 development patches were checked to see if the object file
before and after was identical.  Clearly this will no longer be possible
for mm/slob.o, however this work is still of use to validate the
change from lru -> slab_list.

Patch 1 was tested with a module (creates and populates a list then
calls list_rotate_to_front() and verifies new order):

      https://github.com/tcharding/ktest/tree/master/list_head

Patch 2 was tested with another module that does some basic slab
allocation and freeing to a newly created slab cache:

	https://github.com/tcharding/ktest/tree/master/slab

Tested on a kernel with this in the config:

	CONFIG_SLOB=y
	CONFIG_SLAB_MERGE_DEFAULT=y


Changes since v2:

 - Add list_rotate_to_front().
 - Fix slob to use list_head API.
 - Re-order patches to put the list.h changes up front.
 - Add acks from Christoph.

Changes since v1:

 - Verify object files are the same before and after the patch set is
   applied (suggested by Matthew).
 - Add extra explanation to the commit logs explaining why these changes
   are safe to make (suggested by Roman).
 - Remove stale comment (thanks Willy).

thanks,
Tobin.


Tobin C. Harding (7):
  list: Add function list_rotate_to_front()
  slob: Respect list_head abstraction layer
  slob: Use slab_list instead of lru
  slub: Add comments to endif pre-processor macros
  slub: Use slab_list instead of lru
  slab: Use slab_list instead of lru
  mm: Remove stale comment from page struct

 include/linux/list.h     | 18 ++++++++++++
 include/linux/mm_types.h |  2 +-
 mm/slab.c                | 49 ++++++++++++++++----------------
 mm/slob.c                | 32 +++++++++++++--------
 mm/slub.c                | 60 ++++++++++++++++++++--------------------
 5 files changed, 94 insertions(+), 67 deletions(-)

-- 
2.21.0

