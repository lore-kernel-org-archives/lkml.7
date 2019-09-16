Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F27C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB77B216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568639927;
	bh=yEKQ2EzNebjen4C4J2ejh9i+DO97eD4kjLJii31E0sQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=MQ9dtTZ/Rru70fBCAk31k4CamTGzQL5et30DShGeaQbwBPiMV7J/pK9H26mqZjv2t
	 UZOXhCknuFQT6s/NtDR+ZW/HxfrLYB132x/RM9u6L660XUTsdWo57jP3ERsUTDjvy4
	 WvxQMNm7Wk440lw/AgQSaufbx1IcMYGFccE2Be84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfIPNSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbfIPNSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:18:46 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FE821670;
        Mon, 16 Sep 2019 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568639926;
        bh=yEKQ2EzNebjen4C4J2ejh9i+DO97eD4kjLJii31E0sQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RXANIDI1sBFbF1f8K1T6U1H4McDlCVNenhffJ4BaAqis+MrU2Rf93FYYiiUQfdeI8
         i5l6lIkoCbZuX17Tzm1gjNmLNzwA+3/hITc6uTmIFAYV0p4MV2Fo0TLmfwB1lL0L53
         oC6H5CFlGokiBZDPVEKxzrGL5r6LP8obuT6jV9+c=
Subject: Re: [PATCH v2] usbip: vhci_hcd indicate failed message
To:     Mao Wenan <maowenan@huawei.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, shuah <shuah@kernel.org>
References: <5D7E3D1A.5070906@bfs.de>
 <20190915142223.158404-1-maowenan@huawei.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2743ad5b-9348-bd2b-4763-a2a199e6edad@kernel.org>
Date:   Mon, 16 Sep 2019 07:18:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915142223.158404-1-maowenan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/19 8:22 AM, Mao Wenan wrote:
> If the return value of vhci_init_attr_group and
> sysfs_create_group is non-zero, which mean they failed
> to init attr_group and create sysfs group, so it would
> better add 'failed' message to indicate that.
> This patch also change pr_err to dev_err to trace which
> device is failed.
> 
> Fixes: 0775a9cbc694 ("usbip: vhci extension: modifications to vhci driver")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>   v2: change pr_err to dev_err.
>   drivers/usb/usbip/vhci_hcd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 000ab7225717..bea28ec846ee 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1185,12 +1185,12 @@ static int vhci_start(struct usb_hcd *hcd)
>   	if (id == 0 && usb_hcd_is_primary_hcd(hcd)) {
>   		err = vhci_init_attr_group();
>   		if (err) {
> -			pr_err("init attr group\n");
> +			dev_err(hcd_dev(hcd), "init attr group failed\n");

Why not include err information in the message. Helps figure out why
it failed.

>   			return err;
>   		}
>   		err = sysfs_create_group(&hcd_dev(hcd)->kobj, &vhci_attr_group);
>   		if (err) {
> -			pr_err("create sysfs files\n");
> +			dev_err(hcd_dev(hcd), "create sysfs files failed\n");
>   			vhci_finish_attr_group();
>   			return err;
>   		}
> 

Why not include err information in the message. Helps figure out why
it failed.

thanks,
-- Shuah
