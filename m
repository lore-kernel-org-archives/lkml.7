Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C73BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC8E206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQ28a6tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDDScY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:32:24 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45746 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:32:23 -0400
Received: by mail-yb1-f201.google.com with SMTP id k65so2483981ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FwG1v3MD4Bwg6BVebsWvxW5HMuj6+IPvqv/argV3hVY=;
        b=wQ28a6tZRR5k1aUoVuhoF7APy2ExLtCoLGotNlAL7l9UIDeQLj7/0kKbVejgQkG5A+
         B9EjMDZAQH/MhBETI/Heo9cH9V9ALdn8NSIGSODOmN0KN7qGLx3H63Plk5tfsW+9xnqR
         tLBdGJZHBqIf2d7arWJ+YJozZhXrd2Zi/MgQcdqp07CvcZEdlRNM/bIv6bT+Rg9GIln2
         wV1OZcg566Wc0hXjumjNUQ+G/SGDWZNBjE1NyFxJla3UCn2hAk/wv7ZLHOTofcUbbvmx
         bTjuNwDkgKCl1APoSmn0saRaWBBbcg/EEO75GzXDmYiCYWMccwQH3OQ7CGdwFUzNTC2T
         SGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FwG1v3MD4Bwg6BVebsWvxW5HMuj6+IPvqv/argV3hVY=;
        b=LSzZEZUpAiAMIdIXje1B2m7GITzEF7nZptH2fJC2Gqls7T8dH5wB5JejDWrkOnNPoz
         MkUix8oyxCpKDXs465h4fVGTu0aity8TOgdyzHnfQGAYXcgWTIf0HI79saDktRGu8QoK
         64uxtK1Kl4BJnngij5vy9Z4C53T7Jn0Q2YxfnK2+Pj7maWmkxv9G3b0BryhqsNQjfLrK
         JYiHo1KJSu+YQ8lIIBsEGg0fdgyS3w68OsjzN3EX0YcZSEx9MKsFViHzGmPN0rT8Pt3b
         CCmjCKFYUcBcJnzkANKgGOxky1aH5Fx/QJsQAwl2MZxGZcnRjxU+tCWCZ8ZfwkuQz8R6
         nWKQ==
X-Gm-Message-State: APjAAAWdVryC8sX0CxtPWA4AETgaqN1Ej6YnDdjiT6+t2ckkzxsRMrQt
        h9cYP50pYCcnNsc0hhWhftyhsObUd0Cmr4nuxdVnxAxNaKZrxpd+v0m//JegKr3BUUzcx90goCO
        Js3KmsKvZyI3ng32t/rI+tR9XtNjlP9iAaTYd4n3tcBzFDCsDre3WCFTWNVo8fFxE12RSfgvK
X-Google-Smtp-Source: APXvYqz278yptRsRNYGz4ZJPIiv0VY2xBg6PWtVkSGfo6X9UzW8BtZUDsLMXwTnWJ79aFLM9W9j/QFbZFCAe
X-Received: by 2002:a25:2182:: with SMTP id h124mr1250338ybh.70.1554402742846;
 Thu, 04 Apr 2019 11:32:22 -0700 (PDT)
Date:   Thu,  4 Apr 2019 11:32:16 -0700
Message-Id: <20190404183219.125083-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 0/3] perf/x86/intel: force reschedule on TFA changes
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        kan.liang@intel.com, mingo@elte.hu, nelson.dsouza@intel.com,
        jolsa@redhat.com, tonyj@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short patch series improves the TFA patch series by adding a
guarantee to users each time the allow_force_tsx_abort (TFA) sysctl
control knob is modified. 

The current TFA support in perf_events operates as follow:
 - TFA=1
   The PMU has priority over TSX, if PMC3 is needed, then TSX transactions
   are forced to abort. PMU has access to PMC3 and can schedule events on it.

 - TFA=0
   TSX has priority over PMU. If PMC3 is needed for an event, then the event
   must be scheduled on another counter. PMC3 is not available.

When a sysadmin modifies TFA, the current code base does not change anything
to the events measured at the time nor the actual MSR controlling TFA. If the
kernel transitions from TFA=1 to TFA=0, nothing happens until the events are
descheduled on context switch, multiplexing or termination of measurement.
That means the TSX transactions still fail until then. There is no easy way
to evaluate how long this can take.

This patch series addresses this issue by rescheduling the events as part of the
sysctl changes. That way, there is the guarantee that no more perf_events events
are running on PMC3 by the time the write() syscall (from the echo) returns, and
that TSX transactions may succeed from then on. Similarly, when transitioning
from TFA=0 to TFA=1, the events are rescheduled and can use PMC3 immediately if
needed and TSX transactions systematically abort, by the time the write() syscall
returns.

To make this work, the patch uses an existing reschedule function in the generic
code. It makes it visible outside the generic code as well as the context locking
code. All to avoid code duplication. Given there is no good way to find the struct
pmu, if you do not have it, the patch adds a x86_get_pmu() call which is less than
ideal, but I am open to suggestions here.

Signed-off-by: Stephane Eranian <eranian@google.com>

Stephane Eranian (3):
  perf/core: make perf_ctx_*lock() global inline functions
  perf/core: make ctx_resched() a global function
  perf/x86/intel: force resched when TFA sysctl is modified

 arch/x86/events/core.c       |  4 +++
 arch/x86/events/intel/core.c | 60 ++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   | 28 +++++++++++++++++
 kernel/events/core.c         | 37 ++++------------------
 5 files changed, 97 insertions(+), 33 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

