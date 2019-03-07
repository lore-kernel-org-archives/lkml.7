Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D48C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C639420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCGRir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:38:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGRiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:38:46 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKKER-1hN3e82Z7X-00Ljum; Thu, 07 Mar 2019 18:37:23 +0100
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the
 kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Pavel Machek <pavel@ucw.cz>, hpa@zytor.com,
        Daniel Colascione <dancol@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com>
 <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <742b4797-9954-fb54-cce8-47fcad750c69@metux.net>
 <20190307014802.GA193359@google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <226424d3-d29f-2a83-2d04-81ad4aab1be2@metux.net>
Date:   Thu, 7 Mar 2019 18:37:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190307014802.GA193359@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4ETAHTk3UP4TuYHqVVKcSHFKei7GUTdggkrl0NzVL7qOpavZ6zj
 R3QqVB+x2OnaykgLH+gyOVJtlB0pWy0HX3VekSafxXlbbd9OJ23pyV3o+wgInFddTEZnnVe
 fkYjRd5zWQAjtYjGoRAwt4YVK/8fqsSqKoNjKYanm6K9i0/0dYrtWMVTrCb8Jh/suWwqUcA
 jK0d/L5phzF4mN2Q6VLsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ahvefg0OvLo=:XEIDzNC39yIDS9QcsqrY+G
 d+NUU8gEUunHGQssYR7TJ5K/kw3WncyCcPOgx2P1z+MBllZejKOUHIMY04rv8Fa3gx24Qwr45
 z/kcfDd70UJbxPxpkyhsgK9ojBNdYR/lhwxh2+/gHeQzXwgNyY3T+52Hofj3hnseblCyy47Aj
 uBr1GxoPqXZux4cuJE50N8bQrJygcZRJsT0QssJO0JrZu3uYj89PX+GLw+EG7GBf8NyI2PuaE
 FZNLotSwfExnPWcUu0IU+WThVqIN5po43jRzPLavNA9X8NQ5FE5vMXr1k4MRkJS/3lGp9xJJ1
 R6mHEe0eKV4rJC0m1IujXQbzpj1DJ58b4dOMHdWSKtGPQ1SmurBLIVIXWtB9jXG4WQcOQAc7B
 Zf+6H8CNOZ+7WLBDRZspFAa1BZCO/qhI/AHSE/zCv9ealuOsYgGIVVvv54SDfQs3ZktKA1geJ
 xPJ5m84q5EKXsB6KuqgfuzqMIfvaY//XnPCOkIALejbLIUCbhWvZpwUYcuEsrPHs3x+03wJe+
 Oy1kKOiQx+Dn3n9sIhc+Z6oGNynopEFslEIEwFU1hjWuRO0lVurZX+gGimEIVMWP++xoGxduz
 y5BDX06ykwejsMSENzptbhjaICMevs4t/ZU3nZwheNg6XizWcWJoNrPSZQNQYPp7UNkHeJ2/F
 XKVGqn0xW8SXKdGHHN6pu41iTrjh80g4r40VzcYQJ9GzsARZ1JzSuWEGxFwTccSEG/DsrnBgg
 EqUwEo5VquPGdcBkaA+EknfOxnK2VidUMOjnzkJvnJpHPCxkfvKAU1eoMqw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 02:48, Joel Fernandes wrote:
>> I'm confused.
> 
> Take a look at this thread: https://lkml.org/lkml/2019/2/28/634

Okay, replying to that mail:

> > > There's no linux-headers

That's the first fundamental problem. Actually, there's not even any
decent package management at all (no, apk seriously doesn't count as
that, not if you're used to apt+frieds for over 20 years)

> I have already been down that road. In the Android ecosystem, the
> Android teams only provide a "userspace system image" which goes on
> the system partition of the flash (and a couple other images are also
> provided but system is the main one).

These Android teams should learn how GNU/Linux distros and package
management works for over 20 years. Really, this is pretty trivial.

For such kind of general purpose devices, where users can install
arbitrary applications, I'd never come to the strange idea of deploying
whole operating system and applications in one image. (most likely not
even initially in the factory)

> The system image cannot contain GPL source code.

Why exactly ? Beacuse Big Manitu said so ?

Don't these folks that GPL doesn't prohibit shipping binaries on
disk/flash images ?

> It is also not possible to put kernel headers for every kernel version
> on the system images that ship and is not practical.

Of course not. They should only be deployed when needed, for the
versions needed.

> Android boots on 1000s of forked kernels.

Next big fundamental problem. Why all these forks in the first place ?

I'm not talking about the small patch queue ontop of mainline (or maybe
Andoid kernel baseline) - that's something we do all the day in embedded
world (of course we try to mainline as much as we can).

But what I usually see from the Andoid vendors are pretty much full
forks (full of horrible hacks) that quickly aren't maintained anymore.

If I'd be the responsible manager @google, that'd be one of the very
first things I'd care for: mainline first. (and, of course, ban all
proprietary binary-only kernel modules).

> Now for kernel modules, there's another image called the "vendor
> image" which is flashed onto the vendor parition, this is where kernel
> modules go.

Okay, then why not just putting a tarball there ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
