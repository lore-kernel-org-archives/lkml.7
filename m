Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4727C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BEB20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553535951;
	bh=GvYjNH1rW56z00UHxMSr4BSA1Nwz6zb8ZKN5SlZqw/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v7c71c8YpCbolJbxIHgsCt8z3n6CIRMe6Qvm5iYeo2MGIU0htVZe7pxGVe3AQ4diH
	 XM3NIUmUJjt3aYg7HIQXZrPhwIRE0lD70zKp7eFVXM5sSqUp1UDRInOp5DBt5glW8E
	 QvCgM+nZFRqH9xAiZDcoUI8gleGF/3n0zCpXZrcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfCYRpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:45:50 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:36895 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfCYRpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:45:49 -0400
Received: by mail-lj1-f181.google.com with SMTP id v13so8661821ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRe2oWrFowjPDwMQ0XzV+doqxVqQ9V1/hj0R7uFWrcE=;
        b=FjpUfbuGF9Ba2aish+S9SNuMMwnK1poJo8Oj81SbdIah901GHv7zVQK5hLtkaPkRcz
         kHbeSQZWCXO9w+Q4lLrdROL+JbH31HczbwfF5egbZ6RycWE+sfr4JXd2bG5kcS1jyjeY
         NtrrLqyPNgcaSNoQAMQb2weh1FqMVW1iPa45s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRe2oWrFowjPDwMQ0XzV+doqxVqQ9V1/hj0R7uFWrcE=;
        b=Mxg03vc63FGYOK7KFmz/G1P52S6tKkKP9hYx2V1MemleiSB/nMft/lk0TF5gncsctl
         6hpJtkdlwnks7GFGAAH8AVtFxHuZTTbvPSoH2tr8dh//Jgt+IPjZKNSvJTh8cTdPzHjM
         HJsFgm64h2hfJKUQdE9nlyxUJ+IcFsS2z27LhiQsWYg5Fb+t8h1jwfmUe6u+GlTGljT9
         GQ3ond+nacCH1FoUsWQ5dfcSWgRVrKRcNhQiCTVuV6uL0+klZArp0mByCOfB1qnmEGLd
         9D/GeVCJr6CqNhA9Sdt0pLcZqsvRw0NRfsykYVecB+ET154Up79L6L9ALHjYQzGJ7ZJJ
         YFlg==
X-Gm-Message-State: APjAAAX/PDT6jbwm6ofmACKQlxx/0QTIEOIqd68+dYNARmDcuCqwXR3r
        p27s+15q3CFcTMIrYFH7gSMq2MDow+M=
X-Google-Smtp-Source: APXvYqwm+2rzS2d71VegkXH90FZNkwvKbwtoq4KLYIuKEAW8OeS6okpvgEV3kmn8OFYoTQbeYY5jWA==
X-Received: by 2002:a2e:81c6:: with SMTP id s6mr13759481ljg.56.1553535947305;
        Mon, 25 Mar 2019 10:45:47 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s24sm2133677ljs.30.2019.03.25.10.45.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:45:46 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v22so8634475lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:45:46 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr7533960lja.125.1553535945828;
 Mon, 25 Mar 2019 10:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200702.GA27111@avx2> <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
In-Reply-To: <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Mar 2019 10:45:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com>
Message-ID: <CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com>
Subject: Re: pidfd design
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:34 AM Michael Tirado <mtirado418@gmail.com> wrote:
>
> On Wed, Mar 20, 2019 at 8:08 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > pidfd code should be backed out immediately. Forget about /proc.
>
> Seems like Torvalds just merges this sort of "stuff" without reading
> it now, or there's something that auto accepted pull request to RC tree?

There is no auto-accept.

But there also didn't seem to be any valid arguments against it, and
the android people had arguments for it.

Arguing against it based on "I don't like /proc" is pointless. The
fact is, /proc is our system interface for a lot of things.

Arguing against it based on "I worry about the _other_
non-signal-sending things that could be done with this" is also
pointless. What other things? The only thing that got merged was the
signalling.

Now, arguing that signalling should use the open-time credentials
might make sense, but this isn't read/write. You can't fool some suid
program to do magic randon system calls for you, and if you can, then
arguing about pidfd is kind of pointless.

So the model of using a file descriptor instead of a 'pid' for signal
handling is actually very unix-like. Maybe that's how pid's should
have worked to begin with. Remember that whole "everything is a file"
thing?

Now, the fact that fork() and clone() return a pid obviously means
that pidfd isn't the primary model (not to decades of just history),
but that doesn't make pidfd wrong.

And namespace issues etc are all also kind of irrelevant. If you open
random files in /proc and randomly do pidfd_send_signal() on those,
you get random results. If that worries you, then DON'T DO THAT THEN,
for chrissake! That's not a sane model to begin with, but it's not the
usage model for this, so it's another completely specious argument.

So yes, I thought about the pidfd pull (which was why it happened at
the very end of the merge window), and I found the arguments against
it bad.

                Linus
