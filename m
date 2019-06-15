Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC06C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D921851
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9Rk60Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFOOSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 10:18:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36076 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 10:18:36 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so12106051ioh.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZCWllnmsiBaICnZjSKeck7hGpgHXTO6pHNqapuT9AM=;
        b=Z9Rk60LeD/0ptcPj16hkpfST5k3ZThFqW3OXHdbZlJbMajc0/BhzHF+sQMfmAFeZPf
         g9RM8ZRaUqycBUQNF99rNjCoZSwH+6o3iRvi0RGwdkOg7rMWz5WCxfsdWyMgmM/EpS06
         dAubW+ndaqdG95ne2fbXiysxPXe/a0cF4y9aexF3g+ERtHCy1rR/TApR3VIitpi2rmzF
         Lri4OA9uev4HytKxrr7YzelhP4haIrdQbQrG8iL17AMzhQxcUskPNUFl6YyIDiq9ePwC
         gsZyxStXOcx0YWnIjrsmzA+A36r0ILOMH2lzG/aLqTTxAOHiBZoGgqDc0vgB47TpSJYu
         XzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZCWllnmsiBaICnZjSKeck7hGpgHXTO6pHNqapuT9AM=;
        b=QmjkiECWxR7locOMLG9mUX0eGxijt5rF7y2X1El9zYxYneScyiY9JXlDhh1UxTGYuN
         c0DJRNX2BU3XP1VeLU+yZNqXlPYTnDuPodtvz4w0xEwcFhQLzus0bW41zXP6M3GyQN1q
         2lOz4P0J5YaLHuPS3tiFaImmofu0d++hpxhrkkOuhnIdeasn9lVTfbqA2QwYYhDut0yu
         QmALljE6waict3oBLvKAgtnqMTTjYv0pOFg+MqYLLHYn7tzNQJ+cttpXvvo70I4vvXMx
         0nCsybLUnPGmmVxlPG3MNS0usiY51fWUXC9Ct7Lgz3hyl+tjiocEIocmypSolWUlJS2s
         /1uw==
X-Gm-Message-State: APjAAAVvx8PUwcjmy29LoDeYKyh4SZoj75sNluTsBy810wx0kmJ9Te8f
        +AdJqClfazFUNSNWjVFSzY38ahQAEBZ17Srq3+KmHA==
X-Google-Smtp-Source: APXvYqxghuy0pG3URpiRF/uKu7ofXRDyNB8i7XeBd+Uupypx/WpqsWUjXwueN9xkkeBLCpEwkBt1I6agbNIYnAhx990=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr1769308ior.71.1560608315058;
 Sat, 15 Jun 2019 07:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com> <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police> <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com> <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
 <20190614103850.GG10659@fuggles.cambridge.arm.com> <201906142026.1BC27EDB1E@keescook>
 <CAKv+Gu_XuhgUCYOeykrbaxJz-wL1HFrc_O+HeZHqaGkMHd2J9Q@mail.gmail.com> <201906150654.FF4400F7C8@keescook>
In-Reply-To: <201906150654.FF4400F7C8@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 15 Jun 2019 16:18:21 +0200
Message-ID: <CAKv+Gu9-rZ16Nb9t3=knzW0BHu0eNxQoPwWS4c8UMMm=2iqiuw@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2019 at 15:59, Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, Jun 15, 2019 at 10:47:19AM +0200, Ard Biesheuvel wrote:
> > remaining question Will had was whether it makes sense to do the
> > condition checks before doing the actual store, to avoid having a time
> > window where the refcount assumes its illegal value. Since arm64 does
> > not have memory operands, the instruction count wouldn't change, but
> > it will definitely result in a performance hit on out-of-order CPUs.
>
> What do the races end up looking like? Is it possible to have two
> threads ordered in a way that a second thread could _un_saturate a
> counter?
>
> CPU 1                   CPU 2
> inc()
>   load INT_MAX-1
>   about to overflow?
>   yes
>                         dec()
>                           load INT_MAX-1
>   set to INT_MAX
>                           set to INT_MAX-2
>
> Or would you use the same INT_MIN/2 saturation point done on x86?
>

Yes, I am using the same saturation point as x86. In this example, I
am not entirely sure I understand why it matters, though: the atomics
guarantee that the write by CPU2 fails if CPU1 changed the value in
the mean time, regardless of which value it wrote.

I think the concern is more related to the likelihood of another CPU
doing something nasty between the moment that the refcount overflows
and the moment that the handler pins it at INT_MIN/2, e.g.,

> CPU 1                   CPU 2
> inc()
>   load INT_MAX
>   about to overflow?
>   yes
>
>   set to 0
>                          <insert exploit here>
>   set to INT_MIN/2


> As for performance, it should be easy to measure with the LKDTM test
> to find out exactly the differences.
>

Yes, I intend to look into this on Monday.
