Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79017C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488862085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCteQWEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCRMSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:18:18 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39357 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCRMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:18:16 -0400
Received: by mail-it1-f194.google.com with SMTP id l15so20886670iti.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhc34cp7ul6RIl6hg+LkbLQXlFAa0bux2b/Uv9Q+8ds=;
        b=bCteQWEQ7a/Ce7oIkJ1ujPxTtZS+qerrJQHyfzureR3wkS/5C/gAbvuFtJG6ThrhyO
         C4pX5UA8d9+RGyn6WTHzp6nd2w2c2L7buxUxRipO7Mgn3QFOGn2Y1AI//Lbjti2FQVZy
         0BOyJGm0q5zj2uE9R8LNQQLrMMIuUmJyQkL5wO3Aard9e0FjHdoefmYrNVyyKyEmAv6w
         Hu42TJXs3DEaZ2eJLoZ9KscGeLNW0I+B3ORdCTxRt9G0o4h/B6U5iCJCz10rHua2W9Fj
         KeyKyl7foWVC2Af5T6jTrbhatV2VqrnwnLN/KOGhTlPW6oVV7tJ7g3cpdkwyCkaGC05r
         4bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhc34cp7ul6RIl6hg+LkbLQXlFAa0bux2b/Uv9Q+8ds=;
        b=uH6XIsD9pVIls4ZrcpZJlA7UEBYVkFrhRASUUiZ9WlpLQ398XPlZ2YBVlwpz9lq45z
         r06eKu/EYunVgHQfLZbZ4obCZHkD/E+72+yvCihrNej0suSIgbOx4/pkkwzXEXjxUZGf
         fKr9xuKRGH9Lk3fTxws01owI7qVCP6lj98pNbMHQGcVAVWAovV9JheF1CjkccjKgrHY3
         Ff/PQjX7gwUx2b+jptOUcwuiro7SZMjGTyQ4vcFSvUHWygZsZKN0x05FjVgR7M0j9JkF
         0mawmVK897p3Jz+eBRn7wqn9lqqHK/dZ790qwL1FkK8MN/tIYUQZHwogJQYlXlWWjMyj
         AyVg==
X-Gm-Message-State: APjAAAV/rlDrMRSOcTl9BMkvONjs0DaPTWE5Zf0fQJBcrlEoSKrZnD1k
        w3CL0RpAWW9Qj9C8CrGGiY+myfn2jIMhctc1IvJ690FXb4orKtOf
X-Google-Smtp-Source: APXvYqwQ0AI6IjXA3aCfxfTc3KyOKQxDZ+P2Awfq0baql/7lUUDE4keKZuNVwYzFTm/Uh0NB+GgZM24tiSMcTrYjWx0=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr9678695itl.166.1552911495269;
 Mon, 18 Mar 2019 05:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007da94e05827ea99a@google.com> <0000000000009b8d8a058447efc5@google.com>
 <20190317110447.GA3885@kroah.com>
In-Reply-To: <20190317110447.GA3885@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Mar 2019 13:18:04 +0100
Message-ID: <CACT4Y+YrrTtEAVidT+DiW1Wet0uxEtNP2kjjWN6GYDo8423SCg@mail.gmail.com>
Subject: Re: WARNING in rcu_check_gp_start_stall
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        forest@alittletooquiet.net, "H. Peter Anvin" <hpa@zytor.com>,
        konrad.wilk@oracle.com, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, puwen@hygon.cn,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tvboxspy@gmail.com,
        wang.yi59@zte.com.cn, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 12:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 17, 2019 at 03:43:01AM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit f1e3e92135202ff3d95195393ee62808c109208c
> > Author: Malcolm Priestley <tvboxspy@gmail.com>
> > Date:   Wed Jul 22 18:16:42 2015 +0000
> >
> >     staging: vt6655: fix tagSRxDesc -> next_desc type
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111856cf200000
> > start commit:   f1e3e921 staging: vt6655: fix tagSRxDesc -> next_desc type
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=131856cf200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=151856cf200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000
> >
> > Reported-by: syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com
> > Fixes: f1e3e921 ("staging: vt6655: fix tagSRxDesc -> next_desc type")
>
> I think syzbot is a bit confused here, how can this simple patch, where
> you do not have the hardware for this driver, cause this problem?

Yes, I guess so.
This perf_event_open+sched_setattr combo bug causes problems with
hangs at random places, developers looking at these hangs again and
again, incorrect bisection. I would be useful if somebody
knowledgeable in perf/sched look at it.
