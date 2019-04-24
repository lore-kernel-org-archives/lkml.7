Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3EE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfDXJFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:05:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDXJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:05:02 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBDWo-1hVq3z15Cw-00CgRI; Wed, 24 Apr 2019 11:03:45 +0200
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
 <CAHrFyr76KrgUwHz91fZbkvHD43KzVrcXndRKUJjG9-gT4ZFZuQ@mail.gmail.com>
 <CAKOZueu_ouL_u17UKNNkDaSuP-_m_=fE8nLZGb9YAjonF=zVHg@mail.gmail.com>
 <CAHrFyr6D=41qBJGfVncN2xFhnCBKqKOQakU_2kBMFw+fywO7Hw@mail.gmail.com>
 <CAKOZues-DSu=R7Oe_gsK7=wrm2PtEi5TdH6Z50igNF_B+Wvcdg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <11c00eba-f078-9a67-97e6-bd5a74f3acaa@metux.net>
Date:   Wed, 24 Apr 2019 11:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKOZues-DSu=R7Oe_gsK7=wrm2PtEi5TdH6Z50igNF_B+Wvcdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KC8hpxEUkKPdQ5bUC8dOti8jq7M1rTgdpgBOhcD4aTWX9/TIleV
 XVyUHKf7VLY23NikE3fVZpxZXZX0Hqf1aI3bAfdntsdA6fuCkKYfaicCHWf3YWbu47SJoFm
 CNjzCIXRSgGzW5hAf/wDzI7Hxtlfxe5V7Ak/3vcHixeqOmY7YFw7ucpn881rwP9eyMg0tuj
 9oI6kwbTbypsO/EgRbC7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m9/e0FynbXE=:5kp9gxBK/CMIeyCEkpGa1Y
 11ot8a/HRUWkhvmId1F9mHXleHg5pIv2UdL6GIFgSbqgEvCV5kBYVIPyTei3lea9kg9WYn3jy
 OBVs9Oh54E42oigFxQ/HrItOk3tPGxYcEDTOOlrGD4INswxlrSCEP/bRUiJsSxmUkAbaTbO5/
 rk11ycM8JI+w0+cnBgrJf6RxS/FmO/uwOwpmdwiu23gXQ7SgCPhGOxSJNOI2XJj6hjhX8nncJ
 kJvZ2Irk1sXLBcHVFYYuCPQMdJXTgBSG1qZCXQvZpdOV48y+RrAJlnmJenHTrXG0me0DmPOBA
 qZKQWZj1qyqc85FvIJ6mlbpeVME/AvYtD0SkSRcbKKZaiGN/AWIXAn8w7tQ/H2P4Ay8mUmZ10
 Pg3nUZjX3xk2vCbeOh+IAC10QyiAnfuJ0zOl0BqXtf4nef1uJy9g55I7DZ4uNH14wGAiU0Yhv
 AKhMXV61RHuUgx5XumPJbhozkddH9GLBmd0SBvUxqvSHn9EcIxREmkSs7ztxIhhIe5mJ7bMU9
 A+NsHzFWet2UuDluMOQfTHategchxBy+ZBnbJ23d3kmMVSyNcMi218kipFzpbsBpI3Ncc4Gf6
 B78G2RCOEHJL/L5LNqKldvCXn5xtiBKN456jteC2MIrEVYvdQQdhZvV35vwZGrHEC1oyzn3M/
 g2sUWXwjNbS15x7feCtQGVQxmuHhWYVFt7usz0W9J307rMxtxaQ+p4I1+A1udpI2VMiZt+Gvv
 kRSi46BOpRHolU5Ilv+DgfzqGzUvRsUCBZw0BzhBB2v7+JAapez2lbC1nYE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.19 01:46, Daniel Colascione wrote:

> If you turn pidfd into an event stream, reads have to be destructive.
> If reads are destructive, you can't share pidfds instances between
> multiple readers.

Can't we find a way to duplicate them ? Someting like dup(), but
with actually duplicating the open file ? (maybe add a flag for
that to dup3 ?)

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
