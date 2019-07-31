Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FDEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480B1206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTcevW9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfGaUeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:34:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43600 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfGaUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:34:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so14308693otp.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhyyuWidO2twh71QoQ3IyDneg0h8HkC4FDMzjkF1Knc=;
        b=oTcevW9uWVkAu1HV6ScFP/3BL3h8q7oqrox2GAXadT4n5q0fxkeVFbK61hBM1/FX72
         amIN8l7y8mL4tsZTcwiOivgqwH2T8WKYhShkXthvqnDicbFspi0XhjDECDABx9LCrMuG
         JZNA3dGkqlFWZMZt5XCzikl64GgO3fBtlV9EjDQFaMgVcW9Nk0in+KkuER5S8EVeGz4d
         HQ6iUlv+QZ0oNb4ux5lopRditexf/QmMVvP2nC4i469dNzzRP4pbUlYzu7yHsA8dpv7b
         XQ16lnHfRO/36EiCH/gjJDx9n986zIAHcLvzTIw7rL9X6ndZyk/KdYABIhkC90KHoqjR
         cuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhyyuWidO2twh71QoQ3IyDneg0h8HkC4FDMzjkF1Knc=;
        b=sKsDRL7QQo+VujdTjvAqen0+MzAHS2QPS+2x/UCkmvKVzdyNnCToHnYdUsOT5dYNEM
         kEbTxDa7RWqGHKX4Wd/Ftttdvmy+TR3Wd/ZbTghjoJtRC3CmDq/RIm2TvnOAyahNS24H
         rrwbfSNWsucE3h4ZcQ8lsxJUVYFSzyXtHeRbpp0Sfx0XNgxmTU5U7LYtCLo5RGHvK7Gh
         1Q1a2IalRyLNDejyc2lYDI9cr+HMThTVRH9QlDCirMGYhFq4G5VSx0rsusD5P2e5oOa2
         q4VJ/SgYgZHQeMY6xrZ3rpYzRqNngbBK1tkl89but891nsdSykSBJot4dLTS9/tZmR9h
         ZA+Q==
X-Gm-Message-State: APjAAAWGSd4QT/W5BP3GOInykIng6kOXMuChTeyDVpZyQomIkKHZpTCV
        rR9CX+ejyTUOaT+08ldv9QL5H/YwG9MkRuf/kI8k4g==
X-Google-Smtp-Source: APXvYqwXtu9HEqzwg6BxGW5PDsoBHhz2CdJ/FLp995gTLUpgkjXsVaauGGNSjFMwkoUiNFLz7F+W3M46Tx08cZEpBvY=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr37738641otr.231.1564605256524;
 Wed, 31 Jul 2019 13:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190729221101.228240-4-saravanak@google.com> <20190731181733.60422-1-natechancellor@gmail.com>
In-Reply-To: <20190731181733.60422-1-natechancellor@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 31 Jul 2019 13:33:40 -0700
Message-ID: <CAGETcx9LXP9b_W_1XQFmjODPJVrbnU+vH1RKer2i=jU7Q7EADg@mail.gmail.com>
Subject: Re: [PATCH] of/platform: Add missing const qualifier in of_link_property
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     David Collins <collinsd@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:19 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang errors:
>
> drivers/of/platform.c:632:28: error: initializing 'struct
> supplier_bindings *' with an expression of type 'const struct
> supplier_bindings [4]' discards qualifiers
> [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>         struct supplier_bindings *s = bindings;
>                                   ^   ~~~~~~~~
> 1 error generated.
>
> Fixes: 05f812549f53 ("of/platform: Add functional dependency link from DT bindings")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Given this is still in the driver-core-testing branch, I am fine with
> this being squashed in if desired.
>
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index e2da90e53edb..21838226d68a 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -629,7 +629,7 @@ static bool of_link_property(struct device *dev, struct device_node *con_np,
>                              const char *prop)
>  {
>         struct device_node *phandle;
> -       struct supplier_bindings *s = bindings;
> +       const struct supplier_bindings *s = bindings;
>         unsigned int i = 0;
>         bool done = true, matched = false;

Odd. I never got that email. Thanks for fixing this. I'll squash it
into my patch series since I have a bunch of other kbuild errors about
documentation.

-Saravana
