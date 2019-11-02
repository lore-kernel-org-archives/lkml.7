Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56ADCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A897217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572736218;
	bh=yT2xfdk7VhanLkx0HAZLMAhJ+HGrris22TSXnZ7QnSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pQQRslAQcDgNjGrQ1uKdYS96E5IebaYMWe+WSl9/gX7ZyIATRgwiLMA00mhu714MK
	 fnHLhKhulno/4o5lPeYa8r0KxAea+MZe9U77AQGDx8xRCO8+F4M/o0/9KXOPUJrE6f
	 4ZaUwrJ6fz+mVexmQHOuiBb37xIrOeaXKtwPGXCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKBXKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:10:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38929 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfKBXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:10:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id 195so9618890lfj.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=Vx52JGJ2fL2ca9BB2NXhwTThadLFJNdykQ5Qc2uEp2vn5uwNFrfyadC6EXLjhvKklV
         KXMcjJQrv3h80vcy/cZZjfo/5qqKgj2fI2pWR4TA74i3RLzoy9MP14q5tRVf25F8gLLb
         ceXpd5ICYbOD7PSidUN5wWZK5ccyx9qRkG23Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh8/ql1swcZ/RLJ8zkeObExj1w6DyGVNWtfZIlFMpeo=;
        b=egQqw9fSG2w08MLVsY4QrOzAdqo3/t7J/nnyD1vTESE64cCnMHF/ZH7h3CIPgZ3oMd
         jytIxJNm7TePY+iDh2XRscIIg9IzwIddo1BzkNbC46cvGU73TvyTRNdF/zlgz7OU67ID
         WVVnC3SaormNroDVJzSASSLUmD6kiS4IsYVYT7rzb9R1LxqZUWOBKwxsOmZWgoYqT208
         v6OPvsx6wSl0Pir6K6hVtu98RLXhV54k14ivoa+wBUJbeZ8rOOwLDtY3awV4KcRI+Xvr
         1EwzF+uPDMOpDTrCJ1jn31jmH1UCgBhaLVKRqniJWdfcsBV6WoQeW/tv90w/zBpoemGf
         bB9Q==
X-Gm-Message-State: APjAAAXbhpMdWspj/VNiihknpkcIN5GQNaCoFOfDHIxP+Gu85blwLHmg
        +LNFPK4xvBL7tNK0FcWhffrECzvxWRE=
X-Google-Smtp-Source: APXvYqx4zwfCcRGCtKRpViVLFpXMCJSG9KdZAbkBhNDk+6b6aOm6WyRiBGzvliMO9C50AFwQphDzdQ==
X-Received: by 2002:a19:655b:: with SMTP id c27mr11791144lfj.122.1572736212976;
        Sat, 02 Nov 2019 16:10:12 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e26sm4193246ljj.76.2019.11.02.16.10.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y23so13362926ljc.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr1543119lji.97.1572736211179;
 Sat, 02 Nov 2019 16:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net> <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:09:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 4:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I don't think anybody actually _did_ any of that. But that's
> basically the argument for the three splice operations:
> write/vmsplice/splice(). Which one you use depends on the lifetime and
> the source of your data. write() is obviously for the copy case (the
> source data might not be stable), while splice() is for the "data from
> another source", and vmsplace() is "data is from stable data in my
> vm".

Btw, it's really worth noting that "splice()" and friends are from a
more happy-go-lucky time when we were experimenting with new
interfaces, and in a day and age when people thought that interfaces
like "sendpage()" and zero-copy and playing games with the VM was a
great thing to do.

It turns out that VM games are almost always more expensive than just
copying the data in the first place, but hey, people didn't know that,
and zero-copy was seen a big deal.

The reality is that almost nobody uses splice and vmsplice at all, and
they have been a much bigger headache than they are worth. If I could
go back in time and not do them, I would. But there have been a few
very special uses that seem to actually like the interfaces.

But it's entirely possible that we should kill vmsplice() (likely by
just implementing the semantics as "write()") because it's not common
enough to have the complexity.

             Linus
