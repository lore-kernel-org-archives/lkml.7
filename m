Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A904207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575914614;
	bh=Ho6NIaCNXfbkLEOMsuOLOK6gq9sAAuapYyd79Asasxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uyt3NSX9arzs+5cm1kq7hW6J1cwheL1MP2eryf52WX37ZcOJIUOIIRPtt31bNZdad
	 2cjVV+IPOODvfj++w59Hg14R8JnV6Aq5EjAwEDpcGp3nVAbx8Jvv10V0HR/DWaufJF
	 GvzLe8Fvczs7MsV/0rSQwltf+VocobC+JfMPpfok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLISDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:03:33 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:36911 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfLISDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:03:33 -0500
Received: by mail-lf1-f53.google.com with SMTP id b15so11447717lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpeayAw5RjosR9XsravUrBYg0E2pZAf0Pj7kxkBeMwQ=;
        b=LUAUPaeNDU6XQY5PvOsRTTNlTiJvWnF1rDQwxJZEDyC2iEwn8AaHrWqBf/A9/cXCba
         +4+rN3MzgxVmbvRFRnNdliSz/J/bsVEJ12fRPqK3GbO24nDJT5GLlRmFTEFrhhXpWvh4
         mWoerzE83OXDTE0wQspdalsWrEsrvNRBkYfbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpeayAw5RjosR9XsravUrBYg0E2pZAf0Pj7kxkBeMwQ=;
        b=rt/4kzddH7cIGpiGN/SMNDA5eBhXkGFT+IBva8egy2say/+HLAZR9OjxdazBknDnd4
         GshEF5MA5065NKj4xwPft8s4WpNkavAZjmORO5INQU2AJx4kw4RpP5Ur59gMAVOFvmi4
         oYpGhj5CbJSTaXtSX3Yfi+gkr3myrNaqc2Qdxk9KjkDWQOj83Wl0v9Kmmcd1fUEvW5c9
         ohFwHUnllqYRtUGL1z9ly9jd1A9SvxCgZMdp19isxkmaZTOivgoHVDcOmRqyA4m9qmHT
         EZQip8YXtMnlt739dpangcIKCxPETrc07MY897IOFILktephkA/SozO74i6osugDXdqh
         ymwg==
X-Gm-Message-State: APjAAAWkTBPuN2K8EhvJTguxOzJMkuRhz92BDA2m4SkieCTaKtxKw0bt
        t5MSPkmrTrkAluVIw34tWXnEEt//JOI=
X-Google-Smtp-Source: APXvYqxVylMz11aR/tS23/e/Aui83Lr6hzEBl0nClHPBdCFQJwi8QiuFuDznckAMs2Xf5RV9u1rrJA==
X-Received: by 2002:ac2:5a09:: with SMTP id q9mr6700194lfn.71.1575914608921;
        Mon, 09 Dec 2019 10:03:28 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e8sm359696ljb.45.2019.12.09.10.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:03:27 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m30so11431866lfp.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:03:27 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr15967030lfk.52.1575914607385;
 Mon, 09 Dec 2019 10:03:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209173820.GA11415@redhat.com>
In-Reply-To: <20191209173820.GA11415@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:03:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik2dEemT+aG+Nmv7_kan7Cwz+vobL_=QtGWxPkV3yq7A@mail.gmail.com>
Message-ID: <CAHk-=wik2dEemT+aG+Nmv7_kan7Cwz+vobL_=QtGWxPkV3yq7A@mail.gmail.com>
Subject: Re: Fundamental race condition in wait_event_interruptible_exclusive()
 ?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 9:38 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> > because we've added ourselves as an exclusive writer to the
> > queue. So it _says_ it was interrupted, not woken up, and the wait got
> > cancelled, but because we were an exclusive waiter, we might be the
> > _only_ thing that got woken up,
>
> And that is why ___wait_event() always checks the condition after
> prepare_to_wait_event(), whatever it returns.

Ack. I misread the code, and you're right - if we've been woken up,
the condition is supposed to be true, and we never actually return
-ERESTARTSYS.

So the situation of "got woken but returned error, and lost wakeup"
won't actually ever happen.

Good.

So yeah, I can do what I wanted to do, and it should all work.

I never even tested it, because I was getting fairly anal about
possible races in the pipe code by then.

               Linus
