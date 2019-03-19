Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1871C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB8020857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfCSG5L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:57:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47481 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCSG5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:57:10 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA9A9CF187;
        Tue, 19 Mar 2019 08:05:08 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] Bluetooth: btmtksdio: fix uninitialized symbol errors
 in btmtksdio_rx_packet
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <741bf172b7d0b77e664e7edeab1bd798c955cc5b.1552942432.git.sean.wang@mediatek.com>
Date:   Tue, 19 Mar 2019 07:57:07 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8DD976C7-5512-4228-ADC1-62AE2A3921A1@holtmann.org>
References: <741bf172b7d0b77e664e7edeab1bd798c955cc5b.1552942432.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Fixed all the below warnings. They would probably cause the following
> error handling path would use the uninitialized value and then produce
> unexpected behavior.
> 
> drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          old_data, old_len, true);
>          ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
>  unsigned int old_len;
>               ^~~~~~~
> drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          old_data, old_len, true);
>          ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
>  unsigned char *old_data;
>                 ^~~~~~~~
> 
> v2: Remove old_len and old_data because the error path for sdio_readsb also
>    seems wrong. And change the prefix from "mediatek" to "btmtksdio".
> 
> Fixes: d74eef2834b5 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 10 ----------
> 1 file changed, 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

