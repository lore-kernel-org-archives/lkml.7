Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189722168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtrVEo5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfICPIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:08:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37608 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfICPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:08:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id t14so16438529lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2yAjc2hJCjjaepN2ZkdwcHMrEZsiJoFozFvDMefoRw=;
        b=qtrVEo5hiEW35+KHBeaMmVNP+7Pnoux7SAr+dyV7tNyctOLt0hM5XqWoYPZZAosKMI
         ujnpolv8ByO91hPnZoRt+YWHlIUkQ2u6/6VjKlmhzdkIm1sgCit0OGgmOzsuH+PhZFUN
         oJC0gsIhqSEQ4sl0+ZbfG4zHMuIEyQj8ZZEsQ4ApjqeVnKOmrp3jQqmSxchD7PA6YekT
         FF8nlVXY10LaZFbVioK8GJ3bIVnbNhubmxqaMJROiKkgRe5kFzb0X3peWRlm8c4Pez6a
         Qkzbxs/8bH4vGVU1vD00OoGGnuZVseGxwWA2ITQ25bYTNpqqOtM18qDObGrQ1QKjECus
         n/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2yAjc2hJCjjaepN2ZkdwcHMrEZsiJoFozFvDMefoRw=;
        b=NL8Ub/D+rbxjKMGctMLJlODGlyRT/5slhE8ERy01ro3E/R1YnSyF94iGNH1Fo7XFFw
         eXpV7Xkgzt+8VydR1WD1V9UZF1ZNrXUonJSfgRMNUx1adQeltlCvLoMZPQjr/n7mGw8U
         l5/9SJpI/XRv3+6irBSYI9VuDoVPWUH9zHJjXyeUpT3/5Mu3fpjNjPN7wcZiZsZHeC6I
         9Ep7IY5lEh1KQITCifJncpO8UZr2Sb+irkg9k9sjt6f+d61VQvLZ/mq4uDsCz5FqDsKT
         NkAsBAVKbsnKF9HV+sUHPXH6Lge1hhPF/SCR+KDb/mFIsKusrnNIAiewd4M11X/gH0VQ
         h+RA==
X-Gm-Message-State: APjAAAV2jgMf10S3xjXOD5C8F6Sg1hovqQPgG5uJdjwMjh8ojmA3rRyC
        qbfYhyiH0OlUQRQsfVvGp373hYpF0RARPoIxBlU73w==
X-Google-Smtp-Source: APXvYqzHTJ4rXh88bRtnP+VcBH4Tx2ddUfKifZ8gVfeGmMwa3ovSQrn97zqTmcBfvcoIoTIQ1izbtNDwn6zYYGzgiKY=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr13192354ljj.62.1567523291209;
 Tue, 03 Sep 2019 08:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190903141215.18283-1-dinguyen@kernel.org>
In-Reply-To: <20190903141215.18283-1-dinguyen@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Sep 2019 17:07:59 +0200
Message-ID: <CACRpkdZOn+P6R3RmQEyk-LQ9-g-ng-mVepghS6+Cic-6xMrNjg@mail.gmail.com>
Subject: Re: [PATCHv7] drivers/amba: add reset control to amba bus probe
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 4:20 PM Dinh Nguyen <dinguyen@kernel.org> wrote:

> The primecell controller on some SoCs, i.e. SoCFPGA, is held in reset by
> default. Until recently, the DMA controller was brought out of reset by the
> bootloader(i.e. U-Boot). But a recent change in U-Boot, the peripherals
> that are not used are held in reset and are left to Linux to bring them
> out of reset.
>
> Add a mechanism for getting the reset property and de-assert the primecell
> module from reset if found. This is a not a hard fail if the reset properti
> is not present in the device tree node, so the driver will continue to
> probe.
>
> Because there are different variants of the controller that may have
> multiple reset signals, the code will find all reset(s) specified and
> de-assert them.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this patch into Russell's patch tracker.

Yours,
Linus Walleij
