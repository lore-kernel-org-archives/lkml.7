Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1958DC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B8220815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZ2HOcb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfEPNZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:25:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35043 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfEPNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:25:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so1736835ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7i74xwX9U5ncTUvzhWe57o2tW8tsCxNGT7kMEIaIPk=;
        b=UZ2HOcb7CW2/11jSTnSPHfiHBasuAf7GrJd1OBF6+iXtAEPjKJR5dDzMbRtLzM4B0l
         /VkhzqF8QqngYjEeMk13keD+R52PQsWlMoV5kTRyWfoAgz9X9IgjKR6nnUSsEwV0mlvq
         y+2K3uxFvkCLSlgMAAxkNqa4ewh01JlutozwHyviQURNfG80lV2yU7d+3oyeWqBazhAI
         kuHMJC9agm5hBYp4WmqgZDYo+Xp7/nQBxPU7o3rG/+09m1MHnx/mOwKZsbFpC+wr6c5S
         sZFsWoZBbHj9rRsvLHsDi9DOijCG62RpIhgTZ5Oe6FQPq/y2Q6YEKijQk72SopivTngI
         oXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7i74xwX9U5ncTUvzhWe57o2tW8tsCxNGT7kMEIaIPk=;
        b=uOE7Aq4mYJJVe1lGi/5yFXBl0CiyjYlKsmjjb55t5LawT05TVWyHmv+E50sYaUJh14
         zxY8sqiJDHv40fob+zRE0Gh2XbnEmdXnuVIQ5pokHDmLEDW7uClMZQoDjpenG6Sls1Xw
         j1bJIM5IaEzgkcQrj0JY6h703y9BTthY5Ef0QBcR2HExhAx1zLViU2y7PssJpVRSr31R
         AGPv/wSkGy7hjlPzzb1Fphc3/9I+TC3DxE67DzX22Vbee9btlo0s23Z5p000QsKoxSLT
         l8eiOyOfFkZmEZvZ+WNzWvSXZRHYndnXcxD05hyAq0TW3VubTLv5GZqPgQ9sh2F9QWK8
         oPtA==
X-Gm-Message-State: APjAAAXGFV2sD8eZWKSfAZTSkLIowpJBsLSvguealU1gdt2biMfvPOtk
        JFn4KzTpfFcXZkizNR/Tg3N0sD04t/dLsOAX7EHxVQ==
X-Google-Smtp-Source: APXvYqypGlrkwcWpkDZqIzkGCG+DJBLuflw6yusCBeidrQObvNv3EKCslo+yOFvLup20kJPOGzeawHtuUNUjQ5uzhwo=
X-Received: by 2002:a2e:731a:: with SMTP id o26mr21535501ljc.105.1558013113062;
 Thu, 16 May 2019 06:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190509205955.27842-1-f.fainelli@gmail.com> <20190509205955.27842-2-f.fainelli@gmail.com>
In-Reply-To: <20190509205955.27842-2-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 15:25:01 +0200
Message-ID: <CACRpkdZqAi4bbpGO8sTBq573dDRF-VWg9gE8=uGVJ3Jv0MY5bg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: bcm2835-gpio: Document BCM7211 compatible
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Doug Berger <opendmb@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:01 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> BCM7211 has a slightly different block layout and some additional GPIO
> registers that were added, document the compatible string.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Patch applied for v5.3 with ACKs.

Yours,
Linus Walleij
