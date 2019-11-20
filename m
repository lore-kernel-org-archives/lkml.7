Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F3AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2762071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbfKTPlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:41:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52998 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731837AbfKTPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:40:20 -0500
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iXS5X-0004d6-Iy; Wed, 20 Nov 2019 15:40:15 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iXS5V-0004PA-O7; Wed, 20 Nov 2019 15:40:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Sterba" <dsterba@suse.com>, "Qu Wenruo" <wqu@suse.com>,
        "Hans van Kranenburg" <Hans.van.Kranenburg@mendix.com>,
        "Gu Jinxiang" <gujx@cn.fujitsu.com>,
        "Nikolay Borisov" <nborisov@suse.com>
Date:   Wed, 20 Nov 2019 15:38:32 +0000
Message-ID: <lsq.1574264230.176031096@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 82/83] btrfs: volumes: Cleanup stripe size calculation
In-Reply-To: <lsq.1574264230.280218497@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.78-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 793ff2c88c6397b3531c08cc4f920619b56a9def upstream.

Cleanup the following things:
1) open coded SZ_16M round up
2) use min() to replace open-coded size comparison
3) code style

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Gu Jinxiang <gujx@cn.fujitsu.com>
[ reformat comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16 as dependency of commit baf92114c7
 "btrfs: alloc_chunk: fix more DUP stripe size handling":
 - Add #include <linux/sizes.h> for definition of SZ_16M]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Hans van Kranenburg <Hans.van.Kranenburg@mendix.com>
---
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -27,6 +27,7 @@
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/semaphore.h>
+#include <linux/sizes.h>
 #include <asm/div64.h>
 #include "ctree.h"
 #include "extent_map.h"
@@ -4273,18 +4274,17 @@ static int __btrfs_alloc_chunk(struct bt
 	 * and compare that answer with the max chunk size
 	 */
 	if (stripe_size * data_stripes > max_chunk_size) {
-		u64 mask = (1ULL << 24) - 1;
-
 		stripe_size = div_u64(max_chunk_size, data_stripes);
 
 		/* bump the answer up to a 16MB boundary */
-		stripe_size = (stripe_size + mask) & ~mask;
+		stripe_size = round_up(stripe_size, SZ_16M);
 
-		/* but don't go higher than the limits we found
-		 * while searching for free extents
+		/*
+		 * But don't go higher than the limits we found while searching
+		 * for free extents
 		 */
-		if (stripe_size > devices_info[ndevs-1].max_avail)
-			stripe_size = devices_info[ndevs-1].max_avail;
+		stripe_size = min(devices_info[ndevs - 1].max_avail,
+				  stripe_size);
 	}
 
 	/* align to BTRFS_STRIPE_LEN */

