Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77155C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398220848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7E50cMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgAGKpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:45:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40023 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgAGKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:45:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so54177752ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9S9o2rObb9NcqGJD/gxTAUBsVVzEmnZ0vQA6P9vvWw=;
        b=n7E50cMJgd8ZK+yZ/PZ0NrJg9YxH73/VHIkmsyonXLf3Cso0z9KB2VFwWTOt9Xzf4B
         /zyNRQIA7ik+lq84fT/CQn5Pnv7PhEP8Hmsv3PNtGobLUkgNOhSYL/43dAMhUMA3LhHz
         HHTDjFubRwbxkD8SEXOm9Sqe9mdcAGeDLth39DRwfDqNDZZJdwoqKTKGlzsevGn2lQPN
         q/itCfr6qxQHTm92z1Sk5+eidwdUG6DhbY+aRn7rco7AKG6deXKKkgACqlgVjutT5NEG
         xO1Sgaf7yUSKLEsDHrQ0WeZKXr88aQnlH/kboi0n6fEmWtJq5n+Oo6+Q1VO8HG75H8W/
         vaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9S9o2rObb9NcqGJD/gxTAUBsVVzEmnZ0vQA6P9vvWw=;
        b=WfkMHMEKY9FAPp5v/Y/Cn7CzX2K4JTw/rwFH4YowkUsbCVpXxTFTZDtVqO0bHFitKR
         OiqH64ni6uQGDonl0Cj0PtWX/u/wt4ODNejCqB+Jb5Ur9CEAn6Tp8YtRn9WJrrjn3GQa
         07L1SQcmENSk+9tjFF+8lbFG1Y6S7coALPba8D3rLlTVWFCY9AQoI8gxshrS8/E+yYUd
         bFfVPm77TpcrDHoFZe9LF7sw3wf5m4Y2Fwmj0afXVtz107zhhuGjvCGe9svdFmxNUuAK
         PAd8LY+HLNZrrDH2BWnT285UdVTlI3UFJJQri+/r1hk+lqpIT8A2izqCGD2VGcO2Tk4t
         9tRQ==
X-Gm-Message-State: APjAAAUdOJEdJ0V3W1uEP+gtGR3J8THGasVFTn1bkYg9KhWiza8WbOfL
        RW52bcd5pnRgY1BJK4gwp5D376Kd5eIqvggyBlGD3Q==
X-Google-Smtp-Source: APXvYqwKhnJxUXNI6n4/K0m61QsBl8AZobfZ5X8p7GpweLe3H/vUr4fwKKptKn3Pmh8UUgxfJ2f+IKh6o3+WhaNxMvk=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr61274799ljj.191.1578393918200;
 Tue, 07 Jan 2020 02:45:18 -0800 (PST)
MIME-Version: 1.0
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr> <1577864614-5543-17-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1577864614-5543-17-git-send-email-Julia.Lawall@inria.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:45:07 +0100
Message-ID: <CACRpkdZxQCfyWgWfFtnxo9wvV7z2d7jCLV5fBKW9wD2ZnQUp6A@mail.gmail.com>
Subject: Re: [PATCH 16/16] pinctrl: nuvoton: npcm7xx: constify copied structure
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 1, 2020 at 9:20 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:

> The npcmgpio_irqchip structure is only copied into another
> structure, so make it const.
>
> The opportunity for this change was found using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch applied.

Yours,
Linus Walleij
