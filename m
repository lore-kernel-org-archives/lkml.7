Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99FE2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0X5JhX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfFYJIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:08:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35839 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfFYJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:08:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so12090338lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wu474up4GmX+0xskt+Mco2FNXdilbTUBXQo4lyZfB3c=;
        b=j0X5JhX4ritT7Kcg7Jx6/JVATsHzntqd2p+xmtwYV+1snQQ4jCgEApitNF1YL6awVs
         lmeNAl3Gbw2kYeMZ6XvOCvN2u0aeiMBbsxI7Z0YMfFa7+tE7cAXYHlqE2JPpk+grL4vX
         MCk03LLX62m09fDgbShIu3HLnNm1U+eqLG3Pvpbja+M8uTxdKGrWuQg4RCidb49rc4/N
         zewacsawz8S2kLMcGufblhSzbQhuiaCGPCjKj6Hl2zWtmR+0EGLAGFn4GY1rVAJXwpND
         /pF5fMsJLtY2TCIL7S6rVHrTC2/2lzQ1m2C1AK/mo2vQT6YjZAvhypG5cEgHnXEPY9Is
         h6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wu474up4GmX+0xskt+Mco2FNXdilbTUBXQo4lyZfB3c=;
        b=ULeq+gSYTFG4yrGFGUMd+xI1pwmWMFukHF4/MjvEtc7P7hnuhPwtAmM/92OYuwain+
         tuH5ROZA+/gDdeGbp5+fa4xXNTkCyW2P4hmwt6Cmi2p2LLdSj1KJyS7clk4luXGuyYRv
         e4W3p8gxBjKfRlAYGmNFqX6hfo8zrkJrIXjP9psANby0ZsgcjHCAZtiwbEiBynGoGu9f
         riDoXOxgTuhS2mvDh5p9MEjZF/hKg4pQdm+jv1eAryWUdlzLTU4F6sBaM6QBXjbNf/HW
         r2vM/qT4KCfjHqMf3MVBLv54rrvskHcCVpLRWHdOjTWURa45ut3bZqVFpgZ/6A3R0iOf
         9sAw==
X-Gm-Message-State: APjAAAV1+B1Z1w8qYBeB+/oib/xfKTrLBg56+RXC+QzQsuyImnvyeXfu
        UqYmwc/n8e9FnJnowQpSJKcddTmLrctyQnqrIvB7Dw==
X-Google-Smtp-Source: APXvYqyecatcXnlm6onkaiFcOr0uegoG634tlFs6AaqIXfmTRab5kzN3KC9Pu3xgJbcfEsfZy6LEJ3PlYOTboLNU5wc=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr24533491lfm.61.1561453720741;
 Tue, 25 Jun 2019 02:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-6-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-6-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:08:29 +0200
Message-ID: <CACRpkdYGguB=XvRo28hOQOUjysccpXf1DJwS69xn7o_xmuiK-w@mail.gmail.com>
Subject: Re: [PATCH 6/7] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> don't need the temporary variable "dev", directly use &pdev->dev
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
