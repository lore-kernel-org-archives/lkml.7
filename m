Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A170C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B946218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfDXIGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:06:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbfDXIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:06:19 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MV6G6-1hCARK2U46-00S4C7; Wed, 24 Apr 2019 10:04:32 +0200
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
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
References: <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com> <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com>
 <CAKOZuetkF4zPm-oKMjnoJtvUi4iTnY-ORzPd-JpfpseMXY4yhw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <34c493c3-993f-39f1-3afc-7f59d5113a30@metux.net>
Date:   Wed, 24 Apr 2019 10:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuetkF4zPm-oKMjnoJtvUi4iTnY-ORzPd-JpfpseMXY4yhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jHk41HQrf7eFSMcKEW+gYQHxdGt0dojWSCn9QycWmgOukdN9B/+
 UXIlQ2ddjTGxLLKg6cMjiuWG1wW+6RAVoice/8n0FOMODPfKIApg9lZDFbeY8hzlRwERYHC
 icwzfoPmd4W4o+asNiLBZzRknwKIagmAMuYnVu4iznkgl/d5yqcW82DXdTMfRv6UCbESYf1
 8jGlZGWAbQB5yQI8Yd2hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9TI3qhE1U9A=:Hn4c2h+O6WIDupvtLoKx45
 +DT77Bz0ob2JWX32qoNDM6oTwe13ksWarqnCWD7cvlipGwGUafYFXkF17hvMaQVR/XkKDTQhE
 TXL/X7BnUfgaasS76rBoooqJPnc8qnZClWb6P6uLoDddz10EKTaCIVIoYYtR1/7RUnpVw1geG
 MIgDMb02I1LGm8ok1e+aOIV0If4rPX/p10KZmzIY0Zf8unNJ9a/XIsPvqfunmscNLBp68vkO1
 1iU1/b73jxqAwzJ+fueft8/eBQgMV+9X0f5dyiziHoYW/qj8AcfhoyToOSGR79e2LMFjYxD3J
 qEi6TVbojffiWaa2Tx11cpgbamXTLpnkjJSbrR3xsV4Vvjqi1feWclLHCdEDqQTfltEZHOtUE
 o70kwhTzCME9h+qDrT71fuVLYrPX+1FOWG1M04Hf6i9aaR+Y9aVtAs4OkT467IFdn6vFWbUpk
 zVOgbwqCPNzWK4kmmapcGVa1pF5Q2K34BqYiBiC1QO4DSQ7MeraPoEm4VpIezyjXrLtFC/xZG
 YxqxQ6NvNnWkAxIJ7duHb4JvyBEyt/JfzAtGxorWO7fJVGukt38iaXr5B5PeIGT9bBEVkXZlH
 gFb0Lak3xo+hRl9B8cN+FlZtuZkZW59AoR8KLS0cwusHQV24GYU8ZKOTnZBXJ/2bp5+tdXGN6
 ZuyxdeeaqpW29pfGGlTyOzq5dEeOwplxEE3/FX4fqu/AACIIn3jHWqRuCcDfRRx8F1g7QgvVD
 mWRaKck/Kb4OGQHvj5vOCY4txsbM7SyKEcQthJNTXGa7AnIi5yhJkKsxxt4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 23:24, Daniel Colascione wrote:

Hi folks,

<big_snip>

I haven't followed the whole thread, so forgive me if I'm going to
write something dumb here ... but: this all feels a bit complicated
to me.

Why not just making the pidfd present a stream of events (which are
encoded as text lines) ? It would behave just like any stream, eg.
socket, chardev, ...

An `cat` on a pidfd could look like this:

<timestamp> EXIT <exitcode>
<timestamp> EXEC <cmdline>
<timestamp> SIGNAL <sigid>
...

IOW: just using POLLIN. Let the listener just read all events and
decide which ones he's actually acting on.

In the other direction we could write in commands, eg. for sending
signals.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
