Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9381218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CPOXpemR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfB1TfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:35:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33810 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfB1Te7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:34:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so10208460pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:to:subject
         :message-id:references:from:cc:user-agent:date;
        bh=uDF2AtBbzy8TprTlkTtvocuuWMknSqpyhfqW/pU0Rfs=;
        b=CPOXpemRgDyl87PCPs/LDMrQKY6wvfxNSC2WxgOQmoQxNsu6n0eoSHv4An0DRCMBTZ
         RGl8rD27q2pwKyadIArfrO96sqeROqYzACtSHl5//BJAstVDriw0/iW2Zuk8ascl8VO9
         RQyplD2NaDVsSmJgB8CAMchaRpcYoFLx5tVc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:to:subject:message-id:references:from:cc:user-agent
         :date;
        bh=uDF2AtBbzy8TprTlkTtvocuuWMknSqpyhfqW/pU0Rfs=;
        b=RE1EJiqU6hVO+PoWlNlwYmkafVUF+nXgq57ijHqivyZmlKaD7rnN/GJcrl8k8dWvU/
         Fw19u5aF7vgy5/Yfso01IA3PbAnRsiq0lzNY6QsWOnHJsEr1VtrIJKbC547nyk6XrzEy
         geyUVvGnethmNr3Uhx/osRv2ehlDE1I8hGftDBMhJLzvNtbf7vrYqBaISjMUWk9JIGb0
         AdM3aRyrIVALSrzo7IZB19+kLv5lUFX5W9ub5K50iNxGIwmLyL2y59qf+OpBe1Leiyd6
         OaeN62CS3t5wA5pT5cT16ds0e1tLYoBMHevU7zL38UMdc9aaUOnvO0mqfdcnUHll0EoL
         g2hw==
X-Gm-Message-State: APjAAAWihPT6WMyREQjYB7KnhRlE7Kagp4c7/U2IHeMssguBVuA0+8xA
        28oIPKtU9ROtLiOOX/8QeVOmKg==
X-Google-Smtp-Source: APXvYqw4a5jUv1G9SA7hiSB+aUmwiZQRrJnfFXbc3YNnkyQIvZwKRhUfVgDd1n+OjoxH48ho/LLyOw==
X-Received: by 2002:a63:f5f:: with SMTP id 31mr798607pgp.186.1551382498395;
        Thu, 28 Feb 2019 11:34:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g3sm25875136pgg.41.2019.02.28.11.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:34:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190225065044.11023-4-vaishali.thakkar@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org
Subject: Re: [PATCH v4 3/5] soc: qcom: Add socinfo driver
Message-ID: <155138249693.16805.4376975971704887156@swboyd.mtv.corp.google.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-4-vaishali.thakkar@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Imran Khan <kimran@codeaurora.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
User-Agent: alot/0.8
Date:   Thu, 28 Feb 2019 11:34:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-02-24 22:50:42)
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index f80d040601fd..efe0b053ef82 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -971,11 +972,18 @@ static int qcom_smem_probe(struct platform_device *=
pdev)
> =20
>         __smem =3D smem;
> =20
> +       smem->socinfo =3D platform_device_register_data(&pdev->dev, "qcom=
-socinfo",
> +                                                     PLATFORM_DEVID_NONE=
, NULL,
> +                                                     0);
> +       if (IS_ERR(smem->socinfo))
> +               dev_err(&pdev->dev, "failed to register socinfo device\n"=
);

But we don't fail the probe? Maybe a comment should be added indicating
why it's ok to not fail here, and dev_err should be changed to dev_dbg()
then.

> +
>         return 0;
>  }
> =20
>  static int qcom_smem_remove(struct platform_device *pdev)
>  {
> +

Nitpick: Drop this change? Or add the code to remove the socinfo device
that is created in probe?

>         hwspin_lock_free(__smem->hwlock);
>         __smem =3D NULL;
> =20
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> new file mode 100644
> index 000000000000..02078049fac7
> --- /dev/null
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -0,0 +1,197 @@
[...]
> +
> +struct soc_of_id {
> +       unsigned int id;
> +       const char *name;
> +};
> +
> +static const struct soc_of_id soc_of_id[] =3D {
> +       {87, "MSM8960"},

Nitpick: Please space out the numbers and strings:

	{ 87, "MSM8960" },

> +};
> +
> +static const char *socinfo_machine(struct device *dev, unsigned int id)
> +{
> +       int idx;
> +
> +       for (idx =3D 0; idx < ARRAY_SIZE(soc_of_id); idx++) {
> +               if (soc_of_id[idx].id =3D=3D id)
> +                       return soc_of_id[idx].name;

Why is it called soc_of_id? Is that supposed to be "SoC of ID" or is it
DT based and is "SoC OF ID"? If it's the latter, I'd prefer some non-DT
type of name to provide more clarity that this has nothing to do with
DeviceTree.

> +       }
> +
> +       if (IS_ERR(soc_of_id[idx].name))
> +               dev_err(dev, "Unknown soc id\n");
> +
> +       return NULL;
> +}
> +
> +static int qcom_socinfo_probe(struct platform_device *pdev)
> +{
> +       struct qcom_socinfo *qs;
> +       struct socinfo *info;
> +       size_t item_size;
> +
> +       info =3D qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
> +                             &item_size);
> +       if (IS_ERR(info)) {
> +               dev_err(&pdev->dev, "Couldn't find socinfo\n");
> +               return -EINVAL;

Why not return PTR_ERR(info)?

> +       }
> +
> +       qs =3D devm_kzalloc(&pdev->dev, sizeof(*qs), GFP_KERNEL);
> +       if (!qs)
> +               return -ENOMEM;
> +
> +       qs->attr.family =3D "Snapdragon";
> +       qs->attr.machine =3D socinfo_machine(&pdev->dev,
> +                                          le32_to_cpu(info->id));
> +       qs->attr.revision =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.=
%u",
> +                                          SOCINFO_MAJOR(le32_to_cpu(info=
->ver)),
> +                                          SOCINFO_MINOR(le32_to_cpu(info=
->ver)));
> +       if (le32_to_cpu(info->fmt) >=3D 10)

Maybe this would make more sense if it was written with item_size and
offset of info->fmt? Something like

	if (offsetof(struct qcom_socinfo, serial_num) <=3D item_size)

> +               qs->attr.serial_number =3D devm_kasprintf(&pdev->dev, GFP=
_KERNEL,
> +                                                       "%u",
> +                                                       le32_to_cpu(info-=
>serial_num));
> +
> +       qs->soc_dev =3D soc_device_register(&qs->attr);
> +       if (IS_ERR(qs->soc_dev))
> +               return PTR_ERR(qs->soc_dev);
> +
> +       /* Feed the soc specific unique data into entropy pool */
> +       add_device_randomness(info, item_size);
> +
> +       platform_set_drvdata(pdev, qs->soc_dev);

Weird, this is setting it to qs->soc_dev....

> +
> +       return 0;
> +}
> +
> +static int qcom_socinfo_remove(struct platform_device *pdev)
> +{
> +       struct qcom_socinfo *qs =3D platform_get_drvdata(pdev);

And then extracting this as qs only...


> +
> +       soc_device_unregister(qs->soc_dev);

And so it looks wrong? Probably already have qs->soc_dev from the
platform_get_drvdata() call?

> +
> +       return 0;
> +}
> +
> +static struct platform_driver qcom_socinfo_driver =3D {
> +       .probe =3D qcom_socinfo_probe,
> +       .remove =3D qcom_socinfo_remove,
> +       .driver  =3D {
> +               .name =3D "qcom-socinfo",
> +       },
> +};
> +
> +module_platform_driver(qcom_socinfo_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm socinfo driver");

Maybe write socinfo as SoCinfo here?

> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-socinfo");
