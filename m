Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80264C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5E22086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDAJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:21:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39366 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:21:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id n187so6639743oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 02:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uyNfkAkHQqRwhaktUs+npiLUxME7WYCExkfNYPzksQ=;
        b=p2THevKRTBd97KPR2i2wYcv2pbRaDYk5n2+ZEGViWlRLdtsNHw4RQQJFJ40z7Tx0z4
         Aj7+TZKo4IzKbgrYyqvXSwqo1LUzzz4TfqV9S2DZ/tJsvnrjxTXODzt4QINaD7aZYMLD
         P87tGgrDdV8HSE7B38ukkU6AePC5kf7AAP96QSke3j+5tRO53VAr7Lv51fqJjh2wnyaN
         FvlUQ3lyDirysQy6KTsHQ0quTvoxWTVW0b0CBo542EQu574JyRZRj2vWxuEKv+pp28Xy
         CJa0GlZ9cdCkuVKyHFdszHP2NqOm/VajlwSzqxU32CNpBdj++UEl8v1lU/czv59sXzKM
         F8jg==
X-Gm-Message-State: APjAAAWHQgXOjN3IV60qSL4B9u7lStpfIaZ4kwBKGTt/Lkuc2y5YeNBX
        Jkt6Ai0IDrmp9t3kJsP0idlZUEtU/7K3D4Jbr76qMgWSyLc=
X-Google-Smtp-Source: APXvYqz3WBZB4ZWlZEf5iyJtwq9QLKAS/8lgIJD8Vk8OUG5xs4sBz8Ga2ejjhD7G9oAYQsjTADdmR1UhfObLUNuoJGo=
X-Received: by 2002:aca:4507:: with SMTP id s7mr12148218oia.127.1554110488599;
 Mon, 01 Apr 2019 02:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <CAHC9VhQavjf5M2wDU2jfFe3NpsxCd_mFjtrUC-0jujZFj2tTdg@mail.gmail.com>
 <CAHC9VhRV-QuweDY5ovQD=UkfGhhj4LDACrHTbPTSYBUvSb8E_g@mail.gmail.com>
In-Reply-To: <CAHC9VhRV-QuweDY5ovQD=UkfGhhj4LDACrHTbPTSYBUvSb8E_g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Apr 2019 11:21:17 +0200
Message-ID: <CAFqZXNuMzTFicsDhUSrKwbdGBNAf9NorCoCkM5fFK_LH9X1-Lw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect the
 system clock
To:     Paul Moore <paul@paul-moore.com>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:00 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 25, 2019 at 10:50 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Mar 7, 2019 at 7:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This patchset implements auditing of (syscall-triggered) changes that
> > > can modify or indirectly affect the system clock. Some of these
> > > changes can already be detected by simply logging relevant syscalls,
> > > but this has some disadvantages:
> > >   a) It is usually not possible to find out from the syscall records
> > >      the amount by which the time was shifted.
> > >   b) Syscalls like adjtimex(2) or clock_adjtime(2) can be used also
> > >      for read-only operations, which might flood the audit log with
> > >      false positives. (Note that these patches don't solve this
> > >      problem yet due to the limitations of current record filtering
> > >      capabilities.)
> > >
> > > The main motivation is to provide better reliability of timestamps
> > > on the system as mandated by the FPT_STM.1 security functional
> > > requirement from Common Criteria. This requirement apparently demands
> > > that it is possible to reconstruct from audit trail the old and new
> > > values of the time when it is adjusted (see [1]).
> > >
> > > The current version of the patchset logs the following changes:
> > >   - direct setting of system time to a given value
> > >   - direct injection of timekeeping offset
> > >   - adjustment of timekeeping's TAI offset
> > >   - NTP value adjustments:
> > >     - time_offset
> > >     - time_freq
> > >     - time_status
> > >     - time_adjust
> > >     - tick_usec
> > >
> > > Changes to the following NTP values are not logged, as they are not
> > > important for security:
> > >   - time_maxerror
> > >   - time_esterror
> > >   - time_constant
> > >
> > > Audit kernel GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10
> > > Audit kernel RFE page: https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock
> > >
> > > Testing: Passed audit-testuite; functional tests TBD
> > >
> > > Changes in v6:
> > >   - Reorganized the patches to group changes by record type, not
> > >     kernel subsytem, as suggested in earlier discussions
> > >   - Added checks to ignore no-change events (new value == old value)
> > >   - Added TIME_INJOFFSET logging also to do_settimeofday64() to cover
> > >     syscalls such as settimeofday(2), stime(2), clock_settime(2)
> > >   - Created an RFE page on audit-kernel GitHub
> > > TODO:
> > >   - tests for audit-testsuite
> > >
> > > v5: https://www.redhat.com/archives/linux-audit/2018-August/msg00039.html
> > > Changes in v5:
> > >   - Dropped logging of some less important changes and update commit messages
> > >   - No longer mark the patchset as RFC
> > >
> > > v4: https://www.redhat.com/archives/linux-audit/2018-August/msg00023.html
> > > Changes in v4:
> > >   - Squashed first two patches into one
> > >   - Renamed ADJNTPVAL's "type" field to "op" to align with audit record
> > >     conventions
> > >   - Minor commit message editing
> > >   - Cc timekeeping/NTP people for feedback
> > >
> > > v3: https://www.redhat.com/archives/linux-audit/2018-July/msg00001.html
> > > Changes in v3:
> > >   - Switched to separate records for each variable
> > >   - Both old and new value is now reported for each change
> > >   - Injecting offset is reported via a separate record (since this
> > >     offset consists of two values and is added directly to the clock,
> > >     i.e. it doesn't make sense to log old and new value)
> > >   - Added example records produced by chronyd -q (see the commit message
> > >     of the last patch)
> > >
> > > v2: https://www.redhat.com/archives/linux-audit/2018-June/msg00114.html
> > > Changes in v2:
> > >   - The audit_adjtime() function has been modified to only log those
> > >     fields that contain values that are actually used, resulting in more
> > >     compact records.
> > >   - The audit_adjtime() call has been moved to do_adjtimex() in
> > >     timekeeping.c
> > >   - Added an additional patch (for review) that simplifies the detection
> > >     if the syscall is read-only.
> > >
> > > v1: https://www.redhat.com/archives/linux-audit/2018-June/msg00095.html
> > >
> > > [1] https://www.niap-ccevs.org/MMO/PP/pp_ca_v2.1.pdf -- section 5.1,
> > >     table 4
> > >
> > > Ondrej Mosnacek (2):
> > >   timekeeping: Audit clock adjustments
> > >   ntp: Audit NTP parameters adjustment
> > >
> > >  include/linux/audit.h      | 29 +++++++++++++++++++++++++++++
> > >  include/uapi/linux/audit.h |  2 ++
> > >  kernel/auditsc.c           | 15 +++++++++++++++
> > >  kernel/time/ntp.c          | 38 ++++++++++++++++++++++++++++++--------
> > >  kernel/time/timekeeping.c  |  6 ++++++
> > >  5 files changed, 82 insertions(+), 8 deletions(-)
> >
> > These patches look fine to me, but it would be really nice to get an
> > ACK from the time folks before I merge this into audit/next.  Time
> > folks, I know you've looked at previous versions of this patchset, can
> > you give this a quick look to make sure everything is still okay from
> > your perspective?
>
> Ondrej, please don't let the lack of response from the time folks keep
> you from working on the tests.  If you can get the tests ready in
> time, I see no reason why this couldn't get merged before the next
> merge window.

Sure, I already have them about 50% done. I hope to have them finished
sometime this week.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
