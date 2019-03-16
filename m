Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C1EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7CC21900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwZ18zWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCPOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:16:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39401 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfCPOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:16:51 -0400
Received: by mail-io1-f67.google.com with SMTP id e13so494679ioq.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS+VDciBPbw/cJF2mfBGU8fZjyGc/ql1wZ6c+bxfAqo=;
        b=OwZ18zWe3thmB714gDprtGmJKX/gfabm5JkTYj7CKBy+tqxjz+AeYREXBOfLPM6K67
         5X0m57VZqTQeWTQluB01Bd0dvQ1QLv/O3OwT31LWj10IZg3HbT29xtKKqAyfacQtkJgp
         RShtRtlhnZCTod7DBPsU6fp32PAP2dST90vQ3Bs+Ks3xuELdRiSLQiC3Wg8AeDLYxEEQ
         p3Ba4MdNySRz5s5C6oQoTBwKzL4ic7DJ8pdSJhdMwP6KpqInil2xBeBkeHYEnPCSksVm
         3KZwbJx+xa1Y+y13LIlgcQ8tnkVcYXX4T65pO1D0lJdHNCjGXUOIs1JYLFCbhEUwP5I/
         r7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS+VDciBPbw/cJF2mfBGU8fZjyGc/ql1wZ6c+bxfAqo=;
        b=s3HEjNfR1HOIZ8OyMzrBak3DsSH2Tm6T83wO3PlJWJkjzkn52WsDqDZ/ShW9cSrYVX
         37uxk7yMxwsfIZw1hhKeEREXscjML5Gr4tDgscuW9rXCPPsKyko4ZxrlvivlhgStvJIB
         un+koFen8pK8sjkwEfxrCLqE5XpRH0dbiMNPUGU/tlpugzOTKoYqabPIhnh5fljuSHAM
         al6b501Dh0bFgMBvhTtf8ZUeEasruuMzAFmcZmaO2OYxiIOKx8m/rTGKs31h8vJCV2TR
         3ZzPbry1d6bVTesOCU1z5g722r0bt/eY6IyJM4TynQOD9W+VzRc1p634jSUE4ZS9wTDz
         vWpg==
X-Gm-Message-State: APjAAAVRLswZESO429IhDzUKpNVTdRbTvwu4I4bKYseyJS8utl6hK2FM
        55Uy269NWTh/mMsm6lsEYBaMIbQKbOJ5VlKDZmUsKg==
X-Google-Smtp-Source: APXvYqz4cm/+vb17OD5lliB4+u9uZNYwVXZCideClf/KiGlQ3lUts1/zcr9m77n+dhJX71Jmvn9JUvhPyD6gIg+K1Y8=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr5182334ior.271.1552745809786;
 Sat, 16 Mar 2019 07:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
 <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
 <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp> <20190316141410.GA18654@tigerII.localdomain>
In-Reply-To: <20190316141410.GA18654@tigerII.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 16 Mar 2019 15:16:38 +0100
Message-ID: <CACT4Y+YEx5PF7QqaLdYpkyBCr_eBgp1n2yuY2LyrN9iZANXgzQ@mail.gmail.com>
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

On Sat, Mar 16, 2019 at 3:14 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (03/16/19 19:18), Tetsuo Handa wrote:
> > On 2019/03/16 18:11, Dmitry Vyukov wrote:
> > > Such reports showed up always with low frequency. For all that I
> > > looked at we also always had a normal  non-truncated version, so I was
> > > never too worried.
> > >
> > > If something would write from userspace, that would show up in the
> > > output, or not?
> > >
> > > Perhaps syzkaller somehow manages to lower console output level?
> >
> > panic() calls console_verbose() before calling
> >
> >   pr_emerg("Kernel panic - not syncing: %s\n", buf);
> >
> > line. Then, someone might have changed console_loglevel enough to
> > suppress printk() output.
>
> Hmm... sysctl, may be?
>
> > > I figured out that we should restrict it from doing
> > > syslog(SYSLOG_ACTION_CONSOLE_OFF). And I also restricted its access o
> > > /dev/console. But maybe there is something else? It _should_ not be
> > > able to write to random sysctl's.
> >
> > Maybe try running with "ignore_loglevel" kernel command line option added?
>
> Right, that's something I would expect 0-day and syzkaller to do.

to double-check: enabling this won't lead to verbose/debug level of logging?
