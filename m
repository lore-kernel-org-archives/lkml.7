Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AD2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F5D222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="No1KvCTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410453AbfJRObZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:31:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfJRObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:31:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so4020391pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=DjG/U9BKkuxjcwKWlSCYriO/UmhBuotz78biqdf5iWM=;
        b=No1KvCTyeV9CU08Ov8gBjr93BqIBAQYrV1Mh4/BIMt/WtSM2oYLybWeA3VK5OHor2o
         5X45uILNIprGFt75ykbOG0sPBKLbphIsDhtS6yeDiPyzjTfpC3aBu9DuiXo0iw53nGaT
         9OttcUidiMzO5mWEWFcrUu04Bydt+np+IEeA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=DjG/U9BKkuxjcwKWlSCYriO/UmhBuotz78biqdf5iWM=;
        b=fJXf2HciUHAkwpmjPoe/v4s8dzhzQssIsQa/e3M0vQNW4QDuMGs7HQ/r4GjUyArRfw
         jjPJ/KzeWQ3uvz6i8gw313nNflWVkivvkQtmPCjbc1Ew4inIXkLi29W0F0bIizG+IJ+V
         1ZICYKvmVRbWPbiP9ee7nCGEu709OoepbtWdUhRzgAkDXQtqH5tKyOjz1fqAH8Fa0Asa
         xW4VXV2I934e10/IwmuEkpCGUWJhXYvBB5+E9Ujq5REEMAas3PWKPmohOU6hOCoiL+Kj
         GBq4easnJHYHoj9oQAOCnjv+FWXHKro5zsL7NdcBlpifzuNqwwfVx7IT548BWL8jyEbp
         FtoA==
X-Gm-Message-State: APjAAAUf4fB8ZltWLmZ+OBnTtAf56JM89c5zEN0kkp53fa69nb1pR41s
        2dnMuAIs1moz3O7RpHDO5zT5hQ==
X-Google-Smtp-Source: APXvYqxptM3aFepoM4tJuPMvzOKHwPl2f7fsuCN51qv6pj7z4Pv+GJhJdm+w2xzRVcF02WA8/ldV7A==
X-Received: by 2002:a17:90a:aa97:: with SMTP id l23mr11538299pjq.7.1571409083037;
        Fri, 18 Oct 2019 07:31:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c16sm6419980pja.2.2019.10.18.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:31:22 -0700 (PDT)
Message-ID: <5da9ccba.1c69fb81.3cae7.0064@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d0fd71fbeff6cd040335846cb65e125a89412d43.1571406041.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1571406041.git.saiprakash.ranjan@codeaurora.org> <d0fd71fbeff6cd040335846cb65e125a89412d43.1571406041.git.saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/2] soc: qcom: llcc: Add configuration data for SC7180
User-Agent: alot/0.8.1
Date:   Fri, 18 Oct 2019 07:31:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-10-18 06:57:08)
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4bd982a294ce..4acb52f8536b 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -91,6 +91,13 @@ struct qcom_llcc_config {
>         int size;
>  };
> =20
> +static struct llcc_slice_config sc7180_data[] =3D  {

const?

> +       { LLCC_CPUSS,    1,  256, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 1 },
> +       { LLCC_MDM,      8,  128, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 0 },
> +       { LLCC_GPUHTW,   11, 128, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 0 },
> +       { LLCC_GPU,      12, 128, 1, 0, 0xf, 0x0, 0, 0, 0, 1, 0 },
> +};
> +
>  static struct llcc_slice_config sdm845_data[] =3D  {

This one should be const too I guess but it's not part of this patch.

>         { LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1 },
>         { LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0 },
> @@ -112,6 +119,11 @@ static struct llcc_slice_config sdm845_data[] =3D  {
>         { LLCC_AUDHW,    22, 1024, 1, 1, 0xffc, 0x2,   0, 0, 1, 1, 0 },
>  };
> =20
> +static const struct qcom_llcc_config sc7180_cfg =3D {
> +       .sct_data       =3D sc7180_data,
> +       .size           =3D ARRAY_SIZE(sc7180_data),
> +};
> +
>  static const struct qcom_llcc_config sdm845_cfg =3D {
>         .sct_data       =3D sdm845_data,
>         .size           =3D ARRAY_SIZE(sdm845_data),

Otherwise looks OK to me.

