Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981832081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvjAmXmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCHWDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:03:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36629 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfCHWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:03:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so15094100pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rM6afalI1XD//pr5YZglGO03Vo7d2SccLaqGoTe5TEU=;
        b=EvjAmXmP7ItQIYEtOes6b9f/xJhGVxgYGVA60g/588+Vuwdr+MqcxIs6WClfn5/zKN
         y+xyjtS99PuLxLExYfMvwQsfQOAcSEEioudm3T1EIarDhAr0NtXI//tjc8OEz+c5Uti5
         JeQR55M4Fzo0qF1DvlmLyorVrIAnDfS1uXgUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rM6afalI1XD//pr5YZglGO03Vo7d2SccLaqGoTe5TEU=;
        b=kiD+1jyAL103W2SdL9D25ZFTRRqHftkKG79xuviYy6HH+UK4YJj8U33B+WbHfyMMCY
         yzWn6kIrVKV+Es6cVPc3d4W3QB1hX6QYS2SfWA9Mp/2HYIubaVUJFHNNbTJPWJyOs+Gj
         c1+N0lF5DDAb3eynxFWcCHfogomVk6JoP24Q/7HL0QPKVEal2J614hhiATIvlAMk7z8t
         eI0SZgezsZdwpkcOGQBZ8fzzu+I1yW/I/T0TVHYhI1TPpzw3TK9Z7nuLG4smNB1CfWkr
         fqHTibJA9/mlXxxigMXae4Am56QTijXiXZLmIeUNg8xMtCaxV4AtIYNTwhxdpmgcyXOg
         8jng==
X-Gm-Message-State: APjAAAUng+iiyAEyW2JOPnuMeP17PNrq249+49pXLbEgCa0U9pexBG+O
        ++cqJCMcShe9iRYAgB0Vq4S+kA==
X-Google-Smtp-Source: APXvYqw8ppvjM32jAA/OXZGf/m6VI2rRqE4WfrzOq/xnZ80A4iDIoC78Bm34z6gU/0hAGrD4bchfFA==
X-Received: by 2002:a17:902:20e5:: with SMTP id v34mr21118971plg.319.1552082624646;
        Fri, 08 Mar 2019 14:03:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v4sm12891256pff.181.2019.03.08.14.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 14:03:43 -0800 (PST)
Date:   Fri, 8 Mar 2019 14:03:43 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Add helper function to get the chip
 family
Message-ID: <20190308220343.GC69116@google.com>
References: <20190308185130.207527-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308185130.207527-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:51:30AM -0800, Matthias Kaehlcke wrote:
> Many functions obtain a 'struct qca_serdev' only to read the btsoc_type
> field. Add a helper function that encapsulates this.
> 
> This also fixes crashes observed on platforms with ROME controllers
> that are instantiated through ldisc and not as serdev clients. The
> crashes are caused by NULL pointer dereferentiations, which stem from
> the driver's assumption that a QCA HCI device is always associated with
> a serdev device.
> 
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
> Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 45 +++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f..241e099473f8 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -174,6 +174,21 @@ static int qca_power_setup(struct hci_uart *hu, bool on);
>  static void qca_power_shutdown(struct hci_uart *hu);
>  static int qca_power_off(struct hci_dev *hdev);
>  
> +static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
> +{
> +	enum qca_btsoc_type soc_type;
> +
> +	if (hu->serdev) {
> +		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
> +
> +		soc_type = qsd->btsoc_type;
> +	} else {
> +		soc_type = QCA_AR3002;

Actually this is not correct, I think it should be QCA_ROME.

From commit 6e03126adda3 ("Bluetooth: btqca: Add AR3002 rampatch
support") I deduce the QCA_AR3002 is part of the ROME family. If
that's correct we should probably remove 'QCA_AR3002' (in another
independent patch).

I'll wait with respinning for if there are further comments.

Thanks

Matthias
