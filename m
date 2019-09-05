Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134B6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E472070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567721814;
	bh=t1V58lMOvMILNoohMebRfHZO7tK+Gh/IkPCB82Q6oCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nWOLNJlXYHtYZS8wDE05x1tGSzqSFdcNP5J62XcZHTW8DrrWOXYaGC1XHRCX2ULC5
	 /faVc3GHwXFA96uIYi/WLJi/9ioIChp5Z8clkst3GL7LnRq88mej5wQJCIL/7peorA
	 iw+Z47MVXq3XFHU0b+Xx2ZqELBG7UB9iE+PT26v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfIEWQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:16:53 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38842 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfIEWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:16:52 -0400
Received: by mail-lf1-f49.google.com with SMTP id c12so3336364lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+bS8S77AzTpTBzzxsdlLs0HnCbtRjNnmkiZK0MPy0c=;
        b=LbASCsGx0k6udtd2AsgFeBhmCaCLrlsklx+62iSSE5Gkytkq0WN1acnDpFn5oCNEQS
         KMkfsxyWBngO5Ing5S64rk5RN/Socr904CmKtCx01r5GqFjCKXQfIr7B9uXv9DslB2br
         7qADnXCimEFjoVvgCL5m3EkgAFlL+VHV2J5FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+bS8S77AzTpTBzzxsdlLs0HnCbtRjNnmkiZK0MPy0c=;
        b=iWU6y9LAEsw4sPJgB/hkh29hO5aGwBZybR8+p4WyqQHEHxOkqlo9X6vXAW2UEmowce
         ciE8xBrZ7jmlRoEB0mutipGG0rjIU3d8aeCmRiBY1F3uILD+Y1WmeD9p91yzHW+JZinH
         WeXWcyV52C2jmLl1W26ZlsQSxZXf2AD+BA99r0JF7EHlCzDICwcjYpQkJ49DWWvOgjkm
         NTVkJNtoqao2Ze+BVvQjBvcRWBxVHfoR80Ww9BD7LIqSADOLWPicKgG6BxR+xUVrO3jh
         WHSJrMZECcFu4Rh4vYetxzaFyw2Pg6rJNb7I60/tqTMfc7YqyjJAJm4AZGZ17OJRBtuJ
         qslQ==
X-Gm-Message-State: APjAAAX+UFiDQkQqDu6Mxq2GXF8Qy/LXptuVxNLz+9fUn49A5E+JgqNt
        nANumH9P+3UjAjzUX2a8Uv8Re23yj3A=
X-Google-Smtp-Source: APXvYqxYS9ur5uJy6tHygLeu1fXOdRzDXdlXDmH/MIjEZB+EsoZwfJyqlak7bAOre+7IvV/1h5qSBA==
X-Received: by 2002:a19:cc15:: with SMTP id c21mr3988984lfg.64.1567721810235;
        Thu, 05 Sep 2019 15:16:50 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q13sm684203lfk.51.2019.09.05.15.16.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 15:16:49 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x80so3344855lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 15:16:49 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr3910741lfh.29.1567721338167;
 Thu, 05 Sep 2019 15:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
 <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com> <5396.1567719164@warthog.procyon.org.uk>
In-Reply-To: <5396.1567719164@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 15:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
Message-ID: <CAHk-=wgbCXea1a9OTWgMMvcsCGGiNiPp+ty-edZrBWn63NCYdw@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     David Howells <dhowells@redhat.com>
Cc:     Ray Strode <rstrode@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 2:32 PM David Howells <dhowells@redhat.com> wrote:
>
>  (1) /dev/watch_queue just implements locked-in-memory buffers.  It gets you
>      no events by simply opening it.

Cool. In-memory buffers.

But I know - we *have* one of those. There's already a system call for
it, and has been forever. One that we then extended to allow people to
change the buffer size, and do a lot of other things with.

It's called "pipe()". And you can give the writing side to other user
space processes too, in case you are running an older kernel that
didn't have some "event pipe support". It comes with resource
management, because people already use those things.

If you want to make a message protocol on top of it, it has cool
atomicity guarantees for any message size less than PIPE_BUF, but to
make things simple, maybe just say "fixed record sizes of 64 bytes" or
something like that for events.

Then you can use them from things like perl scripts, not just magical
C programs.

Why do we need a new kind of super-fancy high-speed thing for event reporting?

If you have *so* many events that pipe handling is a performance
issue, you have something seriously wrong going on.

So no. I'm not interested in a magical memory-mapped pipe that is
actually more limited than the real thing.

                  Linus
