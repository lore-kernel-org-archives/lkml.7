Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CDC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B6C21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NMEr0qma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfLLVzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:55:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33734 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfLLVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:55:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so161972pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=Dpa7Bv2IFyLwYORRNirY3eVQ4KxGmvpe/YaQEvngR3w=;
        b=NMEr0qma6c/6kVTLxju2qMg0xWHG8kkbt08ftFtiUBQ1qm/oW0ja/FQ91zWLdNf+Ps
         PiO4S9vz9++ABVV8EAuFkP3WCsSfgsvRC5sbwMKTbqjkYOrs08jqULby2ogzFhIX8VPZ
         onPDTc8CC5VbfdCdgFa2OSinGzrxMa3u138WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=Dpa7Bv2IFyLwYORRNirY3eVQ4KxGmvpe/YaQEvngR3w=;
        b=jiZmzE/K9cpur13OcuSmGDW6yHKcjm2AUKi3aAMkW+NkpLe6v43iHZv/mR2PnLch3b
         O2JIlByvGvgFTfJd5n47hcd3S7Aurq2Vi9lJHFVTpBWQszLGHZsnw2ibhJ9g7eFkgkX7
         yiptJvy4J/iLV6xR8vHfOGL47xq0L8PokbnEMx4JO8uM2ofGVWpbp/Ou0h03QizH3Nmw
         +AMjP1v/FhUtD8gOzPPQQiOlPFfTdouPc831OI7jZ/sK36bvRuESZpy8gY33dnjSjSuu
         hvPoglwpiHRDsqkNZa43RQHR/H9PN8uLRbu24kUY7ri+0S+wPOptzEsx7Dus37gqpmcC
         Zd5g==
X-Gm-Message-State: APjAAAX3wMgjU37Z0AOaU3vDb4lRLVH4HghMzPOTOv/0j+Wp1JxsDtm3
        ORL+Um9VmXwHQy004xVG90nwtQ==
X-Google-Smtp-Source: APXvYqxzsGkM8OxtlGB9CXM/LGWGBaSOenCmnex7GiKghYIbAk0mu3wAHZ3/IOmexH3En06G+pQH9Q==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr12377139plk.5.1576187747069;
        Thu, 12 Dec 2019 13:55:47 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j10sm6591737pjb.14.2019.12.12.13.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:55:46 -0800 (PST)
Message-ID: <5df2b762.1c69fb81.e0c63.0f3b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.1.I158061c65974bf0f653ceb79b442b76a1fd64868@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.1.I158061c65974bf0f653ceb79b442b76a1fd64868@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sc7180: Add SoC name to compatible
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:55:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:37)
> Running `make dtbs_check` yells because qcom.yaml says that we should
> have:
>=20
> - items:
>     - enum:
>         - qcom,sc7180-idp
>     - const: qcom,sc7180
>=20
> ...but we're missing "qcom,sc7180".  Add it.
>=20
> Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for =
SC7180 soc")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

