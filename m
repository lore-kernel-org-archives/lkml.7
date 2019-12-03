Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21BEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB6020656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414373;
	bh=nqrDeAiqwjw67y0i2EHRlzpeX2mJIKdZBClni9COesA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AiH+S7Nm8nit1c7h3GN1VpJE/weo43L93+eJTuZ5MTs2XV0JehEeX8TGpiaSiQ/9W
	 owVgBwLMsh04fm9QOnTRav/hvRsX/GAV7xsEhb/Pzk0cRqOhtJIL7c4IEj27uqOa7M
	 xYx4nyHjOshITJLPiYBs8WpM/2DzdJpGdWE1GxVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfLCWtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbfLCWtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955CE20684;
        Tue,  3 Dec 2019 22:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413347;
        bh=nqrDeAiqwjw67y0i2EHRlzpeX2mJIKdZBClni9COesA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpQxCeoY2nqdvylUr7jVZe7sv4lcBYP0TgW0ETc1iEZ9AuHu2x70e7CDQCcmkxovP
         /5qlhv20SeHFbvphiS7tuS2iVgaWhY4QvDs5jJG/vz4pqSzNWuW1X2rRWUa/0WBGk4
         JZrLLFuYlw/0Ik5xCbM44IFyNa/Z9M+ed3gYDI4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/321] rtl818x: fix potential use after free
Date:   Tue,  3 Dec 2019 23:32:40 +0100
Message-Id: <20191203223432.051347388@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit afbb1947db94eacc5a13302eee88a9772fb78935 ]

entry is released via usb_put_urb just after calling usb_submit_urb.
However, entry is used if the submission fails, resulting in a use after
free bug. The patch fixes this.

Signed-off-by: Pan Bian <bianpan2016@163.com>
ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 9a1d15b3ce453..518caaaf8a987 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -444,12 +444,13 @@ static int rtl8187_init_urbs(struct ieee80211_hw *dev)
 		skb_queue_tail(&priv->rx_queue, skb);
 		usb_anchor_urb(entry, &priv->anchored);
 		ret = usb_submit_urb(entry, GFP_KERNEL);
-		usb_put_urb(entry);
 		if (ret) {
 			skb_unlink(skb, &priv->rx_queue);
 			usb_unanchor_urb(entry);
+			usb_put_urb(entry);
 			goto err;
 		}
+		usb_put_urb(entry);
 	}
 	return ret;
 
-- 
2.20.1



