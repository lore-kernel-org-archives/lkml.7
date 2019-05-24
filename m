Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB54C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348A620851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcHnoD4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391444AbfEXLyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:54:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35389 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391271AbfEXLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:54:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id c17so6946216lfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Azj5Mh17Xr9FCaEyv0nk1c3/T309llcqUN9VP/DQik=;
        b=fcHnoD4vDFTzmg8QamBdu8mV+cYaJtuDyG3kWeofCmb377qqJWF05W/khA8hWMoOsT
         8wGRqbsDSv4n/+4RSB65JncRdIbGsQnGx7wDjPbZsVJh3k+Bvo4Zl8JGMB9vEz2JUePA
         KjzrqGUzbXBk46zgSeUUbjk/PjKvkM5M35w5EQhVrIhWTy4QxCDWBjsm4eKFIPeWd7Dj
         4EsjqzZ2ZulAaBko4yNvM0BI62kMnAd2LykhVsDgS1A7T3m8onYWErWZljVNTCmg9pR1
         7oRQk+2h0FCEZp5hoFMW5nxkzYSWyiVSquCgbnbXQFmLL4PxmL1jWRKGycSyJ0cTnCi+
         hBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Azj5Mh17Xr9FCaEyv0nk1c3/T309llcqUN9VP/DQik=;
        b=ruOJXKLyzoYEi1kA+sg1kfvOkXyyKzrGAl4daHqwHh8YJvNrJJEhZEC2tMaYnqPtOw
         lM7EaXFZID28df3zD28MzzOmiUVz+j+OSH1gbdhCldizwaa5KmORRvpHnT4Ok6CfafEQ
         tuyAXGOI5NthcTBFL+fFe1ity0lmuYh8HOrYjbiYElG5NVq8V+DUKmzaQvPkNP+6EFKp
         tjvLLZ4ydUcOFk4lGi3x2sUxCrNWwBKOo1Zt5E8mohfHT4TaJW9yom45VaS5jiBl7bjp
         Tp35bU4pBr2VzCe31QUQGtiXREyslWyL805iXOk8gX5unCXhb7F87liDXNNCLlxwxvmh
         uIqA==
X-Gm-Message-State: APjAAAX1aM3tAQzJ7LrGLEYrYbBBtuFFPn39uiCN5hmQmeJax14bE1fK
        okCKZ1nQgDuB3aa+juM97xmMNKWzfrfDdctFxFB8Hw==
X-Google-Smtp-Source: APXvYqwIIZNQbUvjC3/LAYZAUbrO59dxsLsAscijArxf5xAPoLHmlBeI4UgtMCBGZ6OBmRpTsXtE3Yphmj2LJ6hmnmA=
X-Received: by 2002:ac2:4209:: with SMTP id y9mr11799734lfh.83.1558698878778;
 Fri, 24 May 2019 04:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org> <20190520083101.10229-6-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190520083101.10229-6-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:54:27 +0200
Message-ID: <CACRpkda1a_WSP5rWGHDZPsbU=5mLN+2TPVF05mEHm17R2fM0aQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: Add pinconf support for BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:31 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add pinconf support for Bitmain BM1880 SoC. Pinconf support includes
> pin bias, slew rate and schmitt trigger. Drive strength support will
> be added later.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
