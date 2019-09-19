Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E4421925
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5/C+5MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfISA55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:57:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44880 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfISA55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:57:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so1075302pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=Yjz5L/ozymWepEMwnwlA62WqR6UE9MQbd1808aWPyz0=;
        b=h5/C+5MFbuEwtpGziR7U/66WRa03Ik7sX99oDvEOGxBQbCv7MSfNP55RcbQ62ZvTQp
         UH4PZC/3lYFlRNwYwHbtx48DVWG2PzdC5NbpXvh7FwalNwN4O8AGckupbMYY7oQN23c+
         tGIyYD5CwrHX5GjgsKALa3HoeJOLfM0MjVwzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=Yjz5L/ozymWepEMwnwlA62WqR6UE9MQbd1808aWPyz0=;
        b=g8c9u8oCHwf+7nkO1/+3IYqmUl8on4kUp1e6aZXha8oLrhpGREcabRvGbN2uuGVhnW
         1iEGUbrruVLBm2WdcBUgh4dPiu9RwRxZ8yStX9dUuYfEp6riTyR08+h5h1oVWpNrvN6Q
         0PZsjc8VTUB1ZgWW/v0eKLns9KyPfRm7rWqiNHInSi48UFwPRX9BkYABt2HPGCfyryYB
         9m4iQITLMy5FnjsjtOtaJcz2v8DGlKNGj95f/I2na5FUITyKwO6HeaNPP375osVbjQVV
         QWBbzW9qHiFnLq06cy2G0C4eP0ngIt/CDgDcZ4qbIcVGt8k2bh7ZLMB6xn3eOneM49Kx
         4WLw==
X-Gm-Message-State: APjAAAVHxkuXlFgrdcvPwp0fOiuzD2zoBSykkZohaTGHJtT2fkZKF28L
        gbbsf3iPX5kt2uZEu9qmbUThvQ==
X-Google-Smtp-Source: APXvYqzZCvp5DCLQzQoL1v/l8sqwapRkBg8n0RTm+rxsZBtu5UIPpwB536sRL+I8xYtZRRUN0+bSfQ==
X-Received: by 2002:aa7:8f14:: with SMTP id x20mr7478238pfr.223.1568854676630;
        Wed, 18 Sep 2019 17:57:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q2sm10853727pfg.144.2019.09.18.17.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:57:56 -0700 (PDT)
Message-ID: <5d82d294.1c69fb81.23c8c.8c61@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org> <1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
User-Agent: alot/0.8.1
Date:   Wed, 18 Sep 2019 17:57:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-09-17 02:45:04)
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 3f88cd078dd5..d62da270f430 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -9,7 +9,6 @@
> =20
>  #include "arm-smmu.h"
> =20
> -
>  static int arm_smmu_gr0_ns(int offset)
>  {
>         switch(offset) {

Why is this hunk still around?

> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> new file mode 100644
> index 000000000000..24c071c1d8b0
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -0,0 +1,51 @@
[...]
> +struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +       struct qcom_smmu *qsmmu;
> +
> +       qsmmu =3D devm_kzalloc(smmu->dev, sizeof(*qsmmu), GFP_KERNEL);
> +       if (!qsmmu)
> +               return ERR_PTR(-ENOMEM);
> +
> +       qsmmu->smmu =3D *smmu;
> +
> +       qsmmu->smmu.impl =3D &qcom_smmu_impl;
> +       devm_kfree(smmu->dev, smmu);

This copy is interesting but OK I guess cavium does it.

> +
> +       return &qsmmu->smmu;
> +}
