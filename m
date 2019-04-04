Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1077206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtrR8/wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfDDM4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:56:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33148 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfDDM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:56:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id j10so2243974otq.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NYZMNAPLGU41XgbKnE/RSIbXA6GnVE1WHvYSyKBc/fI=;
        b=HtrR8/wXqvFLY8Rw/1pQtBfDFYcqWS2T8cj1maQwvcH9KzQKZSKkZC/LZJeNaw5JqH
         +luCbddtF9Bz/HnGThWe2L0seGnyPETQi8HD8SGPuLmVVXvOVERkUmfi8M9i2bXlLRra
         0tsIv97C6uTUa+kYLaivZNQjSPyYWw1uYUegIo8rDyFfBz5V10sSkf9aEA1GmSE5zShl
         t7zDRmYv6/B9FadxGGzUqrWXZuPqz6imU7+mMBSvF6tg+mX5zCf9b+VOiqY2ZvJATBB0
         l+1oLbcpFuXP3LdAV0oldgBIql2S2oMinSF2DPfwIGitbmru16tSmZV/iIgkSovu+wZL
         hvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NYZMNAPLGU41XgbKnE/RSIbXA6GnVE1WHvYSyKBc/fI=;
        b=RTJ1/9KOreeIVsWz+MiYOf8XM+ZHxGb/a3tenX5z+tjMCxX0fD9OLQ7Xb8lY3gM0RC
         FS0JjsJof8+uNfyua/mUkUwdykfGbAoWoiq/FAmCjU+a7qfDMJkYBmRAsRAvYJTuVLIo
         ZIZob1n1Py7/GyJ/mEYmbFHHYz3lIjEQzElRpPQAzui6PaQdaxVs/bIU5mBNok31KE1y
         k9l4gPE3n6BpsG62JZM+fFAfIyxpE//Klw7/Bj3em9GD5KMlrDL8nAM6YRs2VDh5CNr5
         jTB45DNsITHTMIMCcgsvPUZfufCI+UN270Md8r+EDitQsExpaTwJkH527XgQAKykAge+
         cwYw==
X-Gm-Message-State: APjAAAW0AAOm1fVb3LyZu+0dbaUhumtdQNopRRRNMrwPAXWzDk10ahb+
        yOMEI2lJfgZ6Q3ye8TwCwEL6jYgmwWc81Y061xyKFyVF
X-Google-Smtp-Source: APXvYqwnm0vn9iU1sY8pFlDjY4NfW3VCGJ9vEI3vUeQUJpUs7na/GiskEPokvYzy6xgrxnQjm+Jeh8UZqQYCZf95X+8=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr4062621otq.139.1554382568206;
 Thu, 04 Apr 2019 05:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190404124414.22846-1-detegr@gmail.com>
In-Reply-To: <20190404124414.22846-1-detegr@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 4 Apr 2019 14:55:56 +0200
Message-ID: <CAMhs-H_qFRQ21VoJjy0r=B2uashkGK2Oyf=UWFo66G0spydkaA@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci-phy: prevent use of uninitialized variable
To:     =?UTF-8?Q?Antti_Ker=C3=A4nen?= <detegr@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        benniciemanuel78@gmail.com, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 2:46 PM Antti Ker=C3=A4nen <detegr@gmail.com> wrote:
>
> Do not use uninitialized variable 'port' when printing an error message
>
> Signed-off-by: Antti Ker=C3=A4nen <detegr@gmail.com>
> ---
>  drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c b/drivers/st=
aging/mt7621-pci-phy/pci-mt7621-phy.c
> index 118302c122ee..aa3ae7777632 100644
> --- a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> +++ b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
> @@ -331,7 +331,7 @@ static int mt7621_pci_phy_probe(struct platform_devic=
e *pdev)
>
>         ret =3D of_address_to_resource(np, 0, &res);
>         if (ret) {
> -               dev_err(dev, "failed to get address resource(id-%d)\n", p=
ort);
> +               dev_err(dev, "failed to get address resource\n");
>                 return ret;
>         }

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
     Sergio Paracuellos

>
> --
> 2.21.0
>
