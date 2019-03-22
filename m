Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887322082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254982;
	bh=SIYhy/7sRsOGxgjxU5dq25oQM/O39KmLbNKt26DYIG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wO7WasD+sMrhOKQWHPaWlViJF8fY/dAsv2eGhD5mSVYNyOOxVE+PwkMyBEtl1s3Hn
	 apIUPE2MzOISI7tYA7NU9rRt6hnqmHYFFJf3hMo1miaOogVouGMSSfT4kNHMFaFvWL
	 YYV5XdtvGiuQxkFLiwvCruhmrAW0lk7QvJuzHYTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfCVLnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbfCVLm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8402A2082C;
        Fri, 22 Mar 2019 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254977;
        bh=SIYhy/7sRsOGxgjxU5dq25oQM/O39KmLbNKt26DYIG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/SEAjVDzBe11m5VL9ehDdnDyjiIeXWVJi54C0ebIeRyNUDuDgJ/a7Yo4uQWcJ/ga
         eJQpW3mF0kwKF8eMrk2hdzCKdcBVIVcGe2qMZluWg9pkopdphLeo/iCg/Y42rL12jD
         1ZNR0/ZNeCoZSDwaPDqBxmuY2bWxzJXzKYJHX9no=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Steve deRosier <derosier@cal-sierra.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 069/118] libertas_tf: dont set URB_ZERO_PACKET on IN USB transfer
Date:   Fri, 22 Mar 2019 12:15:41 +0100
Message-Id: <20190322111221.520903034@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


