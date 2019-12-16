Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45F8C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB202072B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leqpCm4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfLPIPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:15:39 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44749 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfLPIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:15:39 -0500
Received: by mail-vk1-f195.google.com with SMTP id y184so1365455vkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qu4go+LfnKNu76tzONlM/DXLfpoLwvN/WGMtsTcLNx8=;
        b=leqpCm4mwbX2Ey94U37p2i9Bbx2RkIfvb6WvQBDRNgtT+BR4hoBJgsQ9ofMZk5fgW5
         aqxcfB+w0CyBiGJxW4/iwcSMgOronAmehBnbN81GmoJ70EOU1PUCsHaWHY98vwPhJ44T
         TdoXMzTniNcKi8V8AEo+GkUhJ0dLg4ypg8jqEqpplE+ltTEnK5qErmotbHGqAkodjLG+
         tf4Q5K/uXylKQEEgLK77AIFTtqOg0tNi8n3CfamBgzRNKyv2g7Jq9h57fPnhyJlcrrzm
         cwEcHY9vODoelw/MO0sk05APT3/mfurBJmYf1ri/44TwKzvTZejfR2XBWGKUVsGLVaZ1
         Eyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qu4go+LfnKNu76tzONlM/DXLfpoLwvN/WGMtsTcLNx8=;
        b=ZSDSL78K1L3X8Or3rjiouw/STvLZpGSRrz2dPicB4gwn2OOMpXh+qld/23x5MVrg0X
         236mR7XNs2JJbWI9Z04nMvY2KaRadxF1E18DMDGVJWU17c585K2csw7SeZzT4A+drEOJ
         rlfaIl2kTmAe5K6yjWFrhbYW3MgqW16lE4LcmvSOP9/hLS9oQdyYSLDYpvofbrzJ+TWr
         vMrARLqqxeos23EKiHwJhAOKBhOaPCETqIx/NPGh0du8DWGed/PbwAVRdCT8P8PGJLBi
         EKULi80Q6/oNQYH+rn2Q9ifGvVTtL6/rywRURkNuwkNTulmI/vM85mqHKpA5vMoSR/+y
         Bi1Q==
X-Gm-Message-State: APjAAAXwVW+IDKqpU9cYnqBql1eKBYHMo0N+9klKFrViPry4yN8yhpOk
        WobXGIwKHMQYW6Xl0UFNl4dnWecP8cRVVizCHc+dDi20sijaxg==
X-Google-Smtp-Source: APXvYqxsLIGSSYoLhqReMPk/ckHJ7XR9h2vXGNBZs6Z+b9XI4Prqv4oOpdbXnDGHV9aGiX7g2AlfDFsUeaCDtmU0zBU=
X-Received: by 2002:a1f:ccc6:: with SMTP id c189mr12309632vkg.5.1576484137990;
 Mon, 16 Dec 2019 00:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20191210164446.53912-1-paul@crapouillou.net>
In-Reply-To: <20191210164446.53912-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:15:26 +0100
Message-ID: <CACRpkdZA=0vYhYUXYYNtjkaWKRbm9Y=iQLyjcNWLStpfd=LRAg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Fixup PIN_CONFIG_OUTPUT config
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 5:44 PM Paul Cercueil <paul@crapouillou.net> wrote:

> JZ4760 support was added in parallel of the previous patch so this one
> slipped through. The first SoC to use the new register is the JZ4760 and
> not the JZ4770, fix it here.
>
> Fixes: 7009d046a601 ("pinctrl: ingenic: Handle PIN_CONFIG_OUTPUT
> config")
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied for fixes.

>  The commit it fixes was added in v5.5-rc1, so I didn't Cc
>  linux-stable - I wasn't sure if I had to.

No need for that when it is fixing a current -rc, that is what
-rc:s are for.

Yours,
Linus Walleij
