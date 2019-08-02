Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F027C41514
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B69B21773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zW3PTB/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395190AbfHBVuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:50:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46913 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395179AbfHBVup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:50:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so74308230ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+6NeIcL7nIjmDGVLWabC3vXM+Jl0SVqaRvJgDEpCqw=;
        b=zW3PTB/WFvF+k/aMp2lt6zvwPsJOXSOWNvK4f2fEkcHmPImTWcM4t8CfbJgvDztVZ/
         Q+X25hSkndasM80otX/J5yTNL1FNvqXYEEENQp55f7PNUAmfF/Qla14xP/qKRF4Qx+D/
         iueJUlhJ3B7BrHzJ5hRmFEKtPiZg15ap+2+26eJNzIXV2BBDtR0xeosrH8TRq4UJM69t
         zanGCNJ+48SzWEfcaDnw+Cjsyspsuy2lF1QzxAuEiJT7JbsnmH3KhH5U71qNyJfVPJGG
         15m+snrj+nLwv+GjsSqpSaOpRl2y0XxF9Q3ceTMk10LLo6Mtb2+D8gruB8NTkqL+xrHF
         yVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+6NeIcL7nIjmDGVLWabC3vXM+Jl0SVqaRvJgDEpCqw=;
        b=kG/zqhbBzdVZLeycFcRDe2azEyANfUMWSqcdB2OorH9FLDIYGgmvzLfaeWFM5Addav
         08dOBh3BNETtSgpHIWj3WnX9ymv987JlvMlZfaFV7KE+g3qFBjv8THmEr12+2m+vXgfF
         iK8ZJrXaHEnWRRE2UhWJqm3LugbgJFcg8iFg6R6Db2amJhStKE9CIocfvE5V5VNOZQff
         JFdjjlzH4Za1/cPV4pDZvpb1g+PySnwav+kJl+CrtcpfWUtRrXvxEmAC+HCp63wvaDJ+
         frOkOQft9CHSIXY3bwJiqozAq2aJdKgd8XV8AYubv4luca4YUj+0bFANnb/yrn8HALfl
         mOhQ==
X-Gm-Message-State: APjAAAXiN4FgzNWTexaZgbnFU+AccAyN9SoRPjyF/cIm6cdTU+/Z3b7W
        ZSy/Phi7pRHJ8xdo4BZaMrcglAhEj9vUmmMRK0npAA==
X-Google-Smtp-Source: APXvYqyBjPR9tsFzJkl8sdRatkgQDGJTpofe1VtOni4strgFOm/fAXU02CWmWIzEblvJBHgoefzqjSHWEou+yWPYBLs=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr7977275ljo.69.1564782643699;
 Fri, 02 Aug 2019 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190717141848.31116-1-yuehaibing@huawei.com>
In-Reply-To: <20190717141848.31116-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Aug 2019 23:50:32 +0200
Message-ID: <CACRpkdYvzWA0iZad4yamjhnwbA4rm6FgCQBP3nr1gKCg8_kRAA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: ab8500: remove set but not used
 variables 'vbup33_vrtcn' and 'bup_vch_range'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 4:19 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/power/supply/ab8500_charger.c:
>  In function ab8500_charger_init_hw_registers:
> drivers/power/supply/ab8500_charger.c:3013:24: warning:
>  variable vbup33_vrtcn set but not used [-Wunused-but-set-variable]
> drivers/power/supply/ab8500_charger.c:3013:5: warning:
>  variable bup_vch_range set but not used [-Wunused-but-set-variable]
>
> They are not used since commit 4c4268dc97c4 ("power:
> supply: ab8500: Drop AB8540/9540 support")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for fixing my forgotten codepaths!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
