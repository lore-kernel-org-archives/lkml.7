Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D788FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3172133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246389;
	bh=fneNnKSLrG1qJf//W0e6XEycdUKKXuqZKYEeFfu+X14=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=acp4foEI0uW34u6dxvgxLZrc4/gur6VaKBpTRNQtg09lFq992O5M98AxQ9zwWsjxp
	 RhBVCRnxvAgVNure0YbvkTkbS3BIkksK9mlodyXQYN5FMrrNkFME+FxSw3fH4XbugF
	 nN69mn54Nx8OMgfoD/qI3z5XIbmbw24HXlgUTVvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfDBXG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:06:28 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44013 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBXG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:06:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D9D721F01;
        Tue,  2 Apr 2019 19:06:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2019 19:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=l8c5endvJscPewd22
        ZTuMis3Zjlpf6zi6ZDP1+P2ofI=; b=nM0+XCotwYgyyp+aIrzkVuUlO3vBiZiMl
        NhDd+NNkIrwuxQatdvngcz0uoq4WFUzaYghV7U04+LyAKqRSrfj3SYCu/619irQ1
        otkqhxHfvErJHKMpH7bersJh6JXmdWljB1PUnhFrJzoC477+DrS9hGVPnHKq+5zK
        tIxUPns+amcbKkfeyKAmth9d5II/lsXmvKCn/8jCsEjydZUzWp5W5DMClKRIFDec
        NKNVxCmX+4Qu92a/iQ68wty/d7tkXBm4T/Krpqoia3AUGbWZFlahm/dC7rCnNejJ
        ToVjT24JgmdKtvlVHYjFxDFVx0qmZFRfX1LlzuEKP+dl28tNy7Hkg==
X-ME-Sender: <xms:8OqjXAgBJr2e1HK8XbZF6S4hNaT-P7KhnhmaSBY9F893eWAk7PpyWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdduieculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfh
    rhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvg
    hlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:8OqjXF51mRj2Nx7U703Tn1p2rc9G2UEeKN7pYize8-njg2wMLCjMVw>
    <xmx:8OqjXH0i_hxkJlbj3JvQJhZ6aY4yKWwbHPK3o1YpEMKrqN0aGWQ35Q>
    <xmx:8OqjXAst7V3hoW50X66Wz3Jpv-2OBnipWKJK79EiUE5jwB0X708RVw>
    <xmx:8-qjXMAeBWoYpAJc-79Roxk8qpcb9vGVV4PeI8mOLUyAFPIzQQT-Tg>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A2171030F;
        Tue,  2 Apr 2019 19:06:21 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] mm: Use slab_list list_head instead of lru
Date:   Wed,  3 Apr 2019 10:05:38 +1100
Message-Id: <20190402230545.2929-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is the updated series that caused the bug found by 0day test
robot.  To ease the load on your memory, this series is aimed at
replacing the following:

Original buggy series:

 mm-remove-stale-comment-from-page-struct.patch
 slub-use-slab_list-instead-of-lru.patch
 slab-use-slab_list-instead-of-lru.patch
 slob-use-slab_list-instead-of-lru.patch
 slub-add-comments-to-endif-pre-processor-macros.patch
 slob-respect-list_head-abstraction-layer.patch
 list-add-function-list_rotate_to_front.patch

And the bug fix patch:

 slob-only-use-list-functions-when-safe-to-do-so.patch

Applies cleanly on top of Linus' tree (tag: v5.1-rc3).

This series differs from the bug fix above by adding a separate return
parameter to slob_page_alloc() instead of using a double pointer.  This
is defensive in case later someone adds code that accesses sp (struct
page *), also it is easier to read/verify the code since its less 'tricky'.

Tested by building and booting a kernel using the SLOB allocator and
with CONFIG_DEBUG_LIST.

From v4 ... 

Currently the slab allocators (ab)use the struct page 'lru' list_head.
We have a list head for slab allocators to use, 'slab_list'.

During v2 it was noted by Christoph that the SLOB allocator was reaching
into a list_head, this version adds 2 patches to the front of the set to
fix that.

Clean up all three allocators by using the 'slab_list' list_head instead
of overloading the 'lru' list_head.

Changes since v4:
 - Add return parameter to slob_page_alloc() to indicate whether the
   page is removed from the freelist during allocation.
 - Only do list rotate optimisation if the page was _not_ removed from
   the freelist (fix bug found by 0day test robot).

Changes since v3:

 - Change all ->lru to ->slab_list in slob (thanks Roman).

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
 mm/slob.c                | 59 +++++++++++++++++++++++++++------------
 mm/slub.c                | 60 ++++++++++++++++++++--------------------
 5 files changed, 115 insertions(+), 73 deletions(-)

-- 
2.21.0

