Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1ldyS/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfKYPgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:36:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKYPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:36:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so11349459lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQdIyme6ZG3X2m6iPrJ5ub+wJgNPBCPtZkNSwctyhnM=;
        b=p1ldyS/SwNR93tJ4O9yQxJMSm7WCkDS9QbAG/jwjPQnuKULErVXD1kbDq/3tp+MHH3
         S+76eqkPvdR61ujrBe997YgjYVtS7P7MfELVxk8KAyvQmTxD6P/+/VSOMnyXJ8+U1C3M
         2DHxsvxvyRmTqZVwZjgWV9YeBpca3k6BOBr2c4mRnYBBQ8XB5GvljPH8d9Gc+N+lhuxr
         dIfXl3J3qqM9bnDIbKK5tOpNG/RyHC0V7dJJpnYdLFiDcE+QKEQbidXYceWipLncPk1u
         ximXm/UILNcw9OL55vwYzLL9wBG9pmi+yj/hNHieVdGp+S2xXVtdBKgUrY3YEVJNS+k7
         /ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQdIyme6ZG3X2m6iPrJ5ub+wJgNPBCPtZkNSwctyhnM=;
        b=IisAkHFL2NoCCEHqGs5cM5/wjO7zxmJSDjna2jcoWpN2DFNXO700c/zMhChG9jevT7
         dIMCJzhXtsRbys3L1HzNrmt2TqRgfcZa419CSlBXFY2L3hDrca/tBF5oEcOoJ5PO6+oO
         9a5zrQjUuuIQKPwcwqDwRDOVtszxaKi4lTpHl3ujCxNYfUXejE4x4dviZYWxOUTGO2i/
         Ci7e7AqHT1TGQ8l7vQSyU7DHyCcZMEvEOOOIgGuDGVfKrabHg9TaN0ySTm1sDCwEc6Mt
         Bu1VeSCI0TjL4rsiLSjNv094F7ckOa8xaGPtc/Wpx/r+kdqiZI5mCB6pDZzIPReitzJS
         9CXw==
X-Gm-Message-State: APjAAAUq0MwtR6XnoZ/L9Lsl65SqqE7ktlZFUkvThi9DG2WKbIkkxu06
        iyId0da1O2LkpBQyVH09BZR2pIHYZL8FGMKom/q01g==
X-Google-Smtp-Source: APXvYqz3tpf6SKfxdFRnoZEjY5rLhCm2HbK+cWy5vbhvHm8tHkoIA/I6Jn5s/sjh7LHEsTW2tbVWuKm5WLWLOSC9WnI=
X-Received: by 2002:a19:c84:: with SMTP id 126mr7464529lfm.5.1574696159586;
 Mon, 25 Nov 2019 07:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20191125122256.53482-1-stephan@gerhold.net>
In-Reply-To: <20191125122256.53482-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Nov 2019 16:35:48 +0100
Message-ID: <CACRpkdZ6eg=uLmJJA9OhJBpCL5Q_0MwBvoKwv0RJL=5ZSzwx2g@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: dts: ux500: Move generic pin configs out of ste-href-family-pinctrl.dtsi
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> All existing Ux500 boards make use of ste-href-family-pinctrl.dtsi,
> which contains shared pin configurations for UART, I2C and SDI.
> Most of these can be also used for devices not based on HREF.
>
> Move the generic pin configs into a new device tree include
> "ste-dbx5x0-pinctrl.dtsi". There is no functional change (yet),
> as a next step we will rename the pin configs to use more generic
> names.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied for v5.6.

Yours,
Linus Walleij
