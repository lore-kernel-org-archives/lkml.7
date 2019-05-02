Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C251C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC772216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810689;
	bh=8YJT1FpzLUsFmD5n9vM9UGGa9NVdyiXY65SPaX5MK94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wJWSwkwkal4AQRIxEfxcYXHyz0oYk80mxtlVIUwRdL4D80yNiqeYE+UJevkp/SK87
	 DArhxCxhHljCRiDfkmZYMn6oT43xAqf9ST5fxn3tasBndVBjYsevFXrkIcd/nnpa88
	 QVZjQ6wvKjI6GJAsLiBHdTni4CclAh7mAi21laEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfEBPYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfEBPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:24:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7472085A;
        Thu,  2 May 2019 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810683;
        bh=8YJT1FpzLUsFmD5n9vM9UGGa9NVdyiXY65SPaX5MK94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ze3wKbPme+ezvGvaUcG0Gow6C82m/zaxTQ3FO9qZZN9ZaED7JW76+z1UoxOOkOtXH
         UEVyGFDf5Dvd8nmYQQVYCNpkRRBd8uOikScCO55PpLAZHGniSNVeznGOktBNOyj1T4
         KTrC3euCZFPuQ4DMRN4IKfq+nqRzSmuASA9fflX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Richard Leitner <richard.leitner@skidata.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 40/49] usb: usb251xb: fix to avoid potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:21:17 +0200
Message-Id: <20190502143329.061339727@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



