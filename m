Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D999BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995572073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355672;
	bh=1zCUaZStfYvThWZm8GiktjLr1om2wXGNsupS7xLlmLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ard43cEcqA6CD40i5zRMe3ybzPihkSSJh35TjYJnfhpfN/Z7nu3n7SmY3bcn1asVT
	 e/giI0867DTBgKO8/WsVH0+AmY30gsy7yI6zQWOq701Z2Ffuc3ZzFvseHgRbu7MOMj
	 ib26rS1QA6bcidnHerF1vr6s7GgYO3mII7VfwJuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfDOTOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbfDOTO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F552073F;
        Mon, 15 Apr 2019 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355666;
        bh=1zCUaZStfYvThWZm8GiktjLr1om2wXGNsupS7xLlmLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuuPU2NRjaqZMTtI22lVDr/WViGlgaD+pZ9mAAoSAO0xtkPvI7+zc5d9yYXC4LsHt
         JafN0ngjP0Ylh7NGJruwa70Zru6imUQZV7zkgVOghUpKjRuUYlIKOGCYo2cPMgWPn6
         VrWB914TEYbzxNv3DnsMzmZZgP7Wot2/nxcVA/eQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.0 114/117] dm integrity: fix deadlock with overlapping I/O
Date:   Mon, 15 Apr 2019 21:01:24 +0200
Message-Id: <20190415183750.559288283@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 4ed319c6ac08e9a28fca7ac188181ac122f4de84 upstream.

dm-integrity will deadlock if overlapping I/O is issued to it, the bug
was introduced by commit 724376a04d1a ("dm integrity: implement fair
range locks").  Users rarely use overlapping I/O so this bug went
undetected until now.

Fix this bug by correcting, likely cut-n-paste, typos in
ranges_overlap() and also remove a flawed ranges_overlap() check in
remove_range_unlocked().  This condition could leave unprocessed bios
hanging on wait_list forever.

Cc: stable@vger.kernel.org # v4.19+
Fixes: 724376a04d1a ("dm integrity: implement fair range locks")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -913,7 +913,7 @@ static void copy_from_journal(struct dm_
 static bool ranges_overlap(struct dm_integrity_range *range1, struct dm_integrity_range *range2)
 {
 	return range1->logical_sector < range2->logical_sector + range2->n_sectors &&
-	       range2->logical_sector + range2->n_sectors > range2->logical_sector;
+	       range1->logical_sector + range1->n_sectors > range2->logical_sector;
 }
 
 static bool add_new_range(struct dm_integrity_c *ic, struct dm_integrity_range *new_range, bool check_waiting)
@@ -959,8 +959,6 @@ static void remove_range_unlocked(struct
 		struct dm_integrity_range *last_range =
 			list_first_entry(&ic->wait_list, struct dm_integrity_range, wait_entry);
 		struct task_struct *last_range_task;
-		if (!ranges_overlap(range, last_range))
-			break;
 		last_range_task = last_range->task;
 		list_del(&last_range->wait_entry);
 		if (!add_new_range(ic, last_range, false)) {


