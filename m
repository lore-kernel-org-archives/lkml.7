Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC8ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1077C20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSDqpUym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfJUUnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:43:25 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46504 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfJUUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:43:24 -0400
Received: by mail-ua1-f67.google.com with SMTP id m21so4219017ual.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/J47pHWT2X7Av3FRgY9sGp9A1Q4EsZtxdv8QeJCfN3I=;
        b=KSDqpUymn0gcUp8dFXPeZ/HiSZgbKxXfCtrzL6BZnLONWdSEVg6/Ke0KbCXr4Am7Ft
         PQ7LNFK0xrC/Rzs1NmPkslJtnnvIL1/aotOz8artc1tXedz3v4PQs1sCHzV7cj0E+0g8
         lBFOzuOMbrJ2UVV/FyJ/HXSxexJ2AOV1mW43p1ysYnPcCPjtOCz+n59DOMk3Y+RZbbmR
         ZVsEOEEmGtG+pvfHspdeVdID46tqH/wz/BTkQZiZIwOy4d1tPZAHvm89PAZtpWJzYBzt
         y+pBeWqeVU+tUEqfAuYYA2dOE2vlX3md/TnWCt9fr7Tobunt15FALPHuUxRBRVwCBo/H
         zfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/J47pHWT2X7Av3FRgY9sGp9A1Q4EsZtxdv8QeJCfN3I=;
        b=NRD1DRr8cVTYkpzM3JoJU2EFu8QBzW32Nmj/nKMxVwPxsP1stAoMHzoR/g0QLLiPum
         Uyvxh3khkAO9vl761aRI2Tz/5jfqUkZr7ycA/lRejRBOrJfFQTlPrf0qVAJ/maGi6pyW
         aPbfCsqC5KHXdaYmL8v8dSGywS5OSMJvYL9GHPFOAuluWxXpRW2U3AKAz5gtswJe4Fki
         S3n1JUBld52Cp1vR5J9gSXga727bPbPTTuww63TgoM0Vj577OxPt4pSqhIM9pmTullBs
         gR/R1MuceXHSFwC/pgfEYRagbiOlzwwkJQZWOLbyLbHr3bF0KuSlAunjTNUWkQ/mBqTJ
         80LA==
X-Gm-Message-State: APjAAAWPaXiv0uQwrfA/+LLT/5ls3iuk1XtMYVB81+GEns7h3vq6AS/r
        7p3xSWi63BDB/As+heCcod9k1rwh5VpF4axYNXpLUg==
X-Google-Smtp-Source: APXvYqz4ZEHugfx1iLTVr5oh8wcvQsZnhgiG/2ZE182Aies/iiC08Q8WJN0chuD/KhyaBz5bbSu/RP+GuEhOKFYCX9U=
X-Received: by 2002:ab0:5981:: with SMTP id g1mr64566uad.98.1571690602892;
 Mon, 21 Oct 2019 13:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-6-samitolvanen@google.com> <CAKwvOd=SZ+f6hiLb3_-jytcKMPDZ77otFzNDvbwpOSsNMnifSg@mail.gmail.com>
 <CABCJKuf1cTHqvAC2hyCWjQbNEdGjx8dtfHGWwEvrEWzv+f7vZg@mail.gmail.com> <CAKv+Gu92eR81+W1iXOXZHWgub-fNPcKaa+NCpGS_Yy4K4=7t+Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu92eR81+W1iXOXZHWgub-fNPcKaa+NCpGS_Yy4K4=7t+Q@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 21 Oct 2019 13:43:11 -0700
Message-ID: <CABCJKufZX7McCUoeH8=VR90gdQPCjUSNaPgjPRzo6-vV-y6oHw@mail.gmail.com>
Subject: Re: [PATCH 05/18] arm64: kbuild: reserve reg x18 from general
 allocation by the compiler
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 11:12 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Also, please combine this patch with the one that reserves it
> conditionally, no point in having both in the same series.

Sure, I'll just drop this patch from v2 then and only reserve it with SCS.

Sami
