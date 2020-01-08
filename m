Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27844C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F167120838
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nt1b70vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgAHHDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:03:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37386 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAHHDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:03:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so658253pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 23:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=D87ghgdaSO3k8NnHY1l/nPSvxAChoLFL85zOiWCVIOQ=;
        b=nt1b70vMydunA/QR1B2tf2BIXLFnIBabYtlPrStWr++qSGtx203ggsaQ8g2aawn/Sp
         lvAKA8Iud+EBWvE0Vqa8KhY/8fPBzChYdUQpfn7ZZJxCnJ2/36qCpJbupzJyMLeRncZk
         404Fg2eeY21Q2YtkI9e2f6VQQU1OxeIRWBsBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=D87ghgdaSO3k8NnHY1l/nPSvxAChoLFL85zOiWCVIOQ=;
        b=LLoIinMBoNYOgKb6Ea1OhcooS5KEPPvX6CY+YJrKWsa13AGAPEemWH9qQ+WiYOTlfe
         mRk3CzVWcAX0eKJZmtPI9NKOgyEBCZEB3TqJCwBsudsaassabZybuvbGik4pe2I08Yt7
         uaoKFPXeLQKNpTy9OdYtf1Q0OOfqnmy6ZyiRd81D5rDaVUKqcAV0NoDRh5Ery/8mpclI
         bp3KziW73V9MasgiviQ/pPvWPbIA5fsALsiIhJj0gsuXIZATYwOsmhHqQXebh0mBed7N
         k44oFuOU7TS8X3qjA65bAMTJ2U6cRUkDmmNv3RuPkkYV4SrKYHvJYZff2S1aFtCatCLf
         3Vcg==
X-Gm-Message-State: APjAAAXrS0rYyHVZmVW3ItzhZbokIMa62Vf42ItM+L3j3KnHSdgdVoeb
        eSCiYUkkibq2b0VeLf0llYqnvA==
X-Google-Smtp-Source: APXvYqyq6OeXRylbdYejQHCusXuLDRnnLNmFTBkPgoWcAtjQ0nnYI26XidzZIxVEuJk9eG4XYHpXUg==
X-Received: by 2002:a17:90a:2808:: with SMTP id e8mr2750843pjd.63.1578466981196;
        Tue, 07 Jan 2020 23:03:01 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u18sm2168662pgn.9.2020.01.07.23.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 23:03:00 -0800 (PST)
Message-ID: <5e157ea4.1c69fb81.8361e.6698@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1578431066-19600-18-git-send-email-eberman@codeaurora.org>
References: <1578431066-19600-1-git-send-email-eberman@codeaurora.org> <1578431066-19600-18-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/17] firmware: qcom_scm: Dynamically support SMCCC and legacy conventions
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>, agross@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 07 Jan 2020 23:02:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Nitpick trivia late at night)

Quoting Elliot Berman (2020-01-07 13:04:26)
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 895f148..059bb0f 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -72,6 +72,13 @@ static struct qcom_scm_wb_entry qcom_scm_wb[] =3D {
>         { .flag =3D QCOM_SCM_FLAG_WARMBOOT_CPU3 },
>  };
> =20
> +static const char *qcom_scm_convention_names[] =3D {

Can this be const char * const ?

> +       [SMC_CONVENTION_UNKNOWN] =3D "unknown",
> +       [SMC_CONVENTION_ARM_32] =3D "smc arm 32",
> +       [SMC_CONVENTION_ARM_64] =3D "smc arm 64",
> +       [SMC_CONVENTION_LEGACY] =3D "smc legacy",
> +};
> +
>  static struct qcom_scm *__scm;
> =20
>  static int qcom_scm_clk_enable(void)
> @@ -107,6 +114,143 @@ static void qcom_scm_clk_disable(void)
>         clk_disable_unprepare(__scm->bus_clk);
>  }
> =20
> +static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
> +                                       u32 cmd_id);
> +
> +enum qcom_scm_convention qcom_scm_convention;
> +static bool has_queried __read_mostly;
> +static DEFINE_SPINLOCK(query_lock);
> +
> +static void __query_convention(void)
> +{
> +       unsigned long flags;
> +       struct qcom_scm_desc desc =3D {
> +               .svc =3D QCOM_SCM_SVC_INFO,
> +               .cmd =3D QCOM_SCM_INFO_IS_CALL_AVAIL,
> +               .args[0] =3D SCM_SMC_FNID(QCOM_SCM_SVC_INFO,
> +                                          QCOM_SCM_INFO_IS_CALL_AVAIL) |
> +                          (ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT),
> +               .arginfo =3D QCOM_SCM_ARGS(1),
> +               .owner =3D ARM_SMCCC_OWNER_SIP,
> +       };
> +       struct qcom_scm_res res;
> +       int ret;
> +
> +       spin_lock_irqsave(&query_lock, flags);
> +       if (has_queried)
> +               goto out;
> +
> +       qcom_scm_convention =3D SMC_CONVENTION_ARM_64;
> +       // Device isn't required as there is only one argument - no device
> +       // needed to dma_map_single to secure world

This isn't kernel style for multiline comments. Please use /* and */.

> +       ret =3D scm_smc_call(NULL, &desc, &res, true);
> +       if (!ret && res.result[0] =3D=3D 1)
> +               goto out;
> +
