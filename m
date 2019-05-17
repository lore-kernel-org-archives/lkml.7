Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C9CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B15204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iomWStGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfEQKOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:14:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43723 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfEQKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:14:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so7271403qtr.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zJAY/Pv8Q8rCNwC0Vbgeg982L/4wPTYgnNPmTbKhmDg=;
        b=iomWStGl4iQbx8eysPjAozeB43WumfOwhPB77ZRRDGP/507Zl7PX1Gq7HJ1rJ9Eqlb
         HVJX7hCf6FtmuB82mMUTRb8z4gsMdsm94Bbwk5jKY74u28in3UC3C09azGNKeHNLNEdx
         Se7hyfP11juO1tqPdhboIE+k9wGUduPUC10mzjhJNBokCoUG/NZQhuCkGfOpdUziIQQQ
         XKiTGp25+uJ4xLUhWMDsE+fLqb+x/gbwNLg5CIT7WmhGSPIyHAFycNQ7EzPClNwB7Qwl
         BDtPhmPCodYbrRNYKxnLv7c06tdvUwlx5lKIbVBmg89br/GeOX+lAuwsbf8kxt8W01sd
         gZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zJAY/Pv8Q8rCNwC0Vbgeg982L/4wPTYgnNPmTbKhmDg=;
        b=OOT8SlB1bRzbDK919Pz1rR64f60PBQjaCfF1Ih9lsAp0+8yIwyfsd9Q51m2UqssB6g
         G9DvCYw1mFDdHTGmSOX7RvkW8jzEzKyfCYgqhqfMu0u3UeDPT2eVBr8sVXtre4Cp6nz3
         rTmtVXGRCWGsRoiFeWLNFyYmuVtKqncVFqfZmWbmqlX0z8iAXe4LqukYwGoOOnXYRKzl
         dNhwmq9mryEXPFbLTlaJ9yaq8dOjgEANeZI8qX7ZRWgy8ao+eDiYXy+oOSpKK0HCbuKm
         udQmWT3I1zK7ceatHqJw4xoa505RYgAtspcxJ+MfaNOjt6/o1/2Fac6NvDG5yFuyPMCB
         +zZg==
X-Gm-Message-State: APjAAAUo7Utc9+6X9XRe6Xe0CANrkcQ+ZazjSwCrMZi3FhYPCqEzuTPH
        cgh0Aju782HlIR9FMWFIn3PJ5J+Xou/C/+F/idpNuMd7
X-Google-Smtp-Source: APXvYqz6mT2feKlh8y8KJBFeHaGvmta1tNVLx2J144g2NFmA84lEkdM2Ca/94epR0ewDk42GFLZtxmPXuKFrJ6HDE+g=
X-Received: by 2002:ac8:104:: with SMTP id e4mr47527750qtg.234.1558088051122;
 Fri, 17 May 2019 03:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <1557826556-10079-1-git-send-email-yannick.fertre@st.com> <1557826556-10079-2-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1557826556-10079-2-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 17 May 2019 12:14:00 +0200
Message-ID: <CA+M3ks66kdeCEEzRj9B41YTQQkod5f5p9EgpjUZvnj=q36ak4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: stm32: add supply property
 to DSI controller
To:     =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 14 mai 2019 =C3=A0 11:36, Yannick Fertr=C3=A9 <yannick.fertre@st.co=
m> a =C3=A9crit :
>
> This patch adds documentation of a new property phy-dsi-supply to the
> STM32 DSI controller.
>
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next,

Thanks,
Benjamin

> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt =
b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> index 3eb1b48..60c54da 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
> @@ -40,6 +40,8 @@ Mandatory nodes specific to STM32 DSI:
>  - panel or bridge node: A node containing the panel or bridge descriptio=
n as
>    documented in [6].
>    - port: panel or bridge port node, connected to the DSI output port (p=
ort@1).
> +Optional properties:
> +- phy-dsi-supply: phandle of the regulator that provides the supply volt=
age.
>
>  Note: You can find more documentation in the following references
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -101,6 +103,7 @@ Example 2: DSI panel
>                         clock-names =3D "pclk", "ref";
>                         resets =3D <&rcc STM32F4_APB2_RESET(DSI)>;
>                         reset-names =3D "apb";
> +                       phy-dsi-supply =3D <&reg18>;
>
>                         ports {
>                                 #address-cells =3D <1>;
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
