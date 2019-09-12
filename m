Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B463ECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E525F20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+RtCQ+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfILIYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:24:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47025 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfILIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:24:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id e17so22698049ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w49o6bLlxe70T8dk8RcKOKQ6ege87Mzu24iLNFJSi6U=;
        b=r+RtCQ+QSzYgod49oCaqYCkPTh5kZ0t0Sd0c4Z0+s2eYFento9RBH+cJ6oV9udoLxV
         UAOH78eysBB4GLzpWHG+n3DdyMpTG7bjHG3OJeNy+YTbh7rBITWWJ8UHrdYbqbOvjhKU
         wBTdN/oCGKDqPSMGUinbCLXh34ir+lHen6smdbyfGfv6TgiY+CpSyJIftKzl59psWfws
         otcFJcFnELrgNmLbcSAaY3WNMrDE3O2jMbPXOMUIuJikgcaKm6OPJYCvJZrtz4War3NN
         ajFA0ei1LXIJFhOzIOd53cSYdpBzThBf/siT6WVcfCVmFGAVjjLSKvEWboTgzARw8sLQ
         cIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w49o6bLlxe70T8dk8RcKOKQ6ege87Mzu24iLNFJSi6U=;
        b=N2Usz9QV0voN3oRQOpLjrAdDYTES75BmhdB/qI7uQA0hZ+/IYs1N2oDVYWZDzPYOWz
         QDwh5UogTZRLJedY8fFtZKJ0wGk6Ujin9/J9K40sjHDVOHmRkt4S7eD9Fg0ldPeb2DTX
         dm+z7VLz3/+VCanH4gBM/0ms8SUTZE8FwGd5MLefVYtt8bRzjbwz8JGOroJQetOjXKmA
         s9GON5I7cTYsM9BPuloKERynhSWdcuE6sc8xAunFU2h0yCyIwt4x23Hs/JnycQE6QbAG
         blPRAVbeim7wyxAXptdx2v7D8TL8R4lqP9hB7DzQoNLz9UNrnefsmwuTtFS3Qg+cIeo+
         ixUQ==
X-Gm-Message-State: APjAAAXX89a6CBRDridJ0fAm0moyKZpcEcWO1YqC7zc+h5hzPw1dFPOx
        1GWFErffE21NyD4Bt4XNR4Dqmtkq/4Zqit9mTU8bDg==
X-Google-Smtp-Source: APXvYqxJDL4FyhE3BXAv2E4B/4JEGQGPdbnrnZxx+n3oo9L0E7CyQ/g/GKuusfARHUSvwKnun6uC2HwM7AK4drFXwyc=
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr17993431ljo.180.1568276647071;
 Thu, 12 Sep 2019 01:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190829071738.2523-1-andrew@aj.id.au>
In-Reply-To: <20190829071738.2523-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 09:23:55 +0100
Message-ID: <CACRpkdYW_PX7npB+b1YJ4pfFQNLVOsMx2hpKtntBeHg=C1j-Cg@mail.gmail.com>
Subject: Re: [PATCH pinctrl/fixes] pinctrl: aspeed: Fix spurious mux failures
 on the AST2500
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Wang <wangzqbj@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 8:17 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Commit 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
> was determined to be a partial fix to the problem of acquiring the LPC
> Host Controller and GFX regmaps: The AST2500 pin controller may need to
> fetch syscon regmaps during expression evaluation as well as when
> setting mux state. For example, this case is hit by attempting to export
> pins exposing the LPC Host Controller as GPIOs.
>
> An optional eval() hook is added to the Aspeed pinmux operation struct
> and called from aspeed_sig_expr_eval() if the pointer is set by the
> SoC-specific driver. This enables the AST2500 to perform the custom
> action of acquiring its regmap dependencies as required.
>
> John Wang tested the fix on an Inspur FP5280G2 machine (AST2500-based)
> where the issue was found, and I've booted the fix on Witherspoon
> (AST2500) and Palmetto (AST2400) machines, and poked at relevant pins
> under QEMU by forcing mux configurations via devmem before exporting
> GPIOs to exercise the driver.
>
> Fixes: 7d29ed88acbb ("pinctrl: aspeed: Read and write bits in LPC and GFX controllers")
> Fixes: 674fa8daa8c9 ("pinctrl: aspeed-g5: Delay acquisition of regmaps")
> Reported-by: John Wang <wangzqbj@inspur.com>
> Tested-by: John Wang <wangzqbj@inspur.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for fixes already yesterday!

Yours,
Linus Walleij
