Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85579C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5361720857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCSG6N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:58:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52009 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCSG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:58:13 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9FD93CF187;
        Tue, 19 Mar 2019 08:06:11 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: mediatek: Fixed incorrect type in assignment
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <64582ec6b953c055bc3cf18e7bba18d578f03b0a.1551744635.git.sean.wang@mediatek.com>
Date:   Tue, 19 Mar 2019 07:58:10 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <53100DF6-DAB8-40C2-8DEF-CE4146FC6023@holtmann.org>
References: <64582ec6b953c055bc3cf18e7bba18d578f03b0a.1551744635.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Fixed warning: incorrect type in assignment reported by kbuild test robot.
> The detailed warning is shown as below.
> 
> make ARCH=x86_64 allmodconfig
> make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> All warnings (new ones prefixed by >>):
> 
> btmtkuart.c:671:18: sparse:    warning: incorrect type in assignment
> 			       (different base types)
> btmtkuart.c:671:18: sparse:    expected unsigned int [usertype] baudrate
> btmtkuart.c:671:18: sparse:    got restricted __le32 [usertype]
> 
> sparse warnings: (new ones prefixed by >>)
> btmtkuart.c:671:18: sparse: warning: incorrect type in assignment
> 			       (different base types)
> btmtkuart.c:671:18: sparse:    expected unsigned int [usertype] baudrate
> btmtkuart.c:671:18: sparse:    got restricted __le32 [usertype]
> 
> vim +671 drivers/bluetooth/btmtkuart.c
> 
>   659
>   660	static int btmtkuart_change_baudrate(struct hci_dev *hdev)
>   661	{
>   662		struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
>   663		struct btmtk_hci_wmt_params wmt_params;
>   664		u32 baudrate;
>   665		u8 param;
>   666		int err;
>   667
>   668		/* Indicate the device to enter the probe state the host is
>   669		 * ready to change a new baudrate.
>   670		 */
>> 671		baudrate = cpu_to_le32(bdev->desired_speed);
>   672		wmt_params.op = MTK_WMT_HIF;
> 
> Fixes: 22eaf6c9946a ("Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

