Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7131AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C43D20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MINSvgrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDWJAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:00:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37169 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDWJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:00:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so206897ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpySyR20DaPBZdkYkeoWcznu+aSI4vndXkWIKamHY6o=;
        b=MINSvgrn2eFsfQ6gMN9gIeu6w7NXRI3sUUDyL4Spi148j9unqYs3bsPY6sCKZS32l7
         OsHai/KEk4Auxo8+lKuoKpVAR3xvNVnGdKpby1l1rFNADp+aOPYrwUSEi1B3pkVDuR0G
         JHkrkBM38eXHfrHlN0TkH2LVRquRN8ngsoPpNoa8dIcW0iVvhDGd1cE8gtokvU9t6mNV
         idrPFyYcykqUsnYXkA03fw2acebjzRO3YGRJZqUQAw4jF4qdMeieoPbHTtCh837K2lq5
         4T1dY3iLWO1Syx7PF3WbLqN05AHHFXMMcm2Yjol2WBwexzRl4gcSKPqyqEuqXJnKDOia
         cQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpySyR20DaPBZdkYkeoWcznu+aSI4vndXkWIKamHY6o=;
        b=hEmDAOtdt3e2E1hwDWkNzCwY7ux83G+2L80f/1iv4WQ8pd+GaL7G25m+ZB9MZ4m+h5
         g+iTmQaDmpNaR7uRIxm3e4nqkhGIyd1R8K/caIoZkwZ6Gx5FA8gqa/1ri7wcFHBnhe5o
         qQvYyzviS9Z4aauRaOHIIi2VrwzjzKFkvpCnSdA9DN/707Fte2vNwhO8V6Mf3ftiIOtF
         UFU/b2wkNmH4fMw6+0AGVC4P1v1UBV7SsoUBh+yPMvTX4WnQKJCOqZ3nmjZ+9S2XAflp
         pujkG0TiAKezAjGoMzzZtTYSQJe9Sulo4XV7IS8QXw8Tj+Yxzj6Ybf5gapxfRnDtfOWU
         3Lyg==
X-Gm-Message-State: APjAAAUcumYRSrgCaJTZFT6z6YkXEt1HyO8B7m5JL2jfO/P12z7SPp9q
        7YSAt0/ebqjQbiFP6RYbdLdVAlT+QK8Vu/SHokxqgg==
X-Google-Smtp-Source: APXvYqzHAH/U3mX3NOfXobFYlgyHW2jTS2XiLWH/shLBjS5jLHmHZcOM6QuCd/59Xb53p5mO6yxDxRvDP7dZaHoncJU=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr12484258lji.107.1556010051211;
 Tue, 23 Apr 2019 02:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <1555048943-39589-1-git-send-email-wen.yang99@zte.com.cn> <1555048943-39589-5-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1555048943-39589-5-git-send-email-wen.yang99@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 11:00:39 +0200
Message-ID: <CACRpkda65gMsvuopfuEHQ0d1GviseHpQMHZ7aVd7-vtQ8jxsMA@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: samsung: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wang.yi59@zte.com.cn, Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:01 AM Wen Yang <wen.yang99@zte.com.cn> wrote:

> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> ./drivers/pinctrl/samsung/pinctrl-exynos-arm.c:76:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> ./drivers/pinctrl/samsung/pinctrl-exynos-arm.c:82:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied with Krzysztof's ACK.

Yours,
Linus Walleij
