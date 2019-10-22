Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C1BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BDE2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeZ/77yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbfJVFyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:54:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40694 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJVFyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:54:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so16461398wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70+N4pxkreRk5D8qTuATktL5M/ApNQm1mVe3QKo4Ow8=;
        b=VeZ/77yCO2vkRreTdZF0BmlF3aBW7GYN63ztZ+W9IxGlyzot3aZzQG7XNVjBY7A7oD
         5ErFNuJigjHDoajFcUUKer2ZNuRvqeRRkKDFwX0d2Zr1W2J0Sitj3DU47jafk1WpqrB9
         RO+JgyMPsgCHPUuHfaLf9mhm0FhMWiroTQMq0AMJS2EyfB2q8y2Uj4BUJeCO2gXI9tCY
         6QkWiBS+nVx6fiVGxPNCg3OkhqZK5Cxo3moubEo1LbU3pI9Z3P3SLfQSm8r4r1GEdvXM
         A3I5Jr0ovB215EmWyJbd+kRIvPhHLcOf8Yw0LDZ75fNBWsAH3Ssp+sYWHP4KD/+V8/GQ
         /NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70+N4pxkreRk5D8qTuATktL5M/ApNQm1mVe3QKo4Ow8=;
        b=ftdtM3efjZDG7mkFycUdEdO+nCBShvaB6ztNGjD7EDFWxWIGGm74ZS9SQ0KSmQxCoi
         xh+WvVrkf/PnRjaEQkC9Ix4vWI+HKkHEw0jZEZ50u8N4md9xeqrIHd8dWEcGtH+Dt7US
         Rzv412rvC0OI0NLn+9dDzbSmcU15CiFsEw1KtqB9WVsvsc+K55PKBZ0vBPoYum72waEh
         +QUtXy8lHbRX1QihB+2hchDl/dCFpDrkithS7yCTU+nAjuqKXlzf0e9V2UHHpfLuoTWV
         gs4SSI5wgnmw7slzSnyZcsHRxcvrhwhJ/F6Lc7Z1qcNvs9FfWGwTf/a7sl2KplfRcc1q
         579w==
X-Gm-Message-State: APjAAAUO+/8PSMwcgGteVjv1uZtilF9EAYSVr5wBBoCpzuFTJVdZO6Y8
        oJ7iPgBG+amXvRDme1CQGZFHOI6cEpzZ8cWwjJj25g==
X-Google-Smtp-Source: APXvYqwrYnGYkoL34VBIT6H+JNjJm/uZwOLCkW8JDJj+1Q/w7n/LWtklQn1YWpTuz0AHRX28UXgTzenaMPN3dF2ZvS4=
X-Received: by 2002:adf:9f08:: with SMTP id l8mr1573796wrf.325.1571723652654;
 Mon, 21 Oct 2019 22:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-15-samitolvanen@google.com> <CAKv+Gu-kMzsot5KSPSo_iMsuzcv8J1R5RLT9uGjuzJsxCVUPPg@mail.gmail.com>
 <CABCJKuf-tXu2ZhBMCYTHP3BU8g1i-0GGd7+YvyTDUc1kH2iZvA@mail.gmail.com>
In-Reply-To: <CABCJKuf-tXu2ZhBMCYTHP3BU8g1i-0GGd7+YvyTDUc1kH2iZvA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Oct 2019 07:54:07 +0200
Message-ID: <CAKv+Gu_b6eCy4BbM0xFBgL2EzW+eP5rH+wTOgNCO=ai-vb-WWw@mail.gmail.com>
Subject: Re: [PATCH 14/18] arm64: efi: restore x18 if it was corrupted
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 at 00:40, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Sun, Oct 20, 2019 at 11:20 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > You'll have to elaborate a bit here and explain that this is
> > sufficient, given that we run EFI runtime services with interrupts
> > enabled.
>
> I can add a note about this in v2. This is called with preemption
> disabled and we have a separate interrupt shadow stack, so as far as I
> can tell, this should be sufficient. Did you have concerns about this?
>

No concerns, but we should put the above clarification in the commit log.
