Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1069DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17EF22440
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLJqUgxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKSWFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:05:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44908 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:05:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so12661669plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=w35uR4S5yvW+gEl8iFL2UMaC6KbH2ijDF7KVdoKBW8o=;
        b=GLJqUgxhCv+fJa5gKVieXOAupgyG2OKQJEwAO6IMgsFk85mkmGxDmbOiYt0T2dM2kb
         djRLMAjfPo7XuD/YYwPbfeu3RXVh32KTDejtZPxBTQTAMuJtTdI1kgnKbCsHivlVWv95
         efj3/kVRZgVeCKK1z5L3u4J10RvVukxnT12LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=w35uR4S5yvW+gEl8iFL2UMaC6KbH2ijDF7KVdoKBW8o=;
        b=apgBt+vHBBrheFQQtk0wYJ+YhygxYwHuGxw1gyaq0JRdNnZfW97wczfSTvFpmjA9C+
         TT5rtjKStEaPl7Qn6j8hjVBOImSbLuPtqOXakgM3Ajl3vqZAdTyXlR3377UpGTlVbNLr
         5Oc+lgzRVU4/oCg0GH0uteTx6eBo4NtJk1/KItam2m8dFjVdymyttlpnCFqRjGorUVVC
         CUXeXeeiyoU9wsauozUHOJ7n6NZR3kW29Xb73/j5HNH1fEAL1sHeth2+Obmp20g8ZZam
         niaHQPZncrIBNquCMvriDTL3cg8nsn0vP1OmVWHQbZ7cg5l/K2oGLe18K0k4DlIwtywz
         g0zA==
X-Gm-Message-State: APjAAAVZJz3N8QDRrJ77aiXS2JuvleIIBFIV+Y6dmj6jsSt4utVh4Qs3
        8iMxIM26izkUUSXw3k1uR/P2OP7Hvzc=
X-Google-Smtp-Source: APXvYqy+HJ3AU0DqSC8xJrcXfT1ahsaVkUj9XIc4BXS/vHt4qa9LB3Pq3Ums5TyTKTDzqeQUYGfchA==
X-Received: by 2002:a17:90a:3d01:: with SMTP id h1mr9649495pjc.15.1574201113733;
        Tue, 19 Nov 2019 14:05:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a26sm26310704pff.155.2019.11.19.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:05:13 -0800 (PST)
Message-ID: <5dd46719.1c69fb81.ccbc2.f01d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-14-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-14-git-send-email-eberman@codeaurora.org>
Subject: Re: [PATCH v2 13/18] firmware: qcom_scm-32: Move SMCCC register filling to qcom_scm_call
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 14:05:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:49)
> - Move SMCCC register filling to qcom_scm_call so that qcom_scm_call_do
>   only needs to concern itself with retry mechanism.
> - Use arm_smccc_args struct in atomic variants as well.

This is two things. Please split the patch.

> @@ -266,10 +272,14 @@ static int qcom_scm_call(struct device *dev, struct=
 qcom_scm_desc *desc)
>  static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
>  {
>         int context_id;
> +       struct arm_smccc_args smc =3D {0};
>         struct arm_smccc_res res;
> =20
> -       arm_smccc_smc(LEGACY_ATOMIC_ID(svc, cmd, 1), (unsigned long)&cont=
ext_id,
> -                     arg1, 0, 0, 0, 0, 0, &res);
> +       smc.a[0] =3D LEGACY_ATOMIC_ID(svc, cmd, 1);
> +       smc.a[1] =3D (unsigned long)&context_id;
> +       smc.a[2] =3D arg1;
> +       arm_smccc_smc(smc.a[0], smc.a[1], smc.a[2], smc.a[3],
> +                     smc.a[4], smc.a[5], smc.a[6], smc.a[7], &res);
> =20
>         return res.a0;
>  }
> @@ -287,10 +297,15 @@ static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, =
u32 arg1)
>  static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
>  {
>         int context_id;
> +       struct arm_smccc_args smc =3D {0};
>         struct arm_smccc_res res;
> =20
> -       arm_smccc_smc(LEGACY_ATOMIC_ID(svc, cmd, 2), (unsigned long)&cont=
ext_id,
> -                     arg1, arg2, 0, 0, 0, 0, &res);
> +       smc.a[0] =3D LEGACY_ATOMIC_ID(svc, cmd, 2);
> +       smc.a[1] =3D (unsigned long)&context_id;
> +       smc.a[2] =3D arg1;
> +       smc.a[3] =3D arg2;
> +       arm_smccc_smc(smc.a[0], smc.a[1], smc.a[2], smc.a[3],
> +                     smc.a[4], smc.a[5], smc.a[6], smc.a[7], &res);
> =20
>         return res.a0;
>  }

Why are we changing the above two hunks? It's the same code with more
lines right?

