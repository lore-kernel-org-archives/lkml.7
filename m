Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F29A20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RG35MDR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfHFKDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:03:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37696 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:03:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so75806210wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=saHnwJEPEd+F/arKfhs2r8U9pbG6AT0WaIKfY/E9KBI=;
        b=RG35MDR8qCFMyh/pKO8aFYZd6Zh4V1UuLdb3jU1w/lXFxhvyhyxaem1hFoUcNEuwCc
         MWVoH6nkxp4cmsH6KyZRiqw2y7C7bO/ZvmMayJoPTXZvt1oAcaS+v6OBxhSA/yWxXhBw
         NsKE4+e1dfojFvtwGrfp6TIPeLJ+p72m0OyzkARCpUlDiE1hXgk8OAKVrokMj5y/+xiv
         /06h7F4yDihJEjsVRYm/LLQg29ETPanI4lIUJe4ftyFDq6445pVgp5APjhI5hs2QfQuP
         y6JZeE1y0C4z79fi+37T0dTrs99Em0r2LHiatlZiv3lWnE/DKXnEWneDpdbt8gEM8QZq
         P5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=saHnwJEPEd+F/arKfhs2r8U9pbG6AT0WaIKfY/E9KBI=;
        b=rcI3ByKk9owpAmOJ5X8BqxURi3+BkS9+d7RpNG+c05FAJ6blJWGJYptcVuPdbLDHW6
         bXmBPUOrLz+dGrUAKfdazlbreJdjocXIKGnJX6D/q6dh6WpOM648p8FKbbwRvzVLjJ20
         MFdBu47PaK37bjs7hQ92dc6rUWD/02q8nbha9JlIS/WTy/+FUJhaZQbtkX6y3Ahlwa50
         qsmiIJoDS3aa95pQWhX5893GvBKx+nSEsqnKS8uNlS0Ywl/l1yhSJbY2uYqtpN/IjIYz
         wmOKyVoRG01L4OUJlcNquGm46QEf3PxDG26gm5FBi3c9acBQRuI06EF6EYX7ZNU3EsAO
         6wZw==
X-Gm-Message-State: APjAAAUVvMZp0NjC+G/BjLVVBI8edaavX92tCPvHMWv/ddGnrjBSbNNk
        ly11CCD9+dFHLt0gMrWVYKWHYh+d6qs=
X-Google-Smtp-Source: APXvYqyw+ZwTXq4NISMpigbJV9u0+mgxHWcVICI7KlKj2LY/qJ9xmtBj3XHR6tzSKUY2m4cnoCSd5A==
X-Received: by 2002:a05:600c:114f:: with SMTP id z15mr3798296wmz.131.1565085813095;
        Tue, 06 Aug 2019 03:03:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f17sm83844975wmf.27.2019.08.06.03.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:03:32 -0700 (PDT)
Subject: Re: [PATCH nvmem 1/1] nvmem: imx: add i.MX8QM platform support
To:     fugang.duan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     gregkh@linuxfoundation.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190704142032.10745-1-fugang.duan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <65afeaaf-f703-02f2-a918-90a8bb8f58b6@linaro.org>
Date:   Tue, 6 Aug 2019 11:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704142032.10745-1-fugang.duan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/2019 15:20, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> i.MX8QM efuse table has some difference with i.MX8QXP platform,
> so add i.MX8QM platform support.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>   drivers/nvmem/imx-ocotp-scu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
> index be2f5f0..0d78ab4 100644
> --- a/drivers/nvmem/imx-ocotp-scu.c
> +++ b/drivers/nvmem/imx-ocotp-scu.c
> @@ -16,6 +16,7 @@
>   
>   enum ocotp_devtype {
>   	IMX8QXP,
> +	IMX8QM,
>   };
>   
>   struct ocotp_devtype_data {
> @@ -39,6 +40,11 @@ static struct ocotp_devtype_data imx8qxp_data = {
>   	.nregs = 800,
>   };
>   
> +static struct ocotp_devtype_data imx8qm_data = {
> +	.devtype = IMX8QM,
> +	.nregs = 800,
> +};
> +
>   static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
>   				     u32 *val)
>   {
> @@ -118,6 +124,7 @@ static struct nvmem_config imx_scu_ocotp_nvmem_config = {
>   
>   static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
>   	{ .compatible = "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
> +	{ .compatible = "fsl,imx8qm-scu-ocotp", (void *)&imx8qm_data },
>   	{ },

Looks like you forgot to add this new compatible to device tree bindings 
at ./Documentation/devicetree/bindings/nvmem/imx-ocotp.txt or forgot to 
add me to CC.

Please resend the patch with it, I can not apply this as it is.

Thanks,
srini

>   };
>   MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
> 
