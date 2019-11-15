Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E1CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E60D2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NkQvKiCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKOXas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:30:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43658 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:30:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so6653658pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=gSbKMKql5sEqE07IQgKTqMTq9G16VWJ3CxdiQ6od//U=;
        b=NkQvKiCDlxAzjl0sBQbqPC6dIibiAXMCtybhHP7pvXnnksE9DrSG/C93e1uNoJxkEQ
         6BXQcgL/odCwAPKBSbE3r+5aBZgwxudDwH+fI1tnMB8hU6He3fi2Lk58Ag6BfJEyvqfU
         zMl+JEMn9ky8RPW1cru1G5BaEkpM0a301fGt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=gSbKMKql5sEqE07IQgKTqMTq9G16VWJ3CxdiQ6od//U=;
        b=U1Xghc0COaqCZ6kfi7dPdpnmY1V7/VN85cE9iX5UsvwWD+VEsdw8e4XXTjy31YGrVK
         vSpTRGWlPKrNp7KUMijYrYQ+64l6BXR1bBK84si9SdSombDCf0/nxd+uGUrZhVrWweXz
         j83qLLRpzppWx8xblo61FG6NpGH/3palo6GanXMGlfj4ztcuIr+g9RZHuIquWgsf0ULC
         D+ogTNQ/47Q/y4mRXbXwNhft+n4laQ93uiW8O/AZp/Y60WwxT4sdPRIhHiiQJ8+ccIcd
         r+TQ+0xSFD7AmDBxVOchfu16UuRyjiEY1Nsh1qz71+NrVyJD4JQRy3h85iV47Z0lHgBn
         /b0A==
X-Gm-Message-State: APjAAAXTX7/Dm+gmzwaxd1tcdfcmvPm06DgpTPe2F8TAZ9bw6GqeBTsE
        hoQF14HFVdfqb1npwtixMA9M6w==
X-Google-Smtp-Source: APXvYqwD5U2lVQiKyC0uYB6z/gPgwJXPG5mK8PMHOR2GiQV3y/nT0jjVkvX/wzWRLSIZAwqGIprs+g==
X-Received: by 2002:aa7:961d:: with SMTP id q29mr19742795pfg.89.1573860646234;
        Fri, 15 Nov 2019 15:30:46 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o124sm1832653pfb.56.2019.11.15.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 15:30:45 -0800 (PST)
Message-ID: <5dcf3525.1c69fb81.88c99.5986@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-3-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-3-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 02/18] firmware: qcom_scm: Add funcnum IDs
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 15:30:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:38)
> Add LEGACY_FUNCNUM to qcom_scm-32.c and move SMCCC_FUNCNUM closer to
> other smccc-specific macros.
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 8 +++++---
>  drivers/firmware/qcom_scm-64.c | 3 +--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-3=
2.c
> index 5d52641..5077fcf 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -38,6 +38,8 @@ static struct qcom_scm_entry qcom_scm_wb[] =3D {
> =20
>  static DEFINE_MUTEX(qcom_scm_lock);
> =20
> +#define LEGACY_FUNCNUM(s, c)   (((s) << 10) | ((c) & 0x3ff))

Same name comment here. Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

