Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25056C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43CD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KCDRHk4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfDWUVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:21:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41912 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDWUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:21:10 -0400
Received: by mail-vs1-f65.google.com with SMTP id g187so9060891vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP3kJea3QTaT0rwWzqYn9wrhgO/TUKE2qqDZdHahOSw=;
        b=KCDRHk4yPArTTwlQ3/og0fNGGkB8rX+YnNXnNrnIFAsQEbhkrBjQYX5+N5xyZ9B3jv
         QjMmytgIjJtSDA73pfpsEBQX6nAhSVdx20mP+lR72Q2DvEBCAR3G6v3//1dTvuzPZxxb
         f/O6fgF1GrdIZqFneyaf9H2t6xxFHYQRPtHUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP3kJea3QTaT0rwWzqYn9wrhgO/TUKE2qqDZdHahOSw=;
        b=i9s7QazZXoEC7AEQK8Q45dHcvh19ZGnTOiP0wolIqGAQ/2r95vdUwrSWMZGHeh1gU0
         S2/9UPQln42NcdnO8eRwU/BUSFw3U+GpZV+bhS2wAmmSL5r/U2xwOzmTTnVyHfM1YlkG
         Oqo0Qh0Wm3maG29gkXEYfRm/3n47gqXiyev4UF5wdFcqdrw880kiH+vnSdzGkL2UYbMm
         /LL83lD8v42q5zTJUgJ1ezCD8Xp6+yMlulFub/zHkAcLAwqXz/OlDtU9dBzH6XJWomU0
         Rl2hIJtUK7826zpdv8AT4xR8TlmRa1qy9hOvvztZq8gIDGbGBPftH6ainbqRBZ+U7TGt
         2BsA==
X-Gm-Message-State: APjAAAWDZF8lnIQqoMnCOSa0xC+S/90b6JU00KCABppR89OrQtPv+q3I
        F70XTV+I6+kcTMfzch+Q7/W0fKpes7M=
X-Google-Smtp-Source: APXvYqz8EU41SVklNBl5E8IBG6MEAzHUzFY6Sy5F9EZVClgNcRmCJR0Hjzpko1rfonHA4YO9ChepWw==
X-Received: by 2002:a67:ec47:: with SMTP id z7mr15495605vso.142.1556050868848;
        Tue, 23 Apr 2019 13:21:08 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id b197sm16970567vkd.9.2019.04.23.13.21.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:21:08 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id n17so763966vsr.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:21:08 -0700 (PDT)
X-Received: by 2002:a67:bc13:: with SMTP id t19mr14647886vsn.222.1556050443869;
 Tue, 23 Apr 2019 13:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190320143717.2523-1-cyphar@cyphar.com> <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
 <20190325130429.dbrgjxnvq3w5cpb3@yavin>
In-Reply-To: <20190325130429.dbrgjxnvq3w5cpb3@yavin>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 13:13:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
Message-ID: <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path resolution
To:     Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 6:05 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-03-21, Andy Lutomirski <luto@kernel.org> wrote:
> > On Wed, Mar 20, 2019 at 7:38 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > Now that the holiday break is over, it's time to re-send this patch
> > > series (with a few additions, due to new information we got from
> > > CVE-2019-5736 -- which this patchset mostly protected against but had
> > > some holes with regards to #!-style scripts).
> >
> > I generally like this, but, as Linus pointed out, it will be
> > unfortunate if application authors see this as just another
> > non-portable weird Linux API and don't use it.  Would it be worthwhile
> > to put some thought into making it an API that other OSes might be
> > willing to implement?  As it stands, the openat(2) flags are getting
> > rather crazy in this patch set.

I think many of the issues are specific to Linux (and Linux containers
especially), so I'm not sure this should get blocked because we want
something more portable.

This series provides solutions to so many different race and confusion
issues, I'd really like to see it land. What's the next step here? Is
this planned to go directly to Linus for v5.2, or is it going to live
in -mm for a while? I'd really like to see this moving forward.

Thanks for continuing to work on it!

-Kees
