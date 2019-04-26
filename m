Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69883C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F82C20685
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556245649;
	bh=epardxlwQkWCmilhdT/mTStH4uCQU0CymrjwvTaRwbw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TVajz7cf1euOpP/lzpQEeoJzbOgDYITwv8+XhcNcHyu8gr/rzF2J3sybPKSiFjBRq
	 /sqoi1pZ5ddDnxBJXB4jnMXu8KYYQ13CqNBa7AclR5KGutPwqsierFjp1q8RozZB/M
	 Lnpih34iJrVZXxCNwAo4SqurTHt0wQSLL+0z16xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfDZC11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:27:27 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57789 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfDZC11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:27:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EAE73D691;
        Thu, 25 Apr 2019 22:27:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Apr 2019 22:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y3yrDcJRK7dMxaYtT
        UWgba/vmU9ehGb7y7oYmTnnM9U=; b=SV6OliWTD8ttZp1RKHuKAOf7Ie2IiJcuD
        80Sz9+UWyLhDoItwOSnOmhNh5uSF/mD+sMZ5HLZfFP5PpYqnGxDH+PiD2bKLJK2P
        hFfeUCVsW3F+DYTiI984IrTamwGKDo+udXQIoydexaXGIWJXapEamYTbVKRmhBWQ
        tQpKGwGq1zExtALbVIXa3n7HkckTY2bqYLl6bkrtktIdohEGS9TdVTk7pbD2V26u
        31FXqoHPvmvo03a0WkPGCyFP5QChLnJZErqGywEtKV71awoAVVBZU4LxJQqyats1
        74zCcsHocAJjSw/24f0L6j0icuQIIC4kpSF7XGDZoNJGEFJCL/GlA==
X-ME-Sender: <xms:iWzCXBWuDlemqmrv-oJTwjpHitqe_VxCH1SbcePYwD5rtRIWt7NPMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrudehledrvddutdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:imzCXNqtAfCZ5stdQhcpR3kMY2_-S6gtPvrEYg1DkBiRnK_0HnwcBA>
    <xmx:imzCXIvXT110NsF9AqhlfKJ6_e5Qs1n8gXrKCHvlsiF-Dy6J3AoXsQ>
    <xmx:imzCXDQFNrldy5eBUSK5x8YW8U7FZemC7hoGzRmwE4H4dETTvnGUEA>
    <xmx:i2zCXI_1X8UNP05CrjKqpZQL1AcTRGo9FweuEcztJhvuqFuVj3U73A>
Received: from eros.localdomain (124-169-159-210.dyn.iinet.net.au [124.169.159.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE2BE1037C;
        Thu, 25 Apr 2019 22:27:16 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Pekka Enberg <penberg@iki.fi>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] tools/vm/slabinfo: Add fragmentation output
Date:   Fri, 26 Apr 2019 12:26:18 +1000
Message-Id: <20190426022622.4089-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During recent discussion on LKML over SLAB vs SLUB it was suggested by
Jesper that it would be nice to have a tool to view the current
fragmentation of the slab allocators.  CC list for this set is taken
from that thread. 

For SLUB we have all the information for this already exposed by the
kernel and also we have a userspace tool for displaying this info:

	tools/vm/slabinfo.c

Extend slabinfo to improve the  fragmentation information by enabling
sorting of caches by number of partial slabs.

Also add cache list sorted in this manner to the output of `slabinfo -X`.

thanks,
Tobin.


Tobin C. Harding (4):
  tools/vm/slabinfo: Order command line options
  tools/vm/slabinfo: Add partial slab listing to -X
  tools/vm/slabinfo: Add option to sort by partial slabs
  tools/vm/slabinfo: Add sorting info to help menu

 tools/vm/slabinfo.c | 118 ++++++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 48 deletions(-)

-- 
2.21.0

