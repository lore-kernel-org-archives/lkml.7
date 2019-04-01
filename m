Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823BF21925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138314;
	bh=5mP3b2kp+cqkPYAR54+7mfB7xtIHdYPhjA9ttitFgT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgeAPp2W3YPpHtoyWTOUyVc9STGHHqC/35xGPNMKLOYUQbdOCgBKIijiXALtEY8Fy
	 OnFr3i/76EoZqLm2fD6JHi/dw/ftLqlwGlbK4WmADmPC3mxW+GRriOFSpm7wkAJKPC
	 WzG2K+IAn98ZEQncSf/d6X1cY16YGSNqrdRhdy5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfDARFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfDARFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D659521929;
        Mon,  1 Apr 2019 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138312;
        bh=5mP3b2kp+cqkPYAR54+7mfB7xtIHdYPhjA9ttitFgT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYFh6dZ6Kmi/NnvbdeFdeG9Lql1AHHNW7b7UnNria3XKVTq2vxbAj1NiXELhaIOuF
         M55xon3VBndEhgWszLc28QHIyupucnvHnKVr4NrN4HmLuSmXxmlPHH3Ovu1fesq6T3
         q95DZ/vzfvhhDlGPR/Jn81DV5906gB71KolHX7VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dean Nelson <dnelson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 029/146] thunderx: enable page recycling for non-XDP case
Date:   Mon,  1 Apr 2019 19:00:41 +0200
Message-Id: <20190401170051.011312735@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dean Nelson <dnelson@redhat.com>

[ Upstream commit b3e208069477588c06f4d5d986164b435bb06e6d ]

Commit 773225388dae15e72790 ("net: thunderx: Optimize page recycling for XDP")
added code to nicvf_alloc_page() that inadvertently disables receive buffer
page recycling for the non-XDP case by always NULL'ng the page pointer.

This patch corrects two if-conditionals to allow for the recycling of non-XDP
mode pages by only setting the page pointer to NULL when the page is not ready
for recycling.

Fixes: 773225388dae ("net: thunderx: Optimize page recycling for XDP")
Signed-off-by: Dean Nelson <dnelson@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   23 ++++++++++-----------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -105,20 +105,19 @@ static inline struct pgcache *nicvf_allo
 	/* Check if page can be recycled */
 	if (page) {
 		ref_count = page_ref_count(page);
-		/* Check if this page has been used once i.e 'put_page'
-		 * called after packet transmission i.e internal ref_count
-		 * and page's ref_count are equal i.e page can be recycled.
+		/* This page can be recycled if internal ref_count and page's
+		 * ref_count are equal, indicating that the page has been used
+		 * once for packet transmission. For non-XDP mode, internal
+		 * ref_count is always '1'.
 		 */
-		if (rbdr->is_xdp && (ref_count == pgcache->ref_count))
-			pgcache->ref_count--;
-		else
-			page = NULL;
-
-		/* In non-XDP mode, page's ref_count needs to be '1' for it
-		 * to be recycled.
-		 */
-		if (!rbdr->is_xdp && (ref_count != 1))
+		if (rbdr->is_xdp) {
+			if (ref_count == pgcache->ref_count)
+				pgcache->ref_count--;
+			else
+				page = NULL;
+		} else if (ref_count != 1) {
 			page = NULL;
+		}
 	}
 
 	if (!page) {


