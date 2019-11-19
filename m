Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9333DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BB620674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tm/ClsWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKSWNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:13:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46462 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:13:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so12682698plt.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=ASznCwZJ9ByLV4yzgLO4lJUGY/U/ukbE4wowdWRBq4E=;
        b=Tm/ClsWEZ+XTrHRg12YXmBZbEQduJlGoiWcusKF0D+L31Pf83YcmXs1HDdXuH9vJGq
         YFm24DEbLSuGeqs2xiFuIKVD0V+q64JkWodIP6IN8yricnaEdi5aBgJzRuxmbcyaUQFo
         Xm95Y3iBb1vovUjRjxwLRGWhFsCdg2VCN1vyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=ASznCwZJ9ByLV4yzgLO4lJUGY/U/ukbE4wowdWRBq4E=;
        b=r0tA/UdoJp/1hGDqTHcHY5omXIjkvmNPGRAH/jLQ2WUka1eX5VFPpEVr8t5FaQBbSO
         IZZhvo2nvwuO9/8tL3dmV3KGijyICfOHdqIUBzLQSfmk3PDPhV3vRURQeJNWEU7rKOko
         3eoRKaNpoTEih0t7vHOIjt+G9Hiv1KiMotQuQKfpIwxQMyvhu6Ba6/SOb6CHBJNg2PNu
         vuYsaa+9Lods4wuHy8qVkz8FL6EXYj/3r8N8sOUtRqUaGi5mDzs187xUA97kYWqcj8jg
         XQeQjOd8s5yvXgb3XPeNwz/U/zkLZvXat80FQolASSRwVHUNSgjLTTo0AHW4sjioxwtB
         wPYQ==
X-Gm-Message-State: APjAAAVlZRM0h+6RuGPyvr/TgD2x2WlQszWb5Fjhz/1VgD6px27aVtWA
        BqsYwLzGwWQ3jGKFKVRl1FPprg==
X-Google-Smtp-Source: APXvYqzjtiAMF6Bis8voqOYzvqiuCuY9dRznuUPn80UHLIO0EIWVeK/Q9L79gsJSx7d4c8hbrNX+Fg==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr34136707plo.209.1574201633891;
        Tue, 19 Nov 2019 14:13:53 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b24sm24260272pgk.93.2019.11.19.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:13:53 -0800 (PST)
Message-ID: <5dd46921.1c69fb81.aef4b.686e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-16-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-16-git-send-email-eberman@codeaurora.org>
Subject: Re: [PATCH v2 15/18] firmware: qcom_scm-32: Add device argument to atomic calls
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 14:13:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:51)
> Add this unused parameter to reduce merge friction between SMCCC and
> legacy based conventions.

in an upcoming patch.

>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  drivers/firmware/qcom_scm-32.c | 17 +++++++++--------
>  drivers/firmware/qcom_scm-64.c |  5 +++--
>  drivers/firmware/qcom_scm.c    |  5 +++--
>  drivers/firmware/qcom_scm.h    |  5 +++--
>  4 files changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-3=
2.c
> index eca18e1..c1c0831 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -269,7 +269,7 @@ static int qcom_scm_call(struct device *dev, struct q=
com_scm_desc *desc)
>   * This shall only be used with commands that are guaranteed to be
>   * uninterruptable, atomic and SMP safe.
>   */
> -static int qcom_scm_call_atomic(struct qcom_scm_desc *desc)
> +static int qcom_scm_call_atomic(struct device *dev, struct qcom_scm_desc=
 *desc)

If the argument is unused, how about call it 'struct device *unused' so
we can ignore it?

>  {
>         int context_id;
>         struct arm_smccc_args smc =3D {0};
