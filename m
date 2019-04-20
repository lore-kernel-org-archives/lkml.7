Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A20FC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440132183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wSdZMzhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDTArB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:47:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33073 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTArB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:47:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so3253280plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJeJCEsvjqX5rGVJW/HifUv3RwhSjNdHLvuBe2kGGfU=;
        b=wSdZMzhKAmXWG+c9nxI1Ty9OEoHWhIECkuhxH3mr4CfZGPhKu+43CIdbUmWjaHFNPN
         a4iDaM9ERZujhMePnXrwwGOTOIn+Iel8E4QAXJfWq2VqhCHHcQVA2EWiYAdUcfJugZxt
         iUzsd2EFp378t7EixJw76/OIwIrt3puPV7NuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJeJCEsvjqX5rGVJW/HifUv3RwhSjNdHLvuBe2kGGfU=;
        b=eGSZSymao2raCC8eXzIHOdakwXBcJt461J84Lddw6We7XT6BJWedYnO53h1T8AYc19
         hrv8gKDpYNtbSOJ8mC3xPiD7eTYgx/fH2eLOHRWRapSNY1mlSUwa1ACqtxTuoAa9T4TA
         xLGkiK13LLz0wBnWNZoPRe0Eg0KfK4ZHS41i08SH/tW6CTmMlelMmU9gId3RXMxg26m0
         o0NSZjDe4HV0v5N/8Ut1vjog2+ah5gdoJOaJXuZiiSMuS4ZBSY4OmkVzilAsiVrV5Uk+
         TXI8tfUAOoUU1JfYQuQ3ZqvaND9pyA3hKXbYWIULDRELgKb1YFrAyVTHu/ZAlGwaznOi
         9eVQ==
X-Gm-Message-State: APjAAAVjIvH6+5vPAIwsWwFLJ2V6dArh5fMlOBqUArSRdM7zaCq08Pul
        JA4fp+fbMhagJnYHGC5UuXiPNA==
X-Google-Smtp-Source: APXvYqxfATsHcB4e2dILvIrcj7CiKIpV6NhIpgkeRV7u+EE3NNbOror1y4PJCT6woCZacJ/MaSsKlg==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr6507760plb.181.1555721220670;
        Fri, 19 Apr 2019 17:47:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u4sm433524pgr.89.2019.04.19.17.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 17:46:59 -0700 (PDT)
Date:   Fri, 19 Apr 2019 20:46:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
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
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190420004658.GG251571@google.com>
References: <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com>
 <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:11:37PM -0700, Linus Torvalds wrote:
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
> 
> That may well work fine for pidfd when the task is gone, but it's
> really worth noting that any *normal* state should be about
> POLLIN/POLLOUT. People should not think that "POLLHUP sounds like the
> appropriate name", they should realize that POLLHUP is basically a
> terminal error condition, not a "input is available".
> 
> So just keep that in mind.

Got it, thanks a lot for the detailed explanation of the flags. So then I
feel I should not return POLLHUP or POLLERR because the task_struct getting
reaped is not an error condition. I will simplify the patch and repost it. It
seems that would be the best thing to do to serve the usecase. We just want
to know when the task exited and a reaped task also counts as one that
exited.

thanks,

 - Joel

