Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13596C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E161D20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640875;
	bh=kxy0S+/6EGxRZ8fVxywLz6w0frDKayjYtMn20Cnr5vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sn5Ao7zLZuBOfs6Pq1fD3mDN+lmh/eMVgmfCegKa90SVRnbHOPlhMI3gaRsfK7NW1
	 +JSu6JtS28xZ6/fMLlDOklrTpySSyeOWPcfbIQnAQjm/hPyVDp5cjEPeb7lr5q9W5x
	 SNLQ15LddVrWYK+Sw9dgLoMS3RBulIxxDSssYsTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbfEWTry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731711AbfEWTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:12:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95B12184B;
        Thu, 23 May 2019 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638756;
        bh=kxy0S+/6EGxRZ8fVxywLz6w0frDKayjYtMn20Cnr5vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkwCnqAtw9JXZxK80Y+I/97l2VlZYz0Cfv8/U9om1rGE+fovrFQV/C1X13ViulYGC
         UK3lRYCMkxrhoZmOBm4DbxlyE0+UnAG/reY2GQT+z2+jgr5cjz6zSGRVWUbMfkLUkX
         a5Mwt3iyDpSeJ1ujc21QBL9qy94ZZELM5dJv4T18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 53/77] dm cache metadata: Fix loading discard bitset
Date:   Thu, 23 May 2019 21:06:11 +0200
Message-Id: <20190523181727.349202000@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikos Tsironis <ntsironis@arrikto.com>

commit e28adc3bf34e434b30e8d063df4823ba0f3e0529 upstream.

Add missing dm_bitset_cursor_next() to properly advance the bitset
cursor.

Otherwise, the discarded state of all blocks is set according to the
discarded state of the first block.

Fixes: ae4a46a1f6 ("dm cache metadata: use bitset cursor api to load discard bitset")
Cc: stable@vger.kernel.org
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1166,11 +1166,18 @@ static int __load_discards(struct dm_cac
 		if (r)
 			return r;
 
-		for (b = 0; b < from_dblock(cmd->discard_nr_blocks); b++) {
+		for (b = 0; ; b++) {
 			r = fn(context, cmd->discard_block_size, to_dblock(b),
 			       dm_bitset_cursor_get_value(&c));
 			if (r)
 				break;
+
+			if (b >= (from_dblock(cmd->discard_nr_blocks) - 1))
+				break;
+
+			r = dm_bitset_cursor_next(&c);
+			if (r)
+				break;
 		}
 
 		dm_bitset_cursor_end(&c);


