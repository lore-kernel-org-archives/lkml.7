Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD2C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4FB20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XfOUnVg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfHERx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:53:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32861 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHERx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:53:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so16149586edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ8m1iqTznWb8vi5XPTFdc0ZbQusxg4ERCrVoyD9ISg=;
        b=XfOUnVg5KOyMkHHbMLHfSyWW3eShErC1ZO7KaeuVE4c54XbH0wRE4McEEJQN83CJv7
         vlEx46cX8pvZJ4EDx1NikoDX7WrjLnpOIy7MO2/56Otw5kV7wyI3yDsbvoN3ZpT5D/O6
         ANPGCeMkcoH/YNWa/o+tvNrJPHEu96Dp3rLi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ8m1iqTznWb8vi5XPTFdc0ZbQusxg4ERCrVoyD9ISg=;
        b=XcV2FwEYuX1L/LVREGXHO6XjIbYl0KRSbBF8rhzFF3ZOOiFR5L5o+maPCmov2EYCvo
         rceC+yV2RwwN6E6hU5N7fwGanQHmnJNVOlR1EjKEuHt9lhEaEWzorq92UQ2sNoDLKQ7j
         72520NZJOKPyCOnotOXpMUCE+7kLS1D4jTU+njxNWx+Xev7OT0MAjZgk1DZQdWSKNU14
         Vy5ridf02M3PapSuLAgFK+174sY3YDpe4zzkL5s3MlBsrqZvxp1RVUyyimaGG4l7Iai3
         LZgdSxhMBOHmRQnQ9pyuXi7qNBfqQ19bPu5m2SeLcuN5v0YxBdp8cqq79EJJywcoZvMY
         XNDg==
X-Gm-Message-State: APjAAAXpEvPRVTDEpDrchCSqRfE0BB1ZjBG6dPN2tFdGJ0aViVfrYv+L
        G1zQhLr6a95EToql7raVu8NM81pT3hM=
X-Google-Smtp-Source: APXvYqzHj0uub+Sc8EaYCuixsRYIlH85nY3Ytm888DV+7a49O1nNMQQOmRRn6dw9Z37uxVhCI1aaSA==
X-Received: by 2002:a17:906:f211:: with SMTP id gt17mr117837949ejb.263.1565027634939;
        Mon, 05 Aug 2019 10:53:54 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id hh16sm14106145ejb.18.2019.08.05.10.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:53:53 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id f17so73836715wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:53:53 -0700 (PDT)
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr18318882wmc.22.1565027633048;
 Mon, 05 Aug 2019 10:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-2-thgarnie@chromium.org> <20190805163202.GD18785@zn.tnic>
 <201908050952.BC1F7C3@keescook> <20190805172733.GE18785@zn.tnic>
In-Reply-To: <20190805172733.GE18785@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Mon, 5 Aug 2019 10:53:41 -0700
X-Gmail-Original-Message-ID: <CAJcbSZEnPeCnkpc+uHmBWRJeaaw4TPy9HPkSGeriDb6mN6HR1g@mail.gmail.com>
Message-ID: <CAJcbSZEnPeCnkpc+uHmBWRJeaaw4TPy9HPkSGeriDb6mN6HR1g@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] x86/crypto: Adapt assembly for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 10:27 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Aug 05, 2019 at 09:54:44AM -0700, Kees Cook wrote:
> > I think there was some long-ago feedback from someone (Ingo?) about
> > giving context for the patch so looking at one individually would let
> > someone know that it was part of a larger series.

That's correct.

>
> Strange. But then we'd have to "mark" all patches which belong to a
> larger series this way, no? And we don't do that...
>
> > Do you think it should just be dropped in each patch?
>
> I think reading it once is enough. If the change alone in some commit
> message is not clear why it is being done - to support PIE - then sure,
> by all means. But slapping it everywhere...

I assume the last sentence could be removed in most cases.

>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
