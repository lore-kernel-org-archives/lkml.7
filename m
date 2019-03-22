Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE521218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256998;
	bh=vpIbjk6ZD0nhcX1RLyqtlha2h1nMsyR53gPXcgplKY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ktupHOWTzrwEH9JE34c1KHU6MLZkAKmYmmkbBI/9R5imicDfWVKG6SPbjGDM0aDec
	 XVCzNGh58pqBcMZARq9EvAjCG0VVo3pr1gbNIX42A81FmH/dtkn7046YeCAAoMwJIu
	 l06RQ2b5TZ1ut13O+uGJxzMFpgI308ey5WXoRy8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfCVMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390225AbfCVMQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C88D2082C;
        Fri, 22 Mar 2019 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256992;
        bh=vpIbjk6ZD0nhcX1RLyqtlha2h1nMsyR53gPXcgplKY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1zVNeoT6jtulBhVF+tIufV2Yr5nTzpe9Kfz6g8buXeFmKDWqvKQ5oFwj4CBJIxI4
         DTcYWajw0YhFu3QYWbCs/OHeV9suF7ZPiM35/tnOBDrXyznlXfKdCMfdsPYX7VblXw
         D2hJgjKiCWZP5tCxq1I8BGf3DBfzYzhGnqZntJ5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Steve deRosier <derosier@cal-sierra.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.0 100/238] libertas_tf: dont set URB_ZERO_PACKET on IN USB transfer
Date:   Fri, 22 Mar 2019 12:15:19 +0100
Message-Id: <20190322111304.454209481@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


