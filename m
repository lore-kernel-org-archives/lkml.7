Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA79C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A405A2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2rtsNq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfFQO7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:59:25 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42252 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:59:24 -0400
Received: by mail-vk1-f196.google.com with SMTP id 130so2117244vkn.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeDj455KpUjyGeFAvU/iNT8gTzAGIt+VE2V1K3FogGo=;
        b=x2rtsNq8v/D8WowlfZi68S9op6AgNbvw20AEk01oXwgbgkkIqGoh7yUHC2b/x+Fpks
         hklTr4vyJFfnu46NYXoNF6cujUaH2nJQMgSndZx6YhVWpyXQREM/XIlZFWsCPzzqbYiZ
         d9i05TZWygp+RIske9k1qLrWcaQAd/Qz+aN1n8KuXzvzWd2HFoqGQgZsdgg5slwtqKvh
         pPhE+uUNLhxtsRLRSEVjSrQiG5JEQ60sNKYn0vQTydYe4bzRPTx6iuUywg9Zsu/SsUjU
         fWFjgza4amZzX20SY1DLOo9T5LBGUNCZv8ErViIL7AVqDk5W7UW8sqW9LT4snHzVQcPl
         Y31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeDj455KpUjyGeFAvU/iNT8gTzAGIt+VE2V1K3FogGo=;
        b=SZ1JQHJUF07UqoZWuHdhQMCvbdlpsG8o+ycJIZ0dB+hgI+6XVY+JFVMjaPClTQzPUR
         R9jk2FxRv853/k5qYpBOd5diYd1ukQFdS/BuhdUQ2vYC1PmjnlXjPGiXwScVJ9m5MPYL
         kc87kM+wRAGXQqLJJ9W384chDNCdHlne03Pp9XQdOzDxoiA5AwkKVW+jlm1eUNjIe/U6
         Eyn5d3RnfsIphgkQ4WOCXPJy793NefoM5CY77u8ctTcQqEfX89sdMtqKIQhLQGgC1dJI
         REyqjksBu4VEta1gO8ueOdLD9DEjA3Fj/K1nf3cZvrRwsGuybuIWAuMrkUqI8LnwzfGW
         WzBQ==
X-Gm-Message-State: APjAAAXQstI6xMqitOfjXQwlby5xPKLgxKIgmS3Z2Qi+vCF4rXjIHbBl
        firAniMly3SGK8EXCeq13+76AONx3mNExlGkvPe6wA==
X-Google-Smtp-Source: APXvYqx84xD50NIMODd6WRKKp6Two4nx8BrixlFjO5oD+vW8e0fmtGE84cRELHAfY18BaMIh0MTDpgLtd01jmw7jVCA=
X-Received: by 2002:a1f:8744:: with SMTP id j65mr43978757vkd.17.1560783563932;
 Mon, 17 Jun 2019 07:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
In-Reply-To: <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 16:58:47 +0200
Message-ID: <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >>
> >>
> >>> In regards to the mmc data part, I suggest to drop the
> >>> ->set_tap_delay() callback, but rather use a boolean flag to indicate
> >>> whether clock phases needs to be changed for the variant. Potentially
> >>> that could even be skipped and instead call clk_set_phase()
> >>> unconditionally, as the clock core deals fine with clock providers
> >>> that doesn't support the ->set_phase() callback.
> >>
> >> In connection to another version of this driver for latest Xilinx chip
> >> it would be better to keep set_tap_delay callback in the driver. The
> >> reason is that new chip/ip is capable to setup tap delays directly
> >> without asking firmware to do it. That's why for versal IP there is a
> >> need to call different setup_tap_delay function.
> >
> > The ->set_tap_delay() callback is for ZyncMp pointing to
> > sdhci_arasan_zynqmp_set_tap_delay(). This function calls the
> > clk_set_phase() API.
> >
> > What does ->set_tap_delay() do for the latest version?
>
> There is different set of default tap delays which should be programmed
> and it is done just via writing to registers which are the part of
> controller address space.

Okay, I see.

Not sure what makes most sense to do here, but it sounds to me like
another ->set_phase() callback should be implemented for the clock
provider. In other words, calling clk_set_phase() should continue to
works just fine for this case as well. If it turns out to be
inconvenient, we can always add the ->set_tap_delay() at a later point
when it makes more sense.

[...]

Kind regards
Uffe
