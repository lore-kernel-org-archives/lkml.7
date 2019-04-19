Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E0DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2243D218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsVYrQ8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfDSThR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:37:17 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38164 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfDSThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:37:16 -0400
Received: by mail-yb1-f196.google.com with SMTP id w206so2363509ybg.5;
        Fri, 19 Apr 2019 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54wytT4SbPhXz98Q+UAEWg2WiZYagVuPAyRD7VW1uXY=;
        b=VsVYrQ8wALTupJmMCFQ5EOieblCSpBKHAikC1XC6PsIxqkbIyfKO6qIItK9l8KYW9s
         URJEk+z6+OulcjTOl/ybswNPyM4SLZeuLzRrPcsPC7ARCHFcoznDPegJ90ZKDHhBY41B
         ZjED4GZJE3c5A5HkE5qgyHfylYBYP5xLHx61SQSDnlYT2UZYXtBIWD+WiSv10sp9AO/j
         QCsTuLZNZoTdWHFvsFLtHfTXAj4mvFDePlUutlCbUmfG9RKPWfq5dZXenILDDkaUFzU5
         MUNfjvLhlbGQ76fLzoeNSZ3iAGYVO3oCU94G2OJgcATARpfcVndch+Ga0RIiAPzVJReT
         0tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54wytT4SbPhXz98Q+UAEWg2WiZYagVuPAyRD7VW1uXY=;
        b=rp0IUvRgVx0eBffH6R39mUT/m+V3T8fWoc0rlnUIfcWOcsxn0R8GOrTGGSG2DFQzo2
         qU1SYZsHOLR8yu3IzwHPpJvMmxXYHzLX/JWVuDMxmYIJjq69IiAv1KNoThGyA9YuHG4i
         H6O7sZoMbEG8QlZtIofcEdXOLnTNM738cEOF2nA7aXevsT0OAL6OJmXOq3RuJ70m6FqF
         9YtpJFezxvXX58t1F51W5mOsC6f987afbqFoZYoPIbCDqmMteA+aaqxmh/xUAnj+DqYZ
         lnY8qUGTNlWt1XARIjvx61YEh0kHcwTf24jT9PZ18Fhq9aEpvEx7vWB8euNe+whObWF1
         BZng==
X-Gm-Message-State: APjAAAUhaBifqSLKlviMny3u1KaSOQloAaFcQKnKD1GBY4K1p2InKpv6
        WtYVUHA6BSyR9+c4Hwq5OixbF8M4hnJ0148mO12KMWIp
X-Google-Smtp-Source: APXvYqxLWjkGA/0hOqC4S036+CraDeqXUmK1B/S8AikDOr8tg9ryS+JL1FQ8LzFXKKkC9IhNMdp6eSY46oiRjzOdCHI=
X-Received: by 2002:a5b:543:: with SMTP id r3mr2028188ybp.462.1555666394402;
 Fri, 19 Apr 2019 02:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000091becf0586d104c6@google.com> <000000000000d97b380586d1205f@google.com>
In-Reply-To: <000000000000d97b380586d1205f@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Apr 2019 12:33:02 +0300
Message-ID: <CAOQ4uxgbAQEok9AqnnVwqBrF=q0UBP6yQuvdG-WDVpHNk8Xi7A@mail.gmail.com>
Subject: Re: general protection fault in fanotify_handle_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 8:14 PM syzbot
<syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Jan 10 17:04:37 2019 +0000
>
>      fanotify: cache fsid in fsnotify_mark_connector
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627632d200000
> start commit:   3f018f4a Add linux-next specific files for 20190418
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527632d200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1127632d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=faa7bdc352fc157e
> dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155543d3200000
>
> Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com
> Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
>

Jan,

It looks like lockless access to mark->connector is not safe as there is nothing
preventing a reader from seeing a mark on object list without seeing the
mark->connector assignment.

It made me wonder if (!mark->connector) check in fsnotify_put_mark() is safe.
I couldn't find any call site where that would be a problem, but perhaps
we should be more careful?

Anyway, it seems that fsnotify_put_mark() uses the non NULL mark->connector
as the indication that mark is on object list, so just assigning mark->connector
before adding to object list won't do.

Since a reference of mark is our guaranty that mark->connector is not
going away, I guess we could do opportunistic test for non NULL
mark->connector from lockless path, if that fails, we check again
with mark->lock held and if that fails something went wrong.

Another option is to teach fsnotify_first_mark() and fsnotify_next_mark()
to skip over marks with NULL mark->connector.

What do you think? Did I over complicate this?

Thanks,
Amir.
