Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE3C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1959220700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Io/Hf5q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfLPINd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:13:33 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38378 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLPINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:13:32 -0500
Received: by mail-ua1-f68.google.com with SMTP id z17so1766994uac.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn4dNigwlhxAQyKm9gOJN6QkFcnPQMlJTzy6sb2QOwk=;
        b=Io/Hf5q7xSuHylwL4OacRp4P2PsiZyoZaYrdRYlxqQKP0mShYWfBf+OMhO/2Np5ORk
         fbAabr9vNzYuqtaPzEs9468vWGCNFq6L07CpSEQEZDdQry1M0dq7J63v6z64SWxPOAwf
         aBsKNENdCTw1nW9p7XIYQuyMxASCHpUlj5HAzZvecr+WMA9OvIhKR8QH6qkSHxJvT/sV
         8QWyZr0vsXuIHqdImqYvcvVW/I2GLZFBKq/RBYiJ/t94ixC6bqbpO5tBZVkMH5O/SwID
         fpTlS9kNGShue2P7WPTC5Xv2q8hEBVLvMg4kHJ1x4kG+jy4ihbaykjFCICEm8rKO27mI
         0ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn4dNigwlhxAQyKm9gOJN6QkFcnPQMlJTzy6sb2QOwk=;
        b=WS33zob7lvkDLMVso+MIXGR080u/8Ah8Iu0DUu9SduP+WfinPwcP1j83USJIMm3UTx
         IrKUIXS4i3IVs8vWr1dgTYflay+5cT7cmDK7zgltWnndg9ZCpEoa/IuMMQD7J5MqEUi9
         wtKY67vZ+9t5VaM4KN8W1kU6CMBUiHlhxoZt2JqVEFEOCwRIiOQPbdHXZY1eS+8ALx/Q
         2XuxcVhRCU2rhWT+P5C5aKF4PKqhI9YwzpdSpSY+yvvK4u/PzvkuEkH1YGqV3bVYP5J7
         s2FP2bxo2m93SXPec7/297rx3Z3ALN3X1CbA3BaJtTsBKPWfk1jKVN2ko/jgsWAscmh3
         Xkqg==
X-Gm-Message-State: APjAAAVfSN111IgQEIhS2taOXeCrdJ8TWs404OXg/1Zj2iK83ZT37o9Y
        Ct3Y87uBd0s3HWbmW9bz/YpIZDk0w0o0JboBfHJqfg==
X-Google-Smtp-Source: APXvYqzf6JCyaHJwxPnWzJiB8wq7OgYE7mfA/OKhvFmoPueU8tPGA+C3vAw/23I1YgLjMrghbr0yx4mgW9xyWoMeQRY=
X-Received: by 2002:ab0:1c0a:: with SMTP id a10mr22253217uaj.140.1576484011659;
 Mon, 16 Dec 2019 00:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-5-ktouil@baylibre.com>
In-Reply-To: <20191210154157.21930-5-ktouil@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:13:20 +0100
Message-ID: <CACRpkdbHLv2R+XvCjCaEgaztUqpmHWCmSAqHABkkstJREkmfVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] eeprom: at24: remove the write-protect pin support
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
>
> Removing the support for the write-protect pin after adding it to the
> NVMEM subsystem.
>
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>

I wonder if this needs to be in the same patch that adds it to
the NVMEM subsystem, so as to avoid both code paths being
taken between the two patches (bisectability..)

However that is not the biggest thing in the universe and I'm
no bisectability-perfectionist, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
