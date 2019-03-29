Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049D22184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3J+AA/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfC2ODS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:03:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44221 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfC2ODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:03:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id w5so2379454qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AhLJk/MDv02Fs/iD/1MUcrsjReWxwZYHZH/Zgi7uZ+M=;
        b=g3J+AA/ovBXpHAoMz9u1W2Qu6Qxe+WIq5+YHKJEpuPVkVNs1+gGp2TdotSdSrMpA5z
         a2Z2FWH7kasQw05f03xbuTcAuZFxcZ0seTzIj5Va3EakF+U2oUr45xOqG67kQZMGZdo0
         s787xL0VcTcnTrFNIv+gjrmvf/+LaLY8WmaYGtRezk869oTql+emSRRa2K5+z5qxCYIR
         KY1rvc7HipxOu1EwxeNzYXIU529wSsr/36usVQBk9eEMuFAwBU1+04HoOSYZE2QIPObC
         YsAFIQ4CTOKAVaODfZszfLG0CZEa7UcM7gy6BWnQ3CvtvnXAHGiaLln+AG9R+7zVl/sQ
         fwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AhLJk/MDv02Fs/iD/1MUcrsjReWxwZYHZH/Zgi7uZ+M=;
        b=Og1T/OLyd/U5Fm/FtIkm8+uENfDIKI0417lpatr80JQ2eR8c3ebO2QuZZGJ/tPMBp9
         Ne5jJvS0Owfl94+dxtfYyp1j0q9G41uWz2e2qsPV/6T0FOQoWpmDpWlFjLaFWFxLshh4
         mYqQLIAKuQmQ5lyiY35Zxce3Zg+P84jD6ROILlWk9STwthPXUGFAi42+nlMvYOxdstZ3
         G8M9XFbUSNZ3hRjuFokVzaYT4ShNJEzq5+ThbZTYQJLj/MD1tX20+y/eqHX/P2CxTbSz
         RjhHocKVKZvbRV9e6Kh66YgYGOuvmymIkd50F3ycG1YjAMXdO8nueh1U4KlLhtyitYi5
         nHVQ==
X-Gm-Message-State: APjAAAW5HbY/OBBOEb6syLTp3iTvRnMyUbUpMnWJnQ012+6CpSUA2LYn
        +SC4SrbzVi/9v17FIeKHlVtBofiixZweyMaly5E9g/6b
X-Google-Smtp-Source: APXvYqxn3ZnijDZmnNVutEh82spuR+1c/gC8G4rTTKRYAHemKBBYl1VNekP21xaEc0Igr8Pm+WhKE8W91MtJdldi7EQ=
X-Received: by 2002:a0c:b92c:: with SMTP id u44mr39562381qvf.222.1553868196575;
 Fri, 29 Mar 2019 07:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553863182-6544-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1553863182-6544-1-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 29 Mar 2019 15:03:05 +0100
Message-ID: <CA+M3ks52k=Gj=i662DPzc0OV593xUnRfMiLVH+Bjc63CSSE20Q@mail.gmail.com>
Subject: Re: [PATCH] media: platform: stm32: wait end of transmission
To:     =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 29 mars 2019 =C3=A0 13:40, Yannick Fertr=C3=A9 <yannick.fertre@st.c=
om> a =C3=A9crit :
>
> It is mandatory to write CEC_CFGR only when CECEN=3D0. To protect
> transmission, a check have been added to delayed logical address
> modification. This patch is necessary tp pass all tests of compliance.

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> ---
>  drivers/media/platform/stm32/stm32-cec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/media/platform/stm32/stm32-cec.c b/drivers/media/pla=
tform/stm32/stm32-cec.c
> index 7c496bc..8a86b2c 100644
> --- a/drivers/media/platform/stm32/stm32-cec.c
> +++ b/drivers/media/platform/stm32/stm32-cec.c
> @@ -56,6 +56,13 @@
>  #define ALL_TX_IT      (TXEND | TXBR | TXACKE | TXERR | TXUDR | ARBLST)
>  #define ALL_RX_IT      (RXEND | RXBR | RXACKE | RXOVR)
>
> +/*
> + * 400 ms is the time it takes for one 16 byte message to be
> + * transferred and 5 is the maximum number of retries. Add
> + * another 100 ms as a margin.
> + */
> +#define CEC_XFER_TIMEOUT_MS (5 * 400 + 100)
> +
>  struct stm32_cec {
>         struct cec_adapter      *adap;
>         struct device           *dev;
> @@ -188,7 +195,11 @@ static int stm32_cec_adap_log_addr(struct cec_adapte=
r *adap, u8 logical_addr)
>  {
>         struct stm32_cec *cec =3D adap->priv;
>         u32 oar =3D (1 << logical_addr) << 16;
> +       u32 val;
>
> +       /* Poll every 100=C2=B5s the register CEC_CR to wait end of trans=
mission */
> +       regmap_read_poll_timeout(cec->regmap, CEC_CR, val, !(val & TXSOM)=
,
> +                                100, CEC_XFER_TIMEOUT_MS * 1000);
>         regmap_update_bits(cec->regmap, CEC_CR, CECEN, 0);
>
>         if (logical_addr =3D=3D CEC_LOG_ADDR_INVALID)
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
