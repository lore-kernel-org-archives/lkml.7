Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E50DC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BCB20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsmloQ3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfIKKNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:13:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38409 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfIKKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:13:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so19080801ljn.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCnVGzJ1aayFY2KVyD1Mv7oUSY3ckiY/y1eytoodkhs=;
        b=IsmloQ3qh+w0RxxWI9INZ9WRb+/A5095NFWDlOU0ojKcniCg3x8EawwhTpdwT1nI3v
         LWk8BbA4ERR32ph5dS97WZauymFdmjDcgntluwX6FCCKLbzZdAqN7tjZru61pYKlNRSV
         QYyHm/3HKhdeo+cTZaEaE87uLdzYHPpP3PD8Kid71nN1CyD+Me+ORjfm5oWjxJQ+zwlL
         y1TUbT5IxbD0E4ySpZNyKclMiNdDEVSz4nNLYlirjrjnYQNE2KKMLQsl62ayYl2m74Ju
         ATAllJQxj3IB0o1IYMuC84V5aUBxTRhsNK++jZHUBqWMNK/OxiN931IpoTJv/NAb47f3
         hIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCnVGzJ1aayFY2KVyD1Mv7oUSY3ckiY/y1eytoodkhs=;
        b=MXNnvRwjMx0kEv1UQ1bs4rx6Ept26Kx6GLixI4ZoDrWSDGDU2cLFWlvX/TEi1Nu/Ry
         XFP/gpNMjC0HDwqWU8k9xsGhga7zyNUmgUbm+hlexjan/uBM83pkXr+u7sgeGdyujhSW
         p5MgbUcPLiV9huH16MMhgteGfISt0ASHlCERtK/GF9JEfGeKPE9JkELuhOCB9ez7Oy7X
         XnqqA/dBcnNQkh/zuWTPwQOdfySn7h9Y3h8vaQfWfx+wP0a8b63bRXYE7JDS6U0GW5IL
         bnVFz1toz458/dwu1ojLYuk6E0Dy7t1/6Oq8jaisrNPQT2pQOs4uvL9Gd/+rJ7FLJ6mw
         mnJA==
X-Gm-Message-State: APjAAAX4BF5bjwsHF7X4KxxpWALYAK650v/Bour09WDywmN0IYUTTx2j
        PRXm8L8q4YJXNUsWyRB7Wmk6B3Q+W8cBWKiF7kKGoQ==
X-Google-Smtp-Source: APXvYqwuhpQk3V/zZTpDpM2cpbb8dbSgHN/jIKUQd/PGzomP3IPupkj6DtiQG9j+nks1pOHj0dx1JhhwudEsWNFOZbI=
X-Received: by 2002:a2e:654a:: with SMTP id z71mr22911168ljb.37.1568196829591;
 Wed, 11 Sep 2019 03:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190906063737.15428-1-rashmica.g@gmail.com>
In-Reply-To: <20190906063737.15428-1-rashmica.g@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 11:13:38 +0100
Message-ID: <CACRpkdbmusuLNfzcxxnYk=Up7UT3GMdLU4R+WnS86oTV9PNcWw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] gpio: Add in ast2600 details to Aspeed driver
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:37 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> The ast2600 is a new generation of SoC from ASPEED. Similarly to the
> ast2400 and ast2500, it has a GPIO controller for it's 3.3V GPIO pins.
> Additionally, it has a GPIO controller for 1.8V GPIO pins.
>
> As the register names for both controllers are the same and the 36 1.8V
> GPIOs and the first 36 of the 3.3V GPIOs are all bidirectional, we can
> use the same configuration struct and use the ngpio property to
> differentiate between the two sets of GPIOs.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Patch applied.

Yours,
Linus Walleij
