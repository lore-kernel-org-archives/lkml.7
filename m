Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB724C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E6F20637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575839602;
	bh=F4D9vvmLe0U3Hh/gsNrxd+ojg1P2mYr09CJcs75rmHQ=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=s5HE2ejyAUdfBEFRllAyhCyOUT+525P0G+GKaJoMWKHUpxx/IrDnz6IpDx+3DjlRI
	 7b9Z4XWpofU3DQ7rlS+N3Bd3RANF/H2KGtJcPsVd9pTgby0nGdMtEfDGgCArCvXBr/
	 Owu0bOTNNWEjOaJa3nwBciOv20/EgDTTirem1S4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLHVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 16:13:21 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41366 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLHVNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:13:21 -0500
Received: by mail-lj1-f169.google.com with SMTP id h23so13303288ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d3S3tZ4cyxYnqybCtgSUG/QSzGylVP+6oGA6c3aAP30=;
        b=MCu8xXwViwxnt/W5lRZ1jEe9Q7Q77WzXDMckhiMbrfG3uGXhUJx7gdOkz0KeKNOSsd
         On750D2T1DYYQxpA2zJ35buKOC2qiTumHBjY6pOlYoVy5Ba+CKNudMOmgeV013paeHJF
         cLAq+ODv2koRUIVwVCsmkt078i0rP0y82yhiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d3S3tZ4cyxYnqybCtgSUG/QSzGylVP+6oGA6c3aAP30=;
        b=tSswjUdbBGGbPyARdDm9E7O1xn+72lWJ5c7pEv428ccYlqogL8OmUeiNB1eGaAfTZQ
         2xgGikcT95h0ZEYGdPRR6+GXIMgRsrnjNFo17HHMvB0HNLoYcJuxu3FlgivcGGNR6PLX
         +3X+FKWzWf2AgtZqCcTDTb3qrlzVrj+xdQdAQMjSI5Sgv9Hqs/bS5HlYhcwGNzqojz94
         A+DtD39P7L3DnLymf0cvTc08ysc/l3AuhwMPPiu+tjnqV4ktRKswpzHUMGn7ajq0+mlV
         MgkIVVEyuxIB57WkDoLh3BXMzdhLFLS844pc8Ip2aDFNP+rNuqu1MKeiP7ACA83wimId
         UWbA==
X-Gm-Message-State: APjAAAUWy4fBd+8xvGB0eUnzU4GUK0H9Rj2afYAxFozqYzy13x1IgJQ7
        KiiuswKibqzZvo7yPMW1TOa5CA3KvUo=
X-Google-Smtp-Source: APXvYqzD82Ly78R3xnOD+w8Vgm9M6m/uPwVylLj11BGtUDeR6wWD+drmUIkBL6a0CY1a1HjZzFG4IQ==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr15050487ljc.222.1575839597000;
        Sun, 08 Dec 2019 13:13:17 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e8sm11637225ljb.45.2019.12.08.13.13.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 13:13:15 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id k8so13301136ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 13:13:15 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr12456110ljn.48.1575839595143;
 Sun, 08 Dec 2019 13:13:15 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 13:12:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
Message-ID: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
Subject: Fundamental race condition in wait_event_interruptible_exclusive() ?
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm looking at the thundering herd issue with pipes, and I have a
truly monumentally silly benchmark for it:

        #include <unistd.h>

        int main(int argc, char **argv)
        {
                int fd[2], counters[2];

                pipe(fd);
                counters[0] = 0;
                counters[1] = -1;
                write(fd[1], counters, sizeof(counters));

                /* 64 processes */
                fork(); fork(); fork(); fork(); fork(); fork();

                do {
                        int i;
                        read(fd[0], &i, sizeof(i));
                        if (i < 0)
                                continue;
                        counters[0] = i+1;
                        write(fd[1], counters, (1+(i & 1)) *sizeof(int));
                } while (counters[0] < 1000000);
                return 0;
        }

which basically passes an integer token around (with "-1" being
"ignore" and being passed around occasionally as a test for partial
reads).

It passes that counter token around a million times, and every other
time it also writes that "-1" case, so in a perfect world, you'd get
1.5 million scheduling events, because that's how many write() ->
read() pairings there are.

Even in a perfect world there will be a few extra scheduling events
because the whole "finish the pipeline" waits for _everybody_ to see
that one million number, so the counter token gets passed around a bit
more than exactly a million times, but that's in the noise.

In reality, I get many more than that, because the write will wake up
all the readers, even if only one (or two) get any values. You can see
it easily with "perf stat" or whatever.

Whatever, that's not the important part. The benchmark is obviously
entirely artificial and not that interesting, it's just to show a
point.

I do have a tentative patch to fix it - use separate reader and writer
wake queues, and exclusive waits.

But when I was looking at using exclusive waits, I noticed an issue.
It looks like wait_event_interruptible_exclusive() is fundamentally
untrustworthy.

What I'd _like_ to do is basically something like this in pipe_read():

        .. read the data, pipe is now empty ..
        __pipe_unlock();
        .. wake writers if the pipe used to be full ..

        // Wait for more data
        err = wait_event_interruptible_exclusive(pipe->rd_wait,
pipe_readable());
        if (err)
                return err;

        // Remember that we need to wake up the next reader
        // if we don't consume everything
        wake_remaining_readers = true;

        __pipe_lock();
        .. loop back and read the data ..

but it looks like the above pattern is actually buggy (the above
doesn't have the parts at the end where we actually wake the next
reader if we didn't empty the pipe, I'm just describing the waiting
part).

The reason it is buggy is that wait_event_interruptible_exclusive()
does this (inside the __wait_event() macro that it expands to):

                long __int = prepare_to_wait_event(&wq_head,
&__wq_entry, state);\

         \
                if (condition)
         \
                        break;
         \

         \
                if (___wait_is_interruptible(state) && __int) {
         \
                        __ret = __int;
         \
                        goto __out;
         \

and the thing is, if does that "__ret = __int" case and returns
-ERESTARTSYS, it's possible that the wakeup event has already been
consumed, because we've added ourselves as an exclusive writer to the
queue. So it _says_ it was interrupted, not woken up, and the wait got
cancelled, but because we were an exclusive waiter, we might be the
_only_ thing that got woken up, and the wakeup basically got forgotten
- all the other exclusive waiters will remain waiting.

Yes, yes, I can make the read_pipe() logic be that I ignore the return
value entirely, and always take the pipe lock, and always loop back,
and then the reading code will check for signal_pending() there, and
do the wake_remaining_readers if there is still data to be read, and
just do this instead:

        wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable());

        // Remember that we need to wake up the next reader
        // if we don't consume everything
        wake_remaining_readers = true;

        __pipe_lock();
        .. loop back and read the data ..

but that's kind of sad. And the basic point is that the return value
from wait_event_interruptible_exclusive() seems to not really be
reliable. You can't really use it - even if it says you got
interrupted, you still have to go back and check the condition and do
the work, and only do interruptability handling after that.

I dunno. Maybe this is fundamental to the interface? We do not have a
lot of users that mix "interruptible" and "exclusive". In fact, I see
only two cases that care about the return value, but at least the fuse
use does seem to have exactly this problem with potentially lost
wakeups because the ERESTARTSYS case ends up eating a wakeup without
doing anything about it.

Looks like the other user - the USB gadget HID thing - also has this
buggy pattern of believing the return value, and losing a wakeup
event.

Adding Miklos and Felipe to the cc just because of the fuse and USB
gadget potential issues, but this is mainly a scheduler maintainer
question.

It's possible that I've misread the wait-event code. PeterZ?

                 Linus
