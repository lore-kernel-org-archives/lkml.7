Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA046C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CEC21907
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962523;
	bh=zVLT+shqz30hEIKp4PmR2RPYN544gBgZ/FPVorhLtiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3vk52i/n18crlQqL9yMw2FZAQWD41xhnSC8Bf3VbKOqtGifMTTf/MWskHv/AU8+n
	 GobQc3j7NA1xj9tbAsbM2J/+1dSNevsAOJ+ZiEGNFlYuCaLjRX6JlefEnpqia+6C6j
	 VAC4MUHn/5LzNbpKr2Vb4IUcp/oOXP6Y2FHeCu3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfDVTsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbfDVTsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03AC21915;
        Mon, 22 Apr 2019 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962512;
        bh=zVLT+shqz30hEIKp4PmR2RPYN544gBgZ/FPVorhLtiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fu/8iMKcNJCyyzArraym5owB8x2pOfAG5vkVng3/g3djz51j5GQXPYHMLDDu/Rc4+
         AA7QZ65FJr2D7CH/xcZYBlSGEHnQNu1csYzvt7ZkBVaKEb/We50cH/KLpJXVIZJx/n
         Y10VxAVlGmjQCGG9WCR2kLq0byqiSYgYlSc71XmI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 33/43] usb: usb251xb: fix to avoid potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:47:17 -0400
Message-Id: <20190422194727.12495-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 41f00e6e9e55546390031996b773e7f3c1d95928 ]

of_match_device in usb251xb_probe can fail and returns a NULL pointer.
The patch avoids a potential NULL pointer dereference in this scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/misc/usb251xb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 135c91c434bf..ba8fcdb377e8 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -530,7 +530,7 @@ static int usb251xb_probe(struct usb251xb *hub)
 							   dev);
 	int err;
 
-	if (np) {
+	if (np && of_id) {
 		err = usb251xb_get_ofdata(hub,
 					  (struct usb251xb_data *)of_id->data);
 		if (err) {
-- 
2.19.1

