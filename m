Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B028C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7257208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfDXIV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:21:56 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfDXIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:21:55 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mrfgi-1gySmp38dw-00njUV; Wed, 24 Apr 2019 10:20:39 +0200
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f631a11b-bdaa-1b07-dda5-028bf9efbd58@metux.net>
Date:   Wed, 24 Apr 2019 10:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ptqTMZDJ2Wo4Z2LJdnpB5Xnw53Q8cG1mPDwdx+InPL0ztimpN0h
 WPDIO06x7zH1v67D/a+Z3+O1fpNuKYImG9t+45DZ+hQ84BKKnfLW6zPHDaQN4sNsQ4MjraR
 1+kJXJ1QAVh7EeuMVcAPzKfR3CMOR8wtFaN5wxmbd8/LIOKmBC8MLLCqfg6oGRno6C0Alk0
 MAPh+LRpuuQsp2wlyTHkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xbmelr0mM2c=:9/6O2j5BRgRt5Byrtxxb6B
 l3uiYZ9Gu0RgRcZB6Spvs8FgAsKZOE3CYZdL5RXwQH/n55rnw8fgVpOUcOxhh3/AsUMVQKFRX
 fGxUOJ8DAyg6zie7+3poiiOagRWaHlcTRipvq8P7U4QXdfo/LYMlmS5fXyOxJzHfUHUDlUVxN
 6o/GeyUN7veucJhZr/yTTMnExxQykWNpqS3devFz3iCZwmITgimeBbp1CdWq0eSWzI6b6QRGo
 aS3CQ8C9Vs+F7T/72Sq8M232ILKcf6pQZ4dU/6mfnsEuodfcbZNKARK24LhyCiozpn27Y6Rp2
 q4ttyU4WDwoul7ohBE/qOQb5YaQ9r5plHychSXPeH0mEbX7lITzfWwGSqx5lwIvjSQ1cByIAb
 pJXXzJ0Zwq1qE67yZ7ZiZfayfsClOrlmxadNOrB2/F2PdviNu/9a7SJ3Woe9dADEqu5BsrQ9Y
 52I+iYD16ZDZq+IdU15Z/YIvyU6Ci29M407IWuQxvx6QDLHwVtVQGP5ZGiy4brBJHtNMq3uFn
 Usw2pihLlh1OvIhOHCGOVbufqk96QO532WWugyaZ34VogWeRGbZOjm7OpN53RAHqBrzqCGijh
 cOg+tHw0Wq+kYOYww7gVtZT6sPWGDd7iWo7FiRs1SSC7DBR7ch4rKj1OqtsYl58Mj6lByV08o
 ZBniEvfFCb2pAqNemYwSRam/wtdsB9KbB0XsMXhbyKvIfOKlu+I7Y3zovQPu4hhTr+Q4q7T6K
 YeT2gjaiSjssDkPifG4PnNDC9EiO6NQ0OFjx8qAblivltMlXhPwmGIjULaI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 23:21, Daniel Colascione wrote:

>> EPOLLIN on a pidfd could very well mean that data can be read via
>> a read() on the pidfd *other* than the exit status. The read could e.g.
>> give you a lean struct that indicates the type of state transition: NOTIFY_EXIT,
>> NOTIFY_EXEC, etc.. This way we are not bound to a specific poll event indicating
>> a specific state.
>> Though there's a case to be made that EPOLLHUP could indicate process exit
>> and EPOLLIN a state change + read().
> 
> And do you imagine making read() destructive? Does that read() then
> reset the POLLIN state? You're essentially proposing that a pidfd
> provide an "event stream" interface, delivering notifications packets
> that indicate state changes like "process exited" or "process stopped"
> or "process execed". While this sort of interface is powerful and has
> some nice properties that tools like debuggers and daemon monitors
> might want to use, I think it's too complicated and error prone for
> the overwhelmingly common case of wanting to monitor process lifetime.

I don't think it's so complicated. read() + comparing a few bits
(eg. strncmp(), if the packets are strings) really isn't a big deal.

Actually, I proposed quite the same (before I read this mail).

> I like Linus' idea of just making waitid(2) (not waitpid(2), as I
> mistakenly mentioned earlier) on a pidfd act *exactly* like a
> waitid(2) on the corresponding process and making POLLIN just mean
> "waitid will succeed". It's a nice simple model that's easy to reason
> about and that makes it easy to port existing code to pidfds.

Okay, that's probably a good starting point. We could add more
sophisticated monitoring later.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
