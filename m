Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A3A20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551885064;
	bh=5dVHp/EPiYjEHccokkFz+PjeEIyLbpYbKGxTOZKBTDg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=tbeISQlmORPlc+/K8V1I5OIzQXquLMg9qXpicZ2h1cND59xoGDLtXWp74MEb0GwyH
	 mlucc2ZcD8TXOAKfrEnp9+ZSLIT+lNPFjxl0USj3vXd31ZKAWlV4r9cBj7ev4LpRiG
	 YGqMMvagDVRwQIzb3hw25Ynf+7besdYzJgOxU6Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfCFPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbfCFPLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:11:02 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FFD20675;
        Wed,  6 Mar 2019 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551885061;
        bh=5dVHp/EPiYjEHccokkFz+PjeEIyLbpYbKGxTOZKBTDg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cAGRWAXqlC3KTwaK623YThX0Dt4H2LWO3IULYphLzpTnKjCWR6tkJdmliNWJUCVAg
         dt0Z/5YLRzyx2uewDctHFs6u+IpSQevTFU8rkROpZcNMcXlxskts/shsucd+XtZkZE
         zvAmTUtNcTJ8+TA6gKmeEXYth5vIPCdYPzSuToXE=
Subject: Re: [PATCH] usbip: Remove unnecessary null check
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190305151110.4366-1-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <d40255b3-5f87-c6a5-ebe2-c499dc858b76@kernel.org>
Date:   Wed, 6 Mar 2019 08:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305151110.4366-1-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suwan,

On 3/5/19 8:11 AM, Suwan Kim wrote:
> "vdev" points to vhci_hcd->vdev[] array and vhci_hcd->vdev[] array
> is not a pointer array but a structure array and it is already used
> in vhci_urb_enqueue() and then passed to vhci_tx_urb() as an argument.
> vhci_tx_urb() is not called except vhci_urb_enqueue(). So, "vdev"
> can not be null pointer. This null check statement is meaningless.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index f46ee1fefe02..667d9c0ec905 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -654,15 +654,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
>   {
>   	struct vhci_priv *priv;
> -	struct vhci_hcd *vhci_hcd;
> +	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
>   	unsigned long flags;
>   
> -	if (!vdev) {
> -		pr_err("could not get virtual device");
> -		return;
> -	}
> -	vhci_hcd = vdev_to_vhci_hcd(vdev);
> -
>   	priv = kzalloc(sizeof(struct vhci_priv), GFP_ATOMIC);
>   	if (!priv) {
>   		usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
> 

Thanks for the patch. Looks good to me.

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
