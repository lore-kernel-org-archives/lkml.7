Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078ECC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF14206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556245664;
	bh=IS1rVU/2oZ09yfVcyP6XwSC1Kda7ac81eyPX1mtB8+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LE48aQa9MobqDEK+CwzqEmlHMKd9PgRbPts+6olfvUGRe4RbDEwBzpoQlxot39ka1
	 Bff8iCTGNDbjOUJ0RDYWTZtVKW4aypOROd17h2NfdIuGgEO0sLs99KMrawn1D5e7wg
	 /sX0Zt4Zx+7YZCJJvkBU5EULk3z5NSXcGFCwshQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfDZC1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:27:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33451 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfDZC1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:27:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25647CF14;
        Thu, 25 Apr 2019 22:27:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Apr 2019 22:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=U8DAYh6kKcmZLs62Z24hf1Yov5/xwP/SyAoz3HiKdRQ=; b=kFld8fwp
        rxzL8gfIGZm/CBp7C83dBBFHEi/PmjGVz507ngjQMOb4MD+DTc1Q/Y7ELtkaE4LA
        XADpf1vw8+flbXwPL73uRfr4e3Pwg+S/fX82Cm3Nuu5inaI80LLhaHJ5kEP56VHj
        YisxlLXZfcia0qtoq5RuSRQ1QSkuO+W+tDsTJMF3T71CgJutzsX2cqt50hO3qF24
        auMlBW4TEePdc8dj4MMgKoASjbsRnRHGfZFp8FMebISzhdkLmRiOCK8SEuLQV5wN
        xvOTQSInBiU15oVGCGgVZd2B5jD+YNPANqnOxqpa1lu3m+WdMgmr0zSoVKMShfgl
        07ORxrfp9CY2dw==
X-ME-Sender: <xms:m2zCXMyFt9vXKM3AJsDjT-ToDpveAV_5nVK6HZOUMQ_9rW3vNIJyMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudehledrvddutdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:m2zCXKon2k2xaDVmH3jJyeJM5l4ki4yCpW2BV_zpOoVhgEEYpRIFLA>
    <xmx:m2zCXJ4gF74U3Uc2zHjiK_KyS8YYcvS41Qzl24GPBw7T_D0BS7tUEg>
    <xmx:m2zCXEiSbhrDDpTc6D_Uoir5-A7hpRB_x_KsYYszAsVSBUS9K1fu2A>
    <xmx:nGzCXBhWwNaiVWqfSkWGTUrvWCoNMTRG1u7DwX0boG64Yg5-2afM2Q>
Received: from eros.localdomain (124-169-159-210.dyn.iinet.net.au [124.169.159.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D1F7103CF;
        Thu, 25 Apr 2019 22:27:34 -0400 (EDT)
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
Subject: [PATCH 3/4] tools/vm/slabinfo: Add option to sort by partial slabs
Date:   Fri, 26 Apr 2019 12:26:21 +1000
Message-Id: <20190426022622.4089-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426022622.4089-1-tobin@kernel.org>
References: <20190426022622.4089-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to get a better view of the level of fragmentation within
the SLUB allocator.  Total number of partial slabs is an indicator of
fragmentation.

Add a command line option (-P | --partial) to sort the slab list by
total number of partial slabs.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 3f3a2db65794..469ff6157986 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -111,7 +111,7 @@ static void fatal(const char *x, ...)
 static void usage(void)
 {
 	printf("slabinfo 4/15/2011. (c) 2007 sgi/(c) 2011 Linux Foundation.\n\n"
-		"slabinfo [-aABDefhilLnorsStTUvXz1] [N=K] [-dafzput] [slab-regexp]\n"
+		"slabinfo [-aABDefhilLnoPrsStTUvXz1] [N=K] [-dafzput] [slab-regexp]\n"
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
 		"-B|--Bytes             Show size in bytes\n"
@@ -125,6 +125,7 @@ static void usage(void)
 		"-n|--numa              Show NUMA information\n"
 		"-N|--lines=K           Show the first K slabs\n"
 		"-o|--ops               Show kmem_cache_ops\n"
+		"-P|--partial		Sort by number of partial slabs\n"
 		"-r|--report            Detailed report on single slabs\n"
 		"-s|--shrink            Shrink slabs\n"
 		"-S|--Size              Sort by size\n"
@@ -1361,6 +1362,7 @@ struct option opts[] = {
 	{ "numa", no_argument, NULL, 'n' },
 	{ "lines", required_argument, NULL, 'N'},
 	{ "ops", no_argument, NULL, 'o' },
+	{ "partial", no_argument, NULL, 'p'},
 	{ "report", no_argument, NULL, 'r' },
 	{ "shrink", no_argument, NULL, 's' },
 	{ "Size", no_argument, NULL, 'S'},
@@ -1382,7 +1384,7 @@ int main(int argc, char *argv[])
 
 	page_size = getpagesize();
 
-	while ((c = getopt_long(argc, argv, "aABd::DefhilLnN:orsStTUvXz1",
+	while ((c = getopt_long(argc, argv, "aABd::DefhilLnN:oPrsStTUvXz1",
 						opts, NULL)) != -1)
 		switch (c) {
 		case 'a':
@@ -1436,6 +1438,9 @@ int main(int argc, char *argv[])
 		case 'r':
 			show_report = 1;
 			break;
+		case 'P':
+			sort_partial = 1;
+			break;
 		case 's':
 			shrink = 1;
 			break;
-- 
2.21.0

