Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF390C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C512084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mCRh/W68";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gja3kT9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfJKHBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:01:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:01:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2003260AD9; Fri, 11 Oct 2019 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570777294;
        bh=FjrM0GKwhYrHg3gTdRvsxbbbNqwBJ8x0GeRehvAIeLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mCRh/W68yyLgJ8EBrBBRKDCTiWTVP/TJAGvOSloHLsZSOb3tNLfAIGw193LmxEY+p
         htjOsUYQa/ZxLa9eaohpnMJvzhklw1l7LFayW1Y7EZbPrPV2ZJ3I0DoEvKZW+FLF5v
         C6+GJIHA8dHSgGvGI3WDA73xAAS5r5FoQZI6Prb8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 54BE3602FC;
        Fri, 11 Oct 2019 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570777293;
        bh=FjrM0GKwhYrHg3gTdRvsxbbbNqwBJ8x0GeRehvAIeLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gja3kT9/6qboMqK72LYiJdL5NkM2AjnLG0sJFb3ZL7mJg2xyuF5MJpFonGcLwgHfI
         PjonPadO4cjgB6rQXyYymzIBuHcgzNEF0yE/v7/rExIi3hQCQwGnwRilN2wNoE7BQH
         MfvdnCAtM45S2kTXBB/FiFpHjkzxeDjmK44S3/68=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Oct 2019 12:31:33 +0530
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjliao@codeaurora.org, rongchi@codeaurora.org,
        linux-bluetooth-owner@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: fix in-band sleep enablement
In-Reply-To: <20191009085116.199922-1-tientzu@chromium.org>
References: <20191009085116.199922-1-tientzu@chromium.org>
Message-ID: <238f01ec4b49fee4c0d08a0b8da7e95f@codeaurora.org>
X-Sender: c-hbandi@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ Balakrishna

On 2019-10-09 14:21, Claire Chang wrote:
> Enabling in-band sleep when there is no patch/nvm-config found and
> bluetooth is running with the original fw/config.
> 
> Fixes: ba8f35979002 ("Bluetooth: hci_qca: Avoid setup failure on
> missing rampatch")
> Fixes: 7dc5fe0814c3 ("Bluetooth: hci_qca: Avoid missing rampatch
> failure with userspace fw loader")
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e3164c200eac..367eef893a11 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1291,10 +1291,8 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup patch / NVM configurations */
>  	ret = qca_uart_setup(hdev, qca_baudrate, soc_type, soc_ver,
>  			firmware_name);
> -	if (!ret) {
> -		set_bit(QCA_IBS_ENABLED, &qca->flags);
> -		qca_debugfs_init(hdev);
> -	} else if (ret == -ENOENT) {
> +
> +	if (ret == -ENOENT) {
>  		/* No patch/nvm-config found, run with original fw/config */
>  		ret = 0;
>  	} else if (ret == -EAGAIN) {
> @@ -1305,6 +1303,11 @@ static int qca_setup(struct hci_uart *hu)
>  		ret = 0;
>  	}
> 
> +	if (!ret) {
> +		set_bit(QCA_IBS_ENABLED, &qca->flags);
> +		qca_debugfs_init(hdev);
> +	}
> +
>  	/* Setup bdaddr */
>  	if (qca_is_wcn399x(soc_type))
>  		hu->hdev->set_bdaddr = qca_set_bdaddr;
