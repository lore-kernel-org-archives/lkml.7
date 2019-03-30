Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D51D218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="G+yofZ6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfC3RMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:12:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43683 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfC3RMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:12:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id d26so4622288ede.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zC8Nl9G6/l5MMFOXorxDKy0jA9yGChzBjLvNeElBA7o=;
        b=G+yofZ6M4v5SaeLy/9xv1r+7DYHVR32oTFlPrWToYcUx+oQhgkI9/JnLaDzXJxgLrL
         v+dlBaFETZlGkMKEXQ4vif/yNh0uwn/lU4BWZGhUlQ+Og71Y0UpZYs0mbA8anLytC9Ib
         q0Cm2GPUWSlz8DjoeF3v/EXOsJm68KHIKHLvDN3LHx5P99mcURoj8boGD7evpBJDm+Ic
         QbBk+88dxc9mwiU2cqniD6N7/10O2JTTXRcKaSLFp4lBTRNTZ3bVmV4jQLZa04Y1gALF
         vNZ8ey9b+xGfv8ce6Y79oLxv6dd6QMMcaWs1yrilAKEzmukv5FRg9NKXyaWb50YugdjA
         X9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zC8Nl9G6/l5MMFOXorxDKy0jA9yGChzBjLvNeElBA7o=;
        b=jrwvS9u7r+D3WFNmm9KneE8OD2MmrzzjaApgLy5x2fqYLg7nXjWa0KZZyxUIu+MdXq
         o+Bg1CLJpTKED/xiOlYnp10lceBrcRpIhBnWA65s6NPO2XskkSTmdJkSMQdsakF7TBlk
         baPumOq2XUhu27UOnz07kYC6xTXVtCYyNwK52cHYr+X1Te3M4UE+FaGnbRGYhAu5iuql
         UN1H8Bf6rAxjI8wX+l/rSCqPhSLKW6lrBW//9C5GZ4Q/h7QSev/7Wst9HxO3tm7wY8vn
         hfCH8AQRjMPtddv5bnbA7uis3yKCt2N9D8ioWYkIyZiouSGj4A5Ry6uOWFc0+syZ1+pk
         7/eA==
X-Gm-Message-State: APjAAAUC2P/LWT2Iun965iRBtga2x8Hye7EMrb/Q6QLzzOc8VBc2p0ui
        exwTMC/XpCw2zHivzumAZwjzmQ==
X-Google-Smtp-Source: APXvYqzIDJtVV8x++xTwRnO0Zg/BI+kUfwuZlJ43GI5vWYALvikbhUlAxUHFS3lGu0q/jZzKGpvmIQ==
X-Received: by 2002:a50:8854:: with SMTP id c20mr36027528edc.167.1553965938416;
        Sat, 30 Mar 2019 10:12:18 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id f13sm1657765eda.38.2019.03.30.10.12.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 10:12:17 -0700 (PDT)
Date:   Sat, 30 Mar 2019 18:12:16 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190330171215.3yrfxwodstmgzmxy@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 10:04:33AM -0700, Linus Torvalds wrote:
> On Sat, Mar 30, 2019 at 9:34 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > Just to be clear, I'm not proposing granting secret access to procfs,
> > and as far as I can see, nobody else is either. We've been talking
> > about making it easier to avoid races when you happen to want a pidfd
> > and a procfs fd that point to the same process
> 
> So I thought that was the whole point of just opening /proc/<pid>.
> Exactly because that way you can then use openat() from there on.

To clarify, what the Android guys really wanted to be part of the api is
a way to get race-free access to metadata associated with a given pidfd.
And the idea was that *if and only if procfs is mounted* you could do:

int pidfd = pidfd_open(1234, 0);

int procfd = open("/proc", O_RDONLY | O_CLOEXEC);
int procpidfd = ioctl(pidfd, PIDFD_TO_PROCFD, procfd);

and then we internally verify that the struct pid that the pidfd is
refering to, is still the same as the one that /proc/<pid> is refering
to and only then do we return an fd for the process /proc/<pid>
directory which would then allow you to do, e.g.:

int statusfd = openat(procpidfd, "status", O_RDONLY | O_CLOEXEC);

this would provide race-free access to metadat but again, only if /proc
is mounted and available to the user. But if that's an instant NAK we
will definitely *not* do this.
