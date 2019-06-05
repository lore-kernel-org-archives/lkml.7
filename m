Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E99C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA982075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T0CwpM0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfFEJsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:48:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12855 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfFEJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:48:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf78fd50000>; Wed, 05 Jun 2019 02:48:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Jun 2019 02:48:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Jun 2019 02:48:06 -0700
Received: from [10.19.120.158] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Jun
 2019 09:48:04 +0000
Subject: Re: [PATCH v11 1/2] usb: Add devaddr in struct usb_device
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <Thinh.Nguyen@synopsys.com>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
References: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
 <1559559224-9845-2-git-send-email-jilin@nvidia.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jim Lin <jilin@nvidia.com>
Message-ID: <e56146a9-9a88-b257-c3ea-1dcf307df830@nvidia.com>
Date:   Wed, 5 Jun 2019 17:48:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1559559224-9845-2-git-send-email-jilin@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559728085; bh=grjBNnzx9l51zL5S3keIIjDGVi0z/QiNjnVmI0UGVtc=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=T0CwpM0U1bZ8cYs38JVl/NcOvHXHtjp1u9DpcUpioOoJCgRM13yw2a/ca79gLHgpm
         J+MyJ6f413Xswb0SN5ypua4/y927A7Dizy+nVpZEmFnTvTZnf6UulTJANNz61D8s/7
         7UX3P5iPWNelw2vMVKKj2CAxkygOi7EZJ5yR8HAUKP2ZBtXs8GjlcelndF2JXrdbKl
         lzf+yV5f83SX+QtmkodPMGiiY4H/okuow71RuXx9KVFyqDSKrmr3wO8vY1V8UfhIzA
         YulD6hqh/CdSZkrEXN8bRx/LnE9OidNpX1MczWePk92TsuifmIsXz+OpkAtwK+9xmo
         1sJNXo43zCssg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019=E5=B9=B406=E6=9C=8803=E6=97=A5 18:53, Jim Lin wrote:
> The Clear_TT_Buffer request sent to the hub includes the address of
> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
> uses udev->devnum to set the address wValue. This won't work for
> devices connected to xHC.
>
> For other host controllers udev->devnum is the same as the address of
> the usb device, chosen and set by usb core. With xHC the controller
> hardware assigns the address, and won't be the same as devnum.
>
> Here we add devaddr in "struct usb_device" for
> usb_hub_clear_tt_buffer() to use.
>
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
>      , remove its claiming in xhci.h
> v3: Add description for clearing_tt (xhci.h)
> v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
>      to protect for Clear_TT_Buffer to be run serially.
>      Remove xhci_clear_tt_buffer_complete as it's not necessary.
>      Same reason as the above.
>      Extend usb_hub_clear_tt_buffer parameter
> v5: Not extending usb_hub_clear_tt_buffer parameter
>      Add description.
> v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
> v7: Add devaddr field in "struct usb_device"
> v8: split as two patches, change type from int to u8 for devaddr.
> v9: Use pahole to find place to put devaddr in struct usb_device.
>      Remove space between type cast and variable.
>      hub.c changed from v8
>      clear->devinfo |=3D (u16) (udev->devaddr << 4);
>      to
>      clear->devinfo |=3D ((u16)udev->devaddr) << 4;
>      to solve a problem if devaddr is larger than 16.
> v10 Initialize devaddr in xhci_setup_device()
>      Move devaddr to be below "u8 level"
> v11 Add xhci.c "slot_ctx =3D ..."
>
>   drivers/usb/core/hub.c  | 4 +++-
>   drivers/usb/host/xhci.c | 2 ++
>   include/linux/usb.h     | 2 ++
>   3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 572e8c26a129..82cc3766cb23 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -873,7 +873,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
>   	/* info that CLEAR_TT_BUFFER needs */
>   	clear->tt =3D tt->multi ? udev->ttport : 1;
>   	clear->devinfo =3D usb_pipeendpoint (pipe);
> -	clear->devinfo |=3D udev->devnum << 4;
> +	clear->devinfo |=3D ((u16)udev->devaddr) << 4;
>   	clear->devinfo |=3D usb_pipecontrol(pipe)
>   			? (USB_ENDPOINT_XFER_CONTROL << 11)
>   			: (USB_ENDPOINT_XFER_BULK << 11);
> @@ -2125,6 +2125,8 @@ static void update_devnum(struct usb_device *udev, =
int devnum)
>   	/* The address for a WUSB device is managed by wusbcore. */
>   	if (!udev->wusb)
>   		udev->devnum =3D devnum;
> +	if (!udev->devaddr)
> +		udev->devaddr =3D (u8)devnum;
>   }
>  =20
>   static void hub_free_dev(struct usb_device *udev)
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 20db378a6012..4f92643e3a4c 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4125,6 +4125,8 @@ static int xhci_setup_device(struct usb_hcd *hcd, s=
truct usb_device *udev,
>   	/* Zero the input context control for later use */
>   	ctrl_ctx->add_flags =3D 0;
>   	ctrl_ctx->drop_flags =3D 0;
> +	slot_ctx =3D xhci_get_slot_ctx(xhci, virt_dev->out_ctx);
> +	udev->devaddr =3D (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK=
);
>  =20
>   	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
>   		       "Internal device address =3D %d",
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index ae82d9d1112b..83d35d993e8c 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -578,6 +578,7 @@ struct usb3_lpm_parameters {
>    * @bus_mA: Current available from the bus
>    * @portnum: parent port number (origin 1)
>    * @level: number of USB hub ancestors
> + * @devaddr: device address, XHCI: assigned by HW, others: same as devnu=
m
>    * @can_submit: URBs may be submitted
>    * @persist_enabled:  USB_PERSIST enabled for this device
>    * @have_langid: whether string_langid is valid
> @@ -661,6 +662,7 @@ struct usb_device {
>   	unsigned short bus_mA;
>   	u8 portnum;
>   	u8 level;
> +	u8 devaddr;
>  =20
>   	unsigned can_submit:1;
>   	unsigned persist_enabled:1;

- May I get patch v11 1/2 acked or reviewed by Alan?

Did I not do this already?  Oh well, in any case:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

--nvpublic

