Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A5DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD18821726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfDEPiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:38:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41551 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDEPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:38:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so6003204otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Qqyktl9dpwCcjGJcKMTHlRd6muYfE+fK8iJlpavdGXI=;
        b=LXfdQxJ/b44SLzYrZeOJ3nl35fmNraBCPwVrT1ZG/tBWU/Ug/2RRA0/MaeYp/AEMf0
         pXNfnTpdUhqV/8D2Nmn/WJaELm7e1ILm1qgvO6lqXHcksv/RbsHKJXv+lm8L8n7Fevcy
         4r57icdqWaP6CvaUBuzzc54JvJI2BDj+2Q1e4+zwNi910vRj2rwb4zHbHvn4Gl5512Az
         Y7pdTjlr9hjJJ8pt8iWUal+bDo7XMinhh6yGlO4wP/KbZGsk13X8ZcOsviUKXy2P8wyV
         a2yS9IVgFTCCvg7qeqmp1w/RIqT4txYwevBMnn0GbfW2Tqc9/WyPlX3UkJr5WZDoTgm7
         UYiw==
X-Gm-Message-State: APjAAAUNwehN5YEXGbwFQpYHA3F6caOduuUAfjNpqGotz8xggDCSFWcS
        JsiFClWIkvIt1WxikpQ+A034cpGAXPWQzVCXmdWpWb6U
X-Google-Smtp-Source: APXvYqwMD4F8WqE+WSFWqQtQk5byLcYwdTVNa0rTGBHIhI4ojnqzDpIAAdfo3AWONhx0PFR4rLetNSmkeUQhnUfh+94=
X-Received: by 2002:a9d:5e15:: with SMTP id d21mr9335213oti.138.1554478680174;
 Fri, 05 Apr 2019 08:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <1554478619-12239-1-git-send-email-jsavitz@redhat.com>
In-Reply-To: <1554478619-12239-1-git-send-email-jsavitz@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 5 Apr 2019 11:37:49 -0400
Message-ID: <CAL1p7m6aArGDokWN9vFzd+ARbPdfBR+YFim_GrZvk2wYcCFQZQ@mail.gmail.com>
Subject: Fwd: [RESEND PATCH] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Joel Savitz <jsavitz@redhat.com>
Date: Fri, Apr 5, 2019 at 11:37 AM
Subject: [RESEND PATCH] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To: <pauld@redhat.com>
Cc: Joel Savitz <jsavitz@redhat.com>, Li Zefan <lizefan@huawei.com>,
<cgroups@vger.kernel.org>


If a process is limited by taskset (i.e. cpuset) to only be allowed to
run on cpu N, and then cpu N is offlined via hotplug, the process will
be assigned the current value of its cpuset cgroup's effective_cpus field
in a call to do_set_cpus_allowed() in cpuset_cpus_allowed_fallback().
This argument's value does not makes sense for this case, because
task_cs(tsk)->effective_cpus is modified by cpuset_hotplug_workfn()
to reflect the new value of cpu_active_mask after cpu N is removed from
the mask. While this may make sense for the cgroup affinity mask, it
does not make sense on a per-task basis, as a task that was previously
limited to only be run on cpu N will be limited to every cpu _except_ for
cpu N after it is offlined/onlined via hotplug.

Pre-patch behavior:

        $ grep Cpus /proc/$$/status
        Cpus_allowed:   ff
        Cpus_allowed_list:      0-7

        $ taskset -p 4 $$
        pid 19202's current affinity mask: f
        pid 19202's new affinity mask: 4

        $ grep Cpus /proc/self/status
        Cpus_allowed:   04
        Cpus_allowed_list:      2

        # echo off > /sys/devices/system/cpu/cpu2/online
        $ grep Cpus /proc/$$/status
        Cpus_allowed:   0b
        Cpus_allowed_list:      0-1,3

        # echo on > /sys/devices/system/cpu/cpu2/online
        $ grep Cpus /proc/$$/status
        Cpus_allowed:   0b
        Cpus_allowed_list:      0-1,3

On a patched system, the final grep produces the following
output instead:

        $ grep Cpus /proc/$$/status
        Cpus_allowed:   ff
        Cpus_allowed_list:      0-7

This patch changes the above behavior by instead simply resetting the mask
to cpu_possible_mask.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 479743db6c37..5f65a2167bdf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3243,7 +3243,7 @@ void cpuset_cpus_allowed(struct task_struct
*tsk, struct cpumask *pmask)
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
        rcu_read_lock();
-       do_set_cpus_allowed(tsk, task_cs(tsk)->effective_cpus);
+       do_set_cpus_allowed(tsk, cpu_possible_mask);
        rcu_read_unlock();

        /*
--
2.20.1
