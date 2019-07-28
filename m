Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF0C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9619A2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpW8mh5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfG1WVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:21:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44206 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfG1WVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:21:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so23680800lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLmMIDcIizWuPvrBmc4gpk3vuXYj+LUn4VJhWeYY47A=;
        b=SpW8mh5JmaUwmCYAUiN6Zc6xExwWIrOtwzT3K6hskMbzzxct7PtclBGvCvTicitGLf
         LIzVOV0uPD66YFu/1HFK3iDlSyDK23Jgtip/94zAhM2rxdAo1tepVdNhCYUZDIGh/Zzo
         AMwOoJSB6mqBJ2OBODr6Dy1qT1t9ROJGLge8btIfLcKdTqXA6ztYBiIMsZoBozdQvRzb
         03+n5uoHji2Mfc7XW7d0s5d65Nrbin1rZOdh4CTw/hisxod3/t/KDSj62K1vDV/2hkyi
         DeDRQYCwlhNSblnZMWJAOuEl7ChJr7jVyVmhC0BV64NRbICQFM08LxvXrkocTi15E/Xa
         3svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLmMIDcIizWuPvrBmc4gpk3vuXYj+LUn4VJhWeYY47A=;
        b=mc6EJME+egqxIbsvjaX9/RpTnISvMu7YYviJL30DUudjA2VZHWIqfyS4s+Z/0kYLtb
         PXrulDcA3dKuMLOqFjHbhGVUs93HwnUjBdzUyQfbtlPy6quDmJh2W2iapa8pUu8zgrn7
         CMKGS14qaDWG7EYDjqJ5FWqQKdj1ReIttpTuGTVt9JZWJ3+GNLAX4sIuQdr0y+YjNE+H
         PjfbTo8oCU8HqO/8w1RzZYr0qyGsDYnL9BWUMKToWut7fZHsgK5xgLRuagxkJ14iccqW
         vXoT+KDoINnFbC2FCo2Usy1W/PTYdU4EZKl83UpgxKL+/qWmJ73GrkMiYxkwkUzRL+fi
         WDQg==
X-Gm-Message-State: APjAAAU07k1rhNkQjgY9aQaNrtlt2gF6XxTueH8vf+luILT+E7C6on2X
        65mkd3u2Pony0SJDrf9zFo76AqSBcmvfDTffqrhLZA==
X-Google-Smtp-Source: APXvYqy9tXaK3FvDKV/nxxLTpRbvelziBiCAwnZac43l2iiP91Bvr49N28LMVps7+NvxEUQsozJwed2O5clCXGQ2s/Q=
X-Received: by 2002:a19:e006:: with SMTP id x6mr48865881lfg.165.1564352459718;
 Sun, 28 Jul 2019 15:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190705143043.1929-1-luca@lucaceresoli.net>
In-Reply-To: <20190705143043.1929-1-luca@lucaceresoli.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:20:48 +0200
Message-ID: <CACRpkdbJHPz78YfwRtbnmw_8Rk-Te4GHFvrL4MLCy1xTvjKGAg@mail.gmail.com>
Subject: Re: [PATCH] docs/pinctrl: fix compile errors in example code
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 5, 2019 at 4:30 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:

> The code in the example does not build for a few trivial errors: type
> mismatch in callback, missing semicolon. Fix them to help newcomers using
> the example as a starting point.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Patch applied.

Yours,
Linus Walleij
