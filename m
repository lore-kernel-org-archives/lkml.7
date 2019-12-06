Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87BC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA67124670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575670507;
	bh=9JvzwEgsdxYVt8s8RLOPMbFdcSuM2dK1YoTcGfh72pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cg7A2meCd+3d4oGq/vH7uFHgHFu8uegboKy//t4tiL5JrbcKb3xILXEuUATLGu+IA
	 09IG8uNSwKDcvv+fkFCp59nEsonSF8HY8FbNVycD5S1V58qibxmkFMAJEpXyqdlc/7
	 94LLZxwQHDdBJ37oGynknhkvqrVpAqoCJreA2NII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLFWPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:15:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33551 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfLFWPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:15:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so6444047lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0XBsU0Zwa7k+dx/SYcO/cC8TsFqFe7ap7E70c7vInU=;
        b=bTZdKzPiqpVSRlIEKZEGDMlBYxFAfG1XtbiNaTYxkA8G285Eux5gFHDmaTnJC4iPE5
         o8N7+YD5Z1tWk70yIvruVU0BeSE3YsKa/iMNxQrsM+BsOw2M95U/kwIKkGhLzao/qQKm
         h/+JfuStPH6oZCReJIpg2utxtMnd/SwjidQvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0XBsU0Zwa7k+dx/SYcO/cC8TsFqFe7ap7E70c7vInU=;
        b=ubFPw2H7Ny4JWrYbhKi9si1u5KHPjYkpY4gSFOhz60ZA4HBVa8b051fdPXtIAQr8kl
         uMdSWNSqiL88CWRq6LFccPzjHYtPBF30akmDYuij2KgH9aA1U0cl1uEy5Sc4F+9HfVHu
         V+d3GcrQTVJB2QuSaKpwydyhLYHvx/Otz03icoQ6Z/b3dh3QV6uBmnQs3k/F6MSLI/4N
         5CiRnbMGv47PJLEiF2HnuztLE6iBhABgmLx5KxL0J1PI9t0Wg4hmBrfpR09dFnpE8grI
         qDwXXQjjJzbCK6KjB1tMq96e6j7WS0xQ19nfZA6Fepnn3JRQ+UR6PDtBhEFnIbulf6Pr
         SzSw==
X-Gm-Message-State: APjAAAUsKFSHGUkITmt7RXu9sZ17rnLmuLwSebHG5ntw3h3F4tsvzo3n
        2v6QVjQBCOqMwfk8NyEDGT1LiYSvCi0=
X-Google-Smtp-Source: APXvYqwCjyjioZgdXlYuJ94sJPSE9Te4hZmWmHEWX8taxZFojeB82XSzfMp0ST7XFUmBcSnKLqYafg==
X-Received: by 2002:ac2:4945:: with SMTP id o5mr9097784lfi.93.1575670502748;
        Fri, 06 Dec 2019 14:15:02 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c19sm7179812lff.79.2019.12.06.14.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 14:15:01 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id n12so6412214lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:15:01 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9167196lfk.52.1575670500889;
 Fri, 06 Dec 2019 14:15:00 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk> <20191206214725.GA2108@latitude>
In-Reply-To: <20191206214725.GA2108@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 14:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Message-ID: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
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

On Fri, Dec 6, 2019 at 1:47 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> This change breaks firefox on my system. I've noticed that some pages
> doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
> start loading and than stop. Looks like firefox is waiting for some
> dynamic loading content. I've bisected to this commit, but can't revert
> because of conflicts.

Can you check the current git tree, and see if we've fixed it for you.
There are several fixes there, one being the (currently) topmost
commit 76f6777c9cc0 ("pipe: Fix iteration end check in
fuse_dev_splice_write()").

I _just_ pushed out that one, so check that you get it - it sometimes
takes a couple of minutes for the public-facing git servers to mirror
out. I doubt that's the one that would fix firefox, but still..

               Linus
