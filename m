Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7037FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3005C2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvcxbw3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDLK7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:59:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56091 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:59:43 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so14924452itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQ+37Y+pt9VrLXID4qKvk81Niz5ByGv73zeUFdJ7XP8=;
        b=bvcxbw3GrwTZ+gCXeYZzwDtGm3lBZzZjpbtuE80v8Qi7MjPKtoMXBVUbGhvBykOngh
         r5DLzf4uMhI1w0SkKo3DIal7O5uLzoORDxdJgR2Ak19rsr9LHYRN4u/bCxZrJE5MtStu
         +i+qdJsC8XNhI2GOOnCJsueZjkrkAY/cv+X68xyVYgsvre2NvUknUHd7ssaZ8ZSYIi0q
         1WndAQrCWIL8qOZK0bYBoesW6vCuWgG5Zq9xS/QeMsqm0yGX/ORWtn+Z/Y3cEXfETvm6
         dy4HqhfX7JBmAFr+sUgxkf4d3gTYonjs8kLBKgZy+vjgfLLTlrHrzdXmE3vWqX/6jbhA
         OzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQ+37Y+pt9VrLXID4qKvk81Niz5ByGv73zeUFdJ7XP8=;
        b=ar2ajzx+/EADcoXh3guxr9qdc2iCs9gD+Mr2QUdtDVzo3ZaKgfMJGAj3VTH1XhWnN5
         vWx/OYa5E2/ZLug7R/Db2Zv1bs5/TxJkw428enAwQqGt5QFZ7CjHTmJ7MHry70FmpNzJ
         32ZYuaG8JJ9CEqqB+vcLK2X/ETKxtESjlJBCP8N3qm3GoTjmx0IiOt1++9ZbreuHq0Ae
         WO34vYdaMxl+Eb75OIvvKrfwFvzM7rK0fzhCU1UVARp6C7MdQ8XLxNc6AjuDCPMuuJDh
         6C3iH0S25HOQ1P78owHxLbikN7M1kWYMaEubbvZ1C3KVr/mIczQOwtATy4PccE4cfR/L
         0gCw==
X-Gm-Message-State: APjAAAVYJ2BZsCV3Sq6UJvX/z/y79z9QRyLIosSdvw/dItq7dV2cQzYr
        VL9JewCHyGAOEsNXpuz4Nact8qjBwWZ6jNeyr3ln5w==
X-Google-Smtp-Source: APXvYqxEpyoxk0gJZh6nZukXxmZgMmfYhodUZH9Vuw79HObXKu0EViXw1UzWxF7kWUh2kBCLy9c84BRcamfkGQfVx6g=
X-Received: by 2002:a24:2f49:: with SMTP id j70mr12364018itj.122.1555066782097;
 Fri, 12 Apr 2019 03:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk> <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
 <20190410121159.GY2217@ZenIV.linux.org.uk> <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
 <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
In-Reply-To: <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Apr 2019 12:59:30 +0200
Message-ID: <CACT4Y+YKGX0MVEM-SrDKJc0500vCH+WOZpyzNr-O_tW7p5Sn_A@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 2:50 AM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2019-04-10 at 14:41 +0200, Dmitry Vyukov wrote:
> > On Wed, Apr 10, 2019 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:
> > >
> > > > > I'm unable to find a branch matching the line numbers.
> > > > >
> > > > > Given that, on the face of it, the scenario is impossible I'm
> > > > > seeking clarification on what linux-next to look at for the
> > > > > sake of accuracy.
> > > > >
> > > > > So I'm wondering if this testing done using the master branch
> > > > > or one of the daily branches one would use to check for conflicts
> > > > > before posting?
> > > >
> > > > Sorry those are tags not branches.
> > >
> > > FWIW, that's next-20181214; it is what master had been in mid-December
> > > and master is rebased every day.  Can it be reproduced with the current
> > > tree?
> >
> > From the info on the dashboard we know that it happened only once on
> > d14b746c (the second one is result of reproducing the first one). So
> > it was either fixed or just hard to trigger.
>
> Looking at the source of tag next-20181214 in linux-next-history I see
> this is mistake I made due to incorrect error handling which I fixed
> soon after (there was in fact a double iput()).
>
> I'm pretty sure this never made it to a released kernel so unless
> there's a report of this in a stable released kernel I'm going to
> move on.


Please don't ignore the bug status tracking part. Or we will only have
options of not testing kernel or dropping most of the bug reports on
the floor. Both are equally harmful for kernel quality.

Let's mark it as fixed by the next commit in series (which already
made it into mainline):

#syz fix: autofs: simplify parse_options() function call

But I won't be around always.
