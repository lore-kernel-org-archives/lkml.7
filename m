Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601ABC4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3642A20665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569339146;
	bh=ashIkEiX50BSTycIVxwvZ5leJxHFDURay6EmrQC0vGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bpByY6s9qzDn2zk0wLRYuo6vhEZjhrS4wu9p1gmFhKzqoQBRnrkMN6LRCI2zQpFil
	 dHZmpABCR1dy2BuPXiGjrxLM1zdIX7ZdhnBVIhx5D84CaU5o4POdbj2/XIwnn41dxt
	 7R/B9EH25tkniA9qHhbzqRLYvxJG1m0llzqmn65k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfIXPcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:32:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37907 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbfIXPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:32:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so2354630ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yTXFMWN7uG8HeKP04hBknHMX7DjCzdXpjR3u5gYPGyo=;
        b=csnyqQhYOP+PrKHw6U6DXiICj2iJbqP0xhK/YsgX0NJ8CDm3M7BkvgPR21n8zf2Xoj
         bqRF7cHq2x5ioxRBkz1SMK/+9emYk9lSfnjFcL8FaOaKAL3lr7ybZnVeWLcdBnTKP94a
         XXbMWg7yvpKrqMnmGzh46esRmL0KRGQX8wTMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yTXFMWN7uG8HeKP04hBknHMX7DjCzdXpjR3u5gYPGyo=;
        b=Fb6GBm3zET31xFta3Z66e0l4XI5eK9vH7qUkcFVBypj1Q+vJRrQGUhpkKmHvRN1Ai9
         c/T4BG+Mge+rhh+8iYuxpjL7T/GFQubM1GhpkOVRCnEdXBMk7oOAwxBuxDcWiYserlC0
         3g3KCaax2J6GFecVKK53u0oAsJ8TCSR/xYWC6NyCAp+TqUEkTvgTeLG8bewFnYhNZPKk
         tdQ51y2Uw2D9A+SSgeNq7y/KLpDgEm00IpvF9uMZ09NwBbrfo0iFDwbGbBk6V092OFz5
         WhZcD47LNMCdw0xXoHrMxBtCgjTxc+ROH9Wa4Ggtjc4bJYWPm6IBBMnjAAYjJpQOelea
         pWLw==
X-Gm-Message-State: APjAAAU0MU54sk6ydcaBOELYcdPSCz/BwkjE2FJShj0nHplyKLz9yby4
        8lR43DKVB2cMSo0UxygcYqWn+2aTuJI=
X-Google-Smtp-Source: APXvYqxam6EjdoEFbpROkxNLfyr9Fe36Mpyo4xsQWnOiDe5O7wvN/m8Wcit3DwM+h8jqvtaT7enItg==
X-Received: by 2002:a2e:9748:: with SMTP id f8mr2477698ljj.167.1569339142271;
        Tue, 24 Sep 2019 08:32:22 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c26sm587475ljj.45.2019.09.24.08.32.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:32:21 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 7so2357158ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:32:20 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr2495973ljs.156.1569339140581;
 Tue, 24 Sep 2019 08:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190921231022.kawfomtmka737arq@pburton-laptop>
 <CAHk-=wjmJbF3p9vZTW2nbeD4LkG-JZV+uqv8BnxzojJ5SZsLjw@mail.gmail.com>
 <20190923180728.flp6jx4jc2bh7cys@pburton-laptop> <CAHk-=wiC_B8R6th+83vKwGT1H-8vtFrmMg+1mK_P8n3VeWAWRg@mail.gmail.com>
 <14580.1569328815@warthog.procyon.org.uk>
In-Reply-To: <14580.1569328815@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Sep 2019 08:32:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4g0NgX9BLiTCqFYuM3H2AuhY+uCYfauOegz8OV2HjjA@mail.gmail.com>
Message-ID: <CAHk-=wi4g0NgX9BLiTCqFYuM3H2AuhY+uCYfauOegz8OV2HjjA@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes
To:     David Howells <dhowells@redhat.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 5:40 AM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > In honesty, I actually do have one warning in my tree:
> >
> >   samples/vfs/test-statx.c:24:15: warning: =E2=80=98struct foo=E2=80=99=
 declared
> > inside parameter list
>
> Were there any note lines from the compiler associated with this?  The wa=
rning
> message can't actually be taking place on this line.

That's the only thing that gcc says. I agree that it's not where the
problem occurs, but the gcc warning system tries to avoid warning
inside system header files, so it seems to have logic tracing it back
to the user.

But I have system header files that look like this:

  /* Fill *BUF with information about PATH in DIRFD.  */
  int statx (int __dirfd, const char *__restrict __path, int __flags,
             unsigned int __mask, struct statx *__restrict __buf)
    __THROW __nonnull ((2, 5));

and I think that's the one that triggers.

You must have hit *something* similar too, since the only reason for that

  #define statx foo
  #define statx_timestamp foo_timestamp
  #include <sys/stat.h>
  #undef statx
  #undef statx_timestamp

is that you're playing games with the kernel 'statx' clashing with
user 'statx' use.

And what I think happens is that you had the <sys/types.h> include
*without* that #define, so the 'struct statx' got declared there, and
then in <sys/stat.h> it gets used, but it gets used as 'struct foo',
so now the compiler complains (properly) that you're using this
undeclared 'struct foo' in the function declaration, and because of
namespace rules it's not the same thing as then a later 'struct foo'
would be.

              Linus

              Linus
