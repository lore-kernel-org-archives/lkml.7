Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E82C2D0C4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 06:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C857C20867
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575701254;
	bh=hDSrdJp5FnmJpID01avCkZdZ+J3Sonq9F81P4yAHzg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kQbznLJ6F7tYX5z29YxuJZHx41d5ioamMrYNo+AAAJCDU9HKLwt3q7nZKSe2S/OTd
	 ByoBm1lnitukpzzCUGBjWLDfDNRpGrffZG20YjtVLuUGTrxuFwks1cGvu6k75XmmyI
	 /ulBBI3JkViPZ0jTYo72pFFSt5R+m3S1JUDj6wko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfLGGrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 01:47:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38196 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfLGGrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 01:47:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so6948074lfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPyMBRgocz3Gumc8hl0udOJ28y6fAihoSPqhWLZGSXM=;
        b=h7pAQHlrS6wsadii68Qu+ijamfwzEaVopIOIiDv9h0hJUjMnoGk9P+OtTNLnGmPppc
         W7AxQS9TnRlwOWRH1bRJ+xNjY0XkB6HAqCnGY1EtuiQ1JktHJD/nePqvOv+A95wC7Xjr
         6eP1E881/JjuF6eV/8qFgevKqrjb1xXHiV/Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPyMBRgocz3Gumc8hl0udOJ28y6fAihoSPqhWLZGSXM=;
        b=A1rz5mUZST6U28zNoyemEKaZ4mpg4jKOetmyfzDak/qS3pzSznPYzEL2l/M/KP8bt9
         lYDLcSUvLgkav6Z2/g6vr8QFHeCPhjWkCNPpXdJynRDLrQAyVE0R5Jjb13VPmnDvgDDf
         Q8wVEWTuCFSnj+lKLQBnnWSrX7aH2Vf8NC1CPchuDyxyjiNBspQmRFdFXF+QX8j2iBgq
         FTV++41/i0pJ/vc/tVXJ9kl+DF/QcE0X27JzXvLld6AW/txIo733sg8mD9hUlOBzr9Nz
         rvHhauHux1A7ZXZ9aroy8qwGTye/pIHuuJxE0+j4+knc5FOIIh4MRmlyFlWIjGdR5DHr
         dZEw==
X-Gm-Message-State: APjAAAVTCipS+4DR4pfMp2fMbkKAIkN4w1PS2kaSu45Ve3Q0Ouo8Szv0
        WFnQiuKeTfGc9vbRAO0GtKqciyU4aD4=
X-Google-Smtp-Source: APXvYqxFY1P1qKwjgFS79JrOp4MGfLQ9cybGi3Q7Livs9f1tjOLyEIrwlfiyM69a63GnWIutkOUing==
X-Received: by 2002:ac2:544f:: with SMTP id d15mr10815068lfn.126.1575701249353;
        Fri, 06 Dec 2019 22:47:29 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b17sm7514044lfp.15.2019.12.06.22.47.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 22:47:28 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id r19so10045262ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 22:47:27 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr10951802ljg.133.1575701247153;
 Fri, 06 Dec 2019 22:47:27 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude>
In-Reply-To: <20191207000015.GA1757@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 22:47:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkmG9xu_tvMbFTUyn3f2knr7POHjiwMtEmNxXzdPN8wg@mail.gmail.com>
Message-ID: <CAHk-=wgkmG9xu_tvMbFTUyn3f2knr7POHjiwMtEmNxXzdPN8wg@mail.gmail.com>
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

On Fri, Dec 6, 2019 at 4:00 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.
> Reliable testcase is facebook, where timeline isn't updated with firefox.

Hmm. I'm not on FB, so that's not a great test for me.

But I've been staring at the code for a long time, and I did find another issue.

poll() and select() were subtly racy and broken. The code did

        unsigned int head = READ_ONCE(pipe->head);
        unsigned int tail = READ_ONCE(pipe->tail);

which is ok in theory - select and poll can be racy, and doing racy
reads is ok and we do it in other places too.

But when you don't do proper locking and do racy poll/select, you need
to make sure that *if* you were wrong, and said "there's nothing
pending", you need to have added yourself to the wait-queue so that
any changes caused poll to update.

And the new pipe code did that wrong. It added itself to the poll wait
queues *after* it had read that racy data, so you could get into a
race where

 - poll reads stale data

      - data changes, wakeup happens

 - poll adds itself to the poll wait queue after the wakeup

 - poll returns "nothing to read/write" based on stale data, and never
saw the wakeup event that told it otherwise.

So a patch something like the appended (whitespace-damaged once again,
because it's untested and I've only been _looking_ a the code) might
solve that issue.

That said, the race here is quite small. Since that firefox problem is
apparently repeatable for you, the timing is either _very_ unlucky, or
there is something else going on too.

                  Linus

--- snip snip ---

diff --git a/fs/pipe.c b/fs/pipe.c
index c561f7f5e902..4c39ea9b3419 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -557,12 +557,24 @@ pipe_poll(struct file *filp, poll_table *wait)
 {
        __poll_t mask;
        struct pipe_inode_info *pipe = filp->private_data;
-       unsigned int head = READ_ONCE(pipe->head);
-       unsigned int tail = READ_ONCE(pipe->tail);
+       unsigned int head, tail;

+       /*
+        * Reading only -- no need for acquiring the semaphore.
+        *
+        * But because this is racy, the code has to add the
+        * entry to the poll table _first_ ..
+        */
        poll_wait(filp, &pipe->wait, wait);

-       /* Reading only -- no need for acquiring the semaphore.  */
+       /*
+        * .. and only then can you do the racy tests. That way,
+        * if something changes and you got it wrong, the poll
+        * table entry will wake you up and fix it.
+        */
+       head = READ_ONCE(pipe->head);
+       tail = READ_ONCE(pipe->tail);
+
        mask = 0;
        if (filp->f_mode & FMODE_READ) {
                if (!pipe_empty(head, tail))
