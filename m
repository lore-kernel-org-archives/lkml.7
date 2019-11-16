Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC74C33C8C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B944621739
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919908;
	bh=tGyuerj4tgHb0qQhYD5ienk8WW7ZV2NkS0UB4aqLey4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yu8GbsTi5g9Ml9N+Vm17MOcJTpCtstkDtbmysSjGDtUGYBye3kww+irgkJ2lkrOxK
	 TmWyr6mTMo6LBM0BTwXTAkkuuTGuawQlxAza4MUGfF7SdiUoOot9dzpRU031gdasW7
	 IZBfZhddyfTwGoHn8DS//D+vL5DXG586Tu6Eca/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfKPPyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbfKPPyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:09 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C3721920;
        Sat, 16 Nov 2019 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919648;
        bh=tGyuerj4tgHb0qQhYD5ienk8WW7ZV2NkS0UB4aqLey4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVDeWnJEOrLfUxyVN3AD3+Qd8EYEl8XQYBCuX1XK3yK2eK+vV6WoTdOfxVzjt8759
         bsoMZHoQhP+SLZdWuE70xdFnNc7JNQmLCRMa4eETZzsK+zaLy7EIaTYda8lXHnxAJF
         7cdUDcFjja9enHJVa5//JhzJsW7OMZRRnqAZoIeY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 25/77] macintosh/windfarm_smu_sat: Fix debug output
Date:   Sat, 16 Nov 2019 10:52:47 -0500
Message-Id: <20191116155339.11909-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ Upstream commit fc0c8b36d379a046525eacb9c3323ca635283757 ]

There's some antiquated debug output that's trying
to do a hand-made hexdump and turning into horrible
1-byte-per-line output these days.

Use print_hex_dump() instead

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/windfarm_smu_sat.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index ad6223e883404..3d310dd60a0be 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -22,14 +22,6 @@
 
 #define VERSION "1.0"
 
-#define DEBUG
-
-#ifdef DEBUG
-#define DBG(args...)	printk(args)
-#else
-#define DBG(args...)	do { } while(0)
-#endif
-
 /* If the cache is older than 800ms we'll refetch it */
 #define MAX_AGE		msecs_to_jiffies(800)
 
@@ -106,13 +98,10 @@ struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id, int id,
 		buf[i+2] = data[3];
 		buf[i+3] = data[2];
 	}
-#ifdef DEBUG
-	DBG(KERN_DEBUG "sat %d partition %x:", sat_id, id);
-	for (i = 0; i < len; ++i)
-		DBG(" %x", buf[i]);
-	DBG("\n");
-#endif
 
+	printk(KERN_DEBUG "sat %d partition %x:", sat_id, id);
+	print_hex_dump(KERN_DEBUG, "  ", DUMP_PREFIX_OFFSET,
+		       16, 1, buf, len, false);
 	if (size)
 		*size = len;
 	return (struct smu_sdbp_header *) buf;
@@ -132,13 +121,13 @@ static int wf_sat_read_cache(struct wf_sat *sat)
 	if (err < 0)
 		return err;
 	sat->last_read = jiffies;
+
 #ifdef LOTSA_DEBUG
 	{
 		int i;
-		DBG(KERN_DEBUG "wf_sat_get: data is");
-		for (i = 0; i < 16; ++i)
-			DBG(" %.2x", sat->cache[i]);
-		DBG("\n");
+		printk(KERN_DEBUG "wf_sat_get: data is");
+		print_hex_dump(KERN_DEBUG, "  ", DUMP_PREFIX_OFFSET,
+			       16, 1, sat->cache, 16, false);
 	}
 #endif
 	return 0;
-- 
2.20.1

