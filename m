Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2E9C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAF8208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAsJ4EQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfENHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:54:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39820 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfENHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:54:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id v7so5843436ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf8IJjcdPrQOgX1z3j6gO2WdWT6UVn+L7AhNfe6yMi8=;
        b=IAsJ4EQAYOn036lV8psLdhXQfclTm/pOQHGolyhy+F/M9PN51UF1V/AzbmQ2+szdeA
         50WNp67zAeq6LM46Rm5S8gA77LBMEMw1JsVn/tpSuW3Fmn2xta1oG5hpd6oQAlItiBS0
         V7wGhDfi+6qvy0RGWnt2gDFdS1UQBmLgdXkSmdDpeafokFQHUZoUqTZIOHCETe6JfFAC
         a7PnXUppJHzhn2AVGetOalutM2jS6ypHR9488igXkCBQ8h9ghd/iSRHKRauDRdWVhy3O
         1dBuucve8gsrdUniXl3OAxGA0NC4JSN5HrSsxuOzyO7z9KI/68uSfGyLt3t1vA/hmfgL
         34qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf8IJjcdPrQOgX1z3j6gO2WdWT6UVn+L7AhNfe6yMi8=;
        b=tGRuPylhniiroFAP8XonLoW9DyF/KqsuOxAqoCJ0G7TLJPwsFnYdDQd5ainCEdBlFE
         zK2djAvuW2G/Eq+by+i2f8WPBAfFdtqqPTu61QanPhtxT6DCmPxD85+iZVDUUxmIAAgq
         9kFTJUYgTQH/d5StbcLJIBahJSOWMb7uz2vnUnAv59MdBaTOk2ipfUdHPay7cDsPvbBx
         HTOaBrR4Yu+j2BIZ+AVpvzjNS/w/gYJXkLS/DzS8+aU50zJxqQnxuUNTsYSsP0amSsc+
         i4Ubjt7LrrH1bEEIck3rXcA3QpLgTRclAs54w5UyqVfOYCjFdTBWXlPLw/QG9zwJzJue
         ksgA==
X-Gm-Message-State: APjAAAXl52Tzee188sq+N3SGW4rU5urscRSDmHviVKFv+l7LVBwXN3EH
        kgZRup36yZKXNUWtqDnAymVtKs9LX9J0mxSARYTNWw==
X-Google-Smtp-Source: APXvYqw26na4iAl9OES8/pXHjHR4OX/mYE4JxGMYMoMM698JgOYmYEnp2SYDxqwKYvDyL7iTIXPA7w04vcm/XFFuFFI=
X-Received: by 2002:ab0:30a1:: with SMTP id b1mr13121475uam.104.1557820450699;
 Tue, 14 May 2019 00:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190320094918.20234-1-rnayak@codeaurora.org> <20190320094918.20234-9-rnayak@codeaurora.org>
In-Reply-To: <20190320094918.20234-9-rnayak@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 May 2019 09:53:34 +0200
Message-ID: <CAPDyKFppirfM7B9TB=jZzo67E=rdMnfVKEjdv0wn1zBAUoY_HA@mail.gmail.com>
Subject: Re: [RFC v2 08/11] arm64: dts: sdm845: Add ufs opps and power-domains
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 at 10:50, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add the additional power domain and the OPP table for ufs on sdm845
> so the driver can set the appropriate performance state of the
> power domain while setting the clock rate.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 027ffe6e93e8..a3af4a1757b4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1140,6 +1140,21 @@
>                         };
>                 };
>
> +               ufs_opp_table: ufs-opp-table {
> +                       compatible = "operating-points-v2";
> +
> +                       opp-50000000 {
> +                               opp-hz = /bits/ 64 <50000000>;
> +                               required-opps = <&rpmhpd_opp_min_svs>;
> +                       };
> +
> +                       opp-200000000 {
> +                               opp-hz = /bits/ 64 <200000000>;
> +                               required-opps = <&rpmhpd_opp_nom>;
> +
> +                       };
> +               };
> +
>                 ufs_mem_hc: ufshc@1d84000 {
>                         compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
>                                      "jedec,ufs-2.0";
> @@ -1148,7 +1163,7 @@
>                         phys = <&ufs_mem_phy_lanes>;
>                         phy-names = "ufsphy";
>                         lanes-per-direction = <2>;
> -                       power-domains = <&gcc UFS_PHY_GDSC>;
> +                       power-domains = <&gcc UFS_PHY_GDSC>, <&rpmhpd SDM845_CX>;

You probably want to use "power-domain-names" as well.

[...]

Kind regards
Uffe
