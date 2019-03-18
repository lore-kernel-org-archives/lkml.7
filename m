Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F352085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="larDYdNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCRNmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:42:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33517 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCRNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:42:21 -0400
Received: by mail-io1-f67.google.com with SMTP id b6so14624467iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VSmuZ9cLLShOpzVwst3Yyx8BYdTKgmbABJWYUhy6YE=;
        b=larDYdNz6IxmvZ++Fge205s8PLhnkAT4wCvkx9OJPKnSwbBBBB9v5W3vF1voOBVJwE
         gOc2gkts5VEs9syB5QnJus6Ta4t/bvcbO/H3xEXAspD+QWh5f+YDijhtQx+Ntq43ukPN
         yVMocn37SVrAhUwOQ/PIshwkgnQxXhkVK0DqeTW7pwzyQYWscZzhLp1jPJD9vkCzwJzF
         E7WGaFl0KigAqiTkzRuwtrVR+Ds1lfwASsYqKSlTH/TmX206rbTCX0Ed8iHOvVI2XvGa
         ncem0ZpQ8lWe5r08ZH7KBLznIyxXPuyMEAQsFNuazoP7kaGmVrDeTQXQt6XnEyNJEy6U
         Af3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VSmuZ9cLLShOpzVwst3Yyx8BYdTKgmbABJWYUhy6YE=;
        b=pB6ObpPrIJA/3NiUZVdFS+aRm07ZHGEUg8aH5EGLqmVurgBqpTXi94k2A/7FOebv2d
         2YYfuJ5OFAp6pczeSiQsFI5WiLmMnTKsg0rROZNy2engMyBuVqBDYKWI776i+TIeXxaA
         LrLSbIXkXNS4LEduEJSRZD6HKWcLybDA5+hA/Yp+pKyRE/D7ysl9ao/EPjPt1wZfjraR
         N306O75AsXD83Pr372TlGwEBIHdHaRG9/6HZjV5MH/sbQ9qb4wp/M21jPtocAqq+AlTN
         OPatrpSQBGuQ9XC8Garh5sH96fBnyZPk0L+sFxPXiKA065Tw8KyV+mYyNz5StNkbRQNy
         YL7w==
X-Gm-Message-State: APjAAAUfZ7eg/IicclBrwf8Tj9mQdGXy16emH91YRYLg66qD8T+ewBNa
        hLv1BdG/PnVzGLnTCJ1IusezC8duQLkUaqM111D0VA==
X-Google-Smtp-Source: APXvYqwN/AMBPCtfMmbANSrM3SJj8OndSRAWbN6a6UdukIDjvgw91i81kpNC7o7aWasjHqjs+pyYsTZeQzKBl0c13is=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr11408587iof.11.1552916540769;
 Mon, 18 Mar 2019 06:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp> <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com> <20190318125019.GA2686@tigerII.localdomain>
In-Reply-To: <20190318125019.GA2686@tigerII.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Mar 2019 14:42:09 +0100
Message-ID: <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 1:50 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (03/18/19 13:32), Dmitry Vyukov wrote:
> > Wait, but isn't SYSLOG_ACTION_CONSOLE_LEVEL what we are looking for?
> > syzkaller knows about the syslog syscall:
>
> There is also SYSLOG_ACTION_CONSOLE_OFF, which disables logging.

That one I somehow figured earlier, here is the exact check:
https://github.com/google/syzkaller/blob/61f9c92f3a465025d2b9d91f429aaec968aeaa2a/sys/linux/init.go#L152-L155

But thanks for pointing it out.
