Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AA4C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 03:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110EA21848
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 03:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="E/xgeOAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfJDDyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 23:54:14 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37659 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbfJDDyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 23:54:14 -0400
Received: by mail-vk1-f196.google.com with SMTP id v78so1170862vke.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 20:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gPgCpIAYJa8p/vY1UkyEnZoeMekLpn4eiArUKNY2gk=;
        b=E/xgeOAsMphC/AV8gSRd0LsfY8+LvGdoxkgrJBnEM8B+UmyPeaF3NbcHIIpeBGc6/P
         Tljzvp0RNW+wd31RlAuYdFOApTPiUJHnU7Ffu7OdTcHWo4XL9OQfXnRdwTK1/3LuJjEV
         cubjToPvH6J6Gy4zKZ+BH2srchI9CoJYlHGqTtUvl+aARv1CWWsvmJ76Kqxchg59IdbC
         6Hr+3W5VUZ8rQQJsOmE7lxEQ2eLbx1VPsYHkLhebqd76BfTZt54hCMOwIE+niV2Z+E8K
         FmYF36qxu+7MV5unn7ljRpznvuiUPTCNF0pJyP7t00I1eDvmXGmT9p8Anz438uxoZSV2
         HkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gPgCpIAYJa8p/vY1UkyEnZoeMekLpn4eiArUKNY2gk=;
        b=DXy5VoxSyYpAGlnNE7OW7E50WvLsCIXpkGpu7UAKTW4FXEUUXJQQ+QJFS4TBNN6BNh
         b1JgBdC2/fztjGjcPLTx1HepZTahT4iDKVtEVU7xU+F+fo+Wl+d0rt3YrHWiCnu9iwMv
         bL/rwOTj+ZLeFjonW5wSR9F0DDy/HypMbEpXfxiSAjSHoWY6wCY2zzfqefGLUre/JVRj
         7Oh5QUeBpXzfRQmPkwyWuYU7ckVVxh0qsFhjwgWfl80tpBHUS6/9z4K3jmAFyFLhfSnv
         AvkP3o7UsdH3jVyCLP2sEzKNJjHw2RUvDh6F9EJrM74LAvrtkN+H3WQo2cqXfp9JLhcH
         tRpA==
X-Gm-Message-State: APjAAAUyvbAEQRp8/MfbcEl6de1J2SiWHC5Ue//m630FlwY4O3nGAjMe
        lfx9K8cq7qfAw1P/6Qouzs2cxyd83nYt0DirUq82LQ==
X-Google-Smtp-Source: APXvYqwPwuXqe3t7ih6EMNyN0uj3L4Kc/6XM37p8JU0DMEQcWc0VWxTEk5XW5aWnyxQ3ZhnPR6xPLaI1/x1x32gkMuQ=
X-Received: by 2002:a1f:bd94:: with SMTP id n142mr7016504vkf.86.1570161252601;
 Thu, 03 Oct 2019 20:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191002190756.26895-1-jeffrey.l.hugo@gmail.com>
In-Reply-To: <20191002190756.26895-1-jeffrey.l.hugo@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 4 Oct 2019 09:24:01 +0530
Message-ID: <CAHLCerOTycP9++w_VPOqVkd7QGY8Jfun4fd0mZqinTPE46+T7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8998-clamshell: Remove retention
 idle state
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 12:44 AM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> The retention idle state does not appear to be supported by the firmware
> present on the msm8998 laptops since the state is advertised as disabled
> in ACPI, and attempting to enable the state in DT is observed to result
> in boot hangs.  Therefore, remove the state from use to address the
> observed issues.
>
> Fixes: 2c6d2d3a580a (arm64: dts: qcom: Add Lenovo Miix 630)
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../boot/dts/qcom/msm8998-clamshell.dtsi      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> index 9682d4dd7496..1bae90705746 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> @@ -23,6 +23,43 @@
>         };
>  };
>
> +/*
> + * The laptop FW does not appear to support the retention state as it is
> + * not advertised as enabled in ACPI, and enabling it in DT can cause boot
> + * hangs.
> + */
> +&CPU0 {
> +       cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
> +};
> +
> +&CPU1 {
> +       cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
> +};
> +
> +&CPU2 {
> +       cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
> +};
> +
> +&CPU3 {
> +       cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
> +};
> +
> +&CPU4 {
> +       cpu-idle-states = <&BIG_CPU_SLEEP_1>;
> +};
> +
> +&CPU5 {
> +       cpu-idle-states = <&BIG_CPU_SLEEP_1>;
> +};
> +
> +&CPU6 {
> +       cpu-idle-states = <&BIG_CPU_SLEEP_1>;
> +};
> +
> +&CPU7 {
> +       cpu-idle-states = <&BIG_CPU_SLEEP_1>;
> +};
> +
>  &qusb2phy {
>         status = "okay";
>
> --
> 2.17.1
>
