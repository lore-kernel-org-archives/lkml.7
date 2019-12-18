Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8153C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8826D20684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2kXLr3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfLRPpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:45:18 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:41222 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfLRPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:45:18 -0500
Received: by mail-io1-f49.google.com with SMTP id c16so2437834ioo.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF7eopH0+Q1DDOUMuVeJlk6u8EciD6fSPnO7gCpHeSU=;
        b=S2kXLr3prhuTdkZ5mY6dIJjwvRxWB0MxzSQgEMfDi5t+iJtA/cGv725o4435C4MJQC
         wqiJkkz+I4DS+22TT3+M0SEK1l1sZN+C1u+8RvPcZesR4raugi4XVKOOBil531hf4aAR
         C5c8zGhQoMriYTXo1OaXKYefK7eTkRe7JF5Y5l1apKdMD2EsXljvfp76ixlQ7jjsgiTM
         C3fNfuYdlDxqwdCSY1BV0JnyGW44rhyVdoTNsqAAQhl5hbclhHMltW2aoMDYb8HI7ONe
         AEkP7KiCuFn2P7yAyr169vSPIebfOkQGaZa+8mCXt9BS1pZ14rUz7Ud2r8fHdnMFbQ2F
         N2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF7eopH0+Q1DDOUMuVeJlk6u8EciD6fSPnO7gCpHeSU=;
        b=WkIduv74ddQGHMuVN4ZNCAnF0dZMgoUPhitxnJ5cJZoMnLmxGw60mhM8FJyjrxXREh
         dOuNxUJsVvHLM99FJEtfn7s7B58/laNGLS9oiYP8rWC2HF0nsAL/XOzrgTgV46tGfthr
         g5g5y/bhfDLU7TIykhT89vksIU54odyuCICa2GkkpDqVVhXbRjPhhC/ZWH9pp7YAFJaI
         tiC2uIk/+FBAoFURXNghFQ5SPd7DauwlDogUXk0Ltcnvpc8fW5REqeEKtK/IK1KmbW33
         R4UsLF48Cp6noT1FceFvvxFycwRKalh8paLG0bhk/fR47U8qftcqjoAq3jzosLZFFrQT
         5I1g==
X-Gm-Message-State: APjAAAUKxjiJUGULzaxI4zKbiZUFILdRyGHgt0C+NI2vybUGEeaFRqCJ
        Jay0VeA5POp80CGge+54pyNB2x/fBTKYNJ1PyA==
X-Google-Smtp-Source: APXvYqzSuDv5nZO0ojwjba8lIrbTNnsmM15t9ldewPwhTy0zDd5gYsszT0hIpIg/T4huajWgXbaHFBwy7cyTClmyLEE=
X-Received: by 2002:a5e:8344:: with SMTP id y4mr2036905iom.27.1576683917736;
 Wed, 18 Dec 2019 07:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20191218153107.GA3489@redhat.com>
In-Reply-To: <20191218153107.GA3489@redhat.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 18 Dec 2019 10:45:07 -0500
Message-ID: <CAMzpN2gOA=ysOCidCUmxZ6cev5HuKXPdBA_mni5SR01=ii-+KQ@mail.gmail.com>
Subject: Re: Q: does force_iret() make any sense today?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:31 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> I do not pretend I understand the arch/x86/entry/ code, but it seems that
> asm does all the necessary checks and the "extra" TIF_NOTIFY_RESUME simply
> has no effect except tracehook_notify_resume() will be called for no reason?

It's a relic of a time before the more robust checks for
SYSRET/SYSEXIT were added.  The idea was to divert the syscall return
flow off the fast path.  Even if no exit work was done, the slow path
always returned with IRET.  But with all the entry rework that has
been done it is no longer needed and can be removed.

--
Brian Gerst
