Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB52C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121622253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scNwe2O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLMIsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:48:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44827 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLMIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:48:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so1329211lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rr+x1DIP1g1/KgRpSfHJSzeL4NNFx671OCjuV/vX6RI=;
        b=scNwe2O5QhBXfBOt3IjCVoJEjevAiU6USOetssutDbJWLfyJWVndWsZDvWW71CQYiG
         VK32P310iwbnHOT1jW8wAoNgnvxcSzuTv/55nym+iU6x85ADbyGe1huamHVHf2zC1F93
         JIbdPRQN3GvjL3s+GEMrZT6y8V16Uh4+LI1tFWsSR5KTxof2G76+m/XoGWjbhnDRuecl
         krXxgWelnmTmt5rkaX32h5GcAvX/L2Ey4bqai7cPz33O2iMreAO5hqS+JkwSK+1PfXsv
         s/VWYkuayvgwdFBiWWoh1DZ122uMgPhAQRJDA4clNr/PQWVjz6FcV7Vau4mqKfNTPMmr
         +bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rr+x1DIP1g1/KgRpSfHJSzeL4NNFx671OCjuV/vX6RI=;
        b=ftK6n125FpIEFr8+MDqmnU+LKYwmbUTrkvvQVVc6OsfSh4/P9vzmvcMmQqF3rVGXT2
         nOCuWZUZtQq/bZo2iG5dN6r0/YbwehN5Qn3wNCv257jusmk7CYG6Kn2yrJA7SIwhZ4jl
         dYWLJEuzbBvSCYLeI91fpBaIpzTJe06sKo7ADL5DKfTZQYMD+2DkD0+kRx3aeWqYF/kU
         AUF418cWzlwmyLzzCEUNw7OiKZPRW0ai3AsvxgFRNmGYI7uC/4NIVWXXuY46IsHySmR1
         UNVsQmbNP9Qteya95e7YnKQEEKnd91sUuWgdS8Ubx7KOrNuS41+o/DXTRuDJYCyfrrcU
         gc3Q==
X-Gm-Message-State: APjAAAUc3l1/ouZ5QVSEOaA0V8KzBYn6gPBlE4swv11LXhm5yzGeqlvP
        Z4U94k2HDDYL2YWUViu6GUr8AtRIDQsqfYtHHM+CRQ==
X-Google-Smtp-Source: APXvYqwhoLPGJ2pldnisIzV0cBSTI53njCKP4Cy76wqlT3521n0r+bpxhYrwfU6BsfJhR67BVugqRW4tqQaZGqxTt88=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr8073967lfp.133.1576226890954;
 Fri, 13 Dec 2019 00:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20191203141243.251058-1-paul.kocialkowski@bootlin.com> <20191203141243.251058-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191203141243.251058-2-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 09:47:59 +0100
Message-ID: <CACRpkdb2dvdyAUxt98TaoKAyMsFgZkOyUnn+J=NYWrnjRvp5dw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add Xylon vendor prefix
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:13 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> Xylon is an electronics company that produces FPGA hardware block designs
> optimized for Xilinx FPGAs.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
