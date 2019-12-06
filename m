Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39AFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DBE21835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575664108;
	bh=/mY6Gf87yii0N26MJCZahA8y7dAmKChy7AcGqhinDfs=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=XcXsCCj8bcZA8N/dY5v1+7zNTZZ5MxOOKz/gPoq5FatQzp0aX0sxhA1bNH9dgPtyo
	 ipg8L02xByemmb22NIDp5oK9PWUkD+EoWDqIe934f/U6JAurpaSjCeBQJ1Ix9KEXqY
	 u3x6wqtyGkU+pk49ECg5WfabLbe5v5LPLVDOAX8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFU21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:28:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33971 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:28:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id m6so9047614ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D7AuzC7KPUuG+16rwarCAF7khGQqEuNHk2heBfehumM=;
        b=g8Wqm1UmJpiH9XsG7+mZgytZn6KAUz++mHOwaddVEx2NVcxiPW1xU5oMTujibpzGt1
         vA9Ahc4HGx1rvG4yaU+qIwSsmJrUqOaUYXaZB3Qxd428SSA5oPrNmN3i/iWippFABM3e
         SQvl5CWEZqP7WerH4SEuBDeTCnoSRwNi7YXJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D7AuzC7KPUuG+16rwarCAF7khGQqEuNHk2heBfehumM=;
        b=HYLGhWL4JEjkAgt4kR3JMV9GDMKIWxLGdrCDG3TTvpYla2IxAvu7+KP6bOGgWtF3L9
         7UR3kRapFODZF04/AxpccS4Znf2a0/U8WUhHQRsi51HHJ/fqMnImjxxK89w9tL/B4TS7
         NTpWrYhXqtkWPhOD8reBGRlSn2r4SQGpXiYQHnOGe5rO9It37AOgiyPITfVTwumtI+2e
         58G8eKzgvtq8RPqEjTYNVlekiu09l0x5HE1qeUD5AkVnBwCmGhkryCxJedKTvlfXun44
         N5YDJutLgtrWODdqHfvXclz9qsld2V65W2Mx1Lq/5VnfViuHs2IEe1t9qa9HiOyLBF+N
         tk1g==
X-Gm-Message-State: APjAAAUXKs37IIvWsNMgQAGkpw4wMNSYjyxMaaxWlccQ317ownWRo5os
        53j+NHzRbFuJtbuA2QN4rADSHHO8o74=
X-Google-Smtp-Source: APXvYqz+5qGKoOynTIDcLCrkU65EvYrhHuYGwOYREzOfk7KUB/MsLaP7caCGb39w2d6DOYiB3TpuGQ==
X-Received: by 2002:a2e:8606:: with SMTP id a6mr9670828lji.119.1575664104320;
        Fri, 06 Dec 2019 12:28:24 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b17sm6990427lfp.15.2019.12.06.12.28.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:28:23 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id c19so8954050lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:28:22 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr9946818ljj.1.1575664102180;
 Fri, 06 Dec 2019 12:28:22 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
In-Reply-To: <20191206135604.GB2734@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 12:28:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
Message-ID: <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 5:56 AM David Sterba <dsterba@suse.cz> wrote:
>
> For reference, I've retested current master (b0d4beaa5a4b7d), that
> incldes the 2 pipe fixes, the test still hangs.

I think I found it.

TOTALLY UNTESTED patch appended. It's whitespace-damaged and may be
completely wrong. And might not fix it.

The first hunk is purely syntactic sugar - use the normal head/tail
order. The second/third hunk is what I think fixes the problem:
iter_file_splice_write() had the same buggy "let's cache
head/tail/mask" pattern as pipe_write() had.

You can't cache them over  a 'pipe_wait()' that drops the pipe lock,
and there's one in splice_from_pipe_next().

        Linus

--- snip snip --

diff --git a/fs/splice.c b/fs/splice.c
index f2400ce7d528..fa1f3773c8cd 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -495,7 +495,7 @@ static int splice_from_pipe_feed(struct
pipe_inode_info *pipe, struct splice_des
        unsigned int mask = pipe->ring_size - 1;
        int ret;

-       while (!pipe_empty(tail, head)) {
+       while (!pipe_empty(head, tail)) {
                struct pipe_buffer *buf = &pipe->bufs[tail & mask];

                sd->len = buf->len;
@@ -711,9 +711,7 @@ iter_file_splice_write(struct pipe_inode_info
*pipe, struct file *out,
        splice_from_pipe_begin(&sd);
        while (sd.total_len) {
                struct iov_iter from;
-               unsigned int head = pipe->head;
-               unsigned int tail = pipe->tail;
-               unsigned int mask = pipe->ring_size - 1;
+               unsigned int head, tail, mask;
                size_t left;
                int n;

@@ -732,6 +730,10 @@ iter_file_splice_write(struct pipe_inode_info
*pipe, struct file *out,
                        }
                }

+               head = pipe->head;
+               tail = pipe->tail;
+               mask = pipe->ring_size - 1;
+
                /* build the vector */
                left = sd.total_len;
                for (n = 0; !pipe_empty(head, tail) && left && n <
nbufs; tail++, n++) {
