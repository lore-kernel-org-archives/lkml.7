Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD03C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DCD21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sc6bN9z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgAFXQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:16:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41657 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgAFXQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:16:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so52708406ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=478YH3IYCHrD2e4B506SFn4dG66iW1M4hvXAWnhq7U0=;
        b=Sc6bN9z9vX6vHT6KJ86/wcGYjg701Ez026i8tnOYJhzp4DwZHmKRWtsPGNX7Z7rBNm
         wfA8qiev5ebBo4+7IsnAYVFiISE9k7MrG109NOAQGUqvLRNa/2rMoLfb4RKnfNhmaQwE
         xyPY6at0gwMC2ZzBod7g8wVLAJZroEKUCJs7OB4icZrfs7ufV/kJZtSizkwVYDt81DYR
         HCH12BsFCjiEAxoBgK6NA/gzfZSpx8uzIPgr1hsTM1AdQpd8jopdsIRWSZRgIuurxEqe
         +Gdv1GcJfjuHZg47hm8gTG7XKlXVWo3eyM6MHQP7nVuWWo22R+v69K3pHsEAMOUSJJmX
         B+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=478YH3IYCHrD2e4B506SFn4dG66iW1M4hvXAWnhq7U0=;
        b=pHg01k4gBw1nSbQIHmYr63oXrWyVbSfn4YRM1vCh15B5Jn/ZigjR3QQlJXUatnM+1C
         7zzjLnpP/F6NcN7uhKy2HClsfKXtQ+y7TGzGXkRKb6A2iTn0hOHSRMjts8cNiz4HT5bX
         CoGGdlBoh3MwM1A4yGQoYO5Da0R9tTv8BjDMfHRbwlWtnhxowMM2WQ5SfJ3RJEWHrLM4
         648Yb6P9tXiVczWjIvvgQUHuwcqlTI8nv4YdlIpxhv3WIsID4LED8hnzjVSlJteuPxvy
         YmS011SBZf2gGbk1mm2iT7F9zR3Rzvv9Zfmpb5xQeEWhyGl/NPZiI9dglf3Iey83nE8D
         8+wA==
X-Gm-Message-State: APjAAAUsdQsvX30LXLEoPkaBXadfH5CdbhtVNDdr8ZVYN0ZKAIy13X4y
        u793bu2AL62GeDeohcwB1JlFXhrqs7VvPztsLknzau3XeXo=
X-Google-Smtp-Source: APXvYqzrxWmdShmKUM9TYeByfQUqSIfyhOUDPflUr01aUaoSyuiRbnZsG1KIZtnjSy8sPboUTEjxmBcaoS8PkTk20KY=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr58926187ljh.42.1578352563746;
 Mon, 06 Jan 2020 15:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org> <20191217121642.28534-9-srinivas.kandagatla@linaro.org>
In-Reply-To: <20191217121642.28534-9-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 00:15:52 +0100
Message-ID: <CACRpkdY+A_=phLW6ymz+QXTnGKzzUt4v4iAVndnr5nKH1r48LQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] dt-bindings: gpio: wcd934x: Add bindings for gpio
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 1:17 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
> gpio controller to control 5 gpios on the chip. This patch adds
> required device tree bindings for it.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
