Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D249C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DEB2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cpu2YFT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCLQ3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:29:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35509 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfCLQ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:29:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id j5so2212063pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElZ5ziF/7ZNUJd8C4F1xA5Yjw8p3TB+TlOCx919a/60=;
        b=Cpu2YFT2U1a1VmuEC1AL+cf/gKesG6Xy+lb0c2T+Io1tJChZsHUT9Fr4u1FAIVi3Ut
         elGctAgTL+6jTiY1TclMF2xBs8muZ2/h1b70ofSGji9dHaOtHn5hUDtdn3SrUwBpMUH+
         dAwolHmxQC6jqRfXdFpt6Q1Dykk74dkT7/cic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElZ5ziF/7ZNUJd8C4F1xA5Yjw8p3TB+TlOCx919a/60=;
        b=VfnBEx67D40jIGjjAYLw6odfrslrosBvdb7iTIDpSNF8iaRhL7i3hzxY0BY63GZLGj
         wJWjARe4wmYAPQkTKQepQmqbnG0Hkv8jxbVWI9x3sRYypI0Rs/+R8zwvkq0ehH9ThFXx
         9BqXSNAATJiy/7M1qkBHovHUmYEIbjnP9dGtfcms6ei8IPbVyR3B7gV93FwRszZE6w+a
         TzCaMvh6qaRT2mILGQ1m28pJizEahepwjqal0wpx8cTIEXNmq1phTXq3EZDLywgfGOtD
         8MnPxkavNIxC31xuYpoI5KrNzLrD1PiasBoUoV88LaeUN+NAqxOpawoNff171We1ljjC
         X5WA==
X-Gm-Message-State: APjAAAWRXQMWg4/iwjIRWRB78bep6uz4/ddp8AjjjqUkkGobuPuRu+0v
        7YJBzT9izaKyi/+f1UUKtKPeIxKTc1Y=
X-Google-Smtp-Source: APXvYqyjF03JpG5V20Q0YKYckhvsn/uggJPJb5oglM17sbMS4wSYpLojTt9fV+ScK8IDmL6Yd9Bw9w==
X-Received: by 2002:a62:7592:: with SMTP id q140mr39668430pfc.164.1552408188439;
        Tue, 12 Mar 2019 09:29:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a192sm12065351pge.3.2019.03.12.09.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:29:47 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:29:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_qca: Added support for wcn3998
Message-ID: <20190312162947.GC200579@google.com>
References: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
 <1552393379-26330-2-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1552393379-26330-2-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

On Tue, Mar 12, 2019 at 05:52:58PM +0530, Harish Bandi wrote:
> Added new compatible for wcn3998 and corresponding voltage
> and current values to wcn3998 compatible.
> Changed driver code to support wcn3998
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> changes in v3:
> - updated to latest code base.

This is not useful, for future versions please describe what changed
(e.g. 'specify regulator constraints in the driver instead of the DT')

> ---
>  drivers/bluetooth/btqca.c   |  4 ++--
>  drivers/bluetooth/btqca.h   |  3 ++-
>  drivers/bluetooth/hci_qca.c | 40 ++++++++++++++++++++++++++--------------
>  3 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 6122685..70cab13 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -344,7 +344,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	/* Download rampatch file */
>  	config.type = TLV_TYPE_PATCH;
> -	if (soc_type == QCA_WCN3990) {
> +	if (soc_type >= QCA_WCN3990) {

That works, but isn't super-clear and might need to be adapted when
future non-WCN399x controllers are added.

Some possible alternatives:

- is_wcn399x(soc_type)
- have a family (Rome, Cherokee (IIRC this name was used for WCN3990))
  and a chip id (QCA6174, WCN3990, WCN3998, ...)

>  		/* Firmware files to download are based on ROM version.
>  		 * ROM version is derived from last two bytes of soc_ver.
>  		 */
> @@ -365,7 +365,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
> -	if (soc_type == QCA_WCN3990)
> +	if (soc_type >= QCA_WCN3990)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/crnv%02x.bin", rom_ver);
>  	else
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index c72c56e..f03d96e 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -132,7 +132,8 @@ enum qca_btsoc_type {
>  	QCA_INVALID = -1,
>  	QCA_AR3002,
>  	QCA_ROME,
> -	QCA_WCN3990
> +	QCA_WCN3990,
> +	QCA_WCN3998

nit: if you add a comma after the last value the line doesn't need to
be changed when a new type is added in the future.

Is 'WCN3998' specific enough? You mentioned earlier that there are
multiple WCN3998 variants with different requirements for regulator
voltages/max currents. Which names does Qualcomm use to distinguish
between them (e.g. WCN3998-A, WCN3998-B, ...)?

Thanks

Matthias
