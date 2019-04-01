Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8F220830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CVmiFZ29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDATmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:42:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41095 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfDATmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:42:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so13571095wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QWYfihem4rvWezrn8ZcGvhzVI9rcxqdC2kQjbtFdTpU=;
        b=CVmiFZ2998XvJEF3ES0oHAc9cXiJAlPNcMDNDbJuughDJdMO2tn5sLHmRRHsyC4noz
         KDmAqiDQhqexsgl1RNlqZ37SRGQCRKezy9u78hBO/V8FlCdzwhtmAblopFlQfiIXSfuS
         2P3NGhWoJ3xPrfZjWG5Hqf+y6uElL3ode2W5RhRVDsqEDdX9WxTSNgT4J5VJcJpainle
         jyz/XqUAuccyKwj6QpkYN/U8RSrmcL///N3kpfpmasIRRpAJ8wh5umgSfZdu3M+QLoHx
         w+SkPEnVuHNier/oWh3t3hcWzMu75bZfTnB7Je58Cyl4Y1vHCXn5s2zteYronSj1oVE8
         yuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QWYfihem4rvWezrn8ZcGvhzVI9rcxqdC2kQjbtFdTpU=;
        b=qOnOpHS620mmihUpdJ4AqQGkv6pcs5Wp79xRCWL+zd8ORcXqAI4U53bu81yPrpscEn
         RQ9lDnEspgm5+1mkmMe0Z2GoeY+9kmOJammQVTSdB9DtDPQKTR3KPQ5zdN4verbfqxFQ
         qziErCAdnX3ln1RhgnqLEHIzaA8zWBnzQfXA+2bP9KV5BpDN+YDhy4bgoaokWilclVIB
         hFkIVQbX/PJqWh89tg4sbTmEvPBrPwVTIpgcjdDETdGFih3CDA2reCrmSc/HbmqYpB8z
         VvBhPYpsPdSX8ayasswXWQezO/FSBiiKekE7LuwHSdncDzp+Ptlu9ShTWKDJY72HqV79
         SdAg==
X-Gm-Message-State: APjAAAV4ad68aR5bF48EOLkft9Tqs8g6Hfff8XCL+WHaUucCMGGEBQcC
        pO3e3XkEzSjRZb3xDxOaoc0GeQ==
X-Google-Smtp-Source: APXvYqwDUzx+wjooqpeEpLBl7DxFu/RiJ8zO8BFLDbzsC285OsTs+25m3lDj2mVlarPd9o0s8WFVOA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr41912967wrh.283.1554147737367;
        Mon, 01 Apr 2019 12:42:17 -0700 (PDT)
Received: from brauner.io (p200300EA6F21DE7AB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f21:de7a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id 7sm40903939wrc.81.2019.04.01.12.42.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 12:42:16 -0700 (PDT)
Date:   Mon, 1 Apr 2019 21:42:15 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190401194214.4rbvmwogpke3cjcx@brauner.io>
References: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
 <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:01:29AM -0700, Linus Torvalds wrote:
> On Mon, Apr 1, 2019 at 8:55 AM Daniel Colascione <dancol@google.com> wrote:
> >
> >
> > > I wonder if we really want a fill procfs2, or maybe we could just make
> > > the pidfd readable (yes, it's a directory file descriptor, but we
> > > could allow reading).
> >
> > What would read(2) read?
> 
> We could make it read anything, but it would have to be something
> people agree is sufficient (and not so expensive to create that rare
> users of that data would find the overhead excessive).
> 
> Eg we could make it return the same thing that /proc/<pid>/status
> reads right now.
> 
> But it sounds like you need pretty much all of /proc/<pid>/xyz:

From what I gather from this thread we are still best of with using fds
to /proc/<pid> as pidfds. Linus, do you agree or have I misunderstood?
Yes, we can have an internal mount option to restrict access to various
parts of procfs from such pidfds or do the parent-less bind-mount trick
but I think this beats having a stunted dummy dirfd that we implement a
read method on.
One thing is that we also need something to disable access to the
"/proc/<pid>/net". One option could be to give the files in "net/" an
->open-handler which checks that our file->f_path.mnt is not one of our
special clone() mounts and if it is refuse the open.

To clarify the way forward:
Jann and I were discussing whether pidfd_open() still makes sense and
whether I shouldn't just jump straight to a first version of
CLONE_PIDFD.
Basically, if you have a system without CONFIG_PROC_FS it makes sense
that clone gives back an anon inode file descriptor as pidfds because
you can still signal threads in a race-free way. But it doesn't make a
lot of sense to have pidfd_open() in this scenario because you can't
really do anything with that pidfd apart from sending signals. And on a
system like that sending a signal is still racy. Since the process can
be recycled between learning the pid number and calling pidfd_open()
[1]. So it only makes sense to have _clone()_ give back anon_inode() fds
on a system without CONFIG_PROC_FS but it doesn't make sense for
pidfd_open() In other news, I think it makes more sense if I jump to the
implementation of CLONE_PIDFD instead of working on pidfd_open().

[1]: The only case - that seems rather far-fetched - where it makes
     sense is when the parent wants to create that pidfd and hand it to
     someone else.

Christian
