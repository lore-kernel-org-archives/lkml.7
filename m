Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F106FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D622084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141598;
	bh=4jg3Q4rTcYL9rDk3zh7hGURvn6gaAHNYEz61KJtfan8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hNctvvdY3yzNVnhM4TBq+w1FvYchwCvBBxyiHagLo90yC180s0dP0xylgIOUTBCM1
	 O4LPzRmceUuYBRWx/BCREHTuCs4w/UZChtd6VKfKw9BggBph9rENpGHtzVTsyG99+M
	 wexjdtxubQQwpbU+eJbS32SCUoR2LYfirS2yteTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfDAR75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbfDARRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3456D20883;
        Mon,  1 Apr 2019 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139065;
        bh=4jg3Q4rTcYL9rDk3zh7hGURvn6gaAHNYEz61KJtfan8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCLGJPWT3TDPSPM8aiTLb5Aic0E2yqfLiYEKvyxkJsNHeFky5ppAl3Y3ixzbGd0Xe
         1RX2lGM46Y6HPwFExX6vjaEz7B8RJ2aX03edq42TzJcLYWYfCk41gjRK1cmS4W+aqB
         4lH45+ykLpjYdnCbPzxGipi6f3B686xscL+/tLXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 4.19 102/134] phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs
Date:   Mon,  1 Apr 2019 19:02:18 +0200
Message-Id: <20190401170053.759046539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -481,8 +481,11 @@ static int sun4i_usb_phy_set_mode(struct
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


