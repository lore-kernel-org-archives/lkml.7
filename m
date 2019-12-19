Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A7C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B742053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576773369;
	bh=xG7eJsmAZg4wSxUOdMks7A4AOxBSoLjaaUd4IsnGwg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Au0AN2eO/pP2AjfOTk72FS/cCSR2cL3KX3AVQimpAzQXsK9USYXnguPzBNKQNqu5z
	 aEOZPYSla3oO8WJ5ICvutR1/Z92OeUZIwiNOSvF78prHPmmQSBw48gQmYWh9zz7257
	 R9GuPrvABQdNoIJAp7+zAZBlMfQ89ML/TlDrAjJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfLSQgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:36:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46971 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:36:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so4491788ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0EPaeAm1h5et+pcE0Lw2TnBFxWaf1zou6EIoTCmP30=;
        b=bZHWn0PsXhDbOK/Bql+EUdVYbHBqZFT+2Nbu2NKTbOPDpYJnxQ8/xUws763LXH9j3m
         XvTn3+qa6G5xDrHkogar6bc8r1mWIiQFLSpH4PfDJaTYQjML3UPjF8ReFuAn4IPFe3wt
         CsSw4N/hW8UkyP4cDs7xLRa2iwzcttIS4FCkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0EPaeAm1h5et+pcE0Lw2TnBFxWaf1zou6EIoTCmP30=;
        b=fLD6SclczqgTxMqc83/PnM03yC46mYN7SgbMrpuWcceQgBO3izOnPZVWN3a6VBdcPb
         SEHQSQNh/BGfB7L8LUXFCPa2IGoVPJ6BkCLwB17gWPSC5aUmylJU2Cheb9YWy3k2kIKf
         sMY6lfHxx5UXEG1gcgz2MI8Wqu3Zoej86OG79zmiFxNByPd78mvZmaBaq7UH1l89W0ag
         CsFDqBPal7Sqd57osdmt/nGO/Uq+1gOtugH1hdxGWG4ZbOdSjZhMy4QudpqItfAuNGmI
         kPNKTQDQw67c16Zkg4WcbkUHoREkNRJJcrMIR31joj5po7XFnIVPbe9OeiCd6SlnWwNX
         2gtA==
X-Gm-Message-State: APjAAAWNvmSqqBaUBz1j6pafXGaF6o3oFouDAApRUxULVrTyTrDRRTDf
        Bbgghy1X5oGZpW0AfpdGOEXFY1bVZdU=
X-Google-Smtp-Source: APXvYqxXMYywtGonobgbmDVArwHxncOTzu6oeSFcCoSVbmi8DenMSfhA1pJfLhbmtQ4Tyohrheo4bQ==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr6753013ljh.183.1576773365064;
        Thu, 19 Dec 2019 08:36:05 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u9sm3103342lji.49.2019.12.19.08.36.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 08:36:04 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id u17so6934692lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:36:03 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr6832409ljj.26.1576773363095;
 Thu, 19 Dec 2019 08:36:03 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru> <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
 <20191219000013.GB13065@localhost> <20191219001446.GA49812@localhost>
 <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com> <935.1576742190@warthog.procyon.org.uk>
In-Reply-To: <935.1576742190@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Dec 2019 08:35:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQdy80352u4d39QD58yQKaNfeEz+k3eRwZw5faEYFsgw@mail.gmail.com>
Message-ID: <CAHk-=wiQdy80352u4d39QD58yQKaNfeEz+k3eRwZw5faEYFsgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:56 PM David Howells <dhowells@redhat.com> wrote:
>
> I looked at splitting the waitqueue in to two, but it makes poll tricky.

No, it's actually trivial for poll.

The thing is, poll can happily just add two wait-queues to the
poll_table. In my conversion, I just did

-       poll_wait(filp, &pipe->wait, wait);
+       if (filp->f_mode & FMODE_READ)
+               poll_wait(filp, &pipe->rd_wait, wait);
+       if (filp->f_mode & FMODE_WRITE)
+               poll_wait(filp, &pipe->wr_wait, wait);

which changes the unconditional "add one" to two conditional adds.
They _could_ have been unconditional too, but why add unnecessary
wakeups? So it only really does it twice on named pipes (if opened for
reading and writing).

It's _unusual_ to add two wait-queues for a single poll, but it's not
wrong. The tty layer has always done it - exactly because it has
separate wait queues for reading and writing. Some other drivers do
too. Sometimes there's a separate wait queue for errors, sometimes
there are multiple wait-queues because there are events from the
"subsystem" and there are other events from the "device". I think
sound does the latter, for example.

And no, I don't particularly like the FMODE_READ/WRITE testing above -
it would be better to pass in the polling mask and ask "are we waiting
for polling for reading or writing?" instead of asking whether the
file descriptor was opened for read or write, but hey, it is what it
is.

Sadly, "poll()" doesn't really get passed the bitmask of what is being
waited on (it's there in the poll_tabvle "_key" field, but I don't
want to have the pipe code look into those kinds of details.

So the named pipe case could be improved, but it's not like anybody
really cares. Nobody uses named pipes any more (and few people ever
did). So I didn't worry about it.

            Linus
