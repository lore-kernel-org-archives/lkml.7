Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996A4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892485;
	bh=QfCjO8LCovNwH1MRrDpyQEBYvOGF0awCtZXeqsF6glM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0O3ZB9nOdsneR1Jhn+yFRz+I0ABOt8G+EPv6G/RCktGyjhneT6u1pe3zO/ck25yRk
	 TqfPhwg2Jh3sF3sw/y+IKlpDzvYFi3RSve9z8bBF/XFCTIJlb1FjJC8tdk+5Sm7snW
	 OJbob7G5gMEJQwd3wkD7DHOedSmuiOQSaj32BmqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfH0Hyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbfH0Hyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:54:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5EE206BA;
        Tue, 27 Aug 2019 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892480;
        bh=QfCjO8LCovNwH1MRrDpyQEBYvOGF0awCtZXeqsF6glM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGxSjREdcxNgZhxtfl4KB436OnLJqhm1igfDPkhjUqDOe9oNcVzwkxsmaQxA7m1cd
         sZ05Skpaf9QyO8xHhYKyGCmNaP5ZSBwM7ccAfh4uiK4+xkxI96Zkc5i9TzRHEfaZBg
         0mSPGQAxDJg/9cfG+6nzN7KOAZAbKMSPbzhU3FdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Tao <kontais@zoho.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 52/62] dm table: fix invalid memory accesses with too high sector number
Date:   Tue, 27 Aug 2019 09:50:57 +0200
Message-Id: <20190827072703.573713624@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 1cfd5d3399e87167b7f9157ef99daa0e959f395d upstream.

If the sector number is too high, dm_table_find_target() should return a
pointer to a zeroed dm_target structure (the caller should test it with
dm_target_is_valid).

However, for some table sizes, the code in dm_table_find_target() that
performs btree lookup will access out of bound memory structures.

Fix this bug by testing the sector number at the beginning of
dm_table_find_target(). Also, add an "inline" keyword to the function
dm_table_get_size() because this is a hot path.

Fixes: 512875bd9661 ("dm: table detect io beyond device")
Cc: stable@vger.kernel.org
Reported-by: Zhang Tao <kontais@zoho.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-table.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1308,7 +1308,7 @@ void dm_table_event(struct dm_table *t)
 }
 EXPORT_SYMBOL(dm_table_event);
 
-sector_t dm_table_get_size(struct dm_table *t)
+inline sector_t dm_table_get_size(struct dm_table *t)
 {
 	return t->num_targets ? (t->highs[t->num_targets - 1] + 1) : 0;
 }
@@ -1333,6 +1333,9 @@ struct dm_target *dm_table_find_target(s
 	unsigned int l, n = 0, k = 0;
 	sector_t *node;
 
+	if (unlikely(sector >= dm_table_get_size(t)))
+		return &t->targets[t->num_targets];
+
 	for (l = 0; l < t->depth; l++) {
 		n = get_child(n, k);
 		node = get_node(t, l, n);


