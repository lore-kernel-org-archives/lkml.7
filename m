Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D9C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C86206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSnTg9KH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbfKESoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:44:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41636 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390592AbfKESoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:44:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so3561640plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qih/alkmIQbfF3MY5qtSQFmZNoWqlS/zxFnHUyH1R38=;
        b=aSnTg9KHEMB49AxbsfwaAz90kx72tV9XpVZf1DCYtUItEXCJcShFRUVYe8/jfcE70C
         fGilYsFMnICncY1ka6ITmZXvvljgCa9MPJrZHnKzou4r6lD2kl1np+KosoU7P08tXIJA
         4uopLlBFncqBQ7w1dSeAkq/yiydRQSSTBLdwOHIk6HC3QR4rB5Nt5jRhy1AVLlMZ0tKt
         nKafeDwb0sh6ORPsClkqYrkSR7CtoM1wCptaYtlnwmZlYmEVX5Q7G0ic6R8gvBUXrZBl
         mApaq6akcvbrAsOTtoZWo+NYl3/k72TJBI8oqYwFqrGYCyrUfdQYOZeEz/TuQljKB82S
         erFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qih/alkmIQbfF3MY5qtSQFmZNoWqlS/zxFnHUyH1R38=;
        b=Y1+mlMuTMXWVHRXnpOr38Hfu7feBDGaw+zg0Bg9SFPBhP2+yHfts3PC3RztAwlDfoz
         tEteEzShsejg6gV3z4Wx7JiUDlaFnYJR20gM+QsJwnK1yD9eYJr3+PZD7mSOSvV66cbs
         bA9mkPzRujCp0l2gv7Xww61z3tEWiwZusaTZFnrfT6e/qPOAsEgexSZYg37bhvCqxpp/
         uqBiJtXLttdt2e0WXdE3axxyP7XIFG4HwzzPGRM7n2smRDQ1ikRzAjcY58jo0dEnLe/N
         CeMdvz5N9DzihXDZeySlH7tEu68Xg+JGYB5qIljdQ9WMNVa3mD/hi7QpGSjEJ6KKgkCJ
         addQ==
X-Gm-Message-State: APjAAAXyI1W04Dd442yKXkqesrIj0FmwXHb4dRtWK03jUQt3LhBvYhNJ
        ypSoXeg+g4Pfoniyeosmz5qcEg==
X-Google-Smtp-Source: APXvYqxSuxMrsqDhwIi6laAe2V358hbO8Mf5HSGwYgv9fa5ZiFoJA9Fqc+OE9ZGQSTS0VJdq29PhVA==
X-Received: by 2002:a17:902:b60f:: with SMTP id b15mr35138746pls.68.1572979451125;
        Tue, 05 Nov 2019 10:44:11 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s24sm21442801pfm.144.2019.11.05.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:44:10 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:44:07 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tientzu@chromium.org, seanpaul@chromium.org
Subject: Re: [PATCH v1 2/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC WCN3991
Message-ID: <20191105184407.GA1852@minitux>
References: <20191105144508.22989-1-bgodavar@codeaurora.org>
 <20191105144508.22989-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105144508.22989-3-bgodavar@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Nov 06:45 PST 2019, Balakrishna Godavarthi wrote:

> This patch add support for WCN3991 i.e. current values and fw download
> support.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c   | 68 +++++++++++++++++++++++++++++--------
>  drivers/bluetooth/btqca.h   | 10 ++++--
>  drivers/bluetooth/hci_qca.c | 16 +++++++--
>  3 files changed, 74 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
[..]
> @@ -48,13 +62,16 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
>  	}
>  
>  	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> -	    edl->rtype != EDL_APP_VER_RES_EVT) {
> +	    edl->rtype != rtype) {
>  		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
>  			   edl->rtype);
>  		err = -EIO;
>  		goto out;
>  	}
>  
> +	if (soc_type == QCA_WCN3991)
> +		memcpy(&edl->data, &edl->data[1], sizeof(*ver));

memcpy() shouldn't be used when the two memory regions are overlapping,
use memmove() for this.

[..]
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 7f7a2b2c0df6..309a720ff216 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -126,6 +126,7 @@ enum qca_btsoc_type {
>  	QCA_ROME,
>  	QCA_WCN3990,
>  	QCA_WCN3998,
> +	QCA_WCN3991,

Please maintain sort order.

[..]
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
[..]
> @@ -1663,6 +1674,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,qca6174-bt" },
>  	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>  	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
> +	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},

Ditto

Regards,
Bjorn
