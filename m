Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ADA206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556245652;
	bh=L5NIoMUyZW1BoFRr94k6KrKFOzdO2ikrNt52UpL7oh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nOvocW8GMpEgG7QKbScLdqN5ioyNr6wEI2Y6dkXezimebXVfshJZqts2gQdEfISuP
	 XKhkp44aPjmOs82nFF55+RCmg1KkeM4DmFrnjXXsusYRBzKHjpPTuel1eTrhKJ3HrK
	 lAq7zqQbXX36QU+0aK8ec7FhFufU6H4N/XvMsX3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDZC1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:27:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59385 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfDZC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:27:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D48A31319;
        Thu, 25 Apr 2019 22:27:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Apr 2019 22:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ODApqsgPFRkZS56T3G1W+y0nwkHyeIQIwFHc+/bQecY=; b=M9/aUmzP
        MCDW/wCiMKIGQeuN+QH+Z+uXwUfoVHgV7vZHc4M/K0DOKhV6sotXLs3uMaVSaiWL
        UXzJ7MA/ENkWHTMpIalnv+bOy2+Co0juTnKTc4Vz1C6IpsQYRbkkht3aZGyU13Zk
        Eh+XNpwJ3oQv7uCZCqVe1iQFwkATiSPqTLRbcIpgnVZOcrImO4Zln1aasj2rXybO
        RpklBA9WDokbIhkrDnApNLv07zoiMxK/V/04O3DH9tykbUEg4bT4U5vqql2UmcdJ
        lbCuDssOfZKGCH2Ur0ZAPyUj4SkbZI882w131HAJJVtdKycPVLF5XPoUd5dNyBCA
        CtP2rZ4YGp7Hzg==
X-ME-Sender: <xms:j2zCXNQISCFUnUt-6AkPpBN9dQu4LaN8WGgXMhQaSiNi69gq2LS6Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudehledrvddutdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:j2zCXIC743qaDNsZ47rdvLa_378GQs6aGHAT57ykKRXt4dzYuybieg>
    <xmx:j2zCXIKQCxVE3z5zDjBZJgSyiAv9FJWhYY0JkkadfEJ2t5phkzi7qQ>
    <xmx:j2zCXC_l0Rxb1eCuPX_m7i6vfZUSor3cRT2ltH7h87LbhDpZgX_seg>
    <xmx:j2zCXPMdl2J5cajUKCsJsSKfx3HlHSAd4Lcs7zaz-p7NIazj0xLkpQ>
Received: from eros.localdomain (124-169-159-210.dyn.iinet.net.au [124.169.159.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id 572E9103C9;
        Thu, 25 Apr 2019 22:27:22 -0400 (EDT)
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
Subject: [PATCH 1/4] tools/vm/slabinfo: Order command line options
Date:   Fri, 26 Apr 2019 12:26:19 +1000
Message-Id: <20190426022622.4089-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426022622.4089-1-tobin@kernel.org>
References: <20190426022622.4089-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_opt() has a spurious character within the option string.  Remove it
and reorder the options in alphabetic order so that it is easier to keep
the options correct.  Use the same ordering for command help output and
long option handling code.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 73818f1b2ef8..e9b5437b2f28 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -110,7 +110,7 @@ static void fatal(const char *x, ...)
 static void usage(void)
 {
 	printf("slabinfo 4/15/2011. (c) 2007 sgi/(c) 2011 Linux Foundation.\n\n"
-		"slabinfo [-aADefhilnosrStTvz1LXBU] [N=K] [-dafzput] [slab-regexp]\n"
+		"slabinfo [-aABDefhilLnorsStTUvXz1] [N=K] [-dafzput] [slab-regexp]\n"
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
 		"-B|--Bytes             Show size in bytes\n"
@@ -131,9 +131,9 @@ static void usage(void)
 		"-T|--Totals            Show summary information\n"
 		"-U|--Unreclaim         Show unreclaimable slabs only\n"
 		"-v|--validate          Validate slabs\n"
+		"-X|--Xtotals           Show extended summary information\n"
 		"-z|--zero              Include empty slabs\n"
 		"-1|--1ref              Single reference\n"
-		"-X|--Xtotals           Show extended summary information\n"
 
 		"\n"
 		"-d  | --debug          Switch off all debug options\n"
@@ -1334,6 +1334,7 @@ static void xtotals(void)
 struct option opts[] = {
 	{ "aliases", no_argument, NULL, 'a' },
 	{ "activity", no_argument, NULL, 'A' },
+	{ "Bytes", no_argument, NULL, 'B'},
 	{ "debug", optional_argument, NULL, 'd' },
 	{ "display-activity", no_argument, NULL, 'D' },
 	{ "empty", no_argument, NULL, 'e' },
@@ -1341,21 +1342,20 @@ struct option opts[] = {
 	{ "help", no_argument, NULL, 'h' },
 	{ "inverted", no_argument, NULL, 'i'},
 	{ "slabs", no_argument, NULL, 'l' },
+	{ "Loss", no_argument, NULL, 'L'},
 	{ "numa", no_argument, NULL, 'n' },
+	{ "lines", required_argument, NULL, 'N'},
 	{ "ops", no_argument, NULL, 'o' },
-	{ "shrink", no_argument, NULL, 's' },
 	{ "report", no_argument, NULL, 'r' },
+	{ "shrink", no_argument, NULL, 's' },
 	{ "Size", no_argument, NULL, 'S'},
 	{ "tracking", no_argument, NULL, 't'},
 	{ "Totals", no_argument, NULL, 'T'},
+	{ "Unreclaim", no_argument, NULL, 'U'},
 	{ "validate", no_argument, NULL, 'v' },
+	{ "Xtotals", no_argument, NULL, 'X'},
 	{ "zero", no_argument, NULL, 'z' },
 	{ "1ref", no_argument, NULL, '1'},
-	{ "lines", required_argument, NULL, 'N'},
-	{ "Loss", no_argument, NULL, 'L'},
-	{ "Xtotals", no_argument, NULL, 'X'},
-	{ "Bytes", no_argument, NULL, 'B'},
-	{ "Unreclaim", no_argument, NULL, 'U'},
 	{ NULL, 0, NULL, 0 }
 };
 
@@ -1367,18 +1367,18 @@ int main(int argc, char *argv[])
 
 	page_size = getpagesize();
 
-	while ((c = getopt_long(argc, argv, "aAd::Defhil1noprstvzTSN:LXBU",
+	while ((c = getopt_long(argc, argv, "aABd::DefhilLnN:orsStTUvXz1",
 						opts, NULL)) != -1)
 		switch (c) {
-		case '1':
-			show_single_ref = 1;
-			break;
 		case 'a':
 			show_alias = 1;
 			break;
 		case 'A':
 			sort_active = 1;
 			break;
+		case 'B':
+			show_bytes = 1;
+			break;
 		case 'd':
 			set_debug = 1;
 			if (!debug_opt_scan(optarg))
@@ -1399,9 +1399,22 @@ int main(int argc, char *argv[])
 		case 'i':
 			show_inverted = 1;
 			break;
+		case 'l':
+			show_slab = 1;
+			break;
+		case 'L':
+			sort_loss = 1;
+			break;
 		case 'n':
 			show_numa = 1;
 			break;
+		case 'N':
+			if (optarg) {
+				output_lines = atoi(optarg);
+				if (output_lines < 1)
+					output_lines = 1;
+			}
+			break;
 		case 'o':
 			show_ops = 1;
 			break;
@@ -1411,33 +1424,20 @@ int main(int argc, char *argv[])
 		case 's':
 			shrink = 1;
 			break;
-		case 'l':
-			show_slab = 1;
+		case 'S':
+			sort_size = 1;
 			break;
 		case 't':
 			show_track = 1;
 			break;
-		case 'v':
-			validate = 1;
-			break;
-		case 'z':
-			skip_zero = 0;
-			break;
 		case 'T':
 			show_totals = 1;
 			break;
-		case 'S':
-			sort_size = 1;
-			break;
-		case 'N':
-			if (optarg) {
-				output_lines = atoi(optarg);
-				if (output_lines < 1)
-					output_lines = 1;
-			}
+		case 'U':
+			unreclaim_only = 1;
 			break;
-		case 'L':
-			sort_loss = 1;
+		case 'v':
+			validate = 1;
 			break;
 		case 'X':
 			if (output_lines == -1)
@@ -1445,11 +1445,11 @@ int main(int argc, char *argv[])
 			extended_totals = 1;
 			show_bytes = 1;
 			break;
-		case 'B':
-			show_bytes = 1;
+		case 'z':
+			skip_zero = 0;
 			break;
-		case 'U':
-			unreclaim_only = 1;
+		case '1':
+			show_single_ref = 1;
 			break;
 		default:
 			fatal("%s: Invalid option '%c'\n", argv[0], optopt);
-- 
2.21.0

