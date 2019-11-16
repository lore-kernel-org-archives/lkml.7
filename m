Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238F7C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1D2206D6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1GqM6VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKPAVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 19:21:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfKPAVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 19:21:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so5763482plt.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=UiFGe1ZptxBlAKxNM72C7gs1lEaFQWlmt9mtqRezKHM=;
        b=Y1GqM6VL0BBiSy4Nlkblk4sJJTHGXh7Ja1fH72VPY0iJZpxMj0Ij0onnQSvRxyFK+f
         ddw/6pJW1Upx1wi451QOlBmvtWKZAQWOJzChMAlkGFppxvTDzC1LSQfwCudoqqE2omH0
         Yk7mD/l1tYMjvi7mhUL7YHG193JvZ4c5ngpqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=UiFGe1ZptxBlAKxNM72C7gs1lEaFQWlmt9mtqRezKHM=;
        b=WHRtxmBoWPZ78MUWfqH0RBWETadHtGtGnHdDKsw73T3R3HfaxXlFnfoz7GkK7ZaBVD
         68+I2S2pnnoa0Y33q8+bJj2Z+wIob+PIBIeDnSe43bGoTm+M+KyokHusVwku68IM2rse
         Un9DZ3fXcDBZLkWsOO3nM4Nqbx/ZZdEfSSAv9PpqF5GzNIvcoBlCd8GDspEq4DQR++vx
         DAy39SWYtASZ9jRnbz5i0CE4G6ZDXbnsU8wc4Vmg7urfMxTdV1Ua3pUo/11lUO8wnFUe
         6VLKTUqlB4+uEui9qahrBvRNINR+J3LKc4KkG6TlV1X8zlogIGCCmdMKCFQrxAFcmT9u
         NwzA==
X-Gm-Message-State: APjAAAVKcD4US+7CkmFbtTpyO9JReJwcMxlUgpZm4XGiX4D9+TOM2DWK
        NnxQJ/lAn5IYdRzkIlt3XtUe2w==
X-Google-Smtp-Source: APXvYqw+wsCa7XS8lSHe7s8aY0RZs/GZA8FpNaIPtlOCDBAb9htlfUSM8Hs0kMLXQOcRQsfU/WEQpw==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr2496208plt.160.1573863690575;
        Fri, 15 Nov 2019 16:21:30 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id hi2sm9313474pjb.22.2019.11.15.16.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 16:21:29 -0800 (PST)
Message-ID: <5dcf4109.1c69fb81.ef683.dbd7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-11-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-11-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 10/18] firmware: qcom_scm-64: Improve SMC convention detection
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 16:21:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:46)
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-6=
4.c
> index 977654bb..b82b450 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -302,21 +302,20 @@ int __qcom_scm_hdcp_req(struct device *dev, struct =
qcom_scm_hdcp_req *req,
> =20
>  void __qcom_scm_init(void)
>  {
> -       u64 cmd;
> -       struct arm_smccc_res res;
> -       u32 function =3D SMCCC_FUNCNUM(QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_I=
S_CALL_AVAIL);
> -
> -       /* First try a SMC64 call */
> -       cmd =3D ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
> -                                ARM_SMCCC_OWNER_SIP, function);
> -
> -       arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_S=
HIFT)),
> -                     0, 0, 0, 0, 0, &res);
> -
> -       if (!res.a0 && res.a1)
> -               qcom_smccc_convention =3D ARM_SMCCC_SMC_64;
> -       else
> -               qcom_smccc_convention =3D ARM_SMCCC_SMC_32;
> +       qcom_smccc_convention =3D ARM_SMCCC_SMC_64;
> +       if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> +                       QCOM_SCM_INFO_IS_CALL_AVAIL) =3D=3D 1)

Is this asking if the "is call available function" is available by using
the is call available function? That is recursive. Isn't that why we
make a manually open coded SMC call to see if it works? If this isn't
going to work we may want to just have a property in DT that tells us
what to do.

> +               goto out;
> +
> +       qcom_smccc_convention =3D ARM_SMCCC_SMC_32;
> +       if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> +                       QCOM_SCM_INFO_IS_CALL_AVAIL) =3D=3D 1)
> +               goto out;
> +
> +       qcom_smccc_convention =3D -1;
> +       BUG();

This BUG() is new and not mentioned in the commit text. Why can't we
just start failing all scm calls if we can't detect the calling
convention?

> +out:
> +       pr_debug("QCOM SCM SMC Convention: %llu\n", qcom_smccc_convention=
);

Maybe pr_info() is more appropriate. PSCI currently prints out the
version info so maybe printing something like "QCOM SCM SMC_64 calling
convention" will be useful for early debugging.

