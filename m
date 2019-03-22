Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA9921916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253726;
	bh=oZBQIJU6MLp4YqqWxuh9jx9ZcqMTRER9OHa1udUHnmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RPqpSjXZb47TSYPyVsw3bseLUBmPXAWxAXT89GgV/c54OTQZUaTQAvzlCUP4xZqhR
	 Su6CZncE6ef6cVKonazBRZ2/XKRs+QbmW2wQD4ws4oFDL3jf12iJvm5LP7U1rgT+br
	 6pKi8oDXgSUuA0AwwhcI65RuwlHQq9oraI2OwA+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfCVLWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbfCVLWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:22:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448C421917;
        Fri, 22 Mar 2019 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253721;
        bh=oZBQIJU6MLp4YqqWxuh9jx9ZcqMTRER9OHa1udUHnmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjITRaflOIhgUfnuXvonetEEfb1fy4UzbHebxORo24E0IYje/iIgmpacHEaHeAuHq
         WdXTGIuoJHPJItnZs6mJ8wSrgwMHaAojzJK/s2Ga6V/vznWVAYJBKdirDrIHPM6XeZ
         lcfGT8K3V2T9oxAQdSLVlPFFUY+7Gn2wVxBcmU7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 051/134] netlabel: fix out-of-bounds memory accesses
Date:   Fri, 22 Mar 2019 12:14:24 +0100
Message-Id: <20190322111213.641135183@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 5578de4834fe0f2a34fedc7374be691443396d1f ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/cipso_ipv4.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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


