Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240F207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554175875;
	bh=hp7g6jd2An7qHadtH4UWmz7gr6Z9rruv2mieKHJ1Xmc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AqJs9+VkLzaHpbP7F4mSI8c+Gwox8BlKuo4JI552TR8ll1wAbTIKo9Gl/9DeXOhg4
	 BXf1g+u9/3PZ8Oexbn1eGtGbqlpvqd+zENHJuv9kkpoQ8GhzUAD7u5IxHIH+cxzzgM
	 aW5L6+OV00XNE2I1y6Fu2JcqhS6XX5pg2wSMiSpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfDBDbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:31:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45907 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbfDBDbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:31:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A7F3E22205;
        Mon,  1 Apr 2019 23:31:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 01 Apr 2019 23:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GhdVsMTVKjBk9iUxn
        5IpYnUVsn7WlgpvFL7kEcghYa8=; b=4h6GGvxjAduskW8z2+xkvHUDonHLeaxzo
        OpdND1moNstvSCB3U3UdLmRHXe652TX2LIbSCHBSSeU2QHfoPUnDpE/SYUUWHrju
        W4n+KQ8A8O9eQCbep+ok5OoWGoIRWpbjYMHH/DgckHggOrlWn80KS/F77ZkwFSE8
        qwu6spWnxPpVn+Y3rSjZsqBrCwJaBQBm2h/lUw0WXJ0MZGBYH43tKJ+g13TezuSN
        9G3nOBLFdSlM+BpaDnGL5yRbumtwrw7id36ZWRmKDMuHLJRyeGfnRyWFbrGaHhzO
        D8XKDA3g/TzeQZqMTyKCU05fKaIMBrbi9XLTMsgpKTGE4is3wPx5g==
X-ME-Sender: <xms:fteiXAjnNz3kCdhLz_BNzY1vJkrn2ex_iR3UDTk_kTdj153i9WeFIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrleehgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmpdhoiihlrggsshdrohhrghenucfkphepuddvgedrudej
    uddrvdefrdduvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:fteiXPEdeXrUl6-EIAHSsIYBBfSJGzp32qnEMy0YjngnrfonQJ_G1A>
    <xmx:fteiXLWmLQ_UGez3uQT65pc1rGihfbjIIHgdKhTxYSFQzRc-MVpEYA>
    <xmx:fteiXJYwuU6SQ9oBX_iQqk506dpLynTdOZh4bH6rWD2AxjmALkLW6w>
    <xmx:gNeiXMWpmRg18hyrF_R-xsScykLtThsdIv0Pn3YCaKvtUWsow9nZOQ>
Received: from eros.localdomain (124-171-23-122.dyn.iinet.net.au [124.171.23.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD8B710390;
        Mon,  1 Apr 2019 23:31:06 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, LKP <lkp@01.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] slob: Fix list_head bug during allocation
Date:   Tue,  2 Apr 2019 14:29:56 +1100
Message-Id: <20190402032957.26249-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch is in response to an email from the 0day kernel test robot
subject:

  340d3d6178 ("mm/slob.c: respect list_head abstraction layer"):  kernel BUG at lib/list_debug.c:31!


This patch applies on top of linux-next tag: next-20190401

It fixes a patch that was merged recently into mm:

  The patch titled
       Subject: mm/slob.c: respect list_head abstraction layer
  has been added to the -mm tree.  Its filename is
       slob-respect-list_head-abstraction-layer.patch
  
  This patch should soon appear at
      http://ozlabs.org/~akpm/mmots/broken-out/slob-respect-list_head-abstraction-layer.patch
  and later at
      http://ozlabs.org/~akpm/mmotm/broken-out/slob-respect-list_head-abstraction-layer.patch


If reverting is easier than patching I can re-work this into another
version of the original (buggy) patch set which was the series:

  [PATCH 0/4] mm: Use slab_list list_head instead of lru

Please don't be afraid to give a firm response.  I'm new to mm and I'd
like to not be a nuisance if I can manage it ;)  I'd also like to fix
this in a way that makes your day as easy as possible.


The 0day kernel test robot found a bug in the slob allocator caused by a
patch from me recently merged into the mm tree.  This is the first time
the 0day has found a bug in already merged code of mine so I do not know
the exact protocol in regards to linking the fix with the report,
patching, reverting etc.

I was unable to reproduce the crash, I tried building with the config
attached to the email above but the kernel booted fine for me in Qemu.

So I re-worked the module originally used for testing, it can be found
here:

	https://github.com/tcharding/ktest/tree/master/list_head

From this I think the list.h code added prior to the buggy patch is
ok.

Next I tried to find the bug just using my eyes.  This patch is the
result.  Unfortunately I can not understand why this bug was not
triggered _before_ I originally patched it.  Perhaps I'm not juggling
all the state perfectly in my head.  Anyways, this patch stops and code
calling list manipulation functions if the slab_list page member has
been modified during allocation.

The code in question revolves around an optimisation aimed at preventing
fragmentation at the start of a slab due to the first fit nature of the
allocation algorithm.

Full explanation is in the commit log for the patch, the short version
is; skip optimisation if page list is modified, this only occurs when an
allocation completely fills the slab and in this case the optimisation
is unnecessary since we have not fragmented the slab by this allocation.

This is more than just a bug fix, it significantly reduces the
complexity of the function while still fixing the reason for originally
touching this code (violation of list_head abstraction).

The only testing I've done is to build and boot a kernel in Qemu (with
CONFIG_LIST_DEBUG and CONFIG_SLOB) enabled).  However, as mentioned,
this method of testing did _not_ reproduce the 0day crash so if there
are better suggestions on how I should test these I'm happy to do so.

thanks,
Tobin.


Tobin C. Harding (1):
  slob: Only use list functions when safe to do so

 mm/slob.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

-- 
2.21.0

