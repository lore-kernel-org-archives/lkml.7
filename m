Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57069206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552266501;
	bh=ghZ4YNt/KpiVlJgAzbGCLwba/6poYeDr8obrlbtXYeM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DyXTnI4WpivuxBSDsAN1MNSrml+Z5ReiCYQWit170S2am3gat5uFDXtH3GwF6H9yU
	 OZCgIh4msA52M/UAirgB92lnR07xJfmVmP8pZar0ptgLyF2RVg1VXyR0BuVarnFEWL
	 Z4pxgUeYB912rWyGHFIF5l8tksbAwzs3gjTOUZfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfCKBIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 21:08:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44719 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfCKBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 21:08:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AD193217DD;
        Sun, 10 Mar 2019 21:08:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Mar 2019 21:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=T1dZV3cS1FB6Iz/lC
        stJWsGELgplemQHQV7/Ond8b20=; b=myYETjF4g+/oSJ6XYAfNU6sSO5K0sxbWR
        v3W6dgDMo2JRFPXQL+6wDa1Q7INU3bCSn9p9gHbqAlXsVhhpoQbzyuYhLV7Fnatz
        feWVY9x9zZSkPy53Z3hFCIrWIA1YClG7rD0HmwphDqFSqSk94rZAxvyZqUTk5o75
        VXeWkOTn5jyATQBTTeghZePGMzE8HfyyzhjkcT4rFUjV67/vNXHrUT7bHiTOcqq2
        Bho/RyyDAi5+r+Qfo43vl5Km67j9ZU7hQ8l1eDj9veBABYzLAqCV/k7w0wfv+Bsx
        +6fR9CoZ1oQqCwQzE7jYvDZWDgH09ouQ2wKU8nRzlgDZBF7QbUCyw==
X-ME-Sender: <xms:ALWFXJcLT3SNQhkw2XWOyTkvPz24CWWil7m2J_h30oRRVuJl3eKpUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dukedrvdduuddrudelvddrieeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ALWFXFuGL2vmcy02-nLiJNwEr9Ut0BA4A2AF9-b-mAFVCvfPkdGUtw>
    <xmx:ALWFXK7sy4RaxpBWw5NFWpuLk2C_ylQrdThCeDAoTkNgAtuyuk0f7g>
    <xmx:ALWFXEwuIzXTISEY-ns3msJF3NMGfYhmCVJbEvRhHaCdUeyQtt7rFQ>
    <xmx:ArWFXDrDcPpmSxalAOUCA4tDroDdM7U_V5D7pByQNT_Bi1XWznp2ug>
Received: from eros.localdomain (ppp118-211-192-66.bras1.syd2.internode.on.net [118.211.192.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id B822C10312;
        Sun, 10 Mar 2019 21:08:13 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Date:   Mon, 11 Mar 2019 12:07:40 +1100
Message-Id: <20190311010744.5862-1-tobin@kernel.org>
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

Initial patch makes no code changes, adds comments to #endif statements.

Final 3 patches do changes as a patch per allocator, tested by building
and booting (in Qemu) after configuring kernel to use appropriate
allocator.  Also build and boot with debug options enabled (for slab
and slub).


thanks,
Tobin.

Tobin C. Harding (4):
  slub: Add comments to endif pre-processor macros
  slub: Use slab_list instead of lru
  slab: Use slab_list instead of lru
  slob: Use slab_list instead of lru

 mm/slab.c | 49 +++++++++++++++++++++++----------------------
 mm/slob.c | 10 +++++-----
 mm/slub.c | 60 +++++++++++++++++++++++++++----------------------------
 3 files changed, 60 insertions(+), 59 deletions(-)

-- 
2.21.0

