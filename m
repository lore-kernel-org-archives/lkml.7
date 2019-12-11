Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE26C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB26D2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DLg1Ex1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfLKSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:18:02 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37345 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfLKSSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:18:01 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so23662064ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSC20v3ZZ7Kn1pHo0qwS4Ke00bNlSDQ6xPcCLk1Bks8=;
        b=DLg1Ex1x9EZ6ClCxY4Pwm79pVYYhk7uoSmXnuv6VTILCuD4AWEfjlu1UuKiQYKA4ud
         XANl0JGCsKGJ6OX+2oYHjuAEGAX91bwsI4j+e68HRuGH1F9ZiAte76EvvwgmSa4uv3oj
         PpWXe8CXxhgAJNw8dlv9IyFxA0uN4pZ20pVks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSC20v3ZZ7Kn1pHo0qwS4Ke00bNlSDQ6xPcCLk1Bks8=;
        b=aQcYi+DSWh489E/V2ONk2bbjzJc6rf0+0ON36aetr3dT0BGf1Br3Qn2a76pHrvFDR3
         UuUUQuZXHkG8MX+fM6Orf5zY8o+U86OWyZebnEisDasyeGSRcuCLZ2Xmn4KTNpRox0Hh
         ylLV6FRVWApFk9iJDnjVd/onNQuSPpXhGCByqLM0SMM9NsIIeCe2sQKDXW1kAArXxUph
         nTZ37Gv/5wZQlUdNipbIACVbA6wv97Eb0rNI3G5qPsyB8mVJKPWdtUL361CD1+Jb5azN
         BYRZkONeluIMqgb0vEEYFz0lR5e8HU3jNTPvFuQyE3RDbwPGj6K6wMQ5Xb0qSL5MT4no
         usWQ==
X-Gm-Message-State: APjAAAWoYjasnV7HPLj7lJfOSa98fSA/xYu+FykSQFWicoOEE3hqEJNo
        a4CQNrr3arvbAKI1MI0SCXlfag18/2w=
X-Google-Smtp-Source: APXvYqxe7Fzn/vUFHa5IC74ZCOhYfecH8Pky0wAFIm0d+zOFuom7j7jlaTmJR0fZ1LcrWTUhdubZYw==
X-Received: by 2002:a6b:fc01:: with SMTP id r1mr3509171ioh.33.1576088280967;
        Wed, 11 Dec 2019 10:18:00 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id v17sm927097ilh.12.2019.12.11.10.18.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:18:00 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id z12so20268809iln.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:18:00 -0800 (PST)
X-Received: by 2002:a92:1547:: with SMTP id v68mr4237963ilk.58.1576088279911;
 Wed, 11 Dec 2019 10:17:59 -0800 (PST)
MIME-Version: 1.0
References: <0101016ef3cdac32-1353f7d8-b973-4881-86ec-589d50849765-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ef3cdac32-1353f7d8-b973-4881-86ec-589d50849765-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 10:17:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+yM5bfHPpkwC1-DUmq4fbDCKiN-+JzVQH2VWjQJ=wYg@mail.gmail.com>
Message-ID: <CAD=FV=V+yM5bfHPpkwC1-DUmq4fbDCKiN-+JzVQH2VWjQJ=wYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sc7180: Remove additional spi chip select muxes
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 10, 2019 at 11:12 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> remove the additional CS muxes that were added by default for
> spi so every board using sc7180 does not have to override it.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

In theory we could add some extra pinmux configs that boards could
reference if they want to use those chip selects (as long as we keep
them out of the "default"), but it's also fine to wait until someone
has an actual need for it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
