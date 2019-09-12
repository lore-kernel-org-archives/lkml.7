Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DDAC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C4E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltewyL2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfILJSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:18:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43518 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbfILJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:18:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id u3so3610654lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+78ps/YcRgQREC8bdm59/QXTeZLeIK2n4ix1Zc6YuE=;
        b=ltewyL2WgM1Du8dsV1BulMpBXfyc5iBPw/OicmEDuWpykUKquvS58FZyFlFBoWGtYE
         DKivTxiSwd/VoeS716Qu+MOJ/knvInl1KdWOq2lle4uy/NNshh9dxaOSW0ho5cGc/YIS
         9H3XI58bOMEFypzNTyT3bsNgLV9SmSW9bSRXPPFNUteYYdEH4vptUz9AKEiBCLeiY/j8
         odpcJif9v89xjj7AQ8suKy+VPNdET4YNK6pP7LrzIIvnY88gZGF+YyXjETcPUHcDjk7r
         YEoIXw2SKp+KmhwxnbZtXq6Md2o8+wF3kOx6YoT9qF7GqajMiozNqKiwjeZyFLh5ko7z
         V/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+78ps/YcRgQREC8bdm59/QXTeZLeIK2n4ix1Zc6YuE=;
        b=JRi2hG05D5B3mmkmardboowlsbKVjihdYziP7WuTY2/eZIwc9R0A1xJUVGYoMVRy8P
         D4w63iPH5vPXS02gGwTGv+L0YPWdV1zdzphP8NuB7Fj8qSFtuwwXwuR4nePIYR5SLY9q
         CEH2wIecL1brg1MXsvgXjMmtgxOtMMWcxICFkAeZvmA8qC9SILnrhM5ln/Kv1mT4MEEt
         C3bUT81N2CXdBGNOFX/dcUJzR3WdRfpWEBxs7DMJZkPeKo5xCe+C67+lY8SpEDw13lHf
         380+wa+DyhCHxxHlmegqONFP7XGlkkMg97y5DGxgtkFLbDZcGLrKfE52WeDxnotGO4Af
         tOcw==
X-Gm-Message-State: APjAAAXsoXKgqWjEoSmFRkJeEUtUo5FwIdv2zqaWzDfGPEN4FdE1wmBy
        G2UyTGxrWazUv8vvjVCcOL2ai2hu2lOgxNhJdYYM4A==
X-Google-Smtp-Source: APXvYqw99POSQQmybjyQTzX+pmWjYXGnqHl/f+z6QV0Owgv09UDDxoCLWxb8BQV1wLRbkNBmLMTRSaxBTJicMRvjXTw=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr27498145lfp.61.1568279925827;
 Thu, 12 Sep 2019 02:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190910152855.111588-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190910152855.111588-1-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:18:34 +0100
Message-ID: <CACRpkdYGCWc007s-9_jvX2aKuZv8fTfV2UX-qBBi7WtePABMVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: syscon: Add support for a custom get operation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 4:29 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> Some drivers might need a custom get operation to match custom
> behavior implemented in the set operation.
>
> Add plumbing for supporting that.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Looks OK but as noted in the other patch: we are accumulating stuff
in this driver, possibly this syscon part should just be a library
used by individual drivers that can be switched on/off with Kconfig.

Yours,
Linus Walleij
