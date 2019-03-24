Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD50C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C182133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTY22oNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfCXWPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:15:32 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41477 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCXWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:15:31 -0400
Received: by mail-ed1-f53.google.com with SMTP id a25so5876206edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PmONrJNFkVtd43rOWlESHYGTZgE8rC3MmllN47XQGKI=;
        b=CTY22oNqSb25x/AYLOz/2b5deeEudYkuCobmx0v9ijIhOEn2zvhNLqsqwt2t7Kn5Bw
         qsjUNwEPBdiLOVuGXUVOjscLnJN3i1Z9EWNziqZH623GPVWWtL4jDYGLzBzhz8BEZH/d
         TUHXv3Od0MrDfibzhR6/9yrC+ZF/gtOxb7f8QhRzAtxlXUSDyDcilOPnY/tSI3m/Ecjy
         bfE/XMSUm7W663Z5QkM8HJ59yDoTOwYWSKo4wmiFSoSJhFbAjSbVscMd3m+ppoKxlbrv
         9HGkPQLyHg3yRzpK15vZ+mp/1eCNwZT/4HhxsQ0TA4P0xJ9O6RWs792y+YnPYzxqms+d
         V65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PmONrJNFkVtd43rOWlESHYGTZgE8rC3MmllN47XQGKI=;
        b=QvJjG8e9QmgpTI4FUUGOF++FYZIP/d+m6oVLTQK0WDeIniX+VFNJ7+lmF/UjzzhHQa
         WaDmEF9QIV/Ov15w1K7hFP7+RoUxkE3UOiP6aAaU/X1Y4YbxmmFzVwyqtTatar2UW9qC
         qnEuqRxAD4v3W0llG1oAGX7sp0t6kB6PcIGbfq9hVHIe/uvdZjQYRT+gOPsmtwuTXMkh
         VJHASuE806G1XRJZuBb5YS38mbJA6g7+iib/00NFxgZij4HlKTajoW5EhmysmrDV/3gj
         EL5MAUZmDYQms6fAj7s37ZvY3sjXwNyUnAqaIsZ/dX6JFl7VAbW9okteRFZhhDH1nIct
         osxQ==
X-Gm-Message-State: APjAAAVXORj7cL376qJJH57qRW1wFAIwF80nqMCjPi/9s8OEz8PGb52m
        GoLKhn8niu4qxaPSL7XCBXxkBHZbuPSgxSkGIYA9Tvih
X-Google-Smtp-Source: APXvYqxb8+URA9FPGl2O5mMp/LwNTMqOZX3JBbZY/ucgXDkP61P6y3zmhboSF5yoK6higZ0WJRNnGHjAHXK6OeIPIQo=
X-Received: by 2002:a50:8b21:: with SMTP id l30mr14495400edl.190.1553465728887;
 Sun, 24 Mar 2019 15:15:28 -0700 (PDT)
MIME-Version: 1.0
From:   Rian Quinn <rianquinn@gmail.com>
Date:   Sun, 24 Mar 2019 16:15:17 -0600
Message-ID: <CANmpu8Utk-dLd6bKz+oebx5qwCvS8Y_seX2a=OH4o9f1+GSJ4Q@mail.gmail.com>
Subject: nohz_mode disabled with NO_HZ_IDLE=y
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on the Boxy hypervisor and we have our own custom
compiled Linux kernel. I was doing some performance tests and noticed
that our guest "hlt" handler which implements a guest idle was only
idling for 10ms at a time (or 100Hz) which is the rate we have the
periodic timer set to in the kernel config. The thing is, we have
NO_HZ_IDLE enabled as well and the test that I am running simply
outputs the time to the console and then sleeps for a second, so I
expected the idle time to be closer to 1 second.

It appears that the kernel is acting like it is tick based, even
though it was configured for tickless idle. Here is the output of
/proc/timer_list. Right now, we require an invariant TSC and we
provide an emulated LAPIC timer (we have no intention of ever
supporting legacy hardware so our goal is to keep the amount of
emulation that we have to provide to a minimum). From the output,
nohz_mode is disabled. Another thing that is interesting about this is
I have the high-resolution timing enabled as well, but from the
output, it would appear that high-resolution timing is not working
either.

Any idea on what the issue could be?

------------------

[    0.020043] [U] Timer List Version: v0.8
[    0.020083] [U] HRTIMER_MAX_CLOCK_BASES: 8
[    0.020121] [U] now at 18467102 nsecs
[    0.020157] [U] cpu: 0
[    0.020180] [U]  clock 0:
[    0.020206] [U]   .base:       (____ptrval____)
[    0.020248] [U]   .index:      0
[    0.020279] [U]   .resolution: 10000000 nsecs
[    0.020320] [U]   .get_time:   ktime_get
[    0.020357] [U]   .offset:     0 nsecs
[    0.020392] [U] active timers:
[    0.020421] [U]  clock 1:
[    0.020447] [U]   .base:       (____ptrval____)
[    0.020489] [U]   .index:      1
[    0.020520] [U]   .resolution: 10000000 nsecs
[    0.020561] [U]   .get_time:   ktime_get_real
[    0.020602] [U]   .offset:     1553443224994997061 nsecs
[    0.020651] [U] active timers:
[    0.020680] [U]  clock 2:
[    0.020706] [U]   .base:       (____ptrval____)
[    0.020748] [U]   .index:      2
[    0.020779] [U]   .resolution: 10000000 nsecs
[    0.020820] [U]   .get_time:   ktime_get_boottime
[    0.020864] [U]   .offset:     0 nsecs
[    0.020899] [U] active timers:
[    0.020928] [U]  clock 3:
[    0.020954] [U]   .base:       (____ptrval____)
[    0.020996] [U]   .index:      3
[    0.021027] [U]   .resolution: 10000000 nsecs
[    0.021068] [U]   .get_time:   ktime_get_clocktai
[    0.021112] [U]   .offset:     1553443224994997061 nsecs
[    0.021161] [U] active timers:
[    0.021190] [U]  clock 4:
[    0.021216] [U]   .base:       (____ptrval____)
[    0.021260] [U]   .index:      4
[    0.021291] [U]   .resolution: 10000000 nsecs
[    0.021331] [U]   .get_time:   ktime_get
[    0.021368] [U]   .offset:     0 nsecs
[    0.021404] [U] active timers:
[    0.021433] [U]  clock 5:
[    0.021459] [U]   .base:       (____ptrval____)
[    0.021501] [U]   .index:      5
[    0.021532] [U]   .resolution: 10000000 nsecs
[    0.021572] [U]   .get_time:   ktime_get_real
[    0.021613] [U]   .offset:     1553443224994997061 nsecs
[    0.021662] [U] active timers:
[    0.021691] [U]  clock 6:
[    0.021717] [U]   .base:       (____ptrval____)
[    0.021759] [U]   .index:      6
[    0.021790] [U]   .resolution: 10000000 nsecs
[    0.021830] [U]   .get_time:   ktime_get_boottime
[    0.021874] [U]   .offset:     0 nsecs
[    0.021909] [U] active timers:
[    0.021939] [U]  clock 7:
[    0.021964] [U]   .base:       (____ptrval____)
[    0.022006] [U]   .index:      7
[    0.022037] [U]   .resolution: 10000000 nsecs
[    0.022078] [U]   .get_time:   ktime_get_clocktai
[    0.022122] [U]   .offset:     1553443224994997061 nsecs
[    0.022171] [U] active timers:
[    0.022200] [U]   .expires_next   : 9223372036854775807 nsecs
[    0.022253] [U]   .hres_active    : 0
[    0.022287] [U]   .nr_events      : 0
[    0.022322] [U]   .nr_retries     : 0
[    0.022357] [U]   .nr_hangs       : 0
[    0.022391] [U]   .max_hang_time  : 0
[    0.022444] [U]   .nohz_mode      : 0
[    0.022479] [U]   .last_tick      : 0 nsecs
[    0.022518] [U]   .tick_stopped   : 0
[    0.022553] [U]   .idle_jiffies   : 0
[    0.022587] [U]   .idle_calls     : 0
[    0.022622] [U]   .idle_sleeps    : 0
[    0.022656] [U]   .idle_entrytime : 0 nsecs
[    0.022695] [U]   .idle_waketime  : 0 nsecs
[    0.022734] [U]   .idle_exittime  : 0 nsecs
[    0.022773] [U]   .idle_sleeptime : 0 nsecs
[    0.022813] [U]   .iowait_sleeptime: 0 nsecs
[    0.022852] [U]   .last_jiffies   : 0
[    0.022887] [U]   .next_timer     : 0
[    0.022921] [U]   .idle_expires   : 0 nsecs
[    0.022960] [U] jiffies: 4294937297
[    0.022994] [U] Tick Device: mode:     0
[    0.023031] [U] Broadcast device
[    0.023062] [U] Clock Event Device: <NULL>
[    0.023100] [U] tick_broadcast_mask: 0
[    0.023135] [U] tick_broadcast_oneshot_mask: 0
[    0.023177] [U] Tick Device: mode:     0
[    0.023214] [U] Per CPU device: 0
[    0.023246] [U] Clock Event Device: lapic-deadline
[    0.023290] [U]  max_delta_ns:   1514478803259
[    0.023331] [U]  min_delta_ns:   1000
[    0.023366] [U]  mult:           12180259
[    0.023404] [U]  shift:          25
[    0.023437] [U]  mode:           3
[    0.023469] [U]  next_event:     25002939 nsecs
[    0.023511] [U]  set_next_event: lapic_next_deadline
[    0.023557] [U]  shutdown: lapic_timer_shutdown
[    0.023599] [U]  periodic: lapic_timer_set_periodic
[    0.023644] [U]  oneshot:  lapic_timer_set_oneshot
[    0.023689] [U]  oneshot stopped: lapic_timer_shutdown
[    0.023736] [U]  event_handler:  tick_handle_periodic
[    0.023783] [U]  retries:        0
