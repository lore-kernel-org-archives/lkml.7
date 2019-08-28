Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61758C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCC320856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Koe9DZY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfH1Adq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:33:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34517 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfH1Adq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:33:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so491140pfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=Le67xD4dgnHnmjT2Q3611VE0H3J05KajZPLgblKSiFs=;
        b=Koe9DZY0IjEclkzhNeNnInI3BcoZy5V8wzgIBCHfeKqn3z/6j7hSV0G2lZfrmx4J78
         ns6j2gqfk8C7ZJp5eUqllEEw1As5DAcFIcerT9lN/TN5smHccP1uqLhefoE6wTDOnNtt
         0Mr5Nza3tZNdZmPPlnNdiq1XL1g9X+8IGbxF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=Le67xD4dgnHnmjT2Q3611VE0H3J05KajZPLgblKSiFs=;
        b=U/T17p0gc+htLSS4nINukfMzsSGSkKrBRAXJDq8rPSP0p2g4Zz3Oju4EKa7dbOIhsT
         JQMZO0Fw5l3k8FRLdI6vb7merlM//yaM/RrfZNs95RoK8imeScEpCFm0D64b9QA4jli3
         496mVrzfIZVrVMFO74SYo9Aqn7NiD6Wx5mZPE94/EYFnLD8XXxoSPPBSUl7xcRKpnYyj
         9AJBTAVNuBFGsaf45izj0dVACjt1om0QNfLZJZQ/Gm65pmV7WCxCehaz33vBle3oxO27
         fB6iLOImnV/oiInhK0ykWqELb9n3b4QKU6v9n8Z7ddLOlbjHIVqPX+VYDeQK2FEmd5dp
         t1Tw==
X-Gm-Message-State: APjAAAWwft3mNiE9/3eyWzEEa+545El1vS9PmXcqSXEgAhF0Tw+I0Xu+
        6mkhhV5nzVnBsQKDkBO6WVsLqA==
X-Google-Smtp-Source: APXvYqzB3BKq2zBiCNP/tObOHr5KzgQIMNZwDENpW2WLNkldQ8Tmp6AQRyyp83CfnJR25DPGlbmLsQ==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr1054914pgt.337.1566952425481;
        Tue, 27 Aug 2019 17:33:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b5sm485890pfo.149.2019.08.27.17.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:33:45 -0700 (PDT)
Message-ID: <5d65cbe9.1c69fb81.1ceb.2374@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66ac3d3707d6296ef85bf1fa321f7f1ee0c02131.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <66ac3d3707d6296ef85bf1fa321f7f1ee0c02131.1566907161.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/15] dt: thermal: tsens: Document interrupt support in tsens driver
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:33:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:03)
> Define two new required properties to define interrupts and
> interrupt-names for tsens.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/D=
ocumentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 673cc1831ee9d..686bede72f846 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -22,6 +22,8 @@ Required properties:
> =20
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a descripti=
on.
>  - #qcom,sensors: Number of sensors in tsens block
> +- interrupts: Interrupts generated from Always-On subsystem (AOSS)

Is it always one? interrupt-names makes it sound like it.

> +- interrupt-names: Must be one of the following: "uplow", "critical"
>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how=
 to specify
>  nvmem cells
> =20
