Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871FE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDiykXcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfKYPko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:40:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44759 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbfKYPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:40:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so10339797lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0fv0VfL01xMdWSP2VZWnjiUfIRToWX/SHHYSb7AWDE=;
        b=pDiykXcQZnwwnjSM8z/UXXc2cWhQ80Y2WQKFkZ2nQVOg48dSX/ZW1msmjEqM2jY4Tt
         zolSUv0OMlPQe2xaDG4hdM92VycEb3YcTAz65YvJpy71C4AFoB26Vzw/BcsdWawHgtlh
         CnJoTT2GzlWnWFjc0xhPUGjuzFV24NUjw890zTWHXAd02KYWRg9OYCzTRwQXpHO85SeI
         mvkS4PeJi8h3r4qdNkU0qwB+DwY6swy3C6KBuDsB8gsvyjDVQSDsvks0Pbeqy7+FQOER
         +130a6Vpi9juXS9ZRp+eOUApSsICBJDnNnVVdps5djaZp9pFdkY6nHDrvi7wWf2g93eZ
         CX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0fv0VfL01xMdWSP2VZWnjiUfIRToWX/SHHYSb7AWDE=;
        b=APDIYKbYH2ghNBQe7i1D2kRBFysiQOnMjmGEy42kx6wgoo8H6vs5dWCv6WMmxpdhML
         /D9CTEkVZRg7HkSOhjFg9YNzyjR3HWcq97e+I7e9hWFRj7iUXRmaIVSJLjTRirFDnk6f
         n2K3AhP/wUZ3Q6lgRr/orQ4QRBN96eT+bfneWKI6dkA3Zh9GtmSaxsTEVMS57DgxY6Lj
         JGlzvOdD0uJsLkF4OrPABfsVewgYZDPqF71fe5LpCXtr02H1Qi2dYS/LN21GzAVhbM9z
         6IKHOECKmTAbDNuK/Uz6ptdph9mRFvIG6Y1er/xm/96LNieFvk6lNgULZwshE8MQwjXy
         n8Ww==
X-Gm-Message-State: APjAAAVFusiLNrAYkY/kxve//weePzPSQpryiv6t/A/VRelZ3Bx4loBA
        XGfhzGvkTuCxb+O6kwZqMQHp2fhkMPH4LXDmT6r5Dvzk8K8=
X-Google-Smtp-Source: APXvYqw91BdlGKEVy4ulicoxULZj24A25+7eXLx3jO76pVaXCfRubRgu+6uPho+861OVfUhMFk+EELc9kObLcEvMftE=
X-Received: by 2002:a19:f701:: with SMTP id z1mr15851906lfe.133.1574696442163;
 Mon, 25 Nov 2019 07:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20191125122256.53482-1-stephan@gerhold.net> <20191125122256.53482-4-stephan@gerhold.net>
In-Reply-To: <20191125122256.53482-4-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Nov 2019 16:40:29 +0100
Message-ID: <CACRpkdZ9=sZQ0+QxkKx-0GAAU0ot_nRgqgK4_wk3vGp9v+9DjQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: ux500: Add pin configs for UART1 CTS/RTS pins
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> UART1 an be optionally used with additional CTS/RTS pins.
> The pinctrl driver has an extra "u1ctsrts_a_1" pin group for them.
>
> Add a new pin configuration to configure them correctly if needed.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied for v5.6 fixing up a spelling mistake in the process.

Yours,
Linus Walleij
