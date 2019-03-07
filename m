Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E32C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64C2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MT7ZnhxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:35:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:35:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so11830815pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9kBUhpBcqYBB4rTIv68teSw5/fyCaCZqoMFAFKzXrQ8=;
        b=MT7ZnhxRWSJfpEwK5vDdOv2tKwTZ7tTT51aNVcYa9yJBGaGlGaqLJpeaCtS64OMRWW
         6+A/fEtyNUKctQeyT2OHns+MLNqm8zU52cvwOVdx0cHOZBv0w+CRcL92jkGRUVZHaUtB
         bjNeCPUHFqnSH/SPolhENwY0/1dSXMK3wmgN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kBUhpBcqYBB4rTIv68teSw5/fyCaCZqoMFAFKzXrQ8=;
        b=KePKIuI5NgF4KmIH+ItB0LIU/ApnVd5gNFzi8lMrFaDG20mPD1dCNkLyUCGEILrB8w
         IIR1GCdNkCsdRKGpmfKaufg3eSeKZy+CyHG31IfHTTRnMrAh7097G/ByEIj1xbKx/NYT
         zVSACSX0hkU3Hw/gQJ//D+k7iGQCUUtpQfpTS2rgQHyNACgdPqqdf7ASMJ8CRXCVVOp2
         vmbTVKOAPJi0SJY7dxCbvM5YqXp9KgYFIhJGe5CCb8eC069nb3o3g2ddS64YXbYAattH
         nr1dAGXZe/hHA21QWrfYbfuIytDbT21CznpHNn108/iPe44g9FOLIA0Xc4ngrK2m6ZZ8
         jliw==
X-Gm-Message-State: APjAAAXgnQPggFFc7SZNZlBp+E+l/Ul1g4SuwoKZvFluL6C6sGEvd8Ve
        rgL11M1dZSgD/P/pPoLC6HnWLA==
X-Google-Smtp-Source: APXvYqx3R1aNmWTZCccyUy75ExBV6RbWl9XTWlZ0Ur++xKR0xmFx6/SHeq9umY18JlPShUT7gxtQkQ==
X-Received: by 2002:a62:48c1:: with SMTP id q62mr13653902pfi.113.1551976536604;
        Thu, 07 Mar 2019 08:35:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k74sm8692732pfb.172.2019.03.07.08.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 08:35:35 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:35:35 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to
 QCA_<flags>
Message-ID: <20190307163535.GA138592@google.com>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307004041.38059-2-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 04:40:40PM -0800, Matthias Kaehlcke wrote:
> Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IN_BAND_SLEEP_ENABLED.
> The constant represents a flag (multiple flags can be set at once),
> not a unique state of the controller or driver. Also use the BIT()
> macro to specify the position of the flag instead of an integer
> literal.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f1..ab8e59419dbc4 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -54,8 +54,7 @@
>  #define HCI_IBS_WAKE_ACK	0xFC
>  #define HCI_MAX_IBS_SIZE	10
>  
> -/* Controller states */
> -#define STATE_IN_BAND_SLEEP_ENABLED	1
> +#define QCA_IN_BAND_SLEEP_ENABLED	BIT(0)

I realized that the use of BIT() isn't correct here, since the value
is used with set_bit(), ..., which expect a bit *number*. It should
probably be an emum starting with 0.

I'll update it in the next revision.

>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> @@ -775,7 +774,7 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  	/* Don't go to sleep in middle of patch download or
>  	 * Out-Of-Band(GPIOs control) sleep is selected.
>  	 */
> -	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
> +	if (!test_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
>  		skb_queue_tail(&qca->txq, skb);
>  		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  		return 0;
> @@ -1192,7 +1191,7 @@ static int qca_setup(struct hci_uart *hu)
>  		return ret;
>  
>  	/* Patch downloading has to be done without IBS mode */
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  
>  	if (qcadev->btsoc_type == QCA_WCN3990) {
>  		bt_dev_info(hdev, "setting up wcn3990");
> @@ -1236,7 +1235,7 @@ static int qca_setup(struct hci_uart *hu)
>  	/* Setup patch / NVM configurations */
>  	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, soc_ver);
>  	if (!ret) {
> -		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +		set_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  		qca_debugfs_init(hdev);
>  	} else if (ret == -ENOENT) {
>  		/* No patch/nvm-config found, run with original fw/config */
> @@ -1294,7 +1293,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
>  	 * data in skb's.
>  	 */
>  	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +	clear_bit(QCA_IN_BAND_SLEEP_ENABLED, &qca->flags);
>  	qca_flush(hu);
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>  
