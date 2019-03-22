Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA15206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256319;
	bh=OMdnrxHElTckJNKwPYhFebdDSnknv5B0yWEV1hba+hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XjFSQz2pCSoMeXVicdmv7Z+z6bR9I1MEilBsMTfBcg7vBgnCyL5KuvOlo1hmkdI6/
	 7xk6DeJtGyZJCre0oJY/QMz/tijy0epuSUd+M2Vg6D44Bu7MYA4OQBcQwy6VitGDeB
	 FdLFd/9mJfcwvI/OnPq63LsRsUY4q/Pw+ZglmaRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbfCVMFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbfCVMFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BC321916;
        Fri, 22 Mar 2019 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256315;
        bh=OMdnrxHElTckJNKwPYhFebdDSnknv5B0yWEV1hba+hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEb+90PYaiCfxQl5x8UdSmi5ghszKtMHTOHX21a/zrulAWoTAC0rH1lnxnOl2AGKy
         rouj/YEz4NzaE9PZpJOiylnogobyXf0Ud4/iMAM6Boucu3R3KTx2DxHoIYo4BDIokg
         ivGxhNbztZCh+blxUt0btQhEAbwaO6QICyg+h9qY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Steve deRosier <derosier@cal-sierra.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 173/280] libertas_tf: dont set URB_ZERO_PACKET on IN USB transfer
Date:   Fri, 22 Mar 2019 12:15:26 +0100
Message-Id: <20190322111325.000072034@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Lubomir Rintel <lkundrak@v3.sk>

commit 607076a904c435f2677fadaadd4af546279db68b upstream.

It doesn't make sense and the USB core warns on each submit of such
URB, easily flooding the message buffer with tracebacks.

Analogous issue was fixed in regular libertas driver in commit 6528d8804780
("libertas: don't set URB_ZERO_PACKET on IN USB transfer").

Cc: stable@vger.kernel.org
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/libertas_tf/if_usb.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -433,8 +433,6 @@ static int __if_usb_submit_rx_urb(struct
 			  skb_tail_pointer(skb),
 			  MRVDRV_ETH_RX_PACKET_BUFFER_SIZE, callbackfn, cardp);
 
-	cardp->rx_urb->transfer_flags |= URB_ZERO_PACKET;
-
 	lbtf_deb_usb2(&cardp->udev->dev, "Pointer for rx_urb %p\n",
 		cardp->rx_urb);
 	ret = usb_submit_urb(cardp->rx_urb, GFP_ATOMIC);


