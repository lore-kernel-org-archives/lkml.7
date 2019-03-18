Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0919214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552867410;
	bh=4mr4OwMOB7ttxuN7w+4sDslGTjwJgWkAR64dE2J5dus=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1FYZDsKHVLuKeQXeIrcU0Fohb9z69Z6KyBp3Vw+gNb2CadcQUZZtiC7PoYczt5+2O
	 wmY5C7slhV5Ph54u1fucpKS2J2AzfBgY5knakxyiwsw+WEojXY9PGyt1oq6QBsPHcW
	 v1CgZKKjwWSqPrDWuPvJaU2VJ/zmegseD1gZz7Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfCRAD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:03:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37523 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfCRAD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:03:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 27FD4216AC;
        Sun, 17 Mar 2019 20:03:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 17 Mar 2019 20:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5brKLR3Vqjme6TUXB
        85RDO3aHvQ61CuyZtJW5QH7Sh8=; b=WTfjylv7dQbdHZaxnCl+sVfRIFJLgtpdB
        g7Gvae1lFf0sn/qpVQepvSt6gOTZXgrSX0QBVmxL0zbQJALcUULaESbRyxL/PlUT
        hwqMMOKnfVDFF+hDUd9koBdGoktCUonpvYcaGeT9OV41R+ybXOkvYUQw/qVMlBup
        5K/7kcuXAPRv9sYpwAqRK+AtvmW/k36wJG3TOOtxRaO6Wruob6QRA/PUV6rBDchH
        mRR0i2lAAQiCYAVgbhbXXZQP1YQrLta7pH3tuv2UGFGW9fHA5be0FcNMrlkPHGS4
        9yz1KE8KC+Uzo/g7uK/yX5Cvo+ri8ze1c2uwrJQeSIwgHd3y2qaLA==
X-ME-Sender: <xms:S-COXIBG4-FoeBZJIYbV6ft70L6fa_HEQnjYrAouruQn6M1AbTF7XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecukfhppeduudekrddvuddurdduleelrdduvdeinecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:S-COXGTug3YYoAo23RV0-UY7FRUcWENAXlSIRzppFKhwe3JbI59erg>
    <xmx:S-COXPKNKw083_oexn695NxClsC_FhavvLan_mr9m4u3DqIVQ2qTbg>
    <xmx:S-COXKdxUqnxwME43loun2Tem7aoyffTbHuVHjsbJpxPXYZvTRvOJA>
    <xmx:TeCOXLEXr4LgR0DvVUPeJwkJ11t9N7zEagsF9PmgDPtwaqcJ3YSlKA>
Received: from eros.localdomain (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86676E4684;
        Sun, 17 Mar 2019 20:03:20 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] mm: Use slab_list list_head instead of lru
Date:   Mon, 18 Mar 2019 11:02:27 +1100
Message-Id: <20190318000234.22049-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v4 fixes patch 3 (change _all_ instances of ->lru to ->slab_list) as
noticed by Roman.  Built, booted, and tested with the test modules
mentioned below.

Roman,

I kept your reviewed-by tag on patch 3 since functionally its the same
patch (and the additional changes were pointed out by you :).  Thanks.


From v3 ...

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
 mm/slob.c                | 32 +++++++++++++--------
 mm/slub.c                | 60 ++++++++++++++++++++--------------------
 5 files changed, 94 insertions(+), 67 deletions(-)

-- 
2.21.0

