Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B78EC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463E220656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfDXJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:18:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfDXJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:18:49 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8n8I-1ghTNx1D7O-015neJ; Wed, 24 Apr 2019 11:17:19 +0200
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
 <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com>
 <CAKOZuetiqFx0qW9rdCVWsKQxwaYK2Vis8EXsDba6=F5dp=da6Q@mail.gmail.com>
 <CAHrFyr6FntUgsCRw2b1B9+pjLQ2+pJMTULywRC1woNW4PvtyiQ@mail.gmail.com>
 <CAKOZuesw9JK6DLhFTxN74rH5PDqGn7qbCQT4aaP1qtahSoRZ8w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <322efe1d-4acd-8ca5-1a76-51b90819ef44@metux.net>
Date:   Wed, 24 Apr 2019 11:17:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuesw9JK6DLhFTxN74rH5PDqGn7qbCQT4aaP1qtahSoRZ8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ye7t1S/OG+TUT+i7U72x78anEJ9gMND+G3YFGNWW3yG+tukUjfe
 zaqzSDWxPdAyCL7N6iwGOfxYopumuQKyuT7Ch3x93EIQA9iGjLUQQyw5eQQkZl8Tiv5vB5n
 32X0ccnQu1PqJpplku1jAmFF8omC2T2CDRBsDr8vWhIXRNI1AfKeEvVCRV5vuDpoUxC66g1
 tH8t/47ScCyQ1uRpTpXHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kL3mUu5jf70=:JQDcJBa9YIqvC5dRDBul0B
 pSTrWp2GbCdti8fcDy7hdhjH1zHOSdkpy0otxoKPMff7TBTcvw42sy7O+DYUfLmSRTUdrpbDM
 o4FQiIgEI0+VsP6Oyvjw7WJi3O69Xy0pWOaZD+rKY3x7Ev5wAWwXFe5B89zdaRlpYt4KGmmEY
 j/b8jqK5SqryAKxYTMcqUREQOKJKlvh4uk/0Wmf0KtBizKJ72iP0yvyzRVhAgNKan7FBvFMnu
 FHeml73hEkHynb94ywggGoL+Rhb2id3z52wsv/ygZf1FWIH8YHDQ7xxgKeoycUl8pnAEyEqg+
 qZXOa1LfjIrelm+Pd/FEl7Dnn5KKKfN8etYuHJXHwVRUfENvwJUhe2oz2VODSezrEKnrnHrTP
 orgoR9wbhONVV54qvIRazArdO7AahbaTJYDrSdR5HFQP1dc+nfVuz8MHNHgZd/h1d0MaF7COg
 O7mTCa5u2E8NVegmdgBOKXsqYs8gpvY8hibRaYEqt6WyvgFggASHam6E5foSsZusjjsUMMI2V
 tuJ9BeYqWT82ITKjr2xpTEeH55h/ks8AkSYK+zg6Zgm++g/s2hDUanPtQfoj4guAoGCkRJ1yY
 N7ZKEyCMF8T1OaiDPnHcNCJ5CS4kTfPjHXTHPH2xu3OEr/C9cHsHmNcy5yfs1xl5UoVGOCPFX
 WeVxU+hRT9/1JW2Cxq7Ee6W2l46YR/gR0aYWjp9biJ1UrYdslpCwPgQhSbqmPidJvfhVONhKq
 bOh8h0xY22v++CIX4468xpRZPY3JFElgZqzq9U1cuUSxDiW0wYXlagp7RCCawm6zQmnJ/u5Jm
 fMolAM3nRoc2elTJPIexK4O/ZFd+AnCYRapeuDJh8ZADL1k7No+sJeAo2AOuB1WIS4jRlfmMo
 56IA4lh6NPBRbHqZRcaS51yKmBiRkJciXkwBbw+2VNa7FNTg0HopjGXqmi1HZztcKfblDg92C
 pk9eZjt//HbSD/1+1W0keuZV+B0wvJeQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.19 01:29, Daniel Colascione wrote:

> The point I'm making, to be> very clear, is *NOT* that process monitoring is "not worth>
considering", but that process monitoring is subtle and complicated>
enough that it ought to be considered as a standalone project,>
independent of pidfds proper and of the very simple and effective> pidfd
system that Joel has proposed in his patch series.

At that point I'm wondering: what pidfd is actually meant for,
if not process monitoring ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
