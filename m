Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57526C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31669206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfD0PZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:25:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727411AbfD0PPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:25 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2v-00014H-7L; Sat, 27 Apr 2019 16:15:21 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004dq-QQ; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jann Horn" <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul Moore" <paul@paul-moore.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.407055283@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 182/202] netlabel: fix out-of-bounds memory accesses
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

commit 5578de4834fe0f2a34fedc7374be691443396d1f upstream.

There are two array out-of-bounds memory accesses, one in
cipso_v4_map_lvl_valid(), the other in netlbl_bitmap_walk().  Both
errors are embarassingly simple, and the fixes are straightforward.

As a FYI for anyone backporting this patch to kernels prior to v4.8,
you'll want to apply the netlbl_bitmap_walk() patch to
cipso_v4_bitmap_walk() as netlbl_bitmap_walk() doesn't exist before
Linux v4.8.

Reported-by: Jann Horn <jannh@google.com>
Fixes: 446fda4f2682 ("[NetLabel]: CIPSOv4 engine")
Fixes: 3faa8f982f95 ("netlabel: Move bitmap manipulation functions to the NetLabel core.")
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16 following Paul's hint]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -165,7 +165,8 @@ static int cipso_v4_bitmap_walk(const un
 		    (state == 0 && (byte & bitmask) == 0))
 			return bit_spot;
 
-		bit_spot++;
+		if (++bit_spot >= bitmap_len)
+			return -1;
 		bitmask >>= 1;
 		if (bitmask == 0) {
 			byte = bitmap[++byte_offset];
@@ -735,7 +736,8 @@ static int cipso_v4_map_lvl_valid(const
 	case CIPSO_V4_MAP_PASS:
 		return 0;
 	case CIPSO_V4_MAP_TRANS:
-		if (doi_def->map.std->lvl.cipso[level] < CIPSO_V4_INV_LVL)
+		if ((level < doi_def->map.std->lvl.cipso_size) &&
+		    (doi_def->map.std->lvl.cipso[level] < CIPSO_V4_INV_LVL))
 			return 0;
 		break;
 	}

