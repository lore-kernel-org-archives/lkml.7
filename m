Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD47C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FFE2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Fh3VrPLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfDSXUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:20:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36847 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDSXUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:20:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so5758494ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7g0h4+jmBLCOEULHVApei4eYBlgtsCYwxcMsgGBV+I=;
        b=Fh3VrPLWqsVMh4lZiUksE7Gfe4+PHzIpzxyzHM2jXid453jQY4l9fBdUmD756KbbRV
         /M8WWvdecIysntdbWTk3zMvporZkGiRp1LFZLv6iu1HGHDdJj98od7ynFTAvyTmNt20e
         sM2YKZOb4vfb/aECSYLhkgbdnShRzwYL8oq7P8wVbNtPnv+7fEtawlzzuu55Y47fpkgg
         3e9qyloqct6JXJirMWrYFxm03WFdZ4PrPKlKO9T34Pkj/2s3OxHckU/Jb6p8Oz0r7958
         g8r9iwCSsavrlwAAc1dBLxtHM7mexnKKjHIXb3h5b5gbBYS44s5FzxpUxlOxiguSl8NX
         pZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7g0h4+jmBLCOEULHVApei4eYBlgtsCYwxcMsgGBV+I=;
        b=ZbKHLMtdCiKeGreilsWYszQTqgdbkhUMs9azzAr5OYBEV7uXVOuWTRzzYwE5mW/lme
         WtDzG21zTe6sF0MF1TKbbFkexhDsa/6U3zQH1L1pwrL49MPyTsuGjgVkGiSp4BRsB636
         hVz9BRUkmSVB2Dt5bBao49BGQEaoErmZI5argbx0QdOpAZlhGsGvnHsMz72zpB3cVvki
         NibH29NIaviyxW2Z0VA4Ml8fzuaCph1kc4ua/FZ9ajehngOGUR2tLdb9A/vm6Xri6h+H
         ZimbsEXKtJ3cfiWHzAgdyORaiUxKXBFzltxtFS59lwF8JqYSRlyb9pRz/oNA/R+uya5+
         Dn4g==
X-Gm-Message-State: APjAAAXThBz5MIaGA04wSUD/bgQ5VX+Plm6iB9+kYLIOlWjcx2Qbcq3i
        aLIgzB31kVzS4NEOBTz/p+F9w0mA94SWbxy7HOcWTQ==
X-Google-Smtp-Source: APXvYqxPNUICR5EJ3YP6/Kwl3MOMXWI5ZN7+XTntawVvYbpwp9gyMaoHrm6JZe2RROK0+btJUeQNaTTR0LsGWuTeCXQ=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr3689144ljc.120.1555716012420;
 Fri, 19 Apr 2019 16:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com> <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Sat, 20 Apr 2019 01:20:01 +0200
Message-ID: <CAHrFyr6rA7w6H_N5bV_9EY26Jxza1TLp6=rLL7=grK6_tp6cHw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 1:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 19, 2019 at 2:20 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > According to Linus, POLLHUP usually indicates that something is readable:
>
> Note that if you use the legacy interfaces (ie "select()"), then even
> just a plain POLLHUP will always just show as "readable".
>
> So for a lot of applications, it won't even matter. Returning POLLHUP
> will mean it's readable whether POLLIN is set or not (and EPOLLERR
> will automatically mean that it's marked both readable and writable).
>
> In fact, I'd argue that not a lot of people care about the more
> esoteric bits at all. If your poll function does POLLIN and POLLOUT,
> it's fine. Anything else is specialized enough that most people simply
> won't care. Don't overdesign things too much. You need to have a major
> reason to care about the other POLL bits.
>
> It's also worth noting that POLLERR/POLLHUP/POLLNVAL cannot be masked
> for "poll()". Even if you only ask for POLLIN/POLLOUT, you will always
> get POLLERR/POLLHUP notification. That is again historical behavior,
> and it's kind of a "you can't poll a hung up fd". But it once again
> means that you should consider POLLHUP to be something *exceptional*
> and final, where no further or other state changes can happen or are
> relevant.

Which kind of makes sense for process exit. So the historical behavior
here is in our favor and having POLLIN | POLLHUP rather fitting.
It just seems right that POLLHUP indicates "there can be
no more state transitions".

Christian
