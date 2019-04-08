Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4152148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCIrUGVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfDHRc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:32:59 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:46236 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDHRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:32:58 -0400
Received: by mail-yw1-f74.google.com with SMTP id 201so1213419ywr.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eV/NLtCKNCpFxuOWvJuDZmnGxi7vFg3fs38itZR4e3A=;
        b=kCIrUGVoCv4vcfEb0iJnE4d6hwM7ToxSF6Im+fsEEacz0mFXosg1lbAAa45p68U/xL
         NdZ4LPbGAryju7OuCCjl5uuCy8UZNhTVRzXUZYiuwFgsX7JP0fVgXCBLUspZ9MyWwfRw
         8gWmZ43h/dg0fStdXNjBQ5DGqA+fmnTEOUtPBkEEi5w3dIHhWWcm8cZwJeLgnk8g8Nom
         1JqFd3lwQ8Wgik7hwlE5UYzZXqLaNWXK1UiGIAghc6Zo0I02B6TmG55LC9WiBqid/q9Q
         X8b/bDJnEaLN7LSPG9KMlCPqKws+7CzJDgVoOOfuUHqtupspxmUQi0NDSHlS16vgGysW
         WKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eV/NLtCKNCpFxuOWvJuDZmnGxi7vFg3fs38itZR4e3A=;
        b=OUiY2m1eIkYb+LsvJvePWT70J9cCHCZjsQdEnf/Au8xKrJ4U8UkIIvejRHvT5xgcUT
         HmkR+V0C1Qh3fzO8q/6cY62d6ukw/qzQnHIdxOHByl2AzpzEzGgjfW7Rud+GDRJvhhob
         RQyEmcv2yAay6stajzhj7y094kbSPzidV7KCL84KbPzjA7V9wrK/iDxTwx05w9eymVVr
         7SK4Cy4Pkcsd7luX4fQjbhZk/AzKLxRg+bPtWW4rPVucRUqmHlkYtmh45tFVbG++4sTM
         tzp1kCMH88MA67P4do30alnVWjfogrfT9L1Z82QCqPqoFMfsMcMWgyxakZN0YQOeAicm
         Oszg==
X-Gm-Message-State: APjAAAX05ZG8dSyq4kExWsdyFj1bNzIyAjfYK46XPcV+vlKm3Ub7fIdN
        jRH2aoqFyahqtKAO84oARspnhl0isk3IVs3zN3qiWgGA9C+IYlFXBI5khhVJipoJ4VdyQ3MxXAL
        ud2yTRHn/JIRcQmGi2GUC8/LEjDeaGIICcP1u7n6Lpd11Psc7JEd3B3mjqwQV2BidLCA8wE6w
X-Google-Smtp-Source: APXvYqzid6rS0qlnLiqGZag+LBPrRqnU3DsXVkUV32roEQTN4FQcAjAPuLXYdEmU+ww7OJeFRRc60mfYNEOf
X-Received: by 2002:a25:3288:: with SMTP id y130mr5654827yby.75.1554744777768;
 Mon, 08 Apr 2019 10:32:57 -0700 (PDT)
Date:   Mon,  8 Apr 2019 10:32:50 -0700
Message-Id: <20190408173252.37932-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 0/3] perf/x86/intel: force reschedule on TFA changes
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
code, ctx_resched(). In V2, we export a new function called perf_ctx_resched()
which takes care of locking the contexts and invoking ctx_resched().

The patch adds a x86_get_pmu() call which is less than ideal, but I am open to
suggestions here.

In V2, we also switched from ksttoul() to kstrtobool() and added the proper
get_online_cpus()/put_online_cpus().

Signed-off-by: Stephane Eranian <eranian@google.com>


Stephane Eranian (2):
  perf/core: add perf_ctx_resched() as global function
  perf/x86/intel: force resched when TFA sysctl is modified

 arch/x86/events/core.c       |  4 +++
 arch/x86/events/intel/core.c | 53 ++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   | 14 ++++++++++
 kernel/events/core.c         | 18 ++++++------
 5 files changed, 79 insertions(+), 11 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

