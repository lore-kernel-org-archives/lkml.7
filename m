Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2705FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BBC218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJVYvW9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfC2WIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:08:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44559 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfC2WIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so1630407pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XdUDWqZO+yt0G3gfF0l3ghCYj5qNVSnRNwCwmQ89hNg=;
        b=DJVYvW9iN4ydwey+DmQCUsmKT67K2XJN0BMLchhcYu9TqtKALhwn5HOzcBpMkSy1d9
         sdJ1/S0jFK4wA3ou/xbkod3TDEbqyuo5+cko7hFrNQSz6qsKSDMZAKItgiFSNjkyDuLN
         2qKYj4Vajscgh7cR70EdNDVoSXKITGTInVM8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdUDWqZO+yt0G3gfF0l3ghCYj5qNVSnRNwCwmQ89hNg=;
        b=lX0VCrISknOgrMxqVVHkHRXxspVXDqTiOAhw1kIFwWvmFUDlQbz+QYfswbZmLXlalY
         5zlPiXZlxoRbIffbrJ4xHb3GWhTLvnJgm/YD/En6OyqzPf3DMoooGMFAsE7x2hFROePy
         +aiyKJ9wxdB7ospz6KxEdwjAmr59af/SZJTlasNIl/heGArDynkK6odUNbw4VnfXTDgn
         MWV98AJXXbZsxvjshDY2jXnoj7K5n9VLvuPTRxKqrWaVf7jt0qKA1HT+Z/GsnoR2Fd8m
         RGuwORBzoGiP9ORoXULzpumsS9cLthBQk97KZ2IrNoZTSq+JVmhJywvctXeeQOziq2xq
         3PKA==
X-Gm-Message-State: APjAAAVyK2TLDM76PGcgDSue/NqOM17kc4Uw4Zh7a57yciVWHYxLxpTa
        rFixvGPYBnh6NPRtJlPXMTF3bQ==
X-Google-Smtp-Source: APXvYqz6r7Qf9cV69xmJB5tSLMsn6TyoEc3WiuCv1kmbD6ZIA92GpUAQwPIshElgO4XwjwVCVoffRg==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr51741143plk.106.1553897330303;
        Fri, 29 Mar 2019 15:08:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm8925514pfj.67.2019.03.29.15.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:08:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 4/5] scripts/gdb: Add a timer list command
Date:   Fri, 29 Mar 2019 15:08:43 -0700
Message-Id: <20190329220844.38234-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190329220844.38234-1-swboyd@chromium.org>
References: <20190329220844.38234-1-swboyd@chromium.org>
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
 scripts/gdb/linux/constants.py.in |  13 ++
 scripts/gdb/linux/timerlist.py    | 219 ++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   1 +
 3 files changed, 233 insertions(+)
 create mode 100644 scripts/gdb/linux/timerlist.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index d3319a80788a..76f46f427b96 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -13,8 +13,10 @@
  */
 
 #include <linux/fs.h>
+#include <linux/hrtimer.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
+#include <linux/threads.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
 
@@ -44,6 +46,9 @@ LX_VALUE(SB_DIRSYNC)
 LX_VALUE(SB_NOATIME)
 LX_VALUE(SB_NODIRATIME)
 
+/* linux/htimer.h */
+LX_GDBPARSED(hrtimer_resolution)
+
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
 LX_VALUE(MNT_NODEV)
@@ -52,8 +57,16 @@ LX_VALUE(MNT_NOATIME)
 LX_VALUE(MNT_NODIRATIME)
 LX_VALUE(MNT_RELATIME)
 
+/* linux/threads.h */
+LX_VALUE(NR_CPUS)
+
 /* linux/of_fdt.h> */
 LX_VALUE(OF_DT_HEADER)
 
 /* Kernel Configs */
+LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS)
+LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
+LX_CONFIG(CONFIG_HIGH_RES_TIMERS)
+LX_CONFIG(CONFIG_NR_CPUS)
 LX_CONFIG(CONFIG_OF)
+LX_CONFIG(CONFIG_TICK_ONESHOT)
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
new file mode 100644
index 000000000000..071d0dd5a634
--- /dev/null
+++ b/scripts/gdb/linux/timerlist.py
@@ -0,0 +1,219 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+import binascii
+import gdb
+
+from linux import constants
+from linux import cpus
+from linux import rbtree
+from linux import utils
+
+timerqueue_node_type = utils.CachedType("struct timerqueue_node").get_type()
+hrtimer_type = utils.CachedType("struct hrtimer").get_type()
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
+
+def print_timer(rb_node, idx):
+    timerqueue = utils.container_of(rb_node, timerqueue_node_type.pointer(),
+                                    "node")
+    timer = utils.container_of(timerqueue, hrtimer_type.pointer(), "node")
+
+    function = str(timer['function']).split(" ")[1].strip("<>")
+    softexpires = timer['_softexpires']
+    expires = timer['node']['expires']
+    now = ktime_get()
+
+    text = " #{}: <{}>, {}, ".format(idx, timer, function)
+    text += "S:{:02x}\n".format(int(timer['state']))
+    text += " # expires at {}-{} nsecs [in {} to {} nsecs]\n".format(
+            softexpires, expires, softexpires - now, expires - now)
+    return text
+
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
+
+def print_cpu(hrtimer_bases, cpu, max_clock_bases):
+    cpu_base = cpus.per_cpu(hrtimer_bases, cpu)
+    jiffies = gdb.parse_and_eval("jiffies_64")
+    tick_sched_ptr = gdb.parse_and_eval("&tick_cpu_sched")
+    ts = cpus.per_cpu(tick_sched_ptr, cpu)
+
+    text = "cpu: {}\n".format(cpu)
+    for i in xrange(max_clock_bases):
+        text += " clock {}:\n".format(i)
+        text += print_base(cpu_base['clock_base'][i])
+
+        if constants.LX_CONFIG_HIGH_RES_TIMERS:
+            fmts = [("  .{}   : {} nsecs", 'expires_next'),
+                    ("  .{}    : {}", 'hres_active'),
+                    ("  .{}      : {}", 'nr_events'),
+                    ("  .{}     : {}", 'nr_retries'),
+                    ("  .{}       : {}", 'nr_hangs'),
+                    ("  .{}  : {}", 'max_hang_time')]
+            text += "\n".join([s.format(f, cpu_base[f]) for s, f in fmts])
+            text += "\n"
+
+        if constants.LX_CONFIG_TICK_ONESHOT:
+            fmts = [("  .{}      : {}", 'nohz_mode'),
+                    ("  .{}      : {} nsecs", 'last_tick'),
+                    ("  .{}   : {}", 'tick_stopped'),
+                    ("  .{}   : {}", 'idle_jiffies'),
+                    ("  .{}     : {}", 'idle_calls'),
+                    ("  .{}    : {}", 'idle_sleeps'),
+                    ("  .{} : {} nsecs", 'idle_entrytime'),
+                    ("  .{}  : {} nsecs", 'idle_waketime'),
+                    ("  .{}  : {} nsecs", 'idle_exittime'),
+                    ("  .{} : {} nsecs", 'idle_sleeptime'),
+                    ("  .{}: {} nsecs", 'iowait_sleeptime'),
+                    ("  .{}   : {}", 'last_jiffies'),
+                    ("  .{}     : {}", 'next_timer'),
+                    ("  .{}   : {} nsecs", 'idle_expires')]
+            text += "\n".join([s.format(f, ts[f]) for s, f in fmts])
+            text += "\njiffies: {}\n".format(jiffies)
+
+        text += "\n"
+
+    return text
+
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
+               ('tick_resume', " resume:   {}\n")]
+    for member, fmt in members:
+        if dev[member]:
+            text += fmt.format(dev[member])
+
+    text += " event_handler:  {}\n".format(dev['event_handler'])
+    text += " retries:        {}\n".format(dev['retries'])
+
+    return text
+
+
+def pr_cpumask(mask):
+    nr_cpu_ids = 1
+    if constants.LX_NR_CPUS > 1:
+        nr_cpu_ids = gdb.parse_and_eval("nr_cpu_ids")
+
+    inf = gdb.inferiors()[0]
+    bits = mask['bits']
+    num_bytes = (nr_cpu_ids + 7) / 8
+    buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
+    buf = binascii.b2a_hex(buf)
+
+    chunks = []
+    i = num_bytes
+    while i > 0:
+        i -= 1
+        start = i * 2
+        end = start + 2
+        chunks.append(buf[start:end])
+        if i != 0 and i % 4 == 0:
+            chunks.append(',')
+
+    extra = nr_cpu_ids % 8
+    if 0 < extra <= 4:
+        chunks[0] = chunks[0][0]  # Cut off the first 0
+
+    return "".join(chunks)
+
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
+                mask = pr_cpumask(mask)
+                text += "tick_broadcast_mask: {}\n".format(mask)
+                if constants.LX_CONFIG_TICK_ONESHOT:
+                    mask = gdb.parse_and_eval("tick_broadcast_oneshot_mask")
+                    mask = pr_cpumask(mask)
+                    text += "tick_broadcast_oneshot_mask: {}\n".format(mask)
+                text += "\n"
+
+            tick_cpu_devices = gdb.parse_and_eval("&tick_cpu_device")
+            for cpu in cpus.each_online_cpu():
+                tick_dev = cpus.per_cpu(tick_cpu_devices, cpu)
+                text += print_tickdevice(tick_dev, cpu)
+                text += "\n"
+
+        gdb.write(text)
+
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

