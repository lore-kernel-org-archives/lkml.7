Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AEBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0317F218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254016;
	bh=oY+/Jqh2TtnhI1Qrp3AcSjcK3lqguVR4b2hNEFjJ1JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0rAALeOrNRiuj3kH5mZ54dMVfUHeEa06KkQRGUrc8/EQ1b1wnCYBorLDPAksz6/MM
	 a2Abo5kB7AtUlI8E9dlP27NgFj9vge92k7rjfogreWFsi605jE7TE5u9lg4q93ouyt
	 fGPhMndlPyGNPiTMhurVg5uInyf2CozJkBYf/ijA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfCVL0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbfCVL0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:26:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4499D218A2;
        Fri, 22 Mar 2019 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254010;
        bh=oY+/Jqh2TtnhI1Qrp3AcSjcK3lqguVR4b2hNEFjJ1JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XH0Dj8R++h2FaPSceGGcc9gGiJWwfEeCRpbHCvASjZ+g9nfUwiMYXf2WNvit6NhLo
         9GZY6vOLZ4yVC6RGPuYQdScB9uN1rBqBfNnmz9VVPEK5fn57Ulho+JJxnavTW7H+A8
         WGvYrOdNgAktqCdroZsJFs8u3Y50ElSYnZavmFag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 3.18 131/134] md: Fix failed allocation of md_register_thread
Date:   Fri, 22 Mar 2019 12:15:44 +0100
Message-Id: <20190322111220.030238387@linuxfoundation.org>
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
@@ -3836,6 +3836,8 @@ static int run(struct mddev *mddev)
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
 							"reshape");
+		if (!mddev->sync_thread)
+			goto out_free_conf;
 	}
 
 	return 0;
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6171,6 +6171,8 @@ static int run(struct mddev *mddev)
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
 							"reshape");
+		if (!mddev->sync_thread)
+			goto abort;
 	}
 
 	/* Ok, everything is just fine now */


