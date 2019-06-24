Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0073220820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfFXKxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:53:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39133 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfFXKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:53:46 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so1009779iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 03:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihyVj9AIhaK8HPGk1OnxZEKSWZ3zvaM69CEDWZY4270=;
        b=e3M0XAzB8Hf0XA5MfqZlD/LEJxwKQx6pCXuZyJHQB7Ms0sQ0eQgbMutRXEjxVXA7cT
         iePB7gJ/bJEayf2GYP1RvcN0hErO9pu+gq2qArXhnewxIL0jq1APfIWGvv5oBohVW5U+
         eJ7Zm8R+VKqvb6Rfq4//1EdLekBjjm5SJZza9kQBWvMli47NHxxctcZX8Vt4wGyNFGjy
         z3/7Kf2bxGfX4T1ZDB5itP6AFCECF/qgrDHwovlG8kRNtugTRvBIMRQBFdX4o5MYmK2k
         x2DtnrbCkMw5yeeRjFlXLyBNnf9HFvAxvMvW0XS+yjphKscCqjVRoYpWZNNtJ1J1BYxQ
         dtFA==
X-Gm-Message-State: APjAAAWdAk4ZXtc79edicsCw8JJfGcciohQM2PtPa1b2gXWpVMK0hmv/
        OfN4aDvAn9cd+ISdNTMGnzBDMCaX14jrYB1+XoD8LQ==
X-Google-Smtp-Source: APXvYqxJ7VQx/5vlszbYxhrcE+AmHiH+fTrA2A9o0xXqBtLrWiYkGQw4oqtxmCEH7s7wCWiEVWWuSJO5tYSbMYTpKrg=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr1753892iog.273.1561373625285;
 Mon, 24 Jun 2019 03:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <20190619123019.30032-5-mszeredi@redhat.com>
 <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
 <CAOssrKcU2JKDYMDbW7V6jpM7_4WFSMA91h9AjpjoYmX=H4ybeg@mail.gmail.com>
 <30205.1561372589@warthog.procyon.org.uk> <CAOssrKdGSRVSc38X1J0zCQQN+tUhiwPA4bCL0rHCZ-O8iVzzeQ@mail.gmail.com>
In-Reply-To: <CAOssrKdGSRVSc38X1J0zCQQN+tUhiwPA4bCL0rHCZ-O8iVzzeQ@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Jun 2019 12:53:34 +0200
Message-ID: <CAOssrKc=1FDpOzgpzO9dtkk2sTyq2VVL5ajqgowh4PafzQQJBg@mail.gmail.com>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:44 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:36 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > > What I'm saying is that with a new interface the rules need not follow
> > > the rules of the old interface, because at the start no one is using
> > > the new interface, so no chance of breaking anything.
> >
> > Er. No.  That's not true, since the old interface comes through the new one.
>
> No, old interface sets SB_* directly from arg 4 of mount(2) and not
> via parsing arg 5.

See also 9p mess up of "posixacl" handling *on the old interface* due
to exactly because the internal API doesn't differentiate between
options coming from the old interface and ones coming from the new.

So you are right that there's breakage, but it's due to the fact that
common code parses anything, and not because it doesn't.

Thanks,
Miklos
