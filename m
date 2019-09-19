Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11EC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A4B21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbfISHcg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:32:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58862 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfISHcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:32:36 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4E0ECCECDC;
        Thu, 19 Sep 2019 09:41:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btusb: avoid unused function warning
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190918195918.2190556-1-arnd@arndb.de>
Date:   Thu, 19 Sep 2019 09:32:33 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Alex Lu <alex_lu@realsil.com.cn>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C6D98BD8-F57F-411F-A2F2-D9E531137002@holtmann.org>
References: <20190918195918.2190556-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> The btusb_rtl_cmd_timeout() function is used inside of an
> ifdef, leading to a warning when this part is hidden
> from the compiler:
> 
> drivers/bluetooth/btusb.c:530:13: error: unused function 'btusb_rtl_cmd_timeout' [-Werror,-Wunused-function]
> 
> Use an IS_ENABLED() check instead so the compiler can see
> the code and then discard it silently.
> 
> Fixes: d7ef0d1e3968 ("Bluetooth: btusb: Use cmd_timeout to reset Realtek device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/btusb.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9c35ebb30f8..23e606aaaea4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3807,8 +3807,8 @@ static int btusb_probe(struct usb_interface *intf,
> 		btusb_check_needs_reset_resume(intf);
> 	}
> 
> -#ifdef CONFIG_BT_HCIBTUSB_RTL
> -	if (id->driver_info & BTUSB_REALTEK) {
> +	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
> +	    (id->driver_info & BTUSB_REALTEK)) {
> 		hdev->setup = btrtl_setup_realtek;
> 		hdev->shutdown = btrtl_shutdown_realtek;
> 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
> @@ -3819,7 +3819,6 @@ static int btusb_probe(struct usb_interface *intf,
> 		 */
> 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> 	}
> -#endif

I prefer that we stick another ifdef around the btusb_rtl_cmd_timeout function since that is how we did it for the other vendors as well.

However I start to wonder if we need all these vendor ifdef anyway. The vendor specific functions should turn into empty stubs if their support is not selected.

Regards

Marcel

