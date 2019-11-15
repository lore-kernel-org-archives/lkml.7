Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49634206D6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+hg0LEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKOXpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:45:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36465 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKOXpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:45:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so5736429pls.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=kXOWF2hOb3/7rqhlcEbyPgOoLIssHKsRWuWD+s7f4Mk=;
        b=N+hg0LEiDLpZR1JHyYBMl/j9yOFe0ZBxjdM7MpHVQCian8kpePmieHzQUO68cyecqA
         d3fOig8OLDVDi0BCeS+4wwwTkmOjcJZNUWP8HlPsJolO/UpOx3yCu9f1C989e72DGVGd
         6iBOK98DyHOO2TzJtkIdM1CAX5nLZ1UgIN6Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=kXOWF2hOb3/7rqhlcEbyPgOoLIssHKsRWuWD+s7f4Mk=;
        b=Z3dntwusSBgEl/b3IL0ZtkbydkDkQtMxrwRqsV1sR6A12I82GhwM5Wqzxm2Jigd38D
         wcMHMK0VR676ZVoZu7pTnCxdKzHoHK5lLSVoQeZ6L/6Y6GyhQ1cpNGK4fHsq7IMrW61i
         242CSOSY3Ed9iEnH/HadpEF1glSavoP2hGKDtxZzgLNjNoDtxvFy8G4yW5kJgvI1Dmze
         OX0AZEBix3RYqt4Rn8gW4QQCB2kaQ4ArcYVJV5+UAJaztrFnbKCA8tqX/OUsvail1OZJ
         Wotr9sT3QpeEP+Y3A1wPOJXtehAmRLV8noJicMHWqbU9XUC2bR1XbJW22QxS1Bn/pKg3
         HNKA==
X-Gm-Message-State: APjAAAXMkY2t84479zuGxsT2vreNWaqjesT9H5W1FnSbyglcRbMCqSgy
        EKqA7DsBLOhFWaVOUJTxeOUwgw==
X-Google-Smtp-Source: APXvYqzfhpa9dnTnUtApKLCAjn+CcBjVuT0vCoU21X1BiS3E6fw627ZLvxd+h+HkrmPYOHxgGkUBYA==
X-Received: by 2002:a17:90a:b116:: with SMTP id z22mr22786871pjq.38.1573861517698;
        Fri, 15 Nov 2019 15:45:17 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h13sm12971272pfr.98.2019.11.15.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 15:45:17 -0800 (PST)
Message-ID: <5dcf388d.1c69fb81.bfc02.59ab@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-9-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-9-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 08/18] firmware: qcom_scm-64: Remove qcom_scm_call_do_smccc
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 15:45:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:44)
> Remove thin wrapper to qcom_scm_call_do_smccc because it doesn't do
> enough of anything interesting to dedicate its own function.
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

I don't see the need for this patch. The function was split out in a
patch earlier this year because it was too nested in the calling
function.

>  drivers/firmware/qcom_scm-64.c | 46 ++++++++++++++++++------------------=
------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-6=
4.c
> index f0a5f24..4131093 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -90,31 +90,6 @@ static void __qcom_scm_call_do_quirk(const struct qcom=
_scm_desc *desc,
>         } while (res->a0 =3D=3D QCOM_SCM_INTERRUPTED);
>  }
> =20
> -static void qcom_scm_call_do_smccc(const struct qcom_scm_desc *desc,
> -                            struct arm_smccc_res *res, u64 x5, bool atom=
ic)
> -{
> -       int retry_count =3D 0;

Maybe this can be unsigned given that it's a counter that only
increments.

> -
> -       if (atomic) {
> -               __qcom_scm_call_do_quirk(desc, res, x5, ARM_SMCCC_FAST_CA=
LL);
> -               return;
> -       }
> -
> -       do {
> -               mutex_lock(&qcom_scm_lock);
> -
> -               __qcom_scm_call_do_quirk(desc, res, x5, ARM_SMCCC_STD_CAL=
L);
> -
> -               mutex_unlock(&qcom_scm_lock);
> -
> -               if (res->a0 =3D=3D QCOM_SCM_V2_EBUSY) {
> -                       if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
> -                               break;
> -                       msleep(QCOM_SCM_EBUSY_WAIT_MS);
> -               }
> -       }  while (res->a0 =3D=3D QCOM_SCM_V2_EBUSY);
> -}
> -
>  static int ___qcom_scm_call_smccc(struct device *dev,
>                                   struct qcom_scm_desc *desc, bool atomic)
>  {
