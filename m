Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E9C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59537218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h83wm51N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfGENDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:03:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37238 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfGENDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:03:08 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so14599012iok.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpRqpOEyos9gWVI1KI/vAHqH4Vkw1K4vS/+vG+O4M0M=;
        b=h83wm51N3b9RabIloRjdWAnEOC+c2ImXGh+hgmGj9lO8K8kgTY1/0CLpXIjAZvwaX/
         0qfkwrKKGV72ZlSVF7+yVw8hFbl6nZH+ZWeje+qe1vKc3AarWUHxn+63MtvQqOmlIeSg
         nvWl+/M6ygAn65l2oZ7KBjaDmP3lzfWMo3Cm9O5qDTX0Ymncl5kURYgRd1T5gmCQMPYF
         5FVCLpzMYum5OV1yH6p43O/9FUDUIwtpTMe0bYGQCXiWkFxtbcMMvvVP8wUkDyrX3f9B
         ojfkwX0SIcJLI8SOGVSUzHE++uzxLQyGMhO+Nd+22YPWyYiprZUiQpGwu0mJN3gULwah
         ZGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpRqpOEyos9gWVI1KI/vAHqH4Vkw1K4vS/+vG+O4M0M=;
        b=laYGGtFzZao+3nm9/aOBg3q36uXPaH3a75nLZ159CnaPi9amC4Nqxig2evc9w2WD0S
         RuvEsD1bFKDIqsOJPzqmWvlth2hQlpq9QWGCgK0w/sBSQWXJTCWDtV3N+mWgbODIYDO0
         tIjNHxtOW9+/Y1q2rqhdbHKMCt/7A3KawKK+nJnEY/4yT+acltnytsvySs3S9HCnhNhL
         42PUbwR5YqRaDN79tqa/V4If05dWNMin2F79zlm3FByDgp7PwU6h9JtAVlpV2j6FRJ3p
         tmdCw6JotFPzoD/Aco1QZMUki0GjPM4DYleYjs+mmvFnzeVFldoQmTqttQPpj2hS5l0m
         jtQw==
X-Gm-Message-State: APjAAAXecACaHDcCRn8/uL8lrHLC111YxcyTJ/8QUixHnPvJ0B4pXLH+
        MxFN9srvIzFQWbtIpBljsJcwkJ9H4ART0ge+vdC+Ig==
X-Google-Smtp-Source: APXvYqzikCIRRm6GKiKDXwi/hI0nEYiWh5ayabFF03vNzuu9ihfvXwabo/dqnt4HiGji3FAZ2BKPmf9rRBzJJFA4FEs=
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr4323307jao.82.1562331787454;
 Fri, 05 Jul 2019 06:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb362d058b96d54d@google.com> <20190618140239.GA17978@ZenIV.linux.org.uk>
 <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629203927.GA686@sol.localdomain> <CACT4Y+aAqEyJdjTzRksGuFmnTjDHbB9yS6bPsK52sz3+jhxNbw@mail.gmail.com>
 <20190701151808.GA790@sol.localdomain>
In-Reply-To: <20190701151808.GA790@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 15:02:54 +0200
Message-ID: <CACT4Y+ZR98hxgG9GC0ijC_o0UuYdYEY2pAnf01nBLNTjhG4+Vw@mail.gmail.com>
Subject: Re: general protection fault in do_move_mount (2)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hannes Reinecke <hare@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 5:18 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > FYI, it also isn't really appropriate for syzbot to bisect all bugs in new
> > > syscalls to wiring them up to x86, and then blame all the x86 maintainers.
> > > Normally such bugs will be in the syscall itself, regardless of architecture.
> >
> > Agree. Do you think it's something worth handling automatically
> > (stands out of the long tail of other inappropriate cases)? If so, how
> > could we detect such cases? It seems that some of these predicates are
> > quite hard to program. Similar things happen with introduction of new
> > bug detection tools and checks, wiring any functionality to new access
> > points and similar things.
> >
>
> Yes, this case could easily be automatically detected (most of the time) by
> listing the filenames changed in the commit, and checking whether they all match
> the pattern syscall.*\.tbl.  Sure, it's not common, but it could be alongside
> other similar straightforward checks like checking for merge commits and
> checking for commits that only modify Documentation/.
>
> I'm not even asking for more correct bisection results at this point, I'm just
> asking for fewer bad bisection results.


Agree, if we implement a common framework for doing this type of
checks and affecting reporting in some fixed set of ways, adding more
rules can make sense even if they don't affect lots of cases. I filed
https://github.com/google/syzkaller/issues/1271 for this.

There are several open questions, though.
1. The syscall.*\.tbl change is formally the right bisection result
and it communicates a bit of potentially useful information. Do we
want to handle them differently from, say, Documentation/* changes
which are significantly a different type "incorrect".
2. You mentioned merges. It seems that they can be just anything:
completely incorrect results; formally correct, but not the change
that introduced the bug; as well as the totally right commit to blame.
Are you sure we should mark all of them as completely incorrect?
