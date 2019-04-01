Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A4020830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139499;
	bh=yAmgXM3EGQp5oG6ydysiZ5QkYvOcZDFqki/YVArSfQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2t0SPCbu1GAGQXeSUg+gk79vx6TxXPIQxolCXCnhW0k/Z879FEKeUUne9SXLC9nAK
	 7pdWcqer2EmnG24gtFDtovKlq0uVZzlHplNf4/IWeZPEMR81G/ryABM8Z0vJlxtYQ9
	 6B2GnzdtI8jVp5hEDHQhgVAT4HjSecP0pQ6nQ3PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfDARY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbfDARYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C602063F;
        Mon,  1 Apr 2019 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139494;
        bh=yAmgXM3EGQp5oG6ydysiZ5QkYvOcZDFqki/YVArSfQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVA0dg04RZ6gHw9UwmIXpccNdgOnt31ml2BOq+AvMUVTHTO1u6+WNgG4lRoQBncCp
         f/LjTy3Qv5FXZWsrppZWlcL4OYG/YqGhKEuGG3LrvEKkWDBHWXZVE4v+SoC7krMREJ
         TmNBuH45d+eKTiGHXW/rLwYZtV7O1rMXA7VEHBgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 4.14 093/107] phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs
Date:   Mon,  1 Apr 2019 19:02:48 +0200
Message-Id: <20190401170054.126730563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

From: Chen-Yu Tsai <wens@csie.org>

commit 1396929e8a903db80425343cacca766a18ad6409 upstream.

While only the first PHY supports mode switching, the remaining PHYs
work in USB host mode. They should support set_mode with mode=USB_HOST
instead of failing. This is especially needed now that the USB core does
set_mode for all USB ports, which was added in commit b97a31348379 ("usb:
core: comply to PHY framework").

Make set_mode with mode=USB_HOST a no-op instead of failing for the
non-OTG USB PHYs.

Fixes: 6ba43c291961 ("phy-sun4i-usb: Add support for phy_set_mode")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/allwinner/phy-sun4i-usb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -480,8 +480,11 @@ static int sun4i_usb_phy_set_mode(struct
 	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
 	int new_mode;
 
-	if (phy->index != 0)
+	if (phy->index != 0) {
+		if (mode == PHY_MODE_USB_HOST)
+			return 0;
 		return -EINVAL;
+	}
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:


