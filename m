Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F244CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AAC20700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZO4hmN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfCYSpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:45:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36014 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbfCYSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:45:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id k2so364863plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSkD67YMuIN5pkx45C0XVf4WNpZlekH1n7Y8svSrr3Y=;
        b=hZO4hmN2CeUejTjrScRC8k5v5FRSk9f+OU3WMlXxlNbryp26v/VHG/0StUNAqileDa
         ypFV9AAoSQOp/zC22ng1WA1jY2EtETr3dL7ZqkvRTPatcaPsrEXo09QjP+Nh0IIqU8t7
         S1vOR9BNUAe2WxXPLQcswzeePjtePUE3IDwco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSkD67YMuIN5pkx45C0XVf4WNpZlekH1n7Y8svSrr3Y=;
        b=X+2mMC6t5oV6gD0PLafo9IP2WzmRNZ/oocaOyTC1oA6mThXITz9F6qnenWRMCcJkug
         dVKmVDPzSY85IJIBaPY8Vgy06jwHz74KDpysHBwD7ebXP+RHvetPe0AB+grljgfK3TwL
         LW8zmQv9bf84XsR82wj9vNqVe25afwsnnBR01Ix6woWBoqqT1zDAuVjzEgK28QrXVr8q
         FlWPsbu4h/EjOJVkDZN6LULa7eaot+jy49ZFO3hTtcrLGldEPLiAExtrNuCeqmsobIk+
         79FsFpfiACoJshUbPgTI4OFwkxZIksN8sex2nfwycesrL65iW2G+UB9b8MiKXODKSCPO
         DwUA==
X-Gm-Message-State: APjAAAVzxQOm5QfW/xypJHbSDP3MfnShSHiqSDOpyDJl+GiCeFEd7qxF
        9x3WhmEQwZFVdrSIdCsZiKd4tQ==
X-Google-Smtp-Source: APXvYqwmHeVwaKShrHIGL8OjIt8zhs9Fo8PyyJ0G3GmoBuCSekdBIWMzksK9WTFzyVfCsD63c/zH9w==
X-Received: by 2002:a17:902:586:: with SMTP id f6mr26221995plf.68.1553539528155;
        Mon, 25 Mar 2019 11:45:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm27505108pfb.31.2019.03.25.11.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:45:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 4/4] scripts/gdb: Add a timer list command
Date:   Mon, 25 Mar 2019 11:45:22 -0700
Message-Id: <20190325184522.260535-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325184522.260535-1-swboyd@chromium.org>
References: <20190325184522.260535-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a command to print the timer list, much like how
/proc/timer_list is implemented. This can be used to look at the pending
timers on a crashed system.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn> 
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/gdb/linux/constants.py.in |   8 ++
 scripts/gdb/linux/timerlist.py    | 194 ++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   1 +
 3 files changed, 203 insertions(+)
 create mode 100644 scripts/gdb/linux/timerlist.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index d3319a80788a..2db8183d909c 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
+#include <linux/hrtimer.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
 
@@ -44,6 +45,9 @@ LX_VALUE(SB_DIRSYNC)
 LX_VALUE(SB_NOATIME)
 LX_VALUE(SB_NODIRATIME)
 
+/* linux/htimer.h */
+LX_GDBPARSED(hrtimer_resolution)
+
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
 LX_VALUE(MNT_NODEV)
@@ -56,4 +60,8 @@ LX_VALUE(MNT_RELATIME)
 LX_VALUE(OF_DT_HEADER)
 
 /* Kernel Configs */
+LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS)
+LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
+LX_CONFIG(CONFIG_HIGH_RES_TIMERS)
 LX_CONFIG(CONFIG_OF)
+LX_CONFIG(CONFIG_TICK_ONESHOT)
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
new file mode 100644
index 000000000000..9b0111aa11a0
--- /dev/null
+++ b/scripts/gdb/linux/timerlist.py
@@ -0,0 +1,194 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+import gdb
+
+from linux import constants
+from linux import cpus
+from linux import rbtree
+from linux import utils
+
+timerqueue_node_type = utils.CachedType("struct timerqueue_node")
+hrtimer_type = utils.CachedType("struct hrtimer")
+
+
+def ktime_get():
+    """Returns the current time, but not very accurately
+
+    We can't read the hardware timer itself to add any nanoseconds
+    that need to be added since we last stored the time in the
+    timekeeper. But this is probably good enough for debug purposes."""
+    tk_core = gdb.parse_and_eval("&tk_core")
+
+    return tk_core['timekeeper']['tkr_mono']['base']
+
+def print_timer(rb_node, idx):
+    timerqueue = utils.container_of(rb_node, timerqueue_node_type.get_type().pointer(), "node")
+    timer = utils.container_of(timerqueue, hrtimer_type.get_type().pointer(), "node")
+
+    function = str(timer['function']).split(" ")[1].strip("<>")
+    softexpires = timer['_softexpires']
+    expires = timer['node']['expires']
+    now = ktime_get()
+
+    text = " #{}: <{}>, {}, ".format(idx, timer, function)
+    text += "S:{:02x}\n".format(int(timer['state']))
+    text += " # expires at {}-{} nsecs [in {} to {} nsecs]\n".format(softexpires,
+            expires, softexpires - now, expires - now)
+    return text
+
+def print_active_timers(base):
+    curr = base['active']['next']['node']
+    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    idx = 0
+    while curr:
+        yield print_timer(curr, idx)
+        curr = rbtree.rb_next(curr)
+        idx += 1
+
+def print_base(base):
+    text = " .base:       {}\n".format(base.address)
+    text += " .index:      {}\n".format(base['index'])
+
+    text += " .resolution: {} nsecs\n".format(constants.LX_hrtimer_resolution)
+
+    text += " .get_time:   {}\n".format(base['get_time'])
+    if constants.LX_CONFIG_HIGH_RES_TIMERS:
+        text += "  .offset:     {} nsecs\n".format(base['offset'])
+    text += "active timers:\n"
+    text += "".join([x for x in print_active_timers(base)])
+    return text
+
+def print_cpu(hrtimer_bases, cpu, max_clock_bases):
+    cpu_base = cpus.per_cpu(hrtimer_bases, cpu)
+    jiffies = gdb.parse_and_eval("jiffies")
+    tick_sched_ptr = gdb.parse_and_eval("&tick_cpu_sched")
+    ts = cpus.per_cpu(tick_sched_ptr, cpu)
+
+    text = "cpu: {}\n".format(cpu)
+    for i in xrange(max_clock_bases):
+        text += " clock {}:\n".format(i)
+        text += print_base(cpu_base['clock_base'][i])
+        if constants.LX_CONFIG_HIGH_RES_TIMERS:
+            text += """  .expires_next   : {} nsecs
+  .hres_active    : {}
+  .nr_events      : {}
+  .nr_retries     : {}
+  .nr_hangs       : {}
+  .max_hang_time  : {}
+""".format(cpu_base['expires_next'],
+           cpu_base['hres_active'],
+           cpu_base['nr_events'],
+           cpu_base['nr_retries'],
+           cpu_base['nr_hangs'],
+           cpu_base['max_hang_time'])
+        if constants.LX_CONFIG_TICK_ONESHOT:
+            text += """  .nohz_mode      : {}
+  .last_tick      : {} nsecs
+  .tick_stopped   : {}
+  .idle_jiffies   : {}
+  .idle_calls     : {}
+  .idle_sleeps    : {}
+  .idle_entrytime : {} nsecs
+  .idle_waketime  : {} nsecs
+  .idle_exittime  : {} nsecs
+  .idle_sleeptime : {} nsecs
+  .iowait_sleeptime: {} nsecs
+  .last_jiffies   : {}
+  .next_timer     : {}
+  .idle_expires   : {} nsecs
+jiffies: {}
+""".format(ts['nohz_mode'],
+           ts['last_tick'],
+           ts['tick_stopped'],
+           ts['idle_jiffies'],
+           ts['idle_calls'],
+           ts['idle_sleeps'],
+           ts['idle_entrytime'],
+           ts['idle_waketime'],
+           ts['idle_exittime'],
+           ts['idle_sleeptime'],
+           ts['iowait_sleeptime'],
+           ts['last_jiffies'],
+           ts['next_timer'],
+           ts['idle_expires'],
+           jiffies)
+
+        text += "\n"
+
+    return text
+
+def print_tickdevice(td, cpu):
+    dev = td['evtdev']
+    text = "Tick Device: mode:     {}\n".format(td['mode'])
+    if cpu < 0:
+            text += "Broadcast device\n"
+    else:
+            text += "Per CPU device: {}\n".format(cpu)
+
+    text += "Clock Event Device: "
+    if dev == 0:
+            text += "<NULL>\n"
+            return text
+
+    text += "{}\n".format(dev['name'])
+    text += " max_delta_ns:   {}\n".format(dev['max_delta_ns'])
+    text += " min_delta_ns:   {}\n".format(dev['min_delta_ns'])
+    text += " mult:           {}\n".format(dev['mult'])
+    text += " shift:          {}\n".format(dev['shift'])
+    text += " mode:           {}\n".format(dev['state_use_accessors'])
+    text += " next_event:     {} nsecs\n".format(dev['next_event'])
+
+    text += " set_next_event: {}\n".format(dev['set_next_event'])
+
+    members = [('set_state_shutdown', " shutdown: {}\n"),
+               ('set_state_periodic', " periodic: {}\n"),
+               ('set_state_oneshot', " oneshot:  {}\n"),
+               ('set_state_oneshot_stopped', " oneshot stopped: {}\n"),
+               ('tick_resume', " resume:   {}\n"),
+              ]
+    for (member, fmt) in members:
+        if dev[member]:
+            text += fmt.format(dev[member])
+
+    text += " event_handler:  {}\n".format(dev['event_handler'])
+    text += " retries:        {}\n".format(dev['retries'])
+
+    return text
+
+class LxTimerList(gdb.Command):
+    """Print /proc/timer_list"""
+
+    def __init__(self):
+        super(LxTimerList, self).__init__("lx-timerlist", gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        hrtimer_bases = gdb.parse_and_eval("&hrtimer_bases")
+        max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
+
+        text = "Timer List Version: gdb scripts\n"
+        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
+        text += "now at {} nsecs\n".format(ktime_get())
+
+        for cpu in cpus.each_online_cpu():
+            text += print_cpu(hrtimer_bases, cpu, max_clock_bases)
+
+        if constants.LX_CONFIG_GENERIC_CLOCKEVENTS:
+            if constants.LX_CONFIG_GENERIC_CLOCKEVENTS_BROADCAST:
+                bc_dev = gdb.parse_and_eval("&tick_broadcast_device")
+                text += print_tickdevice(bc_dev, -1)
+                text += "\n"
+                mask = gdb.parse_and_eval("tick_broadcast_mask")
+                text += "tick_broadcast_mask: {}\n".format(mask) # TODO: format properly
+                if constants.LX_CONFIG_TICK_ONESHOT:
+                    mask = gdb.parse_and_eval("tick_broadcast_oneshot_mask")
+                    text += "tick_broadcast_oneshot_mask: {}\n".format(mask) # TODO: format properly
+                text += "\n"
+
+            tick_cpu_devices = gdb.parse_and_eval("&tick_cpu_device")
+            text += "\n".join([print_tickdevice(cpus.per_cpu(tick_cpu_devices, cpu), cpu) for cpu in cpus.each_online_cpu()])
+
+        gdb.write(text)
+
+LxTimerList()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 89e4aa4f8966..033578cc4cd7 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -33,3 +33,4 @@ else:
     import linux.rbtree
     import linux.proc
     import linux.constants
+    import linux.timerlist
-- 
Sent by a computer through tubes

