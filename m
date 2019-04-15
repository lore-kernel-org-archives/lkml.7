Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743AC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CF920651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355357;
	bh=LjlVUQfoCifb+AhOlPR45TlOcokhPlac9TXNBPPNre8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GgZCLi25+eHBQ/TUG9TGZnMyI4f2wgXY4HV1b3V+b1463Aa69siMFZhuimDQ0yGGp
	 ybvhrFfWYAy3IJ3OXghl8rBD6ab9dM4OKnrNJmxOxQFVvprA4LBHRrNFEF7caafPhE
	 anc/Npjw4qujqO5nk7cm/DWNPxw3lYCXFDnK9LvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfDOTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfDOTJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712A921900;
        Mon, 15 Apr 2019 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355347;
        bh=LjlVUQfoCifb+AhOlPR45TlOcokhPlac9TXNBPPNre8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=barPTBkDI4CuL+3mdF5XhDnA3B3gj4U9rN4qh8W5nZ6lU3u3Mc7DfGoHL8J/yW8a3
         KA/CtPZwB1C7gAMlu+ryR+IaaQhxYXHZdJjbZ/B5yhIl/P/sdAi0zAvDn1xRUFM/N8
         3Oeh7KkxvcoqntM/+v8kdyJlVlaZutZINuOoQ4t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 096/101] dm integrity: fix deadlock with overlapping I/O
Date:   Mon, 15 Apr 2019 20:59:34 +0200
Message-Id: <20190415183745.448810349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -908,7 +908,7 @@ static void copy_from_journal(struct dm_
 static bool ranges_overlap(struct dm_integrity_range *range1, struct dm_integrity_range *range2)
 {
 	return range1->logical_sector < range2->logical_sector + range2->n_sectors &&
-	       range2->logical_sector + range2->n_sectors > range2->logical_sector;
+	       range1->logical_sector + range1->n_sectors > range2->logical_sector;
 }
 
 static bool add_new_range(struct dm_integrity_c *ic, struct dm_integrity_range *new_range, bool check_waiting)
@@ -954,8 +954,6 @@ static void remove_range_unlocked(struct
 		struct dm_integrity_range *last_range =
 			list_first_entry(&ic->wait_list, struct dm_integrity_range, wait_entry);
 		struct task_struct *last_range_task;
-		if (!ranges_overlap(range, last_range))
-			break;
 		last_range_task = last_range->task;
 		list_del(&last_range->wait_entry);
 		if (!add_new_range(ic, last_range, false)) {


