Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BF8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BCF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MlgenKpz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y3jdyREq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfC0LV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:21:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0LV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:21:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 87A3960ACE; Wed, 27 Mar 2019 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553685687;
        bh=zcfiPJAu2+7cVz/LYg9E/+ml++2CjeHn4ldgeH9iAKg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MlgenKpzau1wHHbetMScLFW/iW2MrO4S98fZdgSONYiyeKf9B7E2g8TMDtCIqeYcc
         yTuqbztl0NrHznWZ5oqkZc3gfbC37UxNNCaLdGOenjdTin/w7XoLuRDW5jMl+hZe3S
         Q9Hu1vt2r/4RNJQGz4NtDtGR//XPVS1BNnv+t3Og=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2515760ACE;
        Wed, 27 Mar 2019 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553685686;
        bh=zcfiPJAu2+7cVz/LYg9E/+ml++2CjeHn4ldgeH9iAKg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y3jdyREqV3j6/ijQmyicef0XSLg21Z2rSZtE0jFl/3UtFJMznNfux15jqtsBPki5D
         YaRPHn0tR6WKIbNfiOegom7UVBHLbPsiQD1TKPsAk5IjwvNrLJG1I8sJEfMl5HMEJG
         eiOx0OVL++6P0+UJi3K9dfGWudGtcAg4b/s0T6Es=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2515760ACE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] USB/xHCI: Remove returned value 'status' since never used
To:     Mathieu Malaterre <malat@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     trivial@kernel.org, Sarah Sharp <sarah.a.sharp@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190326201557.20388-1-malat@debian.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <698062d2-5f7d-6ad8-88c4-5c823961f97a@codeaurora.org>
Date:   Wed, 27 Mar 2019 16:51:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326201557.20388-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2019 1:45 AM, Mathieu Malaterre wrote:
> The returned value in status has never been used since
> commit 4296c70a5ec3 ("USB/xHCI: Enable USB 3.0 hub remote wakeup.")
> So remove 'status' completely.
>
> Remove warning (W=1):
>
>    drivers/usb/core/hub.c:3671:8: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>
> Cc: Sarah Sharp <sarah.a.sharp@intel.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   drivers/usb/core/hub.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 8d4631c81b9f..15a2934dc29d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3668,7 +3668,6 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
>   	struct usb_hub		*hub = usb_get_intfdata(intf);
>   	struct usb_device	*hdev = hub->hdev;
>   	unsigned		port1;
> -	int			status;
>   
>   	/*
>   	 * Warn if children aren't already suspended.
> @@ -3702,12 +3701,12 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
>   	if (hub_is_superspeed(hdev) && hdev->do_remote_wakeup) {
>   		/* Enable hub to send remote wakeup for all ports. */
>   		for (port1 = 1; port1 <= hdev->maxchild; port1++) {
> -			status = set_port_feature(hdev,
> -					port1 |
> -					USB_PORT_FEAT_REMOTE_WAKE_CONNECT |
> -					USB_PORT_FEAT_REMOTE_WAKE_DISCONNECT |
> -					USB_PORT_FEAT_REMOTE_WAKE_OVER_CURRENT,
> -					USB_PORT_FEAT_REMOTE_WAKE_MASK);


should not we check return value instead of removing it.

Thanks,
Mukesh

> +			set_port_feature(hdev,
> +					 port1 |
> +					 USB_PORT_FEAT_REMOTE_WAKE_CONNECT |
> +					 USB_PORT_FEAT_REMOTE_WAKE_DISCONNECT |
> +					 USB_PORT_FEAT_REMOTE_WAKE_OVER_CURRENT,
> +					 USB_PORT_FEAT_REMOTE_WAKE_MASK);
>   		}
>   	}
>   
