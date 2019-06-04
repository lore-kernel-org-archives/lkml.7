Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16369C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D409125A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559609815;
	bh=GaJ4qL2HdoRrSICUeux3MYc8KHihlthK57DuSkvBIgk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=m6ydWC6Tj2HqMFM5j5FGaEgIOFK+emRo5bACljODigoJmSD50LPllD6l18DTFcHJt
	 u6j7OXk+eNorHKiRPIhIQ9R8lGrfhfIDha9weVNXXou5mGGxvjFOOQW/LDDTxKN447
	 dKdpt8td3dornpgnL7xxNHbCj3qEgjhCzuq1tqlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFDA4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfFDA4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:56:54 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8345325A6B;
        Tue,  4 Jun 2019 00:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559609813;
        bh=GaJ4qL2HdoRrSICUeux3MYc8KHihlthK57DuSkvBIgk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PwW8husjoaZuP0+GbeXzn7kOM2z+KNAFT1AHHZZYLMr37UIpmxR3uC22JXqJUhZUI
         oAR8e29iybCsmwLv9TMxSiqIwCoLcC/G7YSUbdL5M5VyT0GwifdseSa0ESI4kf9MOG
         6mBIuW1y791HDdRclyyZd5zd3yJjgN+0/x9nLz1E=
Subject: Re: [PATCH] usbip: Replace unused kvec array with single variable in
 vhci_send_cmd_unlink()
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20190603150211.24926-1-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <cff86084-5b7b-c02e-69d5-3e0e801fd11f@kernel.org>
Date:   Mon, 3 Jun 2019 18:56:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603150211.24926-1-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 9:02 AM, Suwan Kim wrote:
> vhci_send_cmd_unlink() declears kvec array of size 3 but it actually
> uses just one element of the array. So, remove kvec array and replace
> it with single kvec variable.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>   drivers/usb/usbip/vhci_tx.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> index 9aed15a358b7..2fa26d0578d7 100644
> --- a/drivers/usb/usbip/vhci_tx.c
> +++ b/drivers/usb/usbip/vhci_tx.c
> @@ -144,16 +144,14 @@ static int vhci_send_cmd_unlink(struct vhci_device *vdev)
>   	struct vhci_unlink *unlink = NULL;
>   
>   	struct msghdr msg;
> -	struct kvec iov[3];
> +	struct kvec iov;
>   	size_t txsize;
> -
>   	size_t total_size = 0;
>   
>   	while ((unlink = dequeue_from_unlink_tx(vdev)) != NULL) {
>   		int ret;
>   		struct usbip_header pdu_header;
>   
> -		txsize = 0;
>   		memset(&pdu_header, 0, sizeof(pdu_header));
>   		memset(&msg, 0, sizeof(msg));
>   		memset(&iov, 0, sizeof(iov));
> @@ -169,11 +167,11 @@ static int vhci_send_cmd_unlink(struct vhci_device *vdev)
>   
>   		usbip_header_correct_endian(&pdu_header, 1);
>   
> -		iov[0].iov_base = &pdu_header;
> -		iov[0].iov_len  = sizeof(pdu_header);
> -		txsize += sizeof(pdu_header);
> +		iov.iov_base = &pdu_header;
> +		iov.iov_len  = sizeof(pdu_header);
> +		txsize = sizeof(pdu_header);
>   
> -		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, 1, txsize);
> +		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, &iov, 1, txsize);
>   		if (ret != txsize) {
>   			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
>   			       txsize);
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
