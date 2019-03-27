Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6412C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7075E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NXnJj1uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfC0XAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:00:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38829 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0XAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:00:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id a6so12607567lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BM31IF77c9gqzxl7Vr32c/47A9H9iohQAMUtMi+Ltfo=;
        b=NXnJj1uP59H54pHJ9310Cxe9x0v46rPS2lh2+EFk79XlbHPPGkq8BqtXQFwqRJ3rI1
         tjeQ9fzGsRBZhHcst2NBtYKBwqyrcDkUBwnEJxP9MYT8Pt1E09s5u0huXPZVl+tPM070
         c0v+SlqLe/HBY2eXV30YqEBVE+C+bW02VT9iktg+ltmp+qXjOITyF+44R+pd2QUivLl3
         BKGdq7zUGFNaxqC+9rq9Il80DR+dqCiZl+MXTdOSmOu2hu3NucaqwuEq5QwJE7Td3ww1
         L4m33ZKJpJxv9MuoMe/3FgR0snS2EOcq/g/WnIibgnrC/aS0g7qoOVTjaH0L83uulqNn
         tuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BM31IF77c9gqzxl7Vr32c/47A9H9iohQAMUtMi+Ltfo=;
        b=jPryY2muti8ABtXtAbSPvQ+G34auDCu73jX3fTsh2LqVahTgtHohojlCqsjCYa8xQJ
         +BNGDvndfcgu69Nu/mvvRmae16PFrsLsRkrJdGecrMQeYP00HNbKKvTjVAQSlWR5ZTwN
         3urFIxd6G0j67fxIktno7bQnHvbWpQOxVCirx52eXVEetktgvK/UwknlGVpchJnhNKyb
         WNBaB9wvWfMHQoBtoQlp4qebR9Ocj7LzRQO3QgTMLeoD8dXCTerE9kTWzIZBjwAKa+1D
         X6RmVKUpZxg5laxcAst9Rj1GiCao1EHLQdujPWFfLonqOvxjL5fExZa5Lq/Fj/4zfa9S
         urCg==
X-Gm-Message-State: APjAAAX9D2VFmEGtmNDiQuF1DunHFuiW7n3m1vshtP0tMGvpQH1ZBugH
        i6SFuZJihDP+52tdFpAVxMVpPHlyacRMNrxMIiqm
X-Google-Smtp-Source: APXvYqxawVnONOmClAnOHxp0cKEaAWToMPhrmfINR6MtR6iAtVF+TNHnfMYnPNgThpaJXvw97ceyYcmplg/CH+oFolg=
X-Received: by 2002:a19:238f:: with SMTP id j137mr19864085lfj.79.1553727637640;
 Wed, 27 Mar 2019 16:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <CAHC9VhQavjf5M2wDU2jfFe3NpsxCd_mFjtrUC-0jujZFj2tTdg@mail.gmail.com>
In-Reply-To: <CAHC9VhQavjf5M2wDU2jfFe3NpsxCd_mFjtrUC-0jujZFj2tTdg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Mar 2019 19:00:26 -0400
Message-ID: <CAHC9VhRV-QuweDY5ovQD=UkfGhhj4LDACrHTbPTSYBUvSb8E_g@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect the
 system clock
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-audit@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:50 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 7, 2019 at 7:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This patchset implements auditing of (syscall-triggered) changes that
> > can modify or indirectly affect the system clock. Some of these
> > changes can already be detected by simply logging relevant syscalls,
> > but this has some disadvantages:
> >   a) It is usually not possible to find out from the syscall records
> >      the amount by which the time was shifted.
> >   b) Syscalls like adjtimex(2) or clock_adjtime(2) can be used also
> >      for read-only operations, which might flood the audit log with
> >      false positives. (Note that these patches don't solve this
> >      problem yet due to the limitations of current record filtering
> >      capabilities.)
> >
> > The main motivation is to provide better reliability of timestamps
> > on the system as mandated by the FPT_STM.1 security functional
> > requirement from Common Criteria. This requirement apparently demands
> > that it is possible to reconstruct from audit trail the old and new
> > values of the time when it is adjusted (see [1]).
> >
> > The current version of the patchset logs the following changes:
> >   - direct setting of system time to a given value
> >   - direct injection of timekeeping offset
> >   - adjustment of timekeeping's TAI offset
> >   - NTP value adjustments:
> >     - time_offset
> >     - time_freq
> >     - time_status
> >     - time_adjust
> >     - tick_usec
> >
> > Changes to the following NTP values are not logged, as they are not
> > important for security:
> >   - time_maxerror
> >   - time_esterror
> >   - time_constant
> >
> > Audit kernel GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10
> > Audit kernel RFE page: https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock
> >
> > Testing: Passed audit-testuite; functional tests TBD
> >
> > Changes in v6:
> >   - Reorganized the patches to group changes by record type, not
> >     kernel subsytem, as suggested in earlier discussions
> >   - Added checks to ignore no-change events (new value == old value)
> >   - Added TIME_INJOFFSET logging also to do_settimeofday64() to cover
> >     syscalls such as settimeofday(2), stime(2), clock_settime(2)
> >   - Created an RFE page on audit-kernel GitHub
> > TODO:
> >   - tests for audit-testsuite
> >
> > v5: https://www.redhat.com/archives/linux-audit/2018-August/msg00039.html
> > Changes in v5:
> >   - Dropped logging of some less important changes and update commit messages
> >   - No longer mark the patchset as RFC
> >
> > v4: https://www.redhat.com/archives/linux-audit/2018-August/msg00023.html
> > Changes in v4:
> >   - Squashed first two patches into one
> >   - Renamed ADJNTPVAL's "type" field to "op" to align with audit record
> >     conventions
> >   - Minor commit message editing
> >   - Cc timekeeping/NTP people for feedback
> >
> > v3: https://www.redhat.com/archives/linux-audit/2018-July/msg00001.html
> > Changes in v3:
> >   - Switched to separate records for each variable
> >   - Both old and new value is now reported for each change
> >   - Injecting offset is reported via a separate record (since this
> >     offset consists of two values and is added directly to the clock,
> >     i.e. it doesn't make sense to log old and new value)
> >   - Added example records produced by chronyd -q (see the commit message
> >     of the last patch)
> >
> > v2: https://www.redhat.com/archives/linux-audit/2018-June/msg00114.html
> > Changes in v2:
> >   - The audit_adjtime() function has been modified to only log those
> >     fields that contain values that are actually used, resulting in more
> >     compact records.
> >   - The audit_adjtime() call has been moved to do_adjtimex() in
> >     timekeeping.c
> >   - Added an additional patch (for review) that simplifies the detection
> >     if the syscall is read-only.
> >
> > v1: https://www.redhat.com/archives/linux-audit/2018-June/msg00095.html
> >
> > [1] https://www.niap-ccevs.org/MMO/PP/pp_ca_v2.1.pdf -- section 5.1,
> >     table 4
> >
> > Ondrej Mosnacek (2):
> >   timekeeping: Audit clock adjustments
> >   ntp: Audit NTP parameters adjustment
> >
> >  include/linux/audit.h      | 29 +++++++++++++++++++++++++++++
> >  include/uapi/linux/audit.h |  2 ++
> >  kernel/auditsc.c           | 15 +++++++++++++++
> >  kernel/time/ntp.c          | 38 ++++++++++++++++++++++++++++++--------
> >  kernel/time/timekeeping.c  |  6 ++++++
> >  5 files changed, 82 insertions(+), 8 deletions(-)
>
> These patches look fine to me, but it would be really nice to get an
> ACK from the time folks before I merge this into audit/next.  Time
> folks, I know you've looked at previous versions of this patchset, can
> you give this a quick look to make sure everything is still okay from
> your perspective?

Ondrej, please don't let the lack of response from the time folks keep
you from working on the tests.  If you can get the tests ready in
time, I see no reason why this couldn't get merged before the next
merge window.

-- 
paul moore
www.paul-moore.com
