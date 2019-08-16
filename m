Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D90C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDC420644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iRWDMDDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfHPGsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:48:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34275 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:48:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so8816699otp.1;
        Thu, 15 Aug 2019 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69UIcMbarjhdrqblJ4LWv1FLIeOiPNtNFw7aGmbQg8E=;
        b=iRWDMDDS+1mIRq4pdzsc1IXCplD9aAgt5nH0d0+crjiD+5WwkaPqOQwcmNKlkagwra
         2bbBFfT3TWETYTjOnmcpGiPwO4/nkxg82WPeubDIo8mzrc+ygLebn/UgnUdBLInhN7x6
         eccwLkDZ9B9O9kzHV1EiXK4txN0nS2Wd0ERoSP5wyMKicgp+q6LnKF3XaZIL0xcytyeQ
         hM+PJgJAMtf2hkKHycruU1nkcGuh+Qp4wLZcLi1WTGXrgcSbYixnaicsfqg4CIDW54SD
         OwE9QOE3d2ZSc9mJ/oPMWqn8k7IOqym09uKk+fUCujCbZFoldjha46XqPBsctqUMJ9S2
         X+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69UIcMbarjhdrqblJ4LWv1FLIeOiPNtNFw7aGmbQg8E=;
        b=GtsL17dBnD1wSjwOxJcQt9NrBB5n57AnyIvLWfMk2KkMXZd9VLoqZRT3S3VyTqd9nn
         mJcbeUHt4NI5i2lJlgSXzmbQIGCnNXeKbRRW6gvfAqa/1c+paAHcuZ2UaHwTEQzQq1PI
         ewB+Do0xMZwjwSwVjKYSO93t0VmOY9cZRZFu/J+ea6TSrDT0+lgK7xazNiTz5Nif8rjF
         3r1f9jLSuYvuKy8LeFJOLf3R33HEHxTG1bXmBpkzwegjluw0W1J/EeiUv3t54+wT9M39
         X+TObWfo63lNsHjfG+GWvXVgE0jV/6BUxBulsFTswMFv/C5MvQFyrXLU6odcVdbRx0on
         Xnaw==
X-Gm-Message-State: APjAAAWh/PjKQCJ7hTbo+kjFCFBkmMQ5vMCxnGFrWE/SuTs/fKwG8HYe
        2XPIPe6Q1CTnKzzW4bjvbdTqf7ho/fFhsC/7i0w=
X-Google-Smtp-Source: APXvYqzzqoSsKkhZ6FXvZvrWoEaQPuEcN4bSVATxJqc0lETNEYC6iL2J1GCjH/YD4B6bm8cg064kg3mKquDGxaILqaU=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr6440340ote.98.1565938099783;
 Thu, 15 Aug 2019 23:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190815223155.21384-1-martin.blumenstingl@googlemail.com> <20190815232951.AA402206C2@mail.kernel.org>
In-Reply-To: <20190815232951.AA402206C2@mail.kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 16 Aug 2019 08:48:08 +0200
Message-ID: <CAFBinCA1i=4Lu1xMVyASoFEDhCEn6phDb4h1s15h0ZfGRQX1kw@mail.gmail.com>
Subject: Re: [PATCH RFC v1] clk: Fix potential NULL dereference in clk_fetch_parent_index()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Aug 16, 2019 at 1:29 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Martin Blumenstingl (2019-08-15 15:31:55)
> > Don't compare the parent clock name with a NULL name in the
> > clk_parent_map. This prevents a kernel crash when passing NULL
> > core->parents[i].name to strcmp().
> >
> > An example which triggered this is a mux clock with four parents when
> > each of them is referenced in the clock driver using
> > clk_parent_data.fw_name and then calling clk_set_parent(clk, 3rd_parent)
> > on this mux.
> > In this case the first parent is also the HW default so
> > core->parents[i].hw is populated when the clock is registered. Calling
> > clk_set_parent(clk, 3rd_parent) will then go through all parents and
> > skip the first parent because it's hw pointer doesn't match. For the
> > second parent no hw pointer is cached yet and clk_core_get(core, 1)
> > returns a non-matching pointer (which is correct because we are comparing
> > the second with the third parent). Comparing the result of
> > clk_core_get(core, 2) with the requested parent gives a match. However
> > we don't reach this point because right after the clk_core_get(core, 1)
> > mismatch the old code tried to !strcmp(parent->name, NULL) (where the
> > second argument is actually core->parents[i].name, but that was never
> > populated by the clock driver).
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> > I have seen the original crash when I was testing an MMC driver which
> > is not upstream yet on v5.3-rc4. I'm not sure whether this fix is
> > "correct" (it fixes the crash for me) or where to point the Fixes tag
> > to, it may be one of:
> > - fc0c209c147f ("clk: Allow parents to be specified without string names")
> > - 1a079560b145 ("clk: Cache core in clk_fetch_parent_index() without names")
> >
> > This is meant to be applied on top of v5.3-rc4.
> >
>
> Ah ok. I thought that strcmp() would ignore NULL arguments, but
> apparently not. I can apply this to clk-fixes.
at least ARM [0] and the generic [1] implementations don't

I did not bisect this so do you have any suggestion for a Fixes tag? I
mentioned two candidates above, but I'm not sure which one to use
just let me know, then I'll resend with the fixes tag so you can take
it through clk-fixes


Martin


[0] https://elixir.bootlin.com/linux/v5.2/source/arch/arm/boot/compressed/string.c#L91
[1] https://elixir.bootlin.com/linux/v5.2/source/lib/string.c#L356
