Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED19C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7722CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620048;
	bh=iryYQO161VMi3ttZTGFDeTVGpdK1PfArdz98f7LOIok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tbF+onxRGOKVcxQjQXyIvlNIcke9+k6HgEyIIsTJKgJbkMyn2elnZ2PaOJJgfj2Lv
	 TQ6/aoa5Id4xt5X23whUJBGxrbpDvPdNiIq6NvB6K/WjeDN1KBMNytYlPby0TdZ2ZG
	 vA0adTPXNdURCXyc8hd3GMJjjhwjjJi0IZo50Wzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbfIDSAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388427AbfIDSAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:00:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7071C22CF5;
        Wed,  4 Sep 2019 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620041;
        bh=iryYQO161VMi3ttZTGFDeTVGpdK1PfArdz98f7LOIok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycB7IOigvRd1f06mxFqwRgYfCZFdE60+wvfsTgMZJMrOpNRqpK9jdPAdR3cLVow47
         Yv3VVxzTK1fZyKHuzqz7bfWjFqaDGf/Xh6u2v5c/kJkRKcEamRc9DTQz3UUGbX3kFt
         8vp6oZbA/vimNULmUGJr/swWHy5uAGX0IyY/ORXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 51/83] usb: host: fotg2: restart hcd after port reset
Date:   Wed,  4 Sep 2019 19:53:43 +0200
Message-Id: <20190904175308.222041811@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.488266791@linuxfoundation.org>
References: <20190904175303.488266791@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 777758888ffe59ef754cc39ab2f275dc277732f4 ]

On the Gemini SoC the FOTG2 stalls after port reset
so restart the HCD after each port reset.

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20190810150458.817-1-linus.walleij@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/fotg210-hcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 66efa9a676877..72853020a5426 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -1653,6 +1653,10 @@ static int fotg210_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			/* see what we found out */
 			temp = check_reset_complete(fotg210, wIndex, status_reg,
 					fotg210_readl(fotg210, status_reg));
+
+			/* restart schedule */
+			fotg210->command |= CMD_RUN;
+			fotg210_writel(fotg210, fotg210->command, &fotg210->regs->command);
 		}
 
 		if (!(temp & (PORT_RESUME|PORT_RESET))) {
-- 
2.20.1



