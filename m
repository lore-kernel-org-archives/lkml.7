Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF43C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A7B20732
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SS09XMCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKPAlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 19:41:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42640 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKPAlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 19:41:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id j12so5796355plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 16:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=9yDnCue+dWr9HxY0N6Q2Pch2FE87EcvqUib0TtR7pSQ=;
        b=SS09XMCCT188I3/yk/6QftNMC9IzPDYnQmdpD8FJApyiRworrCIHWetparqWbZqWfh
         sE82EvbhMwpgbLEHsZ261itWPBv2wNpDGEFunxQYMSVby8PR3RU1562IzkkAROSbXOjn
         IyKeUAD0YV6+aWB43jPUxzP0vmTiJL/RssgK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=9yDnCue+dWr9HxY0N6Q2Pch2FE87EcvqUib0TtR7pSQ=;
        b=qZzOsTR9nRQ0xvNvOAu0Z1YZreoDhpqcISsMC6vrXu3zmyIMObV8MhN6EeML4G11nC
         knw7PXSbJOY7OoM562bxv+X/ppj6Q4nbh+XhGEdztrsQSQ6ksFDdGvcXw1PTIh/XiI7K
         7GFPqbfrgK9VIEmwsX+pJ/NgY7amECtfHzW1QBxwej05drGjWi5N0H7Z5rtTNsI7NFuZ
         z4gs0YEYc2ffXp86XDQVETTnzpJ3a4+M01ua6k2AooXdKfOrPwFkLKbWiTfEm7zzD/C4
         gqqUwEYxbSfhw8CYaOqbmGE3N/ZBoLx7F7K3DIAG8F/EypfYiy/7clATiPSkBH6B8/jO
         Z7Ug==
X-Gm-Message-State: APjAAAXMSxwrpJ30adb7NdN4FOytM2/ifO8ooyY0sZbNaII6WNIuQhB7
        sKexQB1HhxAD4lpmH5LfkBnoxZuj9Mw=
X-Google-Smtp-Source: APXvYqyvjrTceDeetKzJjeqQs3diL1hZzZJ5Y8qhrrcMn2HLl3bmepesp6jkH4039XhUy5/6ptKlmQ==
X-Received: by 2002:a17:90a:35d0:: with SMTP id r74mr23276348pjb.47.1573864894228;
        Fri, 15 Nov 2019 16:41:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 193sm13872761pfv.18.2019.11.15.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 16:41:33 -0800 (PST)
Message-ID: <5dcf45bd.1c69fb81.297bb.9cb9@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-12-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-12-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 11/18] firmware: qcom_scm-32: Use SMC arch wrappers
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 16:41:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:47)
> Use SMC arch wrappers instead of inline assembly.
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

Nice. Can this come earlier in the series?

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-3=
2.c
> index e06d59b..c3aeccf 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/qcom_scm.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/dma-mapping.h>
> =20
>  #include "qcom_scm.h"
> @@ -124,25 +125,13 @@ static inline void *legacy_get_response_buffer(
>  static u32 __qcom_scm_call_do(u32 cmd_addr)
>  {
>         int context_id;
> -       register u32 r0 asm("r0") =3D 1;
> -       register u32 r1 asm("r1") =3D (u32)&context_id;
> -       register u32 r2 asm("r2") =3D cmd_addr;
> +       struct arm_smccc_res res;
>         do {
> -               asm volatile(
> -                       __asmeq("%0", "r0")
> -                       __asmeq("%1", "r0")
> -                       __asmeq("%2", "r1")
> -                       __asmeq("%3", "r2")
> -#ifdef REQUIRES_SEC
> -                       ".arch_extension sec\n"
> -#endif
> -                       "smc    #0      @ switch to secure world\n"
> -                       : "=3Dr" (r0)
> -                       : "r" (r0), "r" (r1), "r" (r2)
> -                       : "r3", "r12");

I assume that the clobber list is not a problem? i.e. r12 is going to
get clobbered and that's not a problem.

> -       } while (r0 =3D=3D QCOM_SCM_INTERRUPTED);
> -
> -       return r0;
> +               arm_smccc_smc(1, (unsigned long)&context_id, cmd_addr,
> +                             0, 0, 0, 0, 0, &res);
