Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8544EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518162080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iKHwwFm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfD3UD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:03:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36458 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfD3UD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:03:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id b18so4107602otq.3;
        Tue, 30 Apr 2019 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYR0s9sQkklCAWRjV7jXlmi9PCAdhd4yUnNe8GUQ6e8=;
        b=iKHwwFm0ncZW+kXAshLVCHC28psurWQTUGj9bimhWL9ha9I5gl7REkrkzB2xnO/CwN
         bhtCzdNiS+Qyfc3EjCKc6ojSA8FLnNwclGMzmxDPKoSecC2gMcHb0x07P53XyhW9SSDo
         +QAo2iGG1ndvjhk4AWqj0hr6DPCFvPrM5qpTjspc1zuCKvqtSc6S9QOFJBoB3/gdXxPd
         3BvUw9SXwNpo3dnRk9aYRq5C9D6en6VmQrhj1LD1h8bQntRro0jvOCYdDUPcAlGMPJ1K
         LciPbrOdtZhN+0cXTzFrX+MxO/IO3K1KvR1Tw98+ZXBO2p3RtpKJ6JBoX+sTtgk2aDkR
         gI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYR0s9sQkklCAWRjV7jXlmi9PCAdhd4yUnNe8GUQ6e8=;
        b=OWxYTj6CRw43E/C/xPIB6PJrnRyEbdQoxAqfvz7GnOEJXOvVPOPwbDeubUNkS52fTR
         PeYFZkKSrKlfrcP3pfAO7KjHVdfFELyO6IcS+GdL+CPNFt/a+3SitApf3FjgeHZnznKC
         hH7m8XsG1HSRPn5qjkP413lQA+ddlObrOZLlS35H+fxWKYiv6X6zPAz8oGU+jcuHhkWd
         Mq32gbkFZTQdxmLFXI6/l6Zua0iqUIcWGhEg76+9hU6t6tgMkBosmLxSpxYOe0e89Vt8
         B5YUOcfQIRekPCWDJOtWX+nqox0QKAkB2MAB50paGx+fgCy7qyd/ObqPXGqdFVAkbKBz
         AVmw==
X-Gm-Message-State: APjAAAWCewNStDUnRWtbrtlLCRUZJmyzsEiE3rJOOf81eNdgAoOBYb8I
        ftVOV9h19xmB81K+fXa3BtJRsBTqz5R6bVCAkZaHCQ==
X-Google-Smtp-Source: APXvYqyBm/ugD3AsVu1vS25p2i9ySt1MBCq9E1dkzeWu/yECfAjSSQFEd+AL8pGvWxZi3KOl0eTrA1UI9d9UveNRt6o=
X-Received: by 2002:a9d:6759:: with SMTP id w25mr7495221otm.348.1556654606958;
 Tue, 30 Apr 2019 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
 <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
In-Reply-To: <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 30 Apr 2019 22:03:15 +0200
Message-ID: <CAFBinCC+w6aD6sSk8u=Pt54OKZuo84YMB2mWiLVHFNr329-kEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, Apr 29, 2019 at 8:40 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf, Hi Kevin,
>
> On Mon, Apr 29, 2019 at 12:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > >
> > > The purpose of this series is too improve reliability of the amlogic mmc
> > > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
> > >
> > > * The 3 first patches are just harmless clean ups.
> >
> > Applied these first three, postponing the the rest until Martin are
> > happy with all of them. Thanks!
> thank you for taking the first three patches!
> I am fine with everything except the patch description of patch 4 and
> 7 as noted here: [0]
I did not understand how HS400 works. based on Jerome's latest
explanation I'm fine with the patches as they are


Martin
