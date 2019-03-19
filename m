Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F70EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F49A204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QG3kAGNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCSIKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:10:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39807 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:10:37 -0400
Received: by mail-io1-f66.google.com with SMTP id e13so6739917ioq.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55JpN7h5Cm1wdHGXAMw2S4e/Hdymfa+JelMv9Ti/sbE=;
        b=QG3kAGNLbyq85ujdMaXiqMwjfehuwZ81+bJ8I9c/6v053fzGoNFXQ0ufhaMfDj0z1t
         vQYBqbPlPuYDziKjUNgLZq5aeCc8/zsFCKebyzSVf4sMamzJGWc5IsNNpLKAf5fBRFUA
         nCAJi5ULyolQX2LJ+2g9jbLk0yD+DfhRdHgvo0pDgBLrLJFHcyA5Y6z4p1KTjticyrWG
         MLSO4XJjsV4NpyHHIEQ7UFkghKgRNM7TbCoUI/g3ZSpsuQxFogoY2VL+KgG+zqXkOgAa
         5bvQ88aSvIK3P0AEtu5UFurBuCST9/+EMdTvqHGPrfYhgEyIJ0Owzg9W8YpEAl/Y7e1P
         oL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55JpN7h5Cm1wdHGXAMw2S4e/Hdymfa+JelMv9Ti/sbE=;
        b=TQ+Njz5RIvCURUo12Xbm3Z1ez5gsi3kjAUz4MtwqcdxCOlVMhzXHUuq4UlbuAkW1wF
         5A5ab0BYyDMWJb6WRYTC2LAZqjMq22pw+WTWZyz4e/UOADXWW0cOVhaihU3OXc5GVb2F
         owWGpdGvRaZA+TqhaMItl1HQPbjp9c/HEJ3bXQWsep+vSdZIMYnPCDcKug/JkSgqbX12
         VS+jIqEmiU1luuDW9zLZMd1t+ufQ4TD0Z2fXXCOLjsZUXL8mwpEi3DlzaNdxag/VSBT5
         GSkNQ00/24pTfn0n1AnKl8W0aP3TcLAumnwe7a+syjEdBjesbc+F2qensI8mqsD3MqJp
         7z3Q==
X-Gm-Message-State: APjAAAUmNN1LYEd1V+yymVuvKGY/T3GoH7ejglz3i9Xmd6tU0PzeBtiX
        7omFFK5WjyoMYHFKf3JM/IolXuE0JJ0HCZZaaKUiMQ==
X-Google-Smtp-Source: APXvYqz0I8yoSsJxT+RbjlzMYlv9ljXdxfdfr5YpAA4VQrUGhsoR8/0d1i8nTKGaDIjcB9urAVgrBwDD2z8iqLeox24=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr562496ior.271.1552983036690;
 Tue, 19 Mar 2019 01:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp> <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain> <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
In-Reply-To: <20190318140937.GA29374@tigerII.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Mar 2019 09:10:25 +0100
Message-ID: <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 3:09 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (03/18/19 14:42), Dmitry Vyukov wrote:
> > > There is also SYSLOG_ACTION_CONSOLE_OFF, which disables logging.
> >
> > That one I somehow figured earlier, here is the exact check:
> > https://github.com/google/syzkaller/blob/61f9c92f3a465025d2b9d91f429aaec968aeaa2a/sys/linux/init.go#L152-L155
>
> OK, cool.
> You probably would also want to add SYSLOG_ACTION_CLEAR to the list.

It's not hard to add, but I would like to understand why exactly.
syzkaller reads out console output from qemu, GCE VM, android phone
all the time. So if something was already written and we read it out
right away, it seems that clearing won't affect things. Does
SYSLOG_ACTION_CLEAR affect only reading output via syslog syscall,
/dev/something?

In some setups we read out output with "dmesg -w" (should stream
output as well) in absence of a better solution. Will this be affected
by SYSLOG_ACTION_CLEAR?
