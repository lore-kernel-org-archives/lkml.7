Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2069B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640265;
	bh=/lZTweBW81hb+YjBSmF1dONvupQjZjJDzP6SgXt1RdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/uQeMK1DaxKKzT8ucX4HSIZxXdKenk3C/X6diaXsrIvLFhn1RktuRz58RXfijM6W
	 hbXnI/Q/N2FXzWlhIUr5XQSZi+r8vTNzNRi46bG88ciNQGooW65xeFhwvw6fd0EY1M
	 5oLn7HQXn4eSHuCNWQYM07NjrzdkmFwpMfyL5QSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391423AbfEWThn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbfEWTYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:24:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78EC52054F;
        Thu, 23 May 2019 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639452;
        bh=/lZTweBW81hb+YjBSmF1dONvupQjZjJDzP6SgXt1RdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wprpcTJjEsFyenlnodYBNLieEt7w4Cw/QsRwOJlwg0N2+hCwy9q4wqnsgY7K2ZOCv
         q8AJqjHti4WmV6ph67cXJfLDmhcnzjcFuxidPJ/d8pJUlqKra9zVmvqETs4+/25pso
         OB47AjkZiQ/3Fpp7wtXnKV+Chg8O9M38WdsmCQgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.0 093/139] dm cache metadata: Fix loading discard bitset
Date:   Thu, 23 May 2019 21:06:21 +0200
Message-Id: <20190523181732.701803003@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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
@@ -1167,11 +1167,18 @@ static int __load_discards(struct dm_cac
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


