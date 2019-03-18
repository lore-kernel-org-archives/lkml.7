Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3024C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E212133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCRSKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:10:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42957 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726623AbfCRSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:10:01 -0400
X-UUID: 20acd802dfe1416aba12753549c69d15-20190319
X-UUID: 20acd802dfe1416aba12753549c69d15-20190319
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 695494746; Tue, 19 Mar 2019 02:09:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 02:09:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 02:09:52 +0800
Message-ID: <1552932593.24944.14.camel@mtkswgap22>
Subject: Re: [PATCH] Bluetooth: mediatek: Fixed incorrect type in assignment
From:   Sean Wang <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Mar 2019 02:09:53 +0800
In-Reply-To: <64582ec6b953c055bc3cf18e7bba18d578f03b0a.1551744635.git.sean.wang@mediatek.com>
References: <64582ec6b953c055bc3cf18e7bba18d578f03b0a.1551744635.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is just a gentle ping


On Tue, 2019-03-05 at 08:14 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
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
>    659
>    660	static int btmtkuart_change_baudrate(struct hci_dev *hdev)
>    661	{
>    662		struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
>    663		struct btmtk_hci_wmt_params wmt_params;
>    664		u32 baudrate;
>    665		u8 param;
>    666		int err;
>    667
>    668		/* Indicate the device to enter the probe state the host is
>    669		 * ready to change a new baudrate.
>    670		 */
>  > 671		baudrate = cpu_to_le32(bdev->desired_speed);
>    672		wmt_params.op = MTK_WMT_HIF;
> 
> Fixes: 22eaf6c9946a ("Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btmtkuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
> index b0b680dd69f4..f5dbeec8e274 100644
> --- a/drivers/bluetooth/btmtkuart.c
> +++ b/drivers/bluetooth/btmtkuart.c
> @@ -661,7 +661,7 @@ static int btmtkuart_change_baudrate(struct hci_dev *hdev)
>  {
>  	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
>  	struct btmtk_hci_wmt_params wmt_params;
> -	u32 baudrate;
> +	__le32 baudrate;
>  	u8 param;
>  	int err;
>  


