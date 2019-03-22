Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777942082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259025;
	bh=rgRs+JRvAdAjQ0GvzrGTezdUDhunQWbCTaAhU7L+0UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/1ufyX7GtQTdaRohw++ikDTOZXK60BmoCc2h/farmquTyIMaRrVqsLCPWggrj0jk
	 Jz8T1jbrG+0ydsw+X0eKmweTfonuk4ZDj3gPn+qAOvsLxNFvbEdH+e77GZbvvEW6pv
	 jmhcN9eEkuazCFz3ZVhz7qbFExVLDLdw6hX6zaxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbfCVLzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733236AbfCVLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D21F2082C;
        Fri, 22 Mar 2019 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255685;
        bh=rgRs+JRvAdAjQ0GvzrGTezdUDhunQWbCTaAhU7L+0UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGYpma+9bdmdu3WEeabhY3SmtuVHMFr8znUEbNPRid0Lz6+6zRkjzcry4jLe7s/FT
         iwFICMHTcfJeFfr2K5c4obVf4VtipfnLqXgKZpwnLCWXk1pyzHmnliu7VSr1Oonsc5
         N1iOyMgByIgCU/tvKCxaY0/zsc3LuV98HmtQ7iPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 167/183] md: Fix failed allocation of md_register_thread
Date:   Fri, 22 Mar 2019 12:16:35 +0100
Message-Id: <20190322111253.998668518@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Pakki <pakki001@umn.edu>

commit e406f12dde1a8375d77ea02d91f313fb1a9c6aec upstream.

mddev->sync_thread can be set to NULL on kzalloc failure downstream.
The patch checks for such a scenario and frees allocated resources.

Committer node:

Added similar fix to raid5.c, as suggested by Guoqing.

Cc: stable@vger.kernel.org # v3.16+
Acked-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid10.c |    2 ++
 drivers/md/raid5.c  |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3821,6 +3821,8 @@ static int raid10_run(struct mddev *mdde
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
 							"reshape");
+		if (!mddev->sync_thread)
+			goto out_free_conf;
 	}
 
 	return 0;
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7370,6 +7370,8 @@ static int raid5_run(struct mddev *mddev
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
 							"reshape");
+		if (!mddev->sync_thread)
+			goto abort;
 	}
 
 	/* Ok, everything is just fine now */


