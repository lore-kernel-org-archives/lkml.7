Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC055C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2011218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576716708;
	bh=0EX9r4Usr/Xz41P8DxKtQMFRDEhnKssPtubblGO6yFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BTJsXkee5TABlPPJ+VztzgKEOhopQK/m+zhprMFUURYl8SATpdB9bmAn7M2vZD4uD
	 hNxcNCgEHCNPydrjiXxBr3fjI7+VeZQB9+x2wUKIZOfJFsth9GK3ci36wEDowD9eIo
	 a49Ar4M4PbYfnZUjdsdk2h9E75Jyp4BQrbjEj44s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLSAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:51:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37742 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLSAvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:51:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so3063248lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwJOrPvdC/OUnIx0D6OjuNWpdSOqNbwus7db7UF6FVU=;
        b=Nl5szeDVZvUT71nMP156KqkEP8YHndvFSlJCEiPDHzbV5vK5/s3HiS6NiImDS5R5cN
         Iy+cr0WDd6qL9kXmukbM0acwscQlGDkRF0HR0pWYJBQ0rljJpxJvxat9H5+HxFR0Ib9C
         jge2AHNXRjmluquEn00EdhqyX1BwD/AfPX6vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwJOrPvdC/OUnIx0D6OjuNWpdSOqNbwus7db7UF6FVU=;
        b=Yf1dJjFdsW5FW15HalMj9EnXtwj4PQObNmpKhx8v8cvjji/JIEbA7g1S5HU97CvZoz
         sdqFF+qnr/lbbDKFhh2A+vRRYR68OlDnISgVRiooY7ybU3BwwQRcRczPnzICpg7XsIs5
         s155QD5DAGB4AYQvQXndCa3RtsCArunanS7wjSAzrp05pGkqwT2MJU2Z5gTcbw/2e8Ub
         01hPbETtF/VTk/c9emJM5Q5zs6PsIkR/M0B2ZwfXr5szDySoO2oyqJ6xPesGGOWEChJ3
         vrs5TqeiD6xLARWHL4TAXf+zZWImJrPKeIajA5KjjypebfqSDbCxJ5i8e0j2TdCGxVh1
         47VQ==
X-Gm-Message-State: APjAAAW8kTYyMtj/St2uvoDld4uuYLzfXz17B8qinUugrEmMAtVevaP0
        zcepVBPcoRY4B0kAi8VqEx+l0/fSYjo=
X-Google-Smtp-Source: APXvYqxs5ijWRFSb/y+0krizjV1UNyNyJe+quwO0rZtdUHuDum1Y6LAqtQS0DanYNcYMAFGgEff3wA==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr3599169lfh.102.1576716705149;
        Wed, 18 Dec 2019 16:51:45 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i2sm1819642lfl.20.2019.12.18.16.51.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 16:51:44 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id p8so4261420ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:51:43 -0800 (PST)
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr3975797ljg.82.1576716703501;
 Wed, 18 Dec 2019 16:51:43 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru> <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
 <20191219000013.GB13065@localhost> <20191219001446.GA49812@localhost>
In-Reply-To: <20191219001446.GA49812@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 16:51:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
Message-ID: <CAHk-=wgMiTbRPp6Fx_A4YV+9xL7dc2j0Dj3NTFDPRfjsjLQTWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
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

On Wed, Dec 18, 2019 at 4:14 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Er, wrong file. That's the original patch; the attached patch is the
> right one.

This looks correct to me.

If I were to actually commit it, the "split into two waitqueues" would
be a separate patch from the "use wait_event_interruptible_exclusive()
and add "wake_next_reader/writer logic", but for testing purposes the
unified patch was simpler, and your forward port looks good to me.

I ran the original patch for a couple of days, and didn't see any
other issues than the 'make' thing in F30. It was all good with my
self-build make.

But that "ran for a couple of days" wasn't all that stress-full. I did
do the "verify that the thundering herd is gone" test - including that
silly test-case here again:

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

where you can tweak the numbers - add another fork() or two to create
even more pipe waiters, and maybe change the final count exit value to
match whatever hw performance you have.

         Linus
