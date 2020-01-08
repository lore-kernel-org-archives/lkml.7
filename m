Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107CC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D575206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rwnwk7EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAHSea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:34:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39173 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgAHSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:34:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1462371plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 10:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ycpN+XpOcmzf5Fswpp+TY6J3qUdx2wbF41rrLN2Bl/k=;
        b=Rwnwk7EIjhAbXXR5fDaZqGVQXaJkfD91xDJX/5ih7jqvtCxL1tGSobiOPWVMbpXiTk
         Xzgcesxc9wIeHKM38Q0U5cYDtg+ME3zIni9jOoWk3bywRrigA+qnq5qtO318U/SBD8UH
         QbKwQtTfbvV7uC4pI+V48jc4LTI9G5eedlt7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycpN+XpOcmzf5Fswpp+TY6J3qUdx2wbF41rrLN2Bl/k=;
        b=c2SZ4+uf1YE04tq2rgOS4MH+T3zi+3l8TUuMrXu8wK5yFPugqvKlqFFM3DoqG2dU+k
         OuP58yjJCZCZ6nWdfxmWK9p0vLCgEWrBo1qkc0AwQekRAoRuN6xQ0VnyUl3qP5cMeV7V
         AHYABvzZn4OOuQsvz+cdZSirAAGHb55k7bsfzp4rvjyezYbBf5IInXD7g7lP9yDlnAb9
         515EJ7ESUlDcNSLBTcJZD4T98wnUq/BU/j9ED7J1aDy4txnMtk3LVkVikrjwJH1YkPo0
         w6u+Pd03fRYUjsF3b4zkX8gyZK/dvmQTcOXaQof3KL8yffiHwtnh11otA1X5IYzLSk/b
         L/Xg==
X-Gm-Message-State: APjAAAVu2/Yrrr3UVGhWCO93TGf3G4gRAYBc3t+TUhujR6SM1SIu9csk
        e2cgk51ke0/2//57wso5VOMYApcRLRM=
X-Google-Smtp-Source: APXvYqwFFiua/Q28cb39Q52i6MM5ymiTmVYVZBEZ/535aaJp/yYe9FvOHXWjDhnkEmklHYuX2LyxhA==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr5823396pju.66.1578508469499;
        Wed, 08 Jan 2020 10:34:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id t1sm4695406pgq.23.2020.01.08.10.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 10:34:28 -0800 (PST)
Date:   Wed, 8 Jan 2020 10:34:27 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_qca: Add qca_power_on() API to
 support both wcn399x and Rome power up
Message-ID: <20200108183427.GE89495@google.com>
References: <20200107052601.32216-1-rjliao@codeaurora.org>
 <20200108090804.22889-1-rjliao@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108090804.22889-1-rjliao@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

On Wed, Jan 08, 2020 at 05:08:02PM +0800, Rocky Liao wrote:
> This patch adds a unified API qca_power_on() to support both wcn399x and
> Rome power on. For wcn399x it calls the qca_wcn3990_init() to init the
> regulators, and for Rome it pulls up the bt_en GPIO to power up the btsoc.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
> 
> Changes in v2: None
> 
>  drivers/bluetooth/hci_qca.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9392cc7f9908..f6555bd1adbc 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1532,6 +1532,27 @@ static int qca_wcn3990_init(struct hci_uart *hu)
>  	return 0;
>  }
>  
> +static int qca_power_on(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	enum qca_btsoc_type soc_type = qca_soc_type(hu);
> +	struct qca_serdev *qcadev;
> +	int ret = 0;
> +
> +	if (qca_is_wcn399x(soc_type)) {

Why not include the qca_regulator_enable() call from qca_open() here?
It is clearly part of power on.

> +		ret = qca_wcn3990_init(hu);
> +	} else {
> +		if (hu->serdev) {

nit: you could save a level of indentation (and IMO improve
readability) by doing:

     	       if (!hu->serdev)
	            	return 0;

> +			qcadev = serdev_device_get_drvdata(hu->serdev);
> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +			/* Controller needs time to bootup. */
> +			msleep(150);
> +		}
> +	}
> +
> +	return ret;
> +}
> +

I think common practice would be to combine the 3 patches of this series
into one. The new function doesn't really add any new functionality, but
is a refactoring. This is more evident if you see in a single diff that
the pieces in qca_power_on() are removed elsewhere.
