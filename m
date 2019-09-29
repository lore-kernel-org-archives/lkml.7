Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1988CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FD5218DE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765870;
	bh=YMOZpmrP05wrCsy3mE5emmfL/Ui/BFfGowo3UebEA00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3/6lTArE6q4rqeBR7+aX5qR1LddN3n2zri918wAM5fQ8VviUImsv6gw2CY5P16P9
	 Wf9ybkwRrTgRaLCwLl+RiwbVNapRCHFk0V2xfLDzo3kYzIawXXYdBAYo5OFc0r192p
	 C1psdnQoODjQK3Ju/HKxPox+ktQyMNS1y5byL5fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfI2OE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbfI2ODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9BF2190F;
        Sun, 29 Sep 2019 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765830;
        bh=YMOZpmrP05wrCsy3mE5emmfL/Ui/BFfGowo3UebEA00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bicrY9T+eMlrsv+XH0n5ZFvn/7TTQRyNtcBrContLrToj3cVSzOzNd9hGehi8lIkp
         A74YJCO68db4xYV22TGyjvF3ZUsTpb1QA2zixcUVqHmtpd28etKy0I+nyb5HndSlAW
         SwP1OV/wLbCp7gXWDmcvdtXNRThRz4NOSlIqF1mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.3 10/25] HID: sony: Fix memory corruption issue on cleanup.
Date:   Sun, 29 Sep 2019 15:56:13 +0200
Message-Id: <20190929135012.835786737@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
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
@@ -2811,7 +2811,6 @@ err_stop:
 	sony_cancel_work_sync(sc);
 	sony_remove_dev_list(sc);
 	sony_release_device_id(sc);
-	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -2876,6 +2875,7 @@ static int sony_probe(struct hid_device
 	 */
 	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "failed to claim input\n");
+		hid_hw_stop(hdev);
 		return -ENODEV;
 	}
 


