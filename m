Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A947CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BC8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E1q+mnnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfCFWdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:33:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36358 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfCFWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:33:10 -0500
Received: by mail-it1-f193.google.com with SMTP id v83so12774217itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=Ay3FzATJ0vHPBQdbtmiR6rFU1zWOfawoZWENuYgFKG0=;
        b=E1q+mnnwcA/nSnI39aoUKKtZV/jVXTur0l3CW4lU+j9q2Thvgdri5aLN8Tj5rTsX7R
         aIKnTYM8dyUE2ZZTEsmUaQrh6HgYDGfOw40q/T6R2IPaIs3NFGvv9P1cdM5F8vome6iR
         Y5jiYoq6DKzacP23f+9/CI8VLSgj+/1jtIUAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=Ay3FzATJ0vHPBQdbtmiR6rFU1zWOfawoZWENuYgFKG0=;
        b=BEDGbD4yQSzjk79mz4DDCLxoGdwrHEuKAI+McECWan7DfZpltVUSh6t32IEo7EqKV/
         EIKwGDXej/J+p4Yk87PV9MRyYv+r+eUzwK/D42VrLre7Kmhj0NX1tw20N6M1J/cQpuCl
         kOPXRr4kvABn3BhpEVwOCH5dSDiZhMO1H6C7fhaLjd6vKUiuXbswArXDQbPkT3UHJJ2y
         xhI5GuEEVi+RFXGPkp1faVXG2wxZ8RzSZy9xicr72YlgG2nueSeNfD9c9BUPL13HAONN
         bwKiARQyMtA31Ce//nn/MgTrHmrGGXYdCEac6lsAySoM47DgngPi6ngPLu7fJA4szxIU
         Um/w==
X-Gm-Message-State: APjAAAWGe3YsaLbUFBAuV83IFKFTXiuO4BsA1YDNaTWJra9h9c1ySykP
        P1aSnac3I0TBkvj33t0wAujal4qW+o3/pg==
X-Google-Smtp-Source: APXvYqwXnNs5JijvaF73h7vMK7tuA0+M1Q4vZDcL3M2ooqsCaDusVA0+SnCBrR9Bs9vupT4WzxAN+Q==
X-Received: by 2002:a24:7041:: with SMTP id f62mr3659797itc.62.1551911588900;
        Wed, 06 Mar 2019 14:33:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b20sm1104020ioj.12.2019.03.06.14.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 14:33:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306162113.8585-1-bgodavar@codeaurora.org>
References: <20190306162113.8585-1-bgodavar@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME controller to bootup.
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org
Message-ID: <155191158734.20095.15990837191526416248@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 06 Mar 2019 14:33:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Balakrishna Godavarthi (2019-03-06 08:21:13)
> This patch enables enough time to ROME controller to bootup
> after we bring the enable ping out of reset.
>=20
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---

Any Fixes tag? And maybe some more explanation or background on where
150 ms sleep comes from would be useful. Was it determined
experimentally or did it come from a datasheet somewhere? Does the time
differ between boards?

>  drivers/bluetooth/hci_qca.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f..1953b13511e7 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
>                 qcadev =3D serdev_device_get_drvdata(hu->serdev);
>                 if (qcadev->btsoc_type !=3D QCA_WCN3990) {
>                         gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +                       /* Controller needs time to bootup. */
> +                       msleep(150);
>                 } else {
>                         hu->init_speed =3D qcadev->init_speed;
>                         hu->oper_speed =3D qcadev->oper_speed;
