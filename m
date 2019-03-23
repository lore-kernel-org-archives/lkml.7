Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC79C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E594C218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCWTsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:48:55 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36287 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCWTsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:48:55 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so8482692itl.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 12:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s522FjRALacXWdtiV96CbVXvCJPesQu3aDbWoGo4DtY=;
        b=mGxv6fSzhMZh/WpFduPqBviw/9sNo10RrSm5oxbI5QFIvX0wz1xkrrwzabYob+8WMx
         RocroMhjoOMPAUxzWCDzuBVry4EbrCTv0cQcbkl6VYYipruGfwGb93DBIAfiPIGpUmGt
         YC6CNzDJuw483JpBJxydI5j3QsdjMifuASS9tWHUEQJaM+bECXHw1h3/sgEauxBlYxRE
         urNtPUwn5r4k4+57AITnMY238b4KyygE3G4WmuPFHtivGEPe7VNTQfXoBYRmKZo0GZV6
         tOhCZi3vz8iS82evbqwLcyRx7vWFWFRu5TBsan+wa90CNcnLdHhckXe+pb5fkc4Vnhx7
         lhiw==
X-Gm-Message-State: APjAAAU5P6PDkYgcDksB2lJu9zm5GTwkUnLBicu9GRTSX74P6wwAU8kD
        p7/irSqd7kfOUH3w3uFxA6QtrFbMjr6AdcDNAlQSvA==
X-Google-Smtp-Source: APXvYqwlgjwjZHmqKN7w+HtiPxt3k5vs7y1aHWjzoPwogopi2FeeylXo2vSTAZpFHthQHo6KLwweySN9ugtyKT6mIS0=
X-Received: by 2002:a24:4198:: with SMTP id b24mr3333157itd.25.1553370534883;
 Sat, 23 Mar 2019 12:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f4efae0584be37ab@google.com> <875zs9oage.fsf@xmission.com>
In-Reply-To: <875zs9oage.fsf@xmission.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 23 Mar 2019 20:48:44 +0100
Message-ID: <CAOssrKcsXPqH-s-YLYdao3REpD=iQAeX9UvasB3n6RK84PuP=Q@mail.gmail.com>
Subject: Re: WARNING in request_end
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>,
        dvyukov@google.com, ktkhai@virtuozzo.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 4:52 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com> writes:
>
> > syzbot has bisected this bug to:
>
> Nope.  syzbot got it wrong.
>
> At most that commit will allow a larger class of users to mount fuse
> and thus be able to reproduce the problem.
>
> It does look like syzbot has found something concerning though.
>
> Miklos any ideas?

Dup of this?

bc78abbd55dd ("fuse: Fix use-after-free in fuse_dev_do_read()")

Let's test:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
bc78abbd55dd

Thanks,
Miklos
