Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AD6C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D677422CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XR6mmmgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfHSR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:59:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37497 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:59:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so1604164pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=SJOOj6olxFQRqjrRfjeJgYnys/AXxatkSyB1FQQ9L/Q=;
        b=XR6mmmgNNI2WavLy9/anETqmroNgKCK8LiC4+iFowHiVpZgmWbqyiEYy9IPM1CcHDK
         bHb3Kgtya/1X7BARqYZEzum94Cj+ENuckx2Ja7F71V9iahCof6NgLEyzxBnu3Ia0hFeH
         IGHW1m15ZLmZdnJmziTSdGSEmVpcxmMARdMdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=SJOOj6olxFQRqjrRfjeJgYnys/AXxatkSyB1FQQ9L/Q=;
        b=lrosqo/vdTMJXgO4KhsIIm09cStFUtfBQrC6DqjtvAZJO3YAEwZ8uQYnMmjxhQfnC0
         77dINQWvZlZgRss5XcOEtGV3wVYOPb13vWBQVYZvhwGcAaxSetatjBpqbFet/nEN1Lm7
         wTTguvdqF6HEG699HzJ/9k5ah529+tj+/y3KEZ+1UYut1YoR82gEeOutPUMPmbCPZu+2
         x/80FMyoIoEj+tTI8HnFNVoQ/nTJnycM5lApi1n1GdTmvBXkARlqiTix3Gg8nQnB1JU3
         kyjGmUUPDzHBGy3PjqEL7PPxi7tuiW73jus0AlfAI/Ydawy9Yg2mFbh/1Ppxo3SVjwqB
         yBSw==
X-Gm-Message-State: APjAAAWa86YalfOMU06wgY694KmrEz6ECvc77brrLxzst1443JrMgT3y
        ga7kxg5qts2+1H19YGDSQEKGnw==
X-Google-Smtp-Source: APXvYqzTOYVM7Zk78xk9eKa8c8LP/wSZ2lxqVDb2CVkjo0gNjyjiFXmm7q3184wtTzkvQK+Otp9tCw==
X-Received: by 2002:a17:90a:c20e:: with SMTP id e14mr23074735pjt.0.1566237578018;
        Mon, 19 Aug 2019 10:59:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ck8sm13839498pjb.25.2019.08.19.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:59:37 -0700 (PDT)
Message-ID: <5d5ae389.1c69fb81.cb730.3225@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819100957.17095-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-7-niklas.cassel@linaro.org> <20190819100957.17095-1-niklas.cassel@linaro.org>
Subject: Re: [PATCH v3 06/14] dt-bindings: cpufreq: qcom-nvmem: Support pstates provided by a power domain
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:59:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2019-08-19 03:09:57)
> +
> +soc {
> +....
> +       cprpd: cpr@b018000 {

Maybe node name should be 'avs' for the industry standard adaptive
voltage scaling acronym?


> +               compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
> +               reg =3D <0x0b018000 0x1000>;
> +               ....
> +               vdd-apc-supply =3D <&pms405_s3>;
> +               #power-domain-cells =3D <0>;
