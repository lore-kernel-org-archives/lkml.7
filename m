Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD487C74A49
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E1A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfGKHGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:06:47 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36888 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfGKHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:06:47 -0400
Received: from [192.168.23.168] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 06C12CF2B8;
        Thu, 11 Jul 2019 09:15:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btqca: Add a short delay before downloading
 the NVM
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190709224450.187737-1-mka@chromium.org>
Date:   Thu, 11 Jul 2019 09:06:45 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <21246F6F-ADF5-4D05-8690-D0ABD793BA64@holtmann.org>
References: <20190709224450.187737-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> On WCN3990 downloading the NVM sometimes fails with a "TLV response
> size mismatch" error:
> 
> [  174.949955] Bluetooth: btqca.c:qca_download_firmware() hci0: QCA Downloading qca/crnv21.bin
> [  174.958718] Bluetooth: btqca.c:qca_tlv_send_segment() hci0: QCA TLV response size mismatch
> 
> It seems the controller needs a short time after downloading the
> firmware before it is ready for the NVM. A delay as short as 1 ms
> seems sufficient, make it 10 ms just in case. No event is received
> during the delay, hence we don't just silently drop an extra event.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> I'm only guessing why the delay is needed, maybe QCA folks can shed
> more light on this.
> 
> I didn't see this error when testing 2faa3f15fa2f ("Bluetooth: hci_qca:
> wcn3990: Drop baudrate change vendor event") and 32646db8cc28
> ("Bluetooth: btqca: inject command complete event during fw download")
> intensively a few months ago. My guess is that some changes in the kernel
> (I test with a 4.19 kernel with regular -stable merges) altered the
> timing, which made this issue visible.
> ---
> drivers/bluetooth/btqca.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

