Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25519217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2aicl3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDKNfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:35:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44574 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:35:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so5526603ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TY7bmJ7NRLLnhcPncGNQqexigYYBQfOzKK6h6pL7cE=;
        b=d2aicl3xE6CuyZ8CQEEpk9xqPADVCARa8/OvVaq4JW6cTCGCtGH+nKTX8AFZrWpB+F
         JzHMVY3MlaxEhgMOOlhQ0PLDv26rNWuyJsUMooxvacG6ZuBbye/pga2qKeAM+CZMRDkM
         B9i1fT5ZVHV3Nh6hOhsieLFYzMg/q7Ylr6c8lro4/Cjuiozusf/mQ+8atV/rLCNpu/Ye
         1Q9mVuHbQhPX1gU8iooQbUlfGk0w1XUmpsb3DX8CMYp4QJsmrxZyNxwfTf6kInmUcKRa
         iDaV9tl7ikZHMPack9X+HbhLSva/J+3U4QqLHV3ySDaGB+e2JyDTrbigQPCqJS9TAYgg
         ozbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TY7bmJ7NRLLnhcPncGNQqexigYYBQfOzKK6h6pL7cE=;
        b=Q9D7/jc3adW3bGfR2cmX4DnS1YzA2XQWBAZc+kHuIahraS3MSBMOVG3wNsZC90CzPF
         YG6CDo7J8KiqMbpJ/zcyoVyNtXvhqy3vXpeK0cLUCD8xi22ro9RrLryRS1j4osc22Zuj
         +vn8vkL4zJJCVIgAm/5bMP26T3O8AyWePBaz0VTXqM70dWLVo9RwkT8m1LlBhSgxNbZq
         taef1GPjCGvbsSC6w1kVoTCk6HO2R/ssq3+wFW2CYS3e/sSLYKHr5IKPoq0M9X3RPpWf
         7p6tyYwVlsZI7h4NDe32VsfjXtoqnqVrLzt4kvIHL5ZVGimLmPHWIabhZjo7UFs5juHQ
         KelA==
X-Gm-Message-State: APjAAAVdQZOtcLCbjUaCAZb2WZuBM49BlaUeMngyxhaobdVu8cwTVoOw
        KUUFx98HtdfNBfYmFnLR1D3j9FeosHxeJkoz+Jv0Eg==
X-Google-Smtp-Source: APXvYqyMM7BLWI/PMVpGSqoXejbdxbNoSmlStSUWak1ySI+ybefPrQFTLAQmv5/5F8B5lWcqruteyR5VgjOSGY4XN2E=
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr26395450lji.163.1554989740678;
 Thu, 11 Apr 2019 06:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190409123546.13960-1-alexandre.belloni@bootlin.com> <20190409123546.13960-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409123546.13960-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:35:28 +0200
Message-ID: <CACRpkdY-KdH+Yk_6xqyiiaF1NRMofVsw8pSop0HOdJnnAKvSuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: pca953x: add support for pca6416
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 2:35 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The NXP PCA6416, documented at [1], is a variant of the PCA GPIO
> expander with 16 GPIOs, and supporting an interrupt.
>
> [1] https://www.nxp.com/docs/en/data-sheet/PCA6416A.pdf
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

Yours,
Linus Walleij
