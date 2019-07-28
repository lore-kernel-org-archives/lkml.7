Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23011C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DC22087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7wz/kPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfG1W7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:59:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42910 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfG1W7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:59:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id s19so40704658lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cpnNhjoonDmEkUXX/FcWxaQpdtFRkDDXf/a02wQO8U=;
        b=d7wz/kPrVXPPE0EK8nix4F1zOnDPPR6ikXZJULkZ5sS4YFG8eWhMsit58GZyzEp5dL
         1ax1QLhB7E4uAVdJOjxj+E9Ylok85UGjvaVRqo0fPGkyrnJSHADHB/H4IHM6I9K7ZaNX
         6cqvFpplywcDgxvt4kAsafJcdG68ujh55JQ3kLPOCEGWj/e6FAlrZSpzERUtDYuo1TrS
         gGqXZ+NFuISuOIiME8RXk9YOeww6fonI9TDbLVlOpjY9j8jz2ia3mCXezCUZ2qYH1iw9
         6Ms/fhiRzhH+4Y67bKctLFvAYUSDBY+XmBK7/ztMyJUxDa83imatYifeC83zdy14VjpU
         B6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cpnNhjoonDmEkUXX/FcWxaQpdtFRkDDXf/a02wQO8U=;
        b=EodxjrASuO0yKpLS0P7TLpgBeEzvISVfGWq7Gf6SNfMRoYG1Lmu1/2jOVRRAGcXaLI
         8Lov61WvZC9KFeZpxXNuiq1kJ9EigTdBoE9cd/+DnNg1Z7jmYmixinFfpU5VAMJXHYv9
         /kF8Tb/QnlwdzsHOjii5dEaQDti5GhgtRhTJzD6rHIpEN4+J8oAE6aa3yK+FPtB/nZER
         iJbbeAl9xikpq87AeZDpDHfZWMcB+bh47IlNfpLfsGCKKlZajOBGgz+eiRj0smDdyv4l
         XmXMhpeo00BvyM16G31X8+kuyXuFvIS6XhfqsTsAwUAECTdQgBCpucGOTiaLhgmwlMQk
         3PtA==
X-Gm-Message-State: APjAAAUirKrTU+bdumWNhfaInREreryXtpjNz4Xq30wG4gIkrSUpHaxX
        AZ6/rAnqfMAXfXxmq3LY1C85NHenDDvujczGq+BgUw==
X-Google-Smtp-Source: APXvYqwa2xZ1U26fwVAeM34mNz4McRVa0UDLuCcDymbTVYyP9jT+fg84OSSQiuW1P3zLmlBSm9n4azMLNBNPY3SL4x4=
X-Received: by 2002:a19:e006:: with SMTP id x6mr48911419lfg.165.1564354739013;
 Sun, 28 Jul 2019 15:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190707203558.10993-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190707203558.10993-1-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:58:47 +0200
Message-ID: <CACRpkdags1geSzrLxVGf11PvpH+c_N0F7oa=42C57geKpm2VjQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: Preserve desc->flags when setting state
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 10:36 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> desc->flags may already have values set by of_gpiochip_add() so make
> sure that this isn't undone when setting the initial direction.
>
> Fixes: 3edfb7bd76bd1cba ("gpiolib: Show correct direction from the beginning")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Patch applied for fixes and tagged for stable.

Thanks for digging into this! Excellent work!

Yours,
Linus Walleij
