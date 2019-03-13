Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B806DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B920693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552454470;
	bh=C5MX3d3eRvWGoNhA9hIxaucDOMDDrMcFOZqjRWLCr0Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PkLaxqcrpkVQem5yr/40qItGUaI9UebyToGl2YXwL2J4rlr49vsyV2+uCjDjxFd4d
	 WpiVdOdJHqgEKARwQ7yt5gx9J8BNOXCoPfzhzSuWzZP37LtAgFBV8Sph3x1SYPzyUe
	 73ooAYBc1QkPWLcXsOkUpS3pLqM5hTvaao9EWdCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCMFVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:21:08 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49381 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfCMFVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:21:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EDDC82FB2;
        Wed, 13 Mar 2019 01:21:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 01:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=syfOZfzAEXP08coD5
        8eOkvYA4m3WRZUBnOoyYyN32bc=; b=jkiZvFmA5Yxsd7Q4Uj92iZu1KoJrCzWsn
        9ahQfl0EMu6OyJRSrl23KtVYdOJANGTW1S31McTpaZB/VRJbnSYYHBNcbjDYrJsO
        vSQNZ5BbyUeHFiK7e2WMfgqDdPRrWnIp9UDOGLaEtzTT4VqUD4sCO9MzknmK6i8v
        s88TpBcWcUqB6+xgo7bAx/g3RKcKZzJwV5JKFsT5rB/+lz511LL5xqnUKXUh2PiB
        06d4+qwq5UNcheAMY6Bt0NEnhhLSkubGr7mowrrdaTrHrJ9ZZIRdtBXso6soVHIY
        CA2lpooyn/MLeXcGnNSVzMuSfckD06CqeRrvrbhrZSnrltAPzimzA==
X-ME-Sender: <xms:QJOIXOAsRxVAJuhkp22PLWJxUS7pDDcSPKOvZypr6tU83REriQUW0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QJOIXGZh9BhKKRJhShwCV9I8RwP6iQhaVY2syXoOc0ZmVYjo_2Vcfg>
    <xmx:QJOIXKqQbBnxD4qStmdWdN5YUsimIdKw60rwUubEh7gDNaohpNOTEQ>
    <xmx:QJOIXOCx_MCP0So2QhWcYSBWOoejvktwYvukBIU974q1GPkliR7dYg>
    <xmx:QpOIXFrtkk-EKVM-GhBU4zx9dUYjq4gJ6dV4TO8emxihrev9ugqr2A>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2467E427E;
        Wed, 13 Mar 2019 01:21:00 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5]] mm: Use slab_list list_head instead of lru
Date:   Wed, 13 Mar 2019 16:20:25 +1100
Message-Id: <20190313052030.13392-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the slab allocators (ab)use the struct page 'lru' list_head.
We have a list head for slab allocators to use, 'slab_list'.

Clean up all three allocators by using the 'slab_list' list_head instead
of overloading the 'lru' list_head.

Patch 1 -  Makes no code changes, adds comments to #endif statements.

Patches 2,3,4 - Do changes as a patch per allocator, tested by building
                and booting (in Qemu) after configuring kernel to use
                appropriate allocator.  Also build and boot with debug
                options enabled (for slab and slub).  Verify the object
                files (before and after the set applied) are the same.

Patch 5 - Removes the now stale comment in the page struct definition.

Changes since v1:

 - Verify object files are the same before and after the patch set is
   applied (suggested by Matthew).
 - Add extra explanation to the commit logs explaining why these changes
   are safe to make (suggested by Roman).
 - Remove stale comment (thanks Willy).


thanks,
Tobin.


Tobin C. Harding (5):
  slub: Add comments to endif pre-processor macros
  slub: Use slab_list instead of lru
  slab: Use slab_list instead of lru
  slob: Use slab_list instead of lru
  mm: Remove stale comment from page struct

 include/linux/mm_types.h |  2 +-
 mm/slab.c                | 49 ++++++++++++++++----------------
 mm/slob.c                | 10 +++----
 mm/slub.c                | 60 ++++++++++++++++++++--------------------
 4 files changed, 61 insertions(+), 60 deletions(-)

-- 
2.21.0

