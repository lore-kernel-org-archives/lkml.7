Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DDDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3236E2244A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZjogiTmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKSVt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:49:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45526 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSVt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:49:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so10838802pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=+IdtBG0vM6b58lQdlGAw29aN9zlxTF55K1bP64meZnQ=;
        b=ZjogiTmFxyWuXS0yLjc4LhV0tkEvEcDOcQAirXDAlyjEApeQrONCkQQ3TJ1BoD7iAl
         L08lBqJC/VTTlsTESpTzL2wc3J8rTLQoqXN3r+vbeezL/wVTQxKoE2AQfW0Tr8dQlJtN
         m0st7+Eu5yFG+Nb88aCNfy76ry06d9rdLJ1iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=+IdtBG0vM6b58lQdlGAw29aN9zlxTF55K1bP64meZnQ=;
        b=gYvgGK7rfn/t4gD2BhmRGaYKoEl5vM7Pciwc5kfMwDBzUO6Jt3XJClO9yZ8nezRV2H
         Z0p2YnwYxLO0ZKZTwH90QpmA7+CTHph8sly9xYIaVkBahD320t8fD69+Q+QKqVdwKRgf
         wYBmOZz58UY2xpaDOP6hGw++QbLL59AulBJjb6wjtky5YeA/Rv/k2mcqpeVn3zqxs/Ny
         EOHgyhrmPvc9h0IhXL1PGE2/OnqwlTt4DCEd0jxBRfNuTeTO5VShMB0KAmp3u+ggz698
         ACRilvNPQlW0vWFg9mE2eKuE4ptkg9q+Qtr1nBuFng8hzj0iNs3JiY77U/kMYFjR7cEY
         vkRA==
X-Gm-Message-State: APjAAAW8jh5YiZC9rTbwC/6DiQKND5xdajw7Y8bl0eUQT/DP/sUmqHGr
        6weEcqV+Q4820cAdJq6Ud3bOPQ==
X-Google-Smtp-Source: APXvYqxIoMjGGoVsAPpX6KlkDesb3Lzdb/rB/1EIE/jKrWs9FxyOUwuk0gH8St62ZG0PtcAZGvbFsg==
X-Received: by 2002:a63:101f:: with SMTP id f31mr8101183pgl.410.1574200194904;
        Tue, 19 Nov 2019 13:49:54 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 6sm27478923pfy.43.2019.11.19.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 13:49:54 -0800 (PST)
Message-ID: <5dd46382.1c69fb81.2b4d0.03de@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9b17a38238447780199a7902d8ca0943@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-11-git-send-email-eberman@codeaurora.org> <5dcf4109.1c69fb81.ef683.dbd7@mx.google.com> <9b17a38238447780199a7902d8ca0943@codeaurora.org>
Subject: Re: [PATCH v2 10/18] firmware: qcom_scm-64: Improve SMC convention detection
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        saiprakash.ranjan@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     eberman@codeaurora.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 13:49:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting eberman@codeaurora.org (2019-11-15 17:29:03)
> On 2019-11-15 16:21, Stephen Boyd wrote:
> > Quoting Elliot Berman (2019-11-12 13:22:46)
> >> diff --git a/drivers/firmware/qcom_scm-64.c=20
> >> b/drivers/firmware/qcom_scm-64.c
> >> index 977654bb..b82b450 100644
> >> --- a/drivers/firmware/qcom_scm-64.c
> >> +++ b/drivers/firmware/qcom_scm-64.c
> >> @@ -302,21 +302,20 @@ int __qcom_scm_hdcp_req(struct device *dev,=20
> >> struct qcom_scm_hdcp_req *req,
> >>=20
> >>  void __qcom_scm_init(void)
> >>  {
> >> -       u64 cmd;
> >> -       struct arm_smccc_res res;
> >> -       u32 function =3D SMCCC_FUNCNUM(QCOM_SCM_SVC_INFO,=20
> >> QCOM_SCM_INFO_IS_CALL_AVAIL);
> >> -
> >> -       /* First try a SMC64 call */
> >> -       cmd =3D ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,=20
> >> ARM_SMCCC_SMC_64,
> >> -                                ARM_SMCCC_OWNER_SIP, function);
> >> -
> >> -       arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd &=20
> >> (~BIT(ARM_SMCCC_TYPE_SHIFT)),
> >> -                     0, 0, 0, 0, 0, &res);
> >> -
> >> -       if (!res.a0 && res.a1)
> >> -               qcom_smccc_convention =3D ARM_SMCCC_SMC_64;
> >> -       else
> >> -               qcom_smccc_convention =3D ARM_SMCCC_SMC_32;
> >> +       qcom_smccc_convention =3D ARM_SMCCC_SMC_64;
> >> +       if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> >> +                       QCOM_SCM_INFO_IS_CALL_AVAIL) =3D=3D 1)
> >=20
> > Is this asking if the "is call available function" is available by=20
> > using
> > the is call available function? That is recursive. Isn't that why we
> > make a manually open coded SMC call to see if it works? If this isn't
> > going to work we may want to just have a property in DT that tells us
> > what to do.
>=20
> Yes. The reason the open coded SMC call was made was because a fast call
> works better here. __qcom_scm_is_call_available uses standard call, and
> I'll address this in v3.

So there will be a patch before this that makes
__qcom_scm_is_call_available use SMCCC? I still don't get how it won't
be recursive but I'll have to wait until v3 I guess.

>=20
> >> +       BUG();
> >=20
> > This BUG() is new and not mentioned in the commit text. Why can't we
> > just start failing all scm calls if we can't detect the calling
> > convention?
>=20
> Bjorn has requested that the BUG was introduced in v1:
> https://lore.kernel.org/patchwork/patch/1148619/#1350062
>=20

Ok. I'd prefer a WARN_ON() instead but it's not really up to me. At
least mention this in the commit text.

