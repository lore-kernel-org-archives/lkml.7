Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753DFC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB6C208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uONy/nna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfFQLfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:35:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46740 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfFQLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:35:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id l125so5844119vsl.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaMaGenOD4N8b325Sjijr4yZaXPGNKq+TVNXE6cscOU=;
        b=uONy/nnaWJS5YnlekVpZ6hSp62ck/n140Ql6GM+iMx5eXARgkLsu4yUoBGQG4mZMsx
         JPVEPfAUizflPNYzQdAVNWMEA+EAePkbnAJmhUlLB1bc9cmVnPmYGUe8epJp5QRsr7fv
         3fSXKdbmbUX+lHk+i8IZcWgfzItQYtk1ZrzNZcpygYy0Z2Qzk9paEqGWaq+M8yYUov9n
         vpC1pQkpankIn0pzLQ2yYcH5hlWPq7YsyyIzcAvDY/jZDYHlmnHNvaGaRm+o9V74zP+U
         oCm4zuFp1UkSyXq49pkhH3XgX9bG4WBP7ub8KNmwdmacoeTwtN1G7qFUgr+N7SXLJ2iA
         cPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaMaGenOD4N8b325Sjijr4yZaXPGNKq+TVNXE6cscOU=;
        b=WHT3aTQuJn+rC5LzXDz113peij5sEVo61ajBffOn7zkNwn44U16LSqv1yc/e8pM4Hk
         jaPCQCOh/ILV7aLOe9GzZIiHh9y+0A6PtCBQxtegGyE1X8MnAg88D21yhMLjdQIEZWoH
         fCr64Yliq9EJ7att8nX9o00IHv8L1Hww7EvVg0MpxxDHaAchEKUOCTgOFI2Wav/+1CxY
         C+5RIPABHG/FfhcdsZnp0JftJJ695z+0T0j6p9k9RRnZBsVp2UweKotAvAkaxbmW/Hwu
         nepR7Ps4D3I7FebRe6yK9VxH4E4vBvrO8rmveribst/wxXgevvYH3ctCcny2p7tlvoRt
         vt9A==
X-Gm-Message-State: APjAAAUYfrzgWrj/0iT30hLZTIGXbOIm/J+UXLd5pJfMO4+hQcbdYaux
        XBe5fYhypffWW6Poup7qhd3izOuLtSWbRQgdmb4+xg==
X-Google-Smtp-Source: APXvYqy1iw03xovxVxG7DFIiObqWByOSpxIG6znLpJdvU2E+tvGtVv5f1UFVBS4cZkKB5nErh4SPzFnfR6lB6yyVJvQ=
X-Received: by 2002:a67:3254:: with SMTP id y81mr20641150vsy.34.1560771350006;
 Mon, 17 Jun 2019 04:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com> <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1560769448-23070-2-git-send-email-jjian.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:13 +0200
Message-ID: <CAPDyKFoTBhCy2bB8uzzDTNMBPnNjD81134BGt2Op3USFCW1R7Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: mediatek: fix SDIO IRQ detection issue
To:     Jjian Zhou <jjian.zhou@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yong Mao <yong.mao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 13:04, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> If cmd19 timeout or response crcerr occurs during execute_tuning(),
> it need invoke msdc_reset_hw(). Otherwise SDIO IRQ can't be detected.
>
> Signed-off-by: jjian zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>

Applied for fixes and by adding a fixes/stable tag, thanks!


> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index fa7d420..ba1ad5e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1031,6 +1031,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         msdc_track_cmd_data(host, mrq->cmd, mrq->data);
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq);
> +       if (host->error)
> +               msdc_reset_hw(host);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> --
> 1.9.1
>
