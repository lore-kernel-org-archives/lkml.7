Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93977C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629CC208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9QY044u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfFYPnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:43:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33318 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFYPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:43:01 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so796385iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0F3/IGgCCwnd7hMlU99ncUwqiOLR40qKHSq5IP68Mzc=;
        b=H9QY044uJRljFFwHucCOhLc4TlUNtF2kHhYxC7nwwj7+e/tHCH4wBUIrhXlWTyiEPu
         PemUAXZSYwJZtlfHJffVKvEOyXZqKhI/6jkT+ttlb2ujT+zSE9te3oFPz9WcsfrzevMg
         w7ExozMJAmIxfzxm3rh1o8NUDYrCpAyma1xsD7D8kUP4QTmKwdDZ1rrftq0x9sDAC8+b
         HTRVZlWxj4GDLZ3IWSfyUMSyqULhoSvLKmAzYgpKskjXpAuW/uK49oAWdRpxHsKfnYyd
         7fcMfy+qWWNQBnrF9892tr5yKgaPtSiWUPxKnOFQLCmEU/QWVaBSGGuyKR9hVMIQk3xk
         Z+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0F3/IGgCCwnd7hMlU99ncUwqiOLR40qKHSq5IP68Mzc=;
        b=uYYT9Dw6rNNyKXlQ10qMUnX6PN0eAZyzLV1jUcYvZK9+XYQAjyJwxb5C8K8ili7TzM
         uAJoeCmwtuTZRgeXevCaNyLuW/ARJL2YawnwoLHwavekhBO2wuqO8csfzEx79MTnz566
         6+qh+m9MBfubHTV08I2rlBOaF2Sf1EdH/nm0J26SwDbo15y1kKemyYtf+LUCaWGjxYIw
         eNO9LsfO3Rmuq8O1toW+6wocC5kZ6lu480RK+5V4K0KZt96S2JyyQgdi2bJCkatqHCAY
         xB4wjtMsqBxeEPrqKB1ualwURT7IZgKOf2AbLp6v0z7q552M6AnC56Rm0BDIs/mE9jQX
         SwwQ==
X-Gm-Message-State: APjAAAW7IhLE4/5dJ5POLaifwzhh80MbhSGk7qJOqrPBHe1KR9Qbus3A
        o7IEJ2eIbCpkZy3qgO9kj9YFMXwwlWTlpgMCDLic1A==
X-Google-Smtp-Source: APXvYqy1qg6l/v3w03fmOhhQuCJSIudrOjihUXD9r63wnYGsNHvJNpIBunHfZ0/IXmQPkzvMdLJ6JBNlh80SSu06+Us=
X-Received: by 2002:a02:5a89:: with SMTP id v131mr25486364jaa.130.1561477380793;
 Tue, 25 Jun 2019 08:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police> <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
 <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
 <20190624095749.wasjfrgcda7ygdr5@willie-the-truck> <CAKv+Gu8G2GQGxmcAAy1XQ5gkN-2fJSWAKCQQm9T4skYdh5cT3Q@mail.gmail.com>
 <20190625153918.GA53763@arrakis.emea.arm.com>
In-Reply-To: <20190625153918.GA53763@arrakis.emea.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Jun 2019 17:42:49 +0200
Message-ID: <CAKv+Gu8Kz8fN-xKoEqPBiKWaEza6wUkbGxbKPPZxe14QzYLbJQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 at 17:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:06:18PM +0200, Ard Biesheuvel wrote:
> > On Mon, 24 Jun 2019 at 11:57, Will Deacon <will@kernel.org> wrote:
> > > Thanks for having a look. It could be that we've fixed the issue Catalin was
> > > running into in the past -- he was going to see if the problem persists with
> > > mainline, since it was frequent enough that it was causing us to ignore the
> > > results from our testing infrastructure when RANDOMIZE_BASE=y.
> >
> > I had no idea this was the case. I can look into it if we are still
> > seeing failures.
>
> I've seen the panic below with 5.2-rc1, defconfig + RANDOMIZE_BASE=y in
> a guest on TX2. It takes a few tries to trigger just with kaslr,
> enabling lots of other DEBUG_* options makes the failures more
> deterministic. I can't really say it's kaslr's fault here, only that I
> used to consistently get it in this configuration. For some reason, I
> can no longer reproduce it on arm64 for-next/core (or maybe it just
> takes more tries and my script doesn't catch this).
>
> The fault is in the ip_tables module, the __this_cpu_read in
> xt_write_recseq_begin() inlined in ipt_do_table(). The disassembled
> sequence in my build:
>
> 0000000000000188 <ipt_do_table>:
> ...
>      258:       d538d080        mrs     x0, tpidr_el1
>      25c:       aa1303f9        mov     x25, x19
>      260:       b8606b34        ldr     w20, [x25, x0]
>

This was fixed recently by

arm64/kernel: kaslr: reduce module randomization range to 2 GB

(and arm64/module: deal with ambiguity in PRELxx relocation ranges to
some extent)
