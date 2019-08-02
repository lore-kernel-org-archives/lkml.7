Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323FCC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045942184D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738335;
	bh=JLeOArumhw3pHEpAq0cX2sLAqcrHiDyam2CGdvxGhxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+uA3zz0aF0sNa/zCF8AaEHzWHJC+FoMekG5DQNKMa2k5n3dBy2TI47fRYurl1blU
	 IStz3Sp/P0kjZSF1zCugtAJYntlMnAxSX+hrs/N7Q9+RQA5ielJkrOdW1T0OIo7jOo
	 Lp2qLPnohMJvkh/uQILLw960eM4Kb8KH+7AgOoes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfHBJcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391169AbfHBJcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:32:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B011B217D7;
        Fri,  2 Aug 2019 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738331;
        bh=JLeOArumhw3pHEpAq0cX2sLAqcrHiDyam2CGdvxGhxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xFoIkTsgbxuz46FkXzPsVNCqFSz3plMoFZNuqTaCq+VU7uitiYr78vWrxdMXxEm9C
         zXjZWwNgkfaqu2GYMA4EnLzEVBE5anTzkx0ouxQCbsrJebtc8mh+88MneJPOmKAoEO
         XDfEEpPNyk0GQX1UJOH+ltOOYG5cYdvccLeINr2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 062/158] lib/scatterlist: Fix mapping iterator when sg->offset is greater than PAGE_SIZE
Date:   Fri,  2 Aug 2019 11:28:03 +0200
Message-Id: <20190802092216.662285387@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit aeb87246537a83c2aff482f3f34a2e0991e02cbc upstream.

All mapping iterator logic is based on the assumption that sg->offset
is always lower than PAGE_SIZE.

But there are situations where sg->offset is such that the SG item
is on the second page. In that case sg_copy_to_buffer() fails
properly copying the data into the buffer. One of the reason is
that the data will be outside the kmapped area used to access that
data.

This patch fixes the issue by adjusting the mapping iterator
offset and pgoffset fields such that offset is always lower than
PAGE_SIZE.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 4225fc8555a9 ("lib/scatterlist: use page iterator in the mapping iterator")
Cc: stable@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/scatterlist.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -496,17 +496,18 @@ static bool sg_miter_get_next_page(struc
 {
 	if (!miter->__remaining) {
 		struct scatterlist *sg;
-		unsigned long pgoffset;
 
 		if (!__sg_page_iter_next(&miter->piter))
 			return false;
 
 		sg = miter->piter.sg;
-		pgoffset = miter->piter.sg_pgoffset;
 
-		miter->__offset = pgoffset ? 0 : sg->offset;
+		miter->__offset = miter->piter.sg_pgoffset ? 0 : sg->offset;
+		miter->piter.sg_pgoffset += miter->__offset >> PAGE_SHIFT;
+		miter->__offset &= PAGE_SIZE - 1;
 		miter->__remaining = sg->offset + sg->length -
-				(pgoffset << PAGE_SHIFT) - miter->__offset;
+				     (miter->piter.sg_pgoffset << PAGE_SHIFT) -
+				     miter->__offset;
 		miter->__remaining = min_t(unsigned long, miter->__remaining,
 					   PAGE_SIZE - miter->__offset);
 	}


