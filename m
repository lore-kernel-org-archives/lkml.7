Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03964C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CD120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCKLsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:48:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34148 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCKLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:48:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id r19so133609otn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 04:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4Op3nXMYu7DUp/Bemmj1TQd/62FjfWVJ/UMTXhICbQ=;
        b=DUWMmRwV3BsBqt2XYvl9dcMZCMGbEit3QBG0d7zNN7jDSbOkbLuBhYiPIy9qMlM0nK
         wFChr+mJceSC5M92DSTm7UgzNmhMOIRXVuZ5kR/K/pYT0vXb7A2KNm4PfxCnaJrBw8zi
         7iXaYk2U9Uh9U2vEds5UtFrqA2LTXibMZSQqq7JKng8zfh4cT/M9obOoEJv7GTbXrrL8
         rpxzcgq3fT4Nhiq7nBR4N5hHhSiHep8V2gDo7GUlIpS0GYnjFJhurAexlQFBzJ4zGiL9
         5eGiOYxoeO9drircsGenaybBMkJboEBt6YXHCU4GTGZyO4x45XM2MUlVwNVBLm/5MQci
         g7jA==
X-Gm-Message-State: APjAAAXFaAVQJS0n+wdEMuE3D7k4RZyuN7UmSak8bwB1GceixJW/pcuK
        aLJ+Dsl05OeGev/V6RB4JFUoreAhXTXwBxYmeeAB4jVlEV0=
X-Google-Smtp-Source: APXvYqwRl1CiCt/4TFBDG2KuKdIdErn2glyHSHEgj6Ot7XFfbmKZIpdRpMASFSAs26KH4fheBz4FMBxVfsA/OURTqck=
X-Received: by 2002:a9d:4e10:: with SMTP id p16mr21395675otf.65.1552304895993;
 Mon, 11 Mar 2019 04:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <20190308202555.dj75sfdxxxnckygq@madcap2.tricolour.ca>
In-Reply-To: <20190308202555.dj75sfdxxxnckygq@madcap2.tricolour.ca>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 Mar 2019 12:48:05 +0100
Message-ID: <CAFqZXNv2nX-nRn6zr+HTdKe0SEsB-v1NT+=UM4StiEvr=3=quw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect the
 system clock
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-03-07 13:32, Ondrej Mosnacek wrote:
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
>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
>
> How do you plan to test this in the audit-testsuite?

My plan is to add a new subtest which will use a short C program that
calls the relevant syscalls (they are listed in patch 1/2) directly
and will check if they produce the expected records. I outlined some
specific things to be tested in the RFE page.

>
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
> >
> > --
> > 2.20.1
> >
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
