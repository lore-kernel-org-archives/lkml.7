Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0FF20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCHU0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHU0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:26:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 908287FDE5;
        Fri,  8 Mar 2019 20:26:04 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-21.phx2.redhat.com [10.3.112.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E27C0600CD;
        Fri,  8 Mar 2019 20:25:57 +0000 (UTC)
Date:   Fri, 8 Mar 2019 15:25:55 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect the
 system clock
Message-ID: <20190308202555.dj75sfdxxxnckygq@madcap2.tricolour.ca>
References: <20190307123254.348-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307123254.348-1-omosnace@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 08 Mar 2019 20:26:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-07 13:32, Ondrej Mosnacek wrote:
> This patchset implements auditing of (syscall-triggered) changes that
> can modify or indirectly affect the system clock. Some of these
> changes can already be detected by simply logging relevant syscalls,
> but this has some disadvantages:
>   a) It is usually not possible to find out from the syscall records
>      the amount by which the time was shifted.
>   b) Syscalls like adjtimex(2) or clock_adjtime(2) can be used also
>      for read-only operations, which might flood the audit log with
>      false positives. (Note that these patches don't solve this
>      problem yet due to the limitations of current record filtering
>      capabilities.)
> 
> The main motivation is to provide better reliability of timestamps
> on the system as mandated by the FPT_STM.1 security functional
> requirement from Common Criteria. This requirement apparently demands
> that it is possible to reconstruct from audit trail the old and new
> values of the time when it is adjusted (see [1]).
> 
> The current version of the patchset logs the following changes:
>   - direct setting of system time to a given value
>   - direct injection of timekeeping offset
>   - adjustment of timekeeping's TAI offset
>   - NTP value adjustments:
>     - time_offset
>     - time_freq
>     - time_status
>     - time_adjust
>     - tick_usec
> 
> Changes to the following NTP values are not logged, as they are not
> important for security:
>   - time_maxerror
>   - time_esterror
>   - time_constant
> 
> Audit kernel GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10
> Audit kernel RFE page: https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock
> 
> Testing: Passed audit-testuite; functional tests TBD

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

How do you plan to test this in the audit-testsuite?

> Changes in v6:
>   - Reorganized the patches to group changes by record type, not
>     kernel subsytem, as suggested in earlier discussions
>   - Added checks to ignore no-change events (new value == old value)
>   - Added TIME_INJOFFSET logging also to do_settimeofday64() to cover
>     syscalls such as settimeofday(2), stime(2), clock_settime(2)
>   - Created an RFE page on audit-kernel GitHub
> TODO:
>   - tests for audit-testsuite
> 
> v5: https://www.redhat.com/archives/linux-audit/2018-August/msg00039.html
> Changes in v5:
>   - Dropped logging of some less important changes and update commit messages
>   - No longer mark the patchset as RFC
> 
> v4: https://www.redhat.com/archives/linux-audit/2018-August/msg00023.html
> Changes in v4:
>   - Squashed first two patches into one
>   - Renamed ADJNTPVAL's "type" field to "op" to align with audit record
>     conventions
>   - Minor commit message editing
>   - Cc timekeeping/NTP people for feedback
> 
> v3: https://www.redhat.com/archives/linux-audit/2018-July/msg00001.html
> Changes in v3:
>   - Switched to separate records for each variable
>   - Both old and new value is now reported for each change
>   - Injecting offset is reported via a separate record (since this
>     offset consists of two values and is added directly to the clock,
>     i.e. it doesn't make sense to log old and new value)
>   - Added example records produced by chronyd -q (see the commit message
>     of the last patch)
> 
> v2: https://www.redhat.com/archives/linux-audit/2018-June/msg00114.html
> Changes in v2:
>   - The audit_adjtime() function has been modified to only log those
>     fields that contain values that are actually used, resulting in more
>     compact records.
>   - The audit_adjtime() call has been moved to do_adjtimex() in
>     timekeeping.c
>   - Added an additional patch (for review) that simplifies the detection
>     if the syscall is read-only.
> 
> v1: https://www.redhat.com/archives/linux-audit/2018-June/msg00095.html
> 
> [1] https://www.niap-ccevs.org/MMO/PP/pp_ca_v2.1.pdf -- section 5.1,
>     table 4
> 
> Ondrej Mosnacek (2):
>   timekeeping: Audit clock adjustments
>   ntp: Audit NTP parameters adjustment
> 
>  include/linux/audit.h      | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/audit.h |  2 ++
>  kernel/auditsc.c           | 15 +++++++++++++++
>  kernel/time/ntp.c          | 38 ++++++++++++++++++++++++++++++--------
>  kernel/time/timekeeping.c  |  6 ++++++
>  5 files changed, 82 insertions(+), 8 deletions(-)
> 
> -- 
> 2.20.1
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
