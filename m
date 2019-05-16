Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D85C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37F020833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoYgQMNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfEPLqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:46:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45315 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfEPLqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:46:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so2765223lja.12;
        Thu, 16 May 2019 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YTu9UrMZBuGZUICk0h5ufsKKVuAqbM3thnFJkrTeAE=;
        b=YoYgQMNP2NxEvzHh4e8cmSlEpysOdip71UP8yT1Ghwrc6fEpJX0/7w1FBKsg6wSaX2
         7JGbu747/mkJzruY9GpL0OWnqSxaAbadcWJprNqD5seyLQggL+iIEl6Fh7goIdzaKZmK
         CfgaZiWLyQiyO8+UGEuAdcjA+2WcGSuIITZd+u+NIjq2feclXtjHNgGfO+XtnkTiFHRW
         jQgx2BrXa4fMLehI3OmYOiGFPlqzl2SxS+/jaJtbOuDBzIbMC5MbTr39gtSbrpTx7JBL
         YHgRpICumkdMvneunyfvGZY2lkti89Qm+CrHdtkNXfR2ZLsEf8HejhZSxdKqPI5PM76W
         OEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YTu9UrMZBuGZUICk0h5ufsKKVuAqbM3thnFJkrTeAE=;
        b=RcSrR0KOq6mhmCf+PaV1xyqqVDZVISwdFK7Vm03e2K3V6QmZn7fpktNVNtLjHbZOd9
         Ur5wCfGbnW+7W4rX1X/kFGSmdQMv4sq/h9kP/kT4cxUP726Ct6XZRDDkIzWGVquYuKoX
         aSG1/8eqCQBLuwIS9rSW7MO0ozNUZl4T4jTBXDx4O8hqvRawiNvj7hCLQ95PDf/Db+Zn
         uCh1gO2e/xWQiAATVi5Rq/gV/X89cI03AfnBLv4QiDhBPGDCojMwf7nDYUdGemxpXrKi
         eEWStGVyjGcbw1XUMwgMJD00mgkVTHQxittMGXS6LIEZAbRZm+t6bcOl/n8/LB4tIZRD
         WEig==
X-Gm-Message-State: APjAAAUvihM3Za9NJ1aESG3X0fplck897DXS3mtUHu3DSuXVNxVnOaoA
        AerbKX9nD+lm6Tkgv+DxyP8tBtsksppFFBfdQ1dK+O5g
X-Google-Smtp-Source: APXvYqyOTc7WTRsHVZRRQRytwwDnDnOSVzcOLQVDwUcky2CN7MLQfiAG/p4Ojo7rUwnebX/5KBfJwYRza/rrOsR8DGE=
X-Received: by 2002:a2e:994:: with SMTP id 142mr15627606ljj.192.1558007206878;
 Thu, 16 May 2019 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
In-Reply-To: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 08:46:36 -0300
Message-ID: <CAOMZO5A7Xtg_pV2VAfmw5NacpRLS=0aGMAazu8p8tOTfa9PrCA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V5] ASoC: cs42xx8: add reset-gpios in binding document
To:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[You should always submit dt-bindings patches to Rob and to the
devicetree list as indicated by checkpatch]

On Thu, May 16, 2019 at 8:42 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> Add reset-gpios property, which is optional.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

> +Optional properties:
> +
> +  - reset-gpios : a GPIO spec to define which pin is connected to the chip's
> +    !RESET pin
> +
>  Example:
>
>  cs42888: codec@48 {
> @@ -25,4 +30,5 @@ cs42888: codec@48 {
>         VD-supply = <&reg_audio>;
>         VLS-supply = <&reg_audio>;
>         VLC-supply = <&reg_audio>;
> +       reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;

Reviewed-by: Fabio Estevam <festevam@gmail.com>
