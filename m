Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF520674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQwuU/yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfDWJI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:08:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36838 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:08:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so11142404lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoGHj3NntIyVk3YgTPqssMcgFemIBCdO0zfTpKoFm8M=;
        b=KQwuU/yA3cga8i0qji2Nf2w0c/yshEJreao4lW+dJnL/G6Tn04u0j98W/m5KH23lTc
         Td1kY3WdP037aabygRiIWCvsz1RQItfW9+V2bV6Vw076gMYMT38s9q+bQ13yCHhRrSOe
         99O+KultXgTTw/tNevU8y1yv/g3aD3aoGpIiEnFPThuh8bEvFcXkfIGvU6Im5wf/JHWS
         At1OXg1l1fQEYIHr1PDu+whJrxryfW/uA7l02pJl1M0mu/dGPm1nOCy2FWOfnBOzBLHe
         gVyE+mQ/fXW0Oxswmi+8pc1cMb7KNWlEvIeXz5qiUoGg/wTeYj+6q0pGJr8DYyWgM84H
         0YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoGHj3NntIyVk3YgTPqssMcgFemIBCdO0zfTpKoFm8M=;
        b=tdOEToT3C21dY5N0BCNwQ9sskRtlH/p+3OK0nLAzJg7XDJQIBSYxwjhM893htr0RcX
         Ctmq7S4SWKyvlhmVtQdA/LenWbpa+YL1YZh7/Yw1OAvvLV6nyS9SavB19B6Vj/SqdxRD
         YDvo0HE/Ak1wSumZR7pOBsaLm/nnrrZoZA1JWGn8bwk1KbojGvkRRp8VRZf4fIHG4RUr
         Jmg28bai+W4yGdrKXL0uMNcZN8uFE4dPgQCU5ABcrHUkiV2YeWAMnIXGYqTtIxInEQfC
         oKz8V13Qzas5QWNf33cI/T3Up1iZhQEQMGbETXU3V1lvdiXTniA5UNaOo99iDTYxG8o/
         sIHw==
X-Gm-Message-State: APjAAAV46WPi1FtN3VyV8yZPemSkTAs5CkOEHC1v4X7hiMaOap1Cr/DM
        ezzhp9XC1iT8k/V0xH9tqv5jlnEoUb4D/95xndGpmw==
X-Google-Smtp-Source: APXvYqyfckDGVfdn0yR7Ekqs/5nfWLPYF92GhY/3YG5sWlZUZkuL7kQw3nPMj6VMuIsDt+fI1GhcfwJ8JI3b2e8cATU=
X-Received: by 2002:a19:c301:: with SMTP id t1mr12720880lff.167.1556010503943;
 Tue, 23 Apr 2019 02:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190412141158.21246-1-axel.lin@ingics.com> <20190412141158.21246-2-axel.lin@ingics.com>
In-Reply-To: <20190412141158.21246-2-axel.lin@ingics.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 11:08:12 +0200
Message-ID: <CACRpkdbbUo5mPkzhC9Xw7h8VS8j1uZ_hWZEZLptjyzvEpkLeDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: ab8500: Remove *regulator from struct ab8500_regulator_info
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 4:12 PM Axel Lin <axel.lin@ingics.com> wrote:

> Current code is using devm_regulator_register() so we don't need to save
> *regulator for clean up, use a local variable instead.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
