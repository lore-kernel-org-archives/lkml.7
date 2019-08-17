Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E0AC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3217821019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDT/QN6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQGOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:14:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46403 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHQGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:14:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so3386779pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=rtrt6LI0kB9Ic333TWUlAKHRv4Q2jYrB/26Rv0snh/E=;
        b=bDT/QN6cxlVrIY718QCMopmCxupc4zbElQJoF19VhRged6LQpfFYwm69Fvt/N96DBe
         Xe+3a++GYRrHwT3iCyEsZLIrt57nm46uh4bQuQg92232w8Mrgvp8ZEQW9eCH1K1zW08S
         DU7+kgLUaoXHPhpRsljeBIcy84zb54zzGzIe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=rtrt6LI0kB9Ic333TWUlAKHRv4Q2jYrB/26Rv0snh/E=;
        b=lPe7PacfNYIoJQastoKQGStRP0XUe1zbJh2/dAagyFLlqv3i1Y0yCEtgZ5L5bLl4qk
         /0D3aoA3CRlv7/0gtcVtdIiPcMjm9YYfi3tiWu5TgfXy7XFzyp9JLPTV/zo9j1PqoDv9
         AG5+W/72KrJ/DDkzymbajN4fuCEqnheqiA8ukLAoUIZsk1nS5FroCD2P/9JFE2GbTKxx
         /IYGOhCQb/x01PdksJDWqxlnmNNuEoNTupPxb0z97LB/mcXWPmpZ/QJqDgNtDSNUUreu
         jCCYpde6/JYDDOUKs99jl29JNm/RII2FDOXhu13a0eOfFw1Q/b1j/wGiYlhCcyA+1R7p
         pOsw==
X-Gm-Message-State: APjAAAUL4zYMkJqLeTRuXLNKlVbcQBX+yyXoWBrWjOupwbX8ghc+s9Fc
        qTjiK/feirmBD405n4KAwkQnBg==
X-Google-Smtp-Source: APXvYqy6fACf9rLZ9XVYhUtfzGxg+iUKJz3wFEDMst7bInlXADMiIls0FrVXsaO0pvxu6z3GAjazGg==
X-Received: by 2002:a63:460c:: with SMTP id t12mr10639473pga.69.1566022455934;
        Fri, 16 Aug 2019 23:14:15 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cx22sm5709533pjb.25.2019.08.16.23.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:14:14 -0700 (PDT)
Message-ID: <5d579b36.1c69fb81.85eba.ff51@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190725104144.22924-11-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org> <20190725104144.22924-11-niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 10/14] dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 23:14:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2019-07-25 03:41:38)
> +       cpr@b018000 {
> +               compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
> +               reg =3D <0x0b018000 0x1000>;
> +               interrupts =3D <0 15 IRQ_TYPE_EDGE_RISING>;
> +               clocks =3D <&xo_board>;
> +               clock-names =3D "ref";
> +               vdd-apc-supply =3D <&pms405_s3>;
> +               #power-domain-cells =3D <0>;
> +               operating-points-v2 =3D <&cpr_opp_table>;
> +               acc-syscon =3D <&tcsr>;
> +
> +               nvmem-cells =3D <&cpr_efuse_quot_offset1>,
> +                       <&cpr_efuse_quot_offset2>,
> +                       <&cpr_efuse_quot_offset3>,
> +                       <&cpr_efuse_init_voltage1>,
> +                       <&cpr_efuse_init_voltage2>,
> +                       <&cpr_efuse_init_voltage3>,
> +                       <&cpr_efuse_quot1>,
> +                       <&cpr_efuse_quot2>,
> +                       <&cpr_efuse_quot3>,
> +                       <&cpr_efuse_ring1>,
> +                       <&cpr_efuse_ring2>,
> +                       <&cpr_efuse_ring3>,
> +                       <&cpr_efuse_revision>;
> +               nvmem-cell-names =3D "cpr_quotient_offset1",
> +                       "cpr_quotient_offset2",
> +                       "cpr_quotient_offset3",
> +                       "cpr_init_voltage1",
> +                       "cpr_init_voltage2",
> +                       "cpr_init_voltage3",
> +                       "cpr_quotient1",
> +                       "cpr_quotient2",
> +                       "cpr_quotient3",
> +                       "cpr_ring_osc1",
> +                       "cpr_ring_osc2",
> +                       "cpr_ring_osc3",
> +                       "cpr_fuse_revision";
> +
> +               qcom,cpr-timer-delay-us =3D <5000>;
> +               qcom,cpr-timer-cons-up =3D <0>;
> +               qcom,cpr-timer-cons-down =3D <2>;
> +               qcom,cpr-up-threshold =3D <1>;
> +               qcom,cpr-down-threshold =3D <3>;
> +               qcom,cpr-idle-clocks =3D <15>;
> +               qcom,cpr-gcnt-us =3D <1>;
> +               qcom,vdd-apc-step-up-limit =3D <1>;
> +               qcom,vdd-apc-step-down-limit =3D <1>;

Are any of these qcom,* properties going to change for a particular SoC?
They look like SoC config data that should just go into the driver and
change based on the SoC compatible string.

