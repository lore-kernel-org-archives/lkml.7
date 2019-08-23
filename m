Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2281122CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cY06Xukr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbfHWH64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:58:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33723 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfHWH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:58:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so8046500ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bd8XoLtOAWU+7BwGbBI3SJRXpJvzJRqxBSiZxXkbwbQ=;
        b=cY06XukrB8tjEf9UAwvxbqEkYGIf7YplCL05socdcolxb5FMUe0XrJy1kJFlbZgKRA
         xqBy2i1DYn8CGjEMlIEPBNN/0LLpxzRsS2ynK+EiNpRJVxQP4RSyFdYzu9UbU736NJ5I
         aWADQq7MJJe75skDBRAyGxZ2l5IJ8IbOlJcYqHMxtxxVqAhcy13Kol6ZJ7sVkFqbj/pa
         bHauROnenvzsFCd3LzDoWGTcTldnMrZDcKXLRGU78crbBv4uZNWyvieSTL/GGN5ctTTT
         r7DBfd61vPAP9baxyD63C1Q4bmz3mI8IPOJ6Sdvu6HW0n5kkFwJHqvEmYt4fkKo1BUeJ
         QXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bd8XoLtOAWU+7BwGbBI3SJRXpJvzJRqxBSiZxXkbwbQ=;
        b=KQqhleDW9zJ+B0tKK4NFn6s1tNru/p0pr/PWS0lqslVWw/boFHKaZzya0Wg9hE5+Yy
         1nvvIEzXSko6tZuNEUkojgDV3iR1RpOqUTZbUHNxhh12hM07OGcChqx1mUDXX/AXJqEO
         9US64fmlfXAFvl/VGFxeMrcQN8pDMhN/azu+BArA9wB390w1B47pC9DpVcSgq6Rea8Yk
         2adELChk+bBM/iiyUQ/nEPmf91SjLuh2FcThCRaXPFaS508GJPYKMHLYyHOimen+E7qu
         gY0T+6HIxmmjedqtgWE+PKCPr/UGMBLuCj9P+4SBwxhyzWuZXDqQTbvR4PO64vsbCAo4
         N/Aw==
X-Gm-Message-State: APjAAAUGafvh8Imf8+vfD542MaKgSPYfvAhUHQGnLRpJ2xGVjNm5YK3r
        15zaBTk2xONR69JFXy5rraNXyqlwTuCnl1V4EGZdzg==
X-Google-Smtp-Source: APXvYqx20UFE09WUbvPbKRheJe5uPUYJciAr4V5C0JTxwVk+UKhBPMsa+z9iIIb0TS7UW3n8ScMINNgWL5FoPJpJES0=
X-Received: by 2002:a2e:9903:: with SMTP id v3mr2098659lji.37.1566547133896;
 Fri, 23 Aug 2019 00:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190814123512.6017-1-vkoul@kernel.org>
In-Reply-To: <20190814123512.6017-1-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 09:58:42 +0200
Message-ID: <CACRpkdb-y4PhqH+fSeQNRHKHDKB=qDdcgR4VdnBqXJEh2YPAUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm8150 support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 2:36 PM Vinod Koul <vkoul@kernel.org> wrote:

> Add support for the PM8150 GPIO support to the Qualcomm PMIC GPIO
> binding.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied as lightweight and uncontroversial.

Yours,
Linus Walleij
