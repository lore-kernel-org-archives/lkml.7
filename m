Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04021C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F6720700
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iCsBeVOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfJBT1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:27:19 -0400
Received: from gateway20.websitewelcome.com ([192.185.69.18]:19166 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728000AbfJBT1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:27:18 -0400
X-Greylist: delayed 1382 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 15:27:17 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 39718400F9204
        for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2019 12:57:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Fjv4iiVexVUVYFjv4iVQsI; Wed, 02 Oct 2019 14:04:14 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lGuFHxBRnjeWcjmv8+OVj8h6DT2+GVr2Gf8sL4rtDWM=; b=iCsBeVOYQ8y5i0JxkH7to0mWYD
        nHxhmItBEKPjOco0tAuRVIq+WBxiu994Y2EkTRb704t1zGngb5RkHIe6VV8ImtoUtUJEBmU0Kk1nv
        UL35BlIIoraV6yiT5wmIuoYClrOIKQ0drO01Qw7V2lA8noPMfgeMfjbllZiffnrr5tzZCs9I7imOd
        KPdWXoupPZalrpljy6xtAK8Y9VFmEP8Ie2/OGmVaLmSsCb/ARPklUkjJSikxUt/+TQn/fclSf0G9n
        CjRooX9KKaOo/+3WfV7wo1dG0AfS2sWiuuBJNflXy0Zyy3TQ7g/wBzccnCxpN6fKv43zwgQxCpgC8
        CVS4/Osw==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:39692 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iFjv3-0047wu-MW; Wed, 02 Oct 2019 14:04:13 -0500
Date:   Wed, 2 Oct 2019 14:03:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] md: dm-stripe: Use struct_size() in kmalloc()
Message-ID: <20191002190341.GA8900@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1iFjv3-0047wu-MW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:39692
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct stripe_c {
        ...
        struct stripe stripe[0];
};

In this case alloc_context() and dm_array_too_big() are removed and
replaced by the direct use of the struct_size() helper in kmalloc().

Notice that open-coded form is prone to type mistakes.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/md/dm-stripe.c        | 15 +--------------
 include/linux/device-mapper.h |  3 ---
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 8547d7594338..63bbcc20f49a 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -55,19 +55,6 @@ static void trigger_event(struct work_struct *work)
 	dm_table_event(sc->ti->table);
 }
 
-static inline struct stripe_c *alloc_context(unsigned int stripes)
-{
-	size_t len;
-
-	if (dm_array_too_big(sizeof(struct stripe_c), sizeof(struct stripe),
-			     stripes))
-		return NULL;
-
-	len = sizeof(struct stripe_c) + (sizeof(struct stripe) * stripes);
-
-	return kmalloc(len, GFP_KERNEL);
-}
-
 /*
  * Parse a single <dev> <sector> pair
  */
@@ -142,7 +129,7 @@ static int stripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		return -EINVAL;
 	}
 
-	sc = alloc_context(stripes);
+	sc = kmalloc(struct_size(sc, stripe, stripes), GFP_KERNEL);
 	if (!sc) {
 		ti->error = "Memory allocation for striped context "
 		    "failed";
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 399ad8632356..2e13826898b2 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -594,9 +594,6 @@ void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
  */
 #define dm_round_up(n, sz) (dm_div_up((n), (sz)) * (sz))
 
-#define dm_array_too_big(fixed, obj, num) \
-	((num) > (UINT_MAX - (fixed)) / (obj))
-
 /*
  * Sector offset taken relative to the start of the target instead of
  * relative to the start of the device.
-- 
2.23.0

