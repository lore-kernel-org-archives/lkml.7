Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A6FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1103206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556245658;
	bh=ur2k53PzJytsExX+r6bNHZBx/++M8FUCCSR77n4H2hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HOcPcZs/TXDZ4z66hS99l5Mwko6aLuqSfz2eOdoguAbuVcjFjYhZiW3mc2+x1vxGb
	 TwGtrEkk3DVsNWd4fffqXUbDVQyh5CEjsaVuCFI9EVlNAMUMVHkZY5VOFTT3u0bTDh
	 O0GHIdQjG5Ti4fXhFqJZ/tJkO4mn57cl7EwXG6k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfDZC1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:27:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47245 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfDZC1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:27:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0D24710FA2;
        Thu, 25 Apr 2019 22:27:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Apr 2019 22:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=aATYrCxRlNMszFJ57g3u99UUP818320yu7bmbbR1Mt4=; b=68vQh+yi
        M75/HLJuUgg97N18rXVBRlHToOk742865TAoiRxWPyqFG95mjm3E1uVuLFsiRLAb
        ABG5WUNf5jgQSzekVQs/9nDOXKVGCVOnUArwPFrh0awYu8ci3FP634CLHaJBhw3l
        6RmMNRAFD9kyEY3rm9PVwfvLQTlWTwuORh2yMtwL1Q5YZiS4ccHYbWv0/y7+NDJb
        Y/KS23rBvGHqQycUP5jhobVbGU6iAAx2Ushd3IpWLsw9sTtG5PUML+VkO+Yl9laK
        puyiw1HZF2rnA8OuIreveUWdo0/p+TbSqIu2mDBUaMk4JpTcfikINciam/RbI0qh
        9zw7LoJdGLb1Kg==
X-ME-Sender: <xms:lWzCXP3FES-trKp4szFTvuaokkn52SETSz_Q8gbmtDQVf0qGUTyOMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudehledrvddutdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:lWzCXNCf2YH8IHSN6ksZrUJToGCjR3kXKcL6p0CYYlNVrWg78nm4jw>
    <xmx:lWzCXL9eqLawLdyCIWY0OiBzlAaf02pfCvb344z-JQelTN4UE26-mQ>
    <xmx:lWzCXIVhx2ViuUlC0edbesis_c-GN-hJFrnf12QDburBMiDOhm7sIg>
    <xmx:lmzCXGdnNvl_5jh7r6EWXD7QjvDF4MR2A8dgyQbLvDuD2XFKy4auTQ>
Received: from eros.localdomain (124-169-159-210.dyn.iinet.net.au [124.169.159.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70F8F103C8;
        Thu, 25 Apr 2019 22:27:28 -0400 (EDT)
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
Subject: [PATCH 2/4] tools/vm/slabinfo: Add partial slab listing to -X
Date:   Fri, 26 Apr 2019 12:26:20 +1000
Message-Id: <20190426022622.4089-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426022622.4089-1-tobin@kernel.org>
References: <20190426022622.4089-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to see how fragmented the SLUB allocator is, one window
into fragmentation is the total number of partial slabs.

Currently `slabinfo -X` shows slabs sorted by loss and by size.  We can
use this option to also show slabs sorted by number of partial slabs.

Option '-X' can be used in conjunction with '-N' to control the number
of slabs shown e.g. list of top 5 slabs:

	slabinfo -X -N5

Add list of slabs ordered by number of partial slabs to output of
`slabinfo -X`.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index e9b5437b2f28..3f3a2db65794 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -79,6 +79,7 @@ int sort_size;
 int sort_active;
 int set_debug;
 int show_ops;
+int sort_partial;
 int show_activity;
 int output_lines = -1;
 int sort_loss;
@@ -1047,6 +1048,8 @@ static void sort_slabs(void)
 				result = slab_activity(s1) < slab_activity(s2);
 			else if (sort_loss)
 				result = slab_waste(s1) < slab_waste(s2);
+			else if (sort_partial)
+				result = s1->partial < s2->partial;
 			else
 				result = strcasecmp(s1->name, s2->name);
 
@@ -1307,27 +1310,39 @@ static void output_slabs(void)
 	}
 }
 
+static void _xtotals(char *heading, char *underline,
+		     int loss, int size, int partial)
+{
+	printf("%s%s", heading, underline);
+	line = 0;
+	sort_loss = loss;
+	sort_size = size;
+	sort_partial = partial;
+	sort_slabs();
+	output_slabs();
+}
+
 static void xtotals(void)
 {
+	char *heading, *underline;
+
 	totals();
 
 	link_slabs();
 	rename_slabs();
 
-	printf("\nSlabs sorted by size\n");
-	printf("--------------------\n");
-	sort_loss = 0;
-	sort_size = 1;
-	sort_slabs();
-	output_slabs();
+	heading = "\nSlabs sorted by size\n";
+	underline = "--------------------\n";
+	_xtotals(heading, underline, 0, 1, 0);
+
+	heading = "\nSlabs sorted by loss\n";
+	underline = "--------------------\n";
+	_xtotals(heading, underline, 1, 0, 0);
+
+	heading = "\nSlabs sorted by number of partial slabs\n";
+	underline = "---------------------------------------\n";
+	_xtotals(heading, underline, 0, 0, 1);
 
-	printf("\nSlabs sorted by loss\n");
-	printf("--------------------\n");
-	line = 0;
-	sort_loss = 1;
-	sort_size = 0;
-	sort_slabs();
-	output_slabs();
 	printf("\n");
 }
 
-- 
2.21.0

