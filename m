Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB38218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Sh1RN6Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfC2Xz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:55:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44692 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfC2Xz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:55:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so3412457edh.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nrq8BWIRn/YQVWfwi4OFVGnUNZFD63iddewfvjotgQI=;
        b=Sh1RN6Jxs1gFkA3SskG5lvwlPbMTGxkv/jl4a+JkL8A037+KAO3MMlRrP4fhseHpcg
         eOapaIdUcKWYSuGeo7Jzrm+H6Mvfr76qQ44+SdqyVV6fndYpFeU88/Mc2/Bzu3j6zxcg
         Z4qkPFz+BsfbeWiTVSf7Ytm7hkw0aOD+H2/mx8XMiEqXIYxrvI4vnxmGurKJtcdo+VLQ
         dCKbFRjUFxUVXeudZMWlxDokCU7vjaKzy2a7dCATniQsA2WwnK0A99iMwrJpACHJO6S4
         0/wuhqV9u/O+cBtG861+zA1de+AOtuHqbsJm49VTomDtKqRn8zQoWxHnNAPew/D83X+z
         JJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nrq8BWIRn/YQVWfwi4OFVGnUNZFD63iddewfvjotgQI=;
        b=Rl/kAokBB7KLHc8vjfXsDyqoHYzsdGzDVsP1l44fQFQ3n7rXLv+0GSJM11lBVC86rF
         SmPgbGTX5BA9W7Zw2o72/aKoqx+Pxpx905pXS/wM6c+oXVgwq9ADCCtBMvMpNaMsl5BB
         9wUyw+mGYpjQIDEagt1sR7gyKDmLt6hsI7am+e1PY2WVj2Y74bDW+k7tTvqLDNqOmP3N
         yjbKCue/ScK4WvVimBgA7RMDKZykBzKgKvX9lSlq8e8r3Zc2dM515fdJq/BDp6LR0Z02
         MbeHXG+/uT61BqjKrf4spHJDfdCDtO0xv5dlQrpBAr4JVce8LPb845/XAbRJZxZvuPNG
         J6YA==
X-Gm-Message-State: APjAAAUa/ae8UItNLsPrxv7JUlK19xSnEHDPlc0mSZALng2WknhRFbXz
        sB0+om7aohacVCDQ2eQt6HdvUQ==
X-Google-Smtp-Source: APXvYqzh1InaO8TIYwLkJnyVa22NMbp8jWJefLs0l6ulXEHHvzhXp4RjcBhcRLMHlsbTVFDel23otQ==
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr29351915eju.37.1553903724202;
        Fri, 29 Mar 2019 16:55:24 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id d8sm577242ejm.29.2019.03.29.16.55.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 29 Mar 2019 16:55:23 -0700 (PDT)
Date:   Sat, 30 Mar 2019 00:55:22 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v2 2/5] pid: add pidfd_open()
Message-ID: <20190329235521.wrtuyoualsvcgz5k@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <20190329155425.26059-3-christian@brauner.io>
 <CAG48ez0Arzdtjxj9zVVTaL=T6tX16e6OcR75rtk9mavCbnMK6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0Arzdtjxj9zVVTaL=T6tX16e6OcR75rtk9mavCbnMK6w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:45:46AM +0100, Jann Horn wrote:
> On Fri, Mar 29, 2019 at 4:54 PM Christian Brauner <christian@brauner.io> wrote:
> > /* Introduction */
> > This adds the pidfd_open() syscall.
> > pidfd_open() allows to retrieve file descriptors for a given pid. This
> > includes both file descriptors for processes and file descriptors for
> > threads.
> 
> Looks good to me, overall. Apart from a few nits below:
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks! Will fixup the nits and add your Reviewed-by!

> 
> [...]
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..8c9e15e0e463 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> [...]
> > +static struct file *pidfd_open_proc_pid(const struct file *procf, pid_t pid,
> > +                                       const struct pid *pidfd_pid)
> > +{
> > +       char name[12]; /* int to strlen + \0 but with */
> 
> nit: comment suddenly ends at "but with"?

Will fix.

> 
> [...]
> > +}
> > +
> > +static inline int pidfd_to_procfd(int procfd, struct file *pidfd_file)
> > +{
> > +       long fd;
> 
> nit: This should probably be an int?

Yes.

> 
> [...]
> > +       return fd;
> > +}
> [...]
> > +static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +       int procfd = arg;
> 
> nit: I think it'd be semantically cleaner to move this assignment into
> the switch case, but I don't feel about it strongly.

Agreed.

> 
> > +       switch (cmd) {
> > +       case PIDFD_GET_PROCFD:
> > +               return pidfd_to_procfd(procfd, file);
> > +       default:
> > +               return -ENOTTY;
> > +       }
> > +}
