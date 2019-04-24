Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3579CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B99E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfDXJGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:06:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51165 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDXJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:06:47 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MuDPh-1gWD9r3Otp-00uZbx; Wed, 24 Apr 2019 11:05:30 +0200
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
 <20190416192051.GA184889@google.com> <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
 <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com>
 <CAHrFyr76KrgUwHz91fZbkvHD43KzVrcXndRKUJjG9-gT4ZFZuQ@mail.gmail.com>
 <CAKOZueu_ouL_u17UKNNkDaSuP-_m_=fE8nLZGb9YAjonF=zVHg@mail.gmail.com>
 <CAHrFyr6D=41qBJGfVncN2xFhnCBKqKOQakU_2kBMFw+fywO7Hw@mail.gmail.com>
 <CAKOZues-DSu=R7Oe_gsK7=wrm2PtEi5TdH6Z50igNF_B+Wvcdg@mail.gmail.com>
 <CAHrFyr4akTbvZ_LDSwAsdjTCDhdi+KLY1zjZAduc1xuNawPWig@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <92f374d0-7cc0-9cc4-80fe-f7efa39e0435@metux.net>
Date:   Wed, 24 Apr 2019 11:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHrFyr4akTbvZ_LDSwAsdjTCDhdi+KLY1zjZAduc1xuNawPWig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:euoOHJXX/V5IggltLZ7jte7/XtsCQpJ0F/kvPgX030lkWhdJfrM
 YPp97HW90zVNl7aP0nSOTYHAL8JqkRr9bMm3VgX+3HzwtiRICIEwRn728ECL57PPsA5TgBj
 dYaGYxk/CXycJID8ypF57znsT/S7guh70lXwwDECDXnzQr83JD5G791unt6uid5Emvs5QdJ
 qIG6Ym9xhpF5KEu27Sdug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vIbAPu2Bz6E=:QCht0ggwEHRxXBkM72n8Pb
 ySG7mmMG4RHOm/yYwWNJ5nPGcd1MWDnY2xGsdmH4oAY/QsbDoOA0ae4BQ6xzv4ZEdu8B4LmBO
 ffRoA4CbyQ4gUTN44NVYoLF/yxDvKqfgDhMHA9yQ1PstiFHGxzuGkHTI71LR0ZDLe3GI58fjK
 /+kEjKi1IEUd/cL5TqO2xIfPYxhC4R0t1BvDzHO1W2dEoS1NH81+ZMIZPC0aRsavamtBUfatZ
 yUQFMQxOyl/z8vLOcYPcxG+VYLbNyUzdyo5z4AeCa3izYuBKA1NBHBypz/z5lem2TLeDe3FKb
 X3meGhpyFh51RbznGhYXfi0amzcABO+kCHDzl4vs0T/bFxVlC9QuYheyidSU2HKfwlZe1uMfU
 1d3qbGvysQifh3+i788y9MRj2P7FKEwOwOh1IkGH2CwSPNsIFe8kPgyrxKb14IfsAvLCAZT6W
 yzJ1huH5tOLmA5ASTkvbeW0nXZuVfKsjlFP9FpCBClBLb57GXXvM8uLEm25bbhEWcNBDAt1SK
 XZ51uVhahgBi88UwEcRNIbKpqALwRPl/2wkRToqFLt7erbBujvMbRUpHOPyjYGpiWZEXdG6UT
 2s/XqM1aErNYEj/MA2c5tUkSjAaSgKEV1I6jEYYcSnbVH6UZAwbQvfs0g4/2r1oGjhlZkAOvw
 WfE5ypSjkBNn5frKLcBs6kCWg64RHWJuIRmIK7+keepaVIxmvRfyYwoURWTgi9BwyKr4tvt5t
 /997Tlcv7Ot7B7kUeGX2R64i+CQdfaqrgg2IzUsUNvLAelkOl6Jc/mELFPg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.19 02:17, Christian Brauner wrote:

> It's not off the table that we can add a pidfd_open() if that becomes> a real thing.
What are the exact semantics of pidfd_open() ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
