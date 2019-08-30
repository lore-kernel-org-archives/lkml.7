Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF1C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E132342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsdOLh3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3Pzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:55:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46934 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Pzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:55:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so8034983qtl.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPS60ZvUrPKWZtl+RkrjFYWAeesWeeFgHOMOIR73Nrs=;
        b=jsdOLh3/Y7V/4TNK7iiR+NorbT7xmO3Yb7idUWb32Hj4NRV+G3z7ipJAFFFNGhJ2Sj
         VUCyNOTQrJgxIBWADs5bmO/IXZWTJgWNg2+v/6g4SJb/mucF0fVwZGKCeErqIl83KaKp
         LQKf8BZrx1VeJezWJb67KIXGIxJdZ/KZGBcRSnfIgRv+0fJV1ah9dHMYG4pOsHM1AZ19
         lFcr9UyJ4KAD2+Kwb9FNPkiopH3H6f3SuToPTSzq+OGG/9syMMAlNSq0CmC7Hle8qSdJ
         FN9YUoXp2y4nT6klrf90raaUD/33Stf+Raq8czonlnPltwuKqH/Qt5ghzSKdb+SuzN4N
         2u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPS60ZvUrPKWZtl+RkrjFYWAeesWeeFgHOMOIR73Nrs=;
        b=QZUYAxYBRAFZPorZEw3m37bF9pi5ZRbxWNwTy+WPXhGPzbLHMQ6JBg10V3r69as0UH
         Qm7KKC1GvPFj5Zr06MVWvON1hFA3F9jv155UJM/PLC8hneva1MfPhoy1SSkPoXTrs93G
         tOQq9EH7j15Z/0cOQUrv/6oKjX4lEqdr80K3+gxr8JmlJnXxbgnXthkOV0EG5SB8brqA
         UqJbVZluIYzUfrKaGN4hsEYILB4lsO6RmfscIhgdKjYIUt/hHlZQM5Xwi4nbHq1Yy5OR
         xJOVL2W9Y8YDar4ghL8whkJt4oaLfVAcxPYybd31V/7TmYTe0nCrNR/K5aCTLHFJbsCs
         bRcQ==
X-Gm-Message-State: APjAAAX/o0mv7BaTeqi5G0wmTmZ0Sg0H7J5ch0twsEl8XIjyOaUW1kPg
        Hf8PxUjHUvDr0v4U6eMDAGAAKKz9TM4raSuC+F80mjE9VX4=
X-Google-Smtp-Source: APXvYqxU+VEducGjRU5qhT6UzP+NhwGXWdV4SMeO0UgP4d5AxSR4Faioub2YVECETchjsX4oyNK4tXmIMps8yFhnp/0=
X-Received: by 2002:aed:3f47:: with SMTP id q7mr16074268qtf.209.1567180535102;
 Fri, 30 Aug 2019 08:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190830150302.20551-1-geert+renesas@glider.be>
In-Reply-To: <20190830150302.20551-1-geert+renesas@glider.be>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 30 Aug 2019 21:25:23 +0530
Message-ID: <CAP245DUWP6+2CyV2QA-Awo8JOUFjzjZmPHjM1On8XOyDbKGSHw@mail.gmail.com>
Subject: Re: [PATCH 0/5] dt-bindings: arm: idle-states: Miscellaneous improvements
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:33 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>   - Replace abbreviations "eg" and "ie" by "e.g." resp. "i.e.",
>   - Correct references to wake-up delay,
>   - Correct "constraints guarantees" to "constraint guarantees",
>   - Add punctuation marks to improve readability,
>   - Move exit-latency-us explanation to exit-latency-us section.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This improves the readability of the doc. So for the series, feel free to add

Reviewed-by:  Amit Kucheria <amit.kucheria@linaro.org>

> ---
> Split to ease review.
> Feel free to squash into a single commit.
>
> Geert Uytterhoeven (5):
>   dt-bindings: arm: idle-states: Use "e.g." and "i.e." consistently
>   dt-bindings: arm: idle-states: Correct references to wake-up delay
>   dt-bindings: arm: idle-states: Correct "constraint guarantees"
>   dt-bindings: arm: idle-states: Add punctuation to improve readability
>   dt-bindings: arm: idle-states: Move exit-latency-us explanation
>
>  .../devicetree/bindings/arm/idle-states.txt   | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
