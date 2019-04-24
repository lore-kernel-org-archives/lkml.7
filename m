Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9EA20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfDXJMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:12:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfDXJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:12:47 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBUuV-1hW71i1mxj-00D1fY; Wed, 24 Apr 2019 11:11:21 +0200
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
 <CAKOZuetiqFx0qW9rdCVWsKQxwaYK2Vis8EXsDba6=F5dp=da6Q@mail.gmail.com>
 <CAHrFyr6FntUgsCRw2b1B9+pjLQ2+pJMTULywRC1woNW4PvtyiQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c833c78b-445d-93d9-e59f-6bc62376c111@metux.net>
Date:   Wed, 24 Apr 2019 11:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHrFyr6FntUgsCRw2b1B9+pjLQ2+pJMTULywRC1woNW4PvtyiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rfuZyDhvwMC0qajKA4oSQUcfVF6fV7OpPupKGIp4h89kvao9eZD
 x6ggE5LdbabLPDRSmLlxAm1kkfFdsY+DCvCnm4b/0btnh9MbZzixc6+EULjathJ/rAsKIpg
 IdlRcxLtf7LpBhUI0NCAE5lJxQOvG0u9cLUFo7F6rBDmbbGqokOoLuw0hUGw+K6/4KXXmag
 4bBQtJCOoANQFjHxZ/oNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cnUjEJ4lKhg=:+ke/mXgvOEYG/qdQx+EOpN
 obEH/jlmTpYtecYRfWrmrCiqz6dO/rTUm3rSUxaf/UOWopdAyTY/YKECfr+KcaWTJNE2Ia9xs
 YFNOGzHl0fCzWt/4xs76e9VrXQvtFTrOc6WWXMgEZPKu5KJVFj9MMu7hP0lsRvIHjTmfUq951
 rNG0rrlzRZe2eIHu0Q8MwHj/KYpoDvA4zpBh3h8kywzfM2H7UAXi6Tl9yuP7NzLJyAJG3td21
 rgkW0vK8mHc5uO01gbxyZoAKUnlXOOGMQrmbbpKud0xBYSFFoOgT3W+KzoL7UVQMrGlI6OGvQ
 VAxmT2oIUYoDJ4/ra9Ft4CZjYQocrI6yPS7XNEab5JjHm3XjKQ9l8lSzQdF+a0vuyy+7BBN8T
 sOK2o+NhkN7LMzjGAC4w3i6luXsWf12uKXjlGj6/fGagdDCAsQTXYfUAUBkrgv2ET2ZT3xuaz
 mm+RWv0S/OX7JFPpUjWi4ZngQVMmwjBdq3YiyBPaR3r5iHJ37eJrvb6veipi9y9jljNl4QRdA
 azaWRtUwcgqNcjlZwhP4D3528NjChjtIStT9vE/j9IFE3ET8B4oCsV7fywpw13j8nOxNiRGsn
 T0LVC8Bcm7h3umSQTCY+VwTWIQNj4yeAs/GzmTnSiGxpjcUuO5sPNiynCegS793mHsdHFXQoY
 85fWHyxsUaMdXRykVlm9jE8JoyfJ/hYh3XdzymRfPZdaB6Djer+EoGaJa7p3ZP4sEj8H11OJJ
 EtX8x5VOtgBqJgU+k7hrW8Ql9O3aXFUhyFe0m8INm3SJo56VgCnuW8eU2Pc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.19 01:02, Christian Brauner wrote:

> I'm sorry, who has agreed that a non-parent should be able to wait for
> process death?
> I know you proposed that but has anyone ever substantially supported this?

I actually support this.

One practical usecase I have in mind for some upcoming projects is
monitoring processes in a container from the outside.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
