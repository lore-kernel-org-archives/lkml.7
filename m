Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3330420835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCGMdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:33:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39789 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:33:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so9063466wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jaHZuHsZx3kSV8nyrEn89E5y39IWLwRofSTEoX/RSfo=;
        b=FFBqw43RmhBcOBjwikcGqMx5eLg9sA/UxrwZP6cqDZRhxCQJ4iys0qFTYxXVr7y2gp
         CAe1LQkcV56QNGNf9j7YUDpkQTPLdVHiAYR3ME6OuDMBHpKoe9hQMRVAZSsSmkYglPfD
         vnPUzABsA+uu5VBaMbUBHfr4YZp49p8UZM18mNCS5YvOfgvtS37r901i5NFAjkQg6AQW
         yU377LaZJCLqcb4dhvRvRHwWvS246KGDjjxExOSMS3OHU5IM2PcmeOI+fY1ja66D6Xr5
         CwCHUhLTSiKGx96u0ScM06fTaS0bV8iDivocy8uJsLO4XGIoofGN0q779YZMNomCRAjn
         oCzQ==
X-Gm-Message-State: APjAAAXdPqLfo+IBRb2yGupq3PKN7L2frKwzZmnEgnHYsKVTPF/5HYU/
        UYcsS9Us+riE0ei71HHxxHhUNIP5Ulg=
X-Google-Smtp-Source: APXvYqzhA2Vxu117WosBmdIz1E2dMFgjuj5DoUdfgH9TwVme9gFkuEre4ve0S0YHt82c0a9OWVs7UA==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr5310060wmf.28.1551961986672;
        Thu, 07 Mar 2019 04:33:06 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f68sm10063507wmg.5.2019.03.07.04.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 04:33:05 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect the system clock
Date:   Thu,  7 Mar 2019 13:32:52 +0100
Message-Id: <20190307123254.348-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements auditing of (syscall-triggered) changes that
can modify or indirectly affect the system clock. Some of these
changes can already be detected by simply logging relevant syscalls,
but this has some disadvantages:
  a) It is usually not possible to find out from the syscall records
     the amount by which the time was shifted.
  b) Syscalls like adjtimex(2) or clock_adjtime(2) can be used also
     for read-only operations, which might flood the audit log with
     false positives. (Note that these patches don't solve this
     problem yet due to the limitations of current record filtering
     capabilities.)

The main motivation is to provide better reliability of timestamps
on the system as mandated by the FPT_STM.1 security functional
requirement from Common Criteria. This requirement apparently demands
that it is possible to reconstruct from audit trail the old and new
values of the time when it is adjusted (see [1]).

The current version of the patchset logs the following changes:
  - direct setting of system time to a given value
  - direct injection of timekeeping offset
  - adjustment of timekeeping's TAI offset
  - NTP value adjustments:
    - time_offset
    - time_freq
    - time_status
    - time_adjust
    - tick_usec

Changes to the following NTP values are not logged, as they are not
important for security:
  - time_maxerror
  - time_esterror
  - time_constant

Audit kernel GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10
Audit kernel RFE page: https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock

Testing: Passed audit-testuite; functional tests TBD

Changes in v6:
  - Reorganized the patches to group changes by record type, not
    kernel subsytem, as suggested in earlier discussions
  - Added checks to ignore no-change events (new value == old value)
  - Added TIME_INJOFFSET logging also to do_settimeofday64() to cover
    syscalls such as settimeofday(2), stime(2), clock_settime(2)
  - Created an RFE page on audit-kernel GitHub
TODO:
  - tests for audit-testsuite

v5: https://www.redhat.com/archives/linux-audit/2018-August/msg00039.html
Changes in v5:
  - Dropped logging of some less important changes and update commit messages
  - No longer mark the patchset as RFC

v4: https://www.redhat.com/archives/linux-audit/2018-August/msg00023.html
Changes in v4:
  - Squashed first two patches into one
  - Renamed ADJNTPVAL's "type" field to "op" to align with audit record
    conventions
  - Minor commit message editing
  - Cc timekeeping/NTP people for feedback

v3: https://www.redhat.com/archives/linux-audit/2018-July/msg00001.html
Changes in v3:
  - Switched to separate records for each variable
  - Both old and new value is now reported for each change
  - Injecting offset is reported via a separate record (since this
    offset consists of two values and is added directly to the clock,
    i.e. it doesn't make sense to log old and new value)
  - Added example records produced by chronyd -q (see the commit message
    of the last patch)

v2: https://www.redhat.com/archives/linux-audit/2018-June/msg00114.html
Changes in v2:
  - The audit_adjtime() function has been modified to only log those
    fields that contain values that are actually used, resulting in more
    compact records.
  - The audit_adjtime() call has been moved to do_adjtimex() in
    timekeeping.c
  - Added an additional patch (for review) that simplifies the detection
    if the syscall is read-only.

v1: https://www.redhat.com/archives/linux-audit/2018-June/msg00095.html

[1] https://www.niap-ccevs.org/MMO/PP/pp_ca_v2.1.pdf -- section 5.1,
    table 4

Ondrej Mosnacek (2):
  timekeeping: Audit clock adjustments
  ntp: Audit NTP parameters adjustment

 include/linux/audit.h      | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/audit.h |  2 ++
 kernel/auditsc.c           | 15 +++++++++++++++
 kernel/time/ntp.c          | 38 ++++++++++++++++++++++++++++++--------
 kernel/time/timekeeping.c  |  6 ++++++
 5 files changed, 82 insertions(+), 8 deletions(-)

-- 
2.20.1

