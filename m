Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A220883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDIMbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:31:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52471 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:31:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so3302474wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qz5HMgExkSXCg5f0cwr2riBSaYfgDD3un2I+7mKSBEc=;
        b=BAU6NIA7TgH0hKVjQ3v89K49NH59HWOUCSumaALmHvKhlETJ4IpOS0yky5CnA8GLNj
         9M5eM37a/clOrltc2HPjZdeb5t2Xmtkz8CJ3Rla5jZEutZMKCeFIE30lu09r7wM+KW5u
         0QUNQALeFEhI3yhOSLe+ff4MsbLtDDQWn8/MKC3HbmUhETS0jamf6OX43IwcpJIEkNYZ
         GEx6f7ZPSgtM8wcDQuAxxe1hkvAYqk8etP5eZE2oLSVGpB8WYAkUfbrFSOvOUigf5vHh
         ZJ/tQLZdiSWnjqTm1M205PMl6BoP0F1Y1XJVSi849so6iIk3UwAL6qZP3jrXCI5QvU0g
         uOmg==
X-Gm-Message-State: APjAAAUMySb4XuP2dojkKxHXnXyHkOrj12hLu9kI0qkq2NFcWAiGo7/a
        c2rIcpnbEqvfRU4deATU+7SRtQ==
X-Google-Smtp-Source: APXvYqy3CU1MhFTuA9s7Z1qtodRqeE7zwXvIIPLnvlnUYVfJwr/bkzFm++0j1APESl8gfvPzkdaBUg==
X-Received: by 2002:a1c:e709:: with SMTP id e9mr22636813wmh.14.1554813097018;
        Tue, 09 Apr 2019 05:31:37 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:8308:b13e:ee00:435d:e8f:90ca:755e])
        by smtp.gmail.com with ESMTPSA id z1sm27139721wrs.52.2019.04.09.05.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 05:31:36 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH ghak10 v7 0/2] audit: Log changes that can affect the system clock
Date:   Tue,  9 Apr 2019 14:31:32 +0200
Message-Id: <20190409123134.19350-1-omosnace@redhat.com>
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
  - NTP value adjustments (may affect system time indirectly):
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

Audit userspace PR: https://github.com/linux-audit/audit-userspace/pull/89
Audit testsuite PR: https://github.com/linux-audit/audit-testsuite/pull/82

Testing: Passed audit-testuite (including new functional test from PR#82)

Changes in v7:
  - Removed #include <uapi/linux/timex.h> from audit.h, since it is not
    needed
  - Moved audit_log() calls out of locked sections and switched audit
    allocations to GFP_KERNEL
  - Rebased onto latest audit/next
  - Switched the general NTP value type to long long (was s64),
    which corresponds better with the actual timex field types
  - Simplified commit log messages

v6: https://www.redhat.com/archives/linux-audit/2019-March/msg00016.html
Changes in v6:
  - Reorganized the patches to group changes by record type, not
    kernel subsytem, as suggested in earlier discussions
  - Added checks to ignore no-change events (new value == old value)
  - Added TIME_INJOFFSET logging also to do_settimeofday64() to cover
    syscalls such as settimeofday(2), stime(2), clock_settime(2)
  - Created an RFE page on audit-kernel GitHub

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

 include/linux/audit.h      | 68 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/audit.h |  2 ++
 kernel/auditsc.c           | 29 ++++++++++++++++
 kernel/time/ntp.c          | 22 ++++++++++--
 kernel/time/ntp_internal.h |  4 ++-
 kernel/time/timekeeping.c  | 13 +++++++-
 6 files changed, 133 insertions(+), 5 deletions(-)

-- 
2.20.1

