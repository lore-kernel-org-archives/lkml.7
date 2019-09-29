Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B4C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEE2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765443;
	bh=V4JDjBNY1ZSsHGFbo7C7wIHPvOEOz1geVmPIYaGMxsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U0jHScCF1qz158WianpxNc9bWqmLpm2hFjkQ3VZjBHTK4L38X8ogpj7lt3wDUUkAm
	 waofBB146qx7TKGqjjOhKGoj2pCdBUmfBlkl95bghG30qew0WIJGqOLhbdM6z78Kp3
	 cZRj9oLvekQ5DYIWajuD7eM5RiOYKFovWQ9HhdQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfI2N5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbfI2N5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:57:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE18821835;
        Sun, 29 Sep 2019 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765440;
        bh=V4JDjBNY1ZSsHGFbo7C7wIHPvOEOz1geVmPIYaGMxsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RaQ6OuTE3UvH0mFGPBNzFU9nAvA1bShiO8nBV48CHf5bxgNcmhrc7hUanN72taJ+2
         OJHBbCQM1TukWgxNOJ7/mj1LQzkzu0oowIoMbxffE1gkQWWzEfAFkT5l4psjuLt4Qg
         ZoX8K4n5H//C7iV6zd01TVIUbJ7M2GIA1WmgB59g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 08/63] HID: sony: Fix memory corruption issue on cleanup.
Date:   Sun, 29 Sep 2019 15:53:41 +0200
Message-Id: <20190929135032.746377634@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

commit 2bcdacb70327013ca2066bfcf2af1009eff01f1d upstream.

The sony driver is not properly cleaning up from potential failures in
sony_input_configured. Currently it calls hid_hw_stop, while hid_connect
is still running. This is not a good idea, instead hid_hw_stop should
be moved to sony_probe. Similar changes were recently made to Logitech
drivers, which were also doing improper cleanup.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
CC: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-sony.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2806,7 +2806,6 @@ err_stop:
 	sony_cancel_work_sync(sc);
 	sony_remove_dev_list(sc);
 	sony_release_device_id(sc);
-	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -2868,6 +2867,7 @@ static int sony_probe(struct hid_device
 	 */
 	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "failed to claim input\n");
+		hid_hw_stop(hdev);
 		return -ENODEV;
 	}
 


