Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D092068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKUVA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:00:56 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:48534 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:00:55 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iXtZL-0002sS-Rv; Thu, 21 Nov 2019 14:00:51 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iXtZE-0008Ey-Gy; Thu, 21 Nov 2019 14:00:51 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <0000000000006e31980579315914@google.com>
        <000000000000a6993c0597cc8375@google.com>
        <CALCETrVfWHPHiOmyJ9iDJDiCD3idPA4BdeM=4FUEO-uuxM07_g@mail.gmail.com>
        <CACT4Y+YVfyb6VSiFALAJT-O0GAxsVRY0XafAyx1NM+bkGw9vCQ@mail.gmail.com>
Date:   Thu, 21 Nov 2019 15:00:13 -0600
In-Reply-To: <CACT4Y+YVfyb6VSiFALAJT-O0GAxsVRY0XafAyx1NM+bkGw9vCQ@mail.gmail.com>
        (Dmitry Vyukov's message of "Thu, 21 Nov 2019 21:13:12 +0100")
Message-ID: <87v9rd0wte.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iXtZE-0008Ey-Gy;;;mid=<87v9rd0wte.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/jXqjH+WgpIi9WaXPa/NIDOfo5vaWQXM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: INFO: task hung in __do_page_fault (2)
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Thu, Nov 21, 2019 at 7:01 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On Wed, Nov 20, 2019 at 11:52 AM syzbot
>> <syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com> wrote:
>> >
>> > syzbot has bisected this bug to:
>> >
>> > commit 0161028b7c8aebef64194d3d73e43bc3b53b5c66
>> > Author: Andy Lutomirski <luto@kernel.org>
>> > Date:   Mon May 9 22:48:51 2016 +0000
>> >
>> >      perf/core: Change the default paranoia level to 2
>> >
>> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15910e86e00000
>> > start commit:   18d0eae3 Merge tag 'char-misc-4.20-rc1' of git://git.kerne..
>> > git tree:       upstream
>> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=17910e86e00000
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=13910e86e00000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=342f43de913c81b9
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=6b074f741adbd93d2df5
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12482713400000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158fd4a3400000
>> >
>> > Reported-by: syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com
>> > Fixes: 0161028b7c8a ("perf/core: Change the default paranoia level to 2")
>> >
>> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>
>> Hi syzbot-
>>
>> I'm not quite sure how to tell you this in syzbotese, but I'm pretty
>> sure you've bisected this wrong.  The blamed patch makes no sense.
>
>
> Hi Andy,
>
> Three is no way to tell syzbot about this, it does not have any way to
> use this information.
> You can tell this to other recipients, though, and for the record on
> the bug report email thread. For this you can use any free form.
>
> But what makes you think this is wrong?
> From everything I see this looks like amazingly precise bisection.
> The reproducer contains perf_event_open which seems to cause the hang
> (there is a number of reports where perf_event_open hangs kernel dead
> IIRC) _and_ it contains setresuid. Which makes good match for
> "perf/core: Change the default paranoia level to 2" (for unpriv
> users).
> The bisection log also looks perfectly correct to me: no unrelated
> kernel bugs were hit along the way; the crash was always reproduced
> 100% reliably in all 10 runs; nothing else suspicious.
> I can totally imagine that your patch unmasked some latent bug, but
> it's not 100% obvious to me and in either case syzbot did the job as
> well as a robot could possibly do.

All Andy's patch did was change the default value of
sysctl_perf_event_paranoid.  Which a quick skim of the code can only
cause perf_event_open to fail.

So if perf is running as non-root aka unprivileged it might have
been affected.

That said the most likely effect that would cause a hang is for perf to
not be started and therefore it's NMI's did not happen and so something
else was free to hang.

The other possibility is something in perf_event_open goes haywire
when it attempts to start and gets permission denied.  That seems
unlikely.  Assuming that was the case Andy's change did not
touch any of the perf_event_open code.  So at most it is highlighting
a path that was broken in earlier kernels and Andy's change to
the default caused the syzbot code to take a path that was broken
much earlier.


The common sense operation to perform at this point is to realize
that the setting of sysctl_perf_event_open matters to the test and
to modify the test to set sysctl_perf_event_open before it does
more things, and then syzbot or it's keepers can track down a likely
cause for the hang.


Certainly pointing at Andy's patch gives no one any real information of
why the kernel was hanging.  It is literally changing an default value
of 1 to a default value of 2.

Eric


