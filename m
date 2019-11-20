Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0366C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8862071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ge9P/unM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKTUTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:19:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41239 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKTUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:19:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so594413lfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aO1eMdBEY7hslgerH7x8XFO4GiCMhOytkTZssaC68pw=;
        b=ge9P/unMnfSLgQKieWjra0Yc3TavwLv4MnHQ0kKjXV9ID/Ai7DCv6D3LpMLYde7ECm
         4zP6oqrEagImpHKTJgc4Uc222dXBFxQIEb4KtBTcKZbnBsJApeUelPFEr6sdrd/sWsWR
         AtlHpclzUpGdoSNrKSNWDe00+5cyyA/IGkNlgE27wxRXS7oLFKgQUr4PwPfSM52qfD8/
         Bv8dl0iV1b3pMLwEq1pGx8yni2Dqc/UQH7KaLIi5PdHyabvZnzCJHLzjqXX7599e7RXI
         bzUk8gpI/F4/E+sIjLNV4+7Ba3jk/eTqHW5ADhDlDj3cK4ZbAWHdkudPEvYWgRJDjNIG
         0g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aO1eMdBEY7hslgerH7x8XFO4GiCMhOytkTZssaC68pw=;
        b=H0T6lWCm6hBmrzeyWKI7kii3RTHgFtdlPqhTmHCmTSFWhkbYgXPvix77LfW90dknHL
         Gr3Fn39+m3JG6jMxz4pKJh16XCBzQz56uoP9hMJhNLkIXqNZVXN/x7gTEQIFIFKIoc3X
         vO0ZLL9hb8cjwmtDn67ZuYJzzne3We+r0Ef3+Dq73GFBUUcXxD3bz35jbd+blekUTZR3
         +obs1vLSbftWJv3GAJJU4zZMsEEmSwCoPLIk4VpxuE61rSIN5O1CmfPls4jDgRBS0nfx
         QMWOXk5I2IJSx0Qz9vuaa10pmfqLmFGmeZap3R7tI1AOyZ/llgkXi/oUaTKqyvLUuc0G
         DRvQ==
X-Gm-Message-State: APjAAAU5c1RYDAU7aLYjb4JEW5El41KlSRU1LJueKbJPNhXp/Mmc7ra5
        e5Z0kgOHvVAGeJvKwr4mnZDPdllS7xmIvZcjwFLfNw==
X-Google-Smtp-Source: APXvYqy3kknXCsT33k6sxjMGF1t83Wg3lkQLFFDj3+gZadBEi2HsWf+UQfPK2lcnZH6+5k82htgilxD+HRGtg1tXFlg=
X-Received: by 2002:a19:c144:: with SMTP id r65mr4409719lff.133.1574281163584;
 Wed, 20 Nov 2019 12:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20191120181857.97174-1-stephan@gerhold.net>
In-Reply-To: <20191120181857.97174-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Nov 2019 21:19:12 +0100
Message-ID: <CACRpkdbE3wu9MAdy+y39idaVC9Yq_fwb+fdPmanN3CYzRwzeBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add yet another for ST-Ericsson
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

On Wed, Nov 20, 2019 at 7:19 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Unfortunately the vendor prefix for ST-Ericsson is used very
> inconsistently. "ste," and "stericsson," are already documented,
> but some things in the kernel use "st-ericsson," which is not
> documented yet.
>
> st-ericsson,u8500 is documented in bindings/arm/ux500/boards.txt,
> and is used to match the machine code and the generic DT cpufreq
> driver.
>
> Add it to the list of vendor prefixes.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
