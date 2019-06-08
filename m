Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD3C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 21:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCD2208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 21:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LPLyhkmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfFHV01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 17:26:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfFHV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 17:26:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LQ5S33145369
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:26:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LQ5S33145369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029166;
        bh=3DOInXZ4iRK6cg1I2XjHTZPy+Dj6ZJrIvcfxmr8ebZU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LPLyhkmGt7GZeOLoBbx56HA15wcdl7uQWbXOtfDpr2MaP8EJpFx6dGTTomSOs9Ymv
         tXDcJn4jw6oCyJ3YKGqDTb/hPwtSqxiwzVgRrReKfRzs7ZAxTH5YEA6fbxX50E/NZ1
         YZ3EJiYA9I/Epz7U1vrh7nwyBos47RZzTXe2c6YVE3Cb/Tsn1LRO5pOgMhM04IpBU7
         lkLCvDzP+F2dAQVolNDGmB9IMhSvmrfQhc2biINfTEan4foDBR62rX8t3QNN0D1XJK
         UGY74GHLcV6j0KDCsJY9D68mGyeNh9D4Owf8MgBVV30vIbnJcCEgpAkEY06Tgs41Kn
         ocBcvL5GlEOXQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LQ46A3145366;
        Sat, 8 Jun 2019 14:26:04 -0700
Date:   Sat, 8 Jun 2019 14:26:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-de0e0624d86ff9fc512dedb297f8978698abf21a@git.kernel.org>
Cc:     chao.wang@ucloud.cn, bp@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
          chao.wang@ucloud.cn, hpa@zytor.com, tglx@linutronix.de,
          tony.luck@intel.com
In-Reply-To: <20190418034115.75954-3-chao.wang@ucloud.cn>
References: <20190418034115.75954-3-chao.wang@ucloud.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Check count_threshold unconditionally
Git-Commit-ID: de0e0624d86ff9fc512dedb297f8978698abf21a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  de0e0624d86ff9fc512dedb297f8978698abf21a
Gitweb:     https://git.kernel.org/tip/de0e0624d86ff9fc512dedb297f8978698abf21a
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 14:06:37 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:33:10 +0200

RAS/CEC: Check count_threshold unconditionally

The count_threshold should be checked unconditionally, after insertion
too, so that a count_threshold value of 1 can cause an immediate
offlining. I.e., offline the page on the *first* error encountered.

Add comments to make it clear what cec_add_elem() does, while at it.

Reported-by: WANG Chao <chao.wang@ucloud.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org
Link: https://lkml.kernel.org/r/20190418034115.75954-3-chao.wang@ucloud.cn
---
 drivers/ras/cec.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index f5795adc5a6e..73a975c26f9f 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -294,6 +294,7 @@ int cec_add_elem(u64 pfn)
 
 	ca->ces_entered++;
 
+	/* Array full, free the LRU slot. */
 	if (ca->n == MAX_ELEMS)
 		WARN_ON(!del_lru_elem_unlocked(ca));
 
@@ -306,24 +307,17 @@ int cec_add_elem(u64 pfn)
 			(void *)&ca->array[to],
 			(ca->n - to) * sizeof(u64));
 
-		ca->array[to] = (pfn << PAGE_SHIFT) |
-				(DECAY_MASK << COUNT_BITS) | 1;
-
+		ca->array[to] = pfn << PAGE_SHIFT;
 		ca->n++;
-
-		ret = 0;
-
-		goto decay;
 	}
 
-	count = COUNT(ca->array[to]);
-
-	if (count < count_threshold) {
-		ca->array[to] |= (DECAY_MASK << COUNT_BITS);
-		ca->array[to]++;
+	/* Add/refresh element generation and increment count */
+	ca->array[to] |= DECAY_MASK << COUNT_BITS;
+	ca->array[to]++;
 
-		ret = 0;
-	} else {
+	/* Check action threshold and soft-offline, if reached. */
+	count = COUNT(ca->array[to]);
+	if (count >= count_threshold) {
 		u64 pfn = ca->array[to] >> PAGE_SHIFT;
 
 		if (!pfn_valid(pfn)) {
@@ -338,15 +332,14 @@ int cec_add_elem(u64 pfn)
 		del_elem(ca, to);
 
 		/*
-		 * Return a >0 value to denote that we've reached the offlining
-		 * threshold.
+		 * Return a >0 value to callers, to denote that we've reached
+		 * the offlining threshold.
 		 */
 		ret = 1;
 
 		goto unlock;
 	}
 
-decay:
 	ca->decay_count++;
 
 	if (ca->decay_count >= CLEAN_ELEMS)
