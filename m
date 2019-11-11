Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5A6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C42921655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499409;
	bh=Wr+QOl9fx70tvSuUnMOSAVArjRVbhH+B/hgCt7RzL2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y6fc2JbKAHZW+HTDbB+CONBBTe8nUFvRNGysDVf+vulbEQxhhhRH02oMC8S3f3Ft3
	 VtId0Fi2U8uPinoeY0cpvgGKJMxPM4J0ztDt0of7nLlSVW3mNn8PkWzedFTwmyFIqD
	 4IO9zKYVh96GlDljprIXNQvk339RjhdkaYBPiVmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfKKScl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfKKScf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:32:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E7C214E0;
        Mon, 11 Nov 2019 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497155;
        bh=Wr+QOl9fx70tvSuUnMOSAVArjRVbhH+B/hgCt7RzL2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZcR5idYUcZ/FziZt66TbLA80eSmJ39O7Yxh4GUUgO/l98PZW9qkJBHT56u+5xdfa
         QtAd4gE1rNX8n2YxS8OYu8FN47572VMf4fySgcf/jBISLPFpkP5FR1yQy86YRNidU4
         +noJ78HRmbGhL/e165mznBgVFAjMM+e5bvetsMMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernd Krumboeck <b.krumboeck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 22/65] can: usb_8dev: fix use-after-free on disconnect
Date:   Mon, 11 Nov 2019 19:28:22 +0100
Message-Id: <20191111181345.056368548@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3759739426186a924675651b388d1c3963c5710e upstream.

The driver was accessing its driver data after having freed it.

Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface from 8 devices")
Cc: stable <stable@vger.kernel.org>     # 3.9
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/usb_8dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -1007,9 +1007,8 @@ static void usb_8dev_disconnect(struct u
 		netdev_info(priv->netdev, "device disconnected\n");
 
 		unregister_netdev(priv->netdev);
-		free_candev(priv->netdev);
-
 		unlink_all_urbs(priv);
+		free_candev(priv->netdev);
 	}
 
 }


