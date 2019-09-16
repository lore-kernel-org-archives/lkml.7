Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165CBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3918206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGBAC2Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfIPTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:43:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45853 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfIPTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:43:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so553354pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=WLp+GPttGVxHZ4bc1E597l7UcWrj5/s8colAd/Zrf1E=;
        b=HGBAC2LzEi2bY7Z5K1cpZPh8ExkzEXavrfUP/mkdESNHmIDONxGqHmbtiXYrdIS+dt
         GZX7uhRA3ZPgYGD2tzXp2i/JLavp1eAt+gwRUkef0S2ToGnZEXw7ID0TeV0i1C6LiYdO
         DUjHMhgwnt3lWZcw7w2FJs7Yl/+tGsBPcK6Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=WLp+GPttGVxHZ4bc1E597l7UcWrj5/s8colAd/Zrf1E=;
        b=IjaJB0a39g9s/0Kv0hgGrGW05+I0lb60H5HOmRdVJx+AJPbu0kYfidyMNcwkQ/h2/Z
         FXYTPoAL1n2XZ0K+nFDvvRqLOfk1UnS4mPItpbUZJLXsQKYNHjfde8LKC+yS+dv3XwPS
         z5ePkukhe1/Ick/5PF8wWvVU9zrbQKs+I89AlPVRoXgqUoTJoTyZIgOH8PhYjGfDM0Qo
         NVb7lwB5mTBb/nkMP6VaUbsU9q0paMoxvkH2gtiYoIrQLdRJ8/pJJ588JS8r4IiDZhXt
         Rz0o7BoLfto0kAASf7JDqC3dHXGDbswly+0X/yHLqkgMCRRnUDMY6xV6CxWMhv/NUabq
         nFGQ==
X-Gm-Message-State: APjAAAW+PYjTu0F7Scd1H228QJ0omFn5CNWqrQSmtyOvw6HlzT8cdsZ1
        kXWhTDrM8pkYbToqYBgb7F24vA==
X-Google-Smtp-Source: APXvYqztr3q/MYD/JI7oKNOvIkdW3WzYP90VrrLrD5c3imzhZHsZTjDfElpIe6ZmcRnXlO+zX1iUZQ==
X-Received: by 2002:a62:8c97:: with SMTP id m145mr9801pfd.241.1568662994612;
        Mon, 16 Sep 2019 12:43:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id em21sm372496pjb.31.2019.09.16.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:43:13 -0700 (PDT)
Message-ID: <5d7fe5d1.1c69fb81.eca3b.1121@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190912091019.5334-1-srinivas.kandagatla@linaro.org>
References: <20190912091019.5334-1-srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        andy.gross@linaro.org, bjorn.andersson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] soc: qcom: socinfo: add missing soc_id sysfs entry
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 12:43:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivas Kandagatla (2019-09-12 02:10:19)
> looks like SoC ID is not exported to sysfs for some reason.
> This patch adds it!
>=20
> This is mostly used by userspace libraries like SNPE.

What is SNPE?

>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c | 2 ++
>  1 file changed, 2 insertions(+)

Hmm I wasn't aware this driver was merged.

>=20
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 8dc86a74559b..876a3f6612a3 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -422,6 +422,8 @@ static int qcom_socinfo_probe(struct platform_device =
*pdev)
>         qs->attr.family =3D "Snapdragon";
>         qs->attr.machine =3D socinfo_machine(&pdev->dev,
>                                            le32_to_cpu(info->id));
> +       qs->attr.soc_id =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u",
> +                                        le32_to_cpu(info->id));
>         qs->attr.revision =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.=
%u",
>                                            SOCINFO_MAJOR(le32_to_cpu(info=
->ver)),
>                                            SOCINFO_MINOR(le32_to_cpu(info=
->ver)));
