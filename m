Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9BFC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6662053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017610;
	bh=0VRQ51JQkoihwvzizz89h5bEIjnymJSPaYwXoN5e0Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tsxI4LCYhRLAxr7ql+Zt4sq3xvLglPbGvvtzcfa7c0VBsHxPcVcfa+g285Y7zhEnU
	 NtaCbAxwGdO2tvtg++/u0wIma59YZ+9v936KnwFFO9+vff/ROw7Poei1PROS6HwUFV
	 h8I2SdChAkkwW/CTy1bX1a61yI1i7Ni5kKQOG2U8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLJWcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbfLJWbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00ED3207FF;
        Tue, 10 Dec 2019 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017112;
        bh=0VRQ51JQkoihwvzizz89h5bEIjnymJSPaYwXoN5e0Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArX/k4kDaSpA1VIVmNjRYVT2JTFcheAlF+Q5wUxYiXwnVawOGCh1zV1KfGSgU7Hwu
         wRJJUZ7TlEZHA8HwTAtzzoGiwg9NYXC92foCxWsp+XW/ajESH3utIRCJwExLczOW5F
         NTFuw+YeKSX+hFxToTUtvN9sDI44jPjvICp/us6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Isely <isely@pobox.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 65/91] media: pvrusb2: Fix oops on tear-down when radio support is not present
Date:   Tue, 10 Dec 2019 17:30:09 -0500
Message-Id: <20191210223035.14270-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Isely <isely@pobox.com>

[ Upstream commit 7f404ae9cf2a285f73b3c18ab9303d54b7a3d8e1 ]

In some device configurations there's no radio or radio support in the
driver.  That's OK, as the driver sets itself up accordingly.  However
on tear-down in these caes it's still trying to tear down radio
related context when there isn't anything there, leading to
dereferences through a null pointer and chaos follows.

How this bug survived unfixed for 11 years in the pvrusb2 driver is a
mystery to me.

[hverkuil: fix two checkpatch warnings]

Signed-off-by: Mike Isely <isely@pobox.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 2cc4d2b6f810b..d18ced28797da 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -919,8 +919,12 @@ static void pvr2_v4l2_internal_check(struct pvr2_channel *chp)
 	pvr2_v4l2_dev_disassociate_parent(vp->dev_video);
 	pvr2_v4l2_dev_disassociate_parent(vp->dev_radio);
 	if (!list_empty(&vp->dev_video->devbase.fh_list) ||
-	    !list_empty(&vp->dev_radio->devbase.fh_list))
+	    (vp->dev_radio &&
+	     !list_empty(&vp->dev_radio->devbase.fh_list))) {
+		pvr2_trace(PVR2_TRACE_STRUCT,
+			   "pvr2_v4l2 internal_check exit-empty id=%p", vp);
 		return;
+	}
 	pvr2_v4l2_destroy_no_lock(vp);
 }
 
@@ -994,7 +998,8 @@ static int pvr2_v4l2_release(struct file *file)
 	kfree(fhp);
 	if (vp->channel.mc_head->disconnect_flag &&
 	    list_empty(&vp->dev_video->devbase.fh_list) &&
-	    list_empty(&vp->dev_radio->devbase.fh_list)) {
+	    (!vp->dev_radio ||
+	     list_empty(&vp->dev_radio->devbase.fh_list))) {
 		pvr2_v4l2_destroy_no_lock(vp);
 	}
 	return 0;
-- 
2.20.1

