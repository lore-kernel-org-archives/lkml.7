Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB3DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815AF2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeE6N9Qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfJOJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:45:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45363 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:45:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so29570380qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuwbPy/XmKCY0U76JMQpk5/m+pE5mAJDWkIYV6IvxvQ=;
        b=CeE6N9QdMdIVctB9Tceqb869TD2JKTpcLrpeU6YItEB7Z2B2yiEuwlfAg7Rn+s4H1c
         ExBSM2csw/eRwwEyEC0w5g/FJZTMjFUuQTvLRtwiGWQJNQa2O42dnlz8ukyH8zc+N22o
         yaAb4Of68KBVtn3VvfXdsWb//2GPAD7QpsMnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuwbPy/XmKCY0U76JMQpk5/m+pE5mAJDWkIYV6IvxvQ=;
        b=qUgowavqRsrlNsL7/2j8C6Nn/tYbIR1BCnm8pmaCZccf3WmirIOA91/EACP62DOKxX
         s09fNGbxHtJtbSwr91IAKwEGzVXL3tF4DfLP1yByAzTN4jAEd9t4l/DEjhHFUtVcX77f
         aspScPc+lRnH5c5iheKB8Y5Ah4UUUhVhA0P5DCwU2ssAj6C6N3N+4B2gyZMxcq4r4Bge
         mW7fp7LJjW/5lliWI8oJap/nR8Mz5StlSxlpDDxRacFnIAbNsB/v/S1uCADomWXpsJCT
         M1YzEfVg565hrhJ8gPZdLE2pw/qOpf0UoL1AembdP2I1/VYDMFbyRJKqDUEuImNC8hHz
         +g5Q==
X-Gm-Message-State: APjAAAXA/p0TDBhjLat/s70WVGsFQI5B7lCLzRRaXiLQT8sga0W1clqY
        Wu8qoVO68owcuwKFGPs78WDZNw9PsUkuwVU2UBgYcA==
X-Google-Smtp-Source: APXvYqzSSZi8jfnpLO7WbqAympvckarIZABAn3nzCCpd9yyJ9QTOxGOcAmoXV1JBhz88rAT7TGdxXFpfOM2ncKxkFI4=
X-Received: by 2002:a0c:d610:: with SMTP id c16mr34911499qvj.229.1571132718984;
 Tue, 15 Oct 2019 02:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191005113632.GA74715@light.dominikbrodowski.net> <20191015004041.oijbe245is5rhev2@willie-the-truck>
In-Reply-To: <20191015004041.oijbe245is5rhev2@willie-the-truck>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 15 Oct 2019 17:44:53 +0800
Message-ID: <CAJMQK-jveFn_DEmqWJk7Y+SP0oPRJQFJSAj35NkEKbEkt+0cMg@mail.gmail.com>
Subject: Re: [PATCH] random: inform about bootloader-provided randomness
To:     Will Deacon <will@kernel.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 8:40 AM Will Deacon <will@kernel.org> wrote:
>
> On Sat, Oct 05, 2019 at 01:36:32PM +0200, Dominik Brodowski wrote:
> > Inform how many bits of randomness were provided by the bootloader,
> > and whether we trust that input.
> >
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Will Deacon <will@kernel.org>
> >
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index de434feb873a..673375e05c0d 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -2515,6 +2515,10 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
> >   */
> >  void add_bootloader_randomness(const void *buf, unsigned int size)
> >  {
> > +     pr_notice("random: adding %u bits of %sbootloader-provided randomness",
> > +             size * 8,
> > +             IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER) ? "trusted " : "");
> > +
> >       if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
> >               add_hwgenerator_randomness(buf, size, size * 8);
> >       else
>
> Looks fine to me:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Will

Thanks.

Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>
