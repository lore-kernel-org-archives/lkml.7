Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfDXI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:58:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:58:35 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwjO6-1gZo3b2LAg-00y9M4; Wed, 24 Apr 2019 10:56:53 +0200
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>
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
 <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <1772079b-6e84-35e3-62b8-92034c29759d@metux.net>
Date:   Wed, 24 Apr 2019 10:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hhphKdCu6l4QGadGKMP/R057kudvf56R8RLX18gA8jTh+tj2jbC
 hz1sT+N3+3qjNoGVg8+Tqhe3Hi8gS82K8R6/nBqbXH8XszWHvNWOe32yjChh4KxKdt60/SU
 +dkLbq6E+dO9jGgqDiJnjNvqshZRnnIqh2d8Alqsf4FbhyJlClslMmBpQuMgyg5vaGYD3Qa
 nuS13tQOUk436rbYn4JGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJmd/FeBbGc=:V8JRDfOA3l+1I85jUGY9h5
 lxGRdPw4oPoIeXwwXMTV/bdV1xWPtoR1EKYcjgsmRKFVhbpT3/tHwZh4e2ypYeD33k4JCLf/d
 Gv/F6Q/AQ8KwyFTc1J7D3QPSPloLkcCK2dcOkcEiGCXN4+cVn/aqgo5ElgA9u4wxyRLuiWEz3
 QnG6eLN9STWXHuOAyFU6KtX0K3UpTmDSXnvnQPusA008DOolo8di9YwfGXIiJYfuG3WqfquQ9
 U3SPZ7Bzy1K6Z/D9qlJ8uaG2Jk9dFbMlHlra1pMELReA9aIWJuUfOePukfM3dO9bksKULt1zF
 T9eWTH9muX3S1/swRTOzzLiEYhlEkHVJG1YMUyo1y3JvNmhFB5wcBbGACCBW/xB1m1GkusK1s
 cBgoU9DPKbsVxxvJnGchqkBY8PmiJ/hd1yJbX+ApEoM/OFh4mUDUpfizH2jjkR59u4bhl0c1b
 LI1FKqQloqjcRNRk7WwIc2wgrNB972Vo2OStNdDwC1t5gcwUF7pwYkBVVGk51ibiwtVd+kYu3
 IAidf5OIyLpJbdXRm027Jj+gzu80sZ7ZMbIRIJy9RX1uwEM6OLDz378kq+bMXCsuuCCpW2Of/
 HZBRscZYAzgDaBjqbK/p1l2Ci6E96oqHxOTJe0LGp88/ghwPMZOw7RzwIVob5+0Rf3N7rxy5f
 Ce/8EvuP8ZoWFoDrqHTQGTwxgHEqJGkWC/ugxfeZRkx+5UzyxgdEF7NV4IJgvxU55jEmo5Her
 CTio0z2ylYExzvZb6+ktqutSFEiVQ+Bx/22hDEUqRcFDAnigIKhZdQCfEFo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 23:48, Christian Brauner wrote:

> So is Android and we're not designing an interface for Android but for
> all of userspace.
> I hope this is clear. Service managers are quite important and systemd
> is the largest one
> and they can make good use of this feature.

Maybe just talk about talking about service managers and not even
mentioning systemd ;-)

> That whole pargraph is about dismissing a range of valid use-cases based on
> assumptions such as "way more common" and
> even argues that service managers are special cases and therefore not
> really worth considering. I would like to be more open to other use cases.

ACK. Things like pidfd can make life for service managers a lot easier,
and even allow whole new scenarios.

For example, the monitoring part doesn't need to be the spawning
process  anymore. The spawner could send the pidfd to the monitor,
eg. via unix socket. If we had plan9-like srv filesystem (something
I've got on my todo list) we could even make the pidfd's available in
the fs and so replace the old pidfiles (pidfile now would be really a
process handle instead of just a scratchpad for writing down the pid).

>> Joel indicated that he believes poll(2)
>> shouldn't be supported on procfs pidfds. Is that your thinking as
>> well? If that's the case, then we're in a state where non-parents
> 
> Yes, it is.

Why so ?

IMHO, it would be much more useful, if another process can get the
same process handle via procfs. This also would allow the scenario
described above w/o srvfs: pidfiles could just be symlinks to the
corresponding /proc files.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
