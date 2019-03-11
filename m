Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D3BC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30032075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRwVKSh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCKINB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:13:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40865 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:13:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id v20so3154090otk.7;
        Mon, 11 Mar 2019 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7Rk9kezEJnxm7hOZJROia1G26h1ody0h9CH7C5LhS0=;
        b=qRwVKSh6DR7WRptFXNjIhj5cMG3TOz17cztmkhFI92t3EXjPPyc/o4QZMRVbiucm5G
         yP1gQpnl059eP9sf+tHEuCtwtOcHj/bJOcpbId/q1Z0ShhVRLenjFVDMKHX+sNCLe6n3
         hB1f7at39CLEtelt3ltcIPD9nEuKUjrvKttuBndCoUA5mrs5HNhknJJ/b4m64kZWDDa5
         ywWKKNATQoYwXU4Y4p9XhHYBfRVyaYz3g3Jjo506zr4c2cRDUHWxSiVmBCfk4K5RO1IQ
         g/iu0/wjtyF7rLU0zJXqDC0+rFEnbmEezXtgStb67fzekh2KU8AXxD3G3Kfh3hsTlwLg
         i3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7Rk9kezEJnxm7hOZJROia1G26h1ody0h9CH7C5LhS0=;
        b=sc0NzNmhQjhI7FIFFVPQV7RXvQV+BLO6NYCn9FaCgQfz+GO+tY+434m9eYUWwV2ShD
         F1kpSmeRoH7Dl9pLE5MeEW40BJOcXrBIPw2nka/VMEmv85B+XrxZRnz6ApESfSxIIk6i
         OsJnJi2aVJA47U/hulgHiXocVA1xkkb3e+uJ+Qjr7zaP89FDH1gdXp6x9hqUAcH2skur
         F93zjXBkXI2FpYA3tg3310fE7qffNnvz/azKcned6SPmFV5wGRLBPxM5WkCNczvQxnhh
         v6hcEFjNxDbnmRyRu6jyk7DkH2uvnjFYyRhHF5ivRxmOUWPNZ1MSmwJ5is/rH78+oGPX
         hzDg==
X-Gm-Message-State: APjAAAUKPGmbrzvF3GNnQFUZhNjgYjnaE4F6aMpqJgMB80791PYOgpEL
        0J/8Hhl/ZsDsQp/wfC4P3RHFIaJbivyC3+bkDag=
X-Google-Smtp-Source: APXvYqy8O2zsux+Jz1trdJaiPp75hPXjduLxuOS3ebM6fI5prayKqx5b5HGSM0cJeomB0JtaQtB+hvLYkYw0rl7ylTM=
X-Received: by 2002:a9d:66d0:: with SMTP id t16mr19981068otm.35.1552291980676;
 Mon, 11 Mar 2019 01:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1552252931-10592-1-git-send-email-karen.palacio.1994@gmail.com>
In-Reply-To: <1552252931-10592-1-git-send-email-karen.palacio.1994@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 11 Mar 2019 10:12:48 +0200
Message-ID: <CA+U=Dso8UzRFcHj-2Ss08DmykuXaTzbYmtj3F40tzchgvb7zBw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7192: Add spaces around minus operator
To:     Karen Palacio <karen.palacio.1994@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        lars@metafoo.de, Mircea Caprioru <mircea.caprioru@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 11:23 PM Karen Palacio
<karen.palacio.1994@gmail.com> wrote:
>
> Add spaces around minus operator to fix readibility.
>
> Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07..7c632cf 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
>  }
>
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -                            in_voltage-voltage_scale_available,
> +                            in_voltage - voltage_scale_available,

This isn't broken, but I do agree it should be addressed.
I think it's the second time I see a similar patch trying to fix this.
So, obviously the code is a bit misleading.

>                              0444, ad7192_show_scale_available, NULL, 0);
>
>  static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> --
> 2.7.4
>
