Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52264C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E8206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569177358;
	bh=gFmi0oKqa/Y/Kd/KUix46wQOXIT+B2OGW1fPo4DBleM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UoJaL3yPvGmQYSsWQiSotUiojfjCHdSn9Ys4DO8Ym9DxHaw8Vl/gpw+i0vhvKVKT8
	 kmJ91eKQgqbvGzkovsfqO8KVfe3SCRxkSUBjiMVYipfG22lRaUCFydIuW5qeasR4/9
	 HTo4hRgePD1NOoTQts+bn4hOTH+MI39vwZnj2CkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbfIVSf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:35:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42386 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbfIVSf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:35:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so11516361lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cRoLwcm3Bb7q4lPiN1rwfLvtJPNQzTFyUagpOf2DWnI=;
        b=AxpAMa13K7mqHpC92mPyI3hm643Gi5sFppNr3Oenhx4gcOBf50M/6nFdHjfwTv+LdK
         gfDYtO+n4HqfjK+joMh+M9iHYIM3yrPWmz6jZB1Q0yKsGnF8T5E50EPD1d6xztfI7eez
         TdOZdS0zkzKXWxMn9qjYNXSNRw4ee2IFgcfPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cRoLwcm3Bb7q4lPiN1rwfLvtJPNQzTFyUagpOf2DWnI=;
        b=ZwWdrdEDB6gRH7WBW4YWLWNkpCDQ1n9R7Q1LFB5rzPIQbSBobM2lxGMdfkhrNNTnGy
         pIubcr8jaU4v3lEM6MiMJsMs8KmdHMkHpQWV6n88LRV7e2rbE7GlLGVYU3ys2/PrSryd
         KvdGTGyVWfj1uzsz9qkthRpVtq+8jWRKQMXwAIAXfpNkglH7y3YPujhWfWte/0E4fpU8
         2i6jYYi0NcvQNw0uikMXtQpRhi5asux3o9KlaMYvJrJAx+jdR/QFVMcH0XclhAi2H+3p
         u69hJtvR7YBuEEq3o4ozgh8Tg3A+1aIxlXzjyFHDx4+E773ge85Ylx4LCGJh8f+Q494V
         4QdA==
X-Gm-Message-State: APjAAAX3v9CdFv8DI/4ZlwgQToGxttoYGxqKALlGmS7F503JMhCoF/3O
        n/0S2BAcN/O9RUJdLgP7tQnKtZdV9CE=
X-Google-Smtp-Source: APXvYqxDr0Pc6HhB2GqYOoNms9prWqgsl/1u+mdvrTBmLgwZUg9ADHHv2EWLTrMvKgaU0M9Y6ctuYw==
X-Received: by 2002:a2e:3e16:: with SMTP id l22mr14447458lja.195.1569177353638;
        Sun, 22 Sep 2019 11:35:53 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q66sm597046ljq.101.2019.09.22.11.35.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2019 11:35:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id l21so11552668lje.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 11:35:52 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr15742816ljj.72.1569177352341;
 Sun, 22 Sep 2019 11:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190921231022.kawfomtmka737arq@pburton-laptop>
In-Reply-To: <20190921231022.kawfomtmka737arq@pburton-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Sep 2019 11:35:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmJbF3p9vZTW2nbeD4LkG-JZV+uqv8BnxzojJ5SZsLjw@mail.gmail.com>
Message-ID: <CAHk-=wjmJbF3p9vZTW2nbeD4LkG-JZV+uqv8BnxzojJ5SZsLjw@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 4:10 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Here are the main MIPS changes for v5.4; please pull.

Hmm. I pulled and because initial tests didn't show any issues, I
already pushed out.

But some unrelated further testing then shows that this:

> Florian Fainelli (2):
>       firmware: bcm47xx_nvram: Correct size_t printf format
>       firmware: bcm47xx_nvram: Allow COMPILE_TEST

causes problems, and commit feb4eb060c3a ("firmware: bcm47xx_nvram:
Correct size_t printf format") is buggy:

  drivers/firmware/broadcom/bcm47xx_nvram.c: In function =E2=80=98nvram_ini=
t=E2=80=99:
  drivers/firmware/broadcom/bcm47xx_nvram.c:151: warning: format =E2=80=98%=
zu=E2=80=99
expects argument of type =E2=80=98size_t=E2=80=99, but argument 2 has type =
=E2=80=98u32=E2=80=99 {aka
=E2=80=98unsigned int=E2=80=99} [-Wformat=3D]

and the change to use %zu was completely wrong.

It prints out 'header.len', which is an u32, not nvram_len which is a size_=
t.

Tssk tssk.

I've fixed it in my tree, but this should have shown up in linux-next,
or in MIPS testing. The process clearly failed.

                 Linus
