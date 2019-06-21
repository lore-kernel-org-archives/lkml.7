Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F8EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEE6208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133956;
	bh=dR+sQyPZpvOsY7vM6jG36NBwA1jf68h3ITQR18BAeSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7HIquzJAeTvm5AhKszrGcqAR0GQcpQ0wjVPmbOlawPfya1DTYIAwGMo8S/jvZnDk
	 jdONn0BqBir5a1m+KBlR0QAm+CtxgWIsM56SSreAuHBgZUvr62ePRCfsWWA0ILT2Hz
	 NKxRbShrMMB5aYsbTUje8ZSG6d9yytjbOc26bwVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFUQTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D4E208C3;
        Fri, 21 Jun 2019 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133953;
        bh=dR+sQyPZpvOsY7vM6jG36NBwA1jf68h3ITQR18BAeSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DElU5oT7/BaMJxyrFQKHbYizVL7T9PLL5w5A0AmhPdUb8ByEAJos0+bDUaen4+665
         UN9XCXOO+QRslaYf5WOdajzhdeaYtx+t/bAQE0gGZqeaXqzGPaDlX3Kc9iGZ759EGv
         wH55BampWIIaaApPkTV60XRLapUvMLE03OmXoW6s=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 07/11] dt-bindings: tracing: Add ftrace binding document
Date:   Sat, 22 Jun 2019 01:19:09 +0900
Message-Id: <156113394914.28344.8750555167313878580.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding document for ftrace node.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../devicetree/bindings/tracing/ftrace.yaml        |  170 ++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tracing/ftrace.yaml

diff --git a/Documentation/devicetree/bindings/tracing/ftrace.yaml b/Documentation/devicetree/bindings/tracing/ftrace.yaml
new file mode 100644
index 000000000000..cbd7af986c38
--- /dev/null
+++ b/Documentation/devicetree/bindings/tracing/ftrace.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/tracing/ftrace.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Ftrace setting devicetree binding
+
+maintainers:
+  - Masami Hiramatsu <mhiramat@kernel.org>
+
+description: |
+  Boot-time ftrace tracing setting via devicetree. Users can use devicetree node
+  for programming ftrace boot-time tracing.
+
+properties:
+  compatible:
+    items:
+      - const: linux,ftrace
+
+  trace-clock:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string
+      - enum: [ global, local, counter, uptime, perf, mono, mono_raw, boot, ppc-tb, x86-tsc ]
+    description: Specify which clock method is used for trace-clock.
+
+  dump-on-oops:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2]
+    description: |
+      A neumerical flag to enable ftrace dump on Kernel Oops. 0 means no dump,
+      1 means dump on the origin cpu of the oops, and means dump on all cpus.
+
+  traceoff-on-warning:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: A flag to stop tracing on warning.
+
+  tp-printk:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: A flag to send tracing output to printk buffer too.
+
+  alloc-snapshot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      A flag to allocate snapshot buffer at boot. This will be required if you
+      use "snapshot" action on some events.
+
+  buffer-size-kb:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 1
+    description: |
+      The size of per-cpu tracing buffer in KByte. Note that the size must be
+      larger than page size, and total size of buffers depends on the number
+      of CPUs.
+
+  events:
+    minItems: 1
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      A string array of enabling events (including wildcard patterns).
+      See Documentation/trace/events.rst for detail.
+
+  options:
+    minItems: 1
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      A string array of trace options for ftrace to control what gets printed
+      in the trace output or manipulate the tracers.
+      See Documentation/trace/ftrace.rst#trace_options for detail.
+
+  tracer:
+    default: nop
+    $ref: /schemas/types.yaml#/definitions/string
+    description: A string of the tracer to start up.
+
+patternProperties:
+   "event[0-9a-fA-F]+$":
+     type: object
+
+     description: |
+       event-* properties are child nodes for per-event settings. It is also
+       able to define new kprobe events and synthetic events. Note that you
+       can not define both "probes" and "fields" properties on same event.
+
+     properties:
+       event:
+         $ref: /schemas/types.yaml#/definitions/string
+         description: |
+           Event name string formatted as "GROUP:EVENT". For synthetic event,
+           you must use "synthetic" for group name. For kprobe and synthetic
+           event, you can ommit the group name.
+
+       probes:
+         minItems: 1
+         $ref: /schemas/types.yaml#/definitions/string-array
+         description: |
+           A string array of kprobe event definitions, including location
+           (symbol+offset) and event arguments.
+           See Documentation/trace/kprobetrace.rst for detail.
+
+       fields:
+         minItems: 1
+         $ref: /schemas/types.yaml#/definitions/string-array
+         description: |
+           A string of synthetic event's fields definition. Note that you
+           don't need to repeat event name.
+
+       filter:
+         $ref: /schemas/types.yaml#/definitions/string
+         description: A string of event filter rule
+
+       actions:
+         minItems: 1
+         $ref: /schemas/types.yaml#/definitions/string-array
+         description: A string array of event trigger actions.
+
+       enable:
+         type: boolean
+         description: |
+           A flag to enable event. Note that the event is not enabled by
+           default. (But actions will set the event soft-disabled)
+
+     oneOf:
+       - required:
+         - event
+       - required:
+         - event
+         - probes
+       - required:
+         - event
+         - fields
+
+required:
+  - compatible
+
+examples:
+  - |
+    ftrace {
+          compatible = "linux,ftrace";
+          events = "initcall:*";
+          tp-printk;
+          buffer-size-kb = <0x400>;
+          event0 {
+                event = "task:task_newtask";
+                filter = "pid < 128";
+                enable;
+          };
+          event1 {
+                event = "kprobes:vfs_read";
+                probes = "vfs_read $arg1 $arg2";
+                filter = "common_pid < 200";
+          };
+          event2 {
+                event = "initcall_latency";
+                fields = "unsigned long func", "u64 lat";
+                actions = "hist:keys=func.sym,lat:vals=lat:sort=lat";
+          };
+          event3 {
+                event = "initcall:initcall_start";
+                actions = "hist:keys=func:ts0=common_timestamp.usecs";
+          };
+          event4 {
+                event = "initcall:initcall_finish";
+                actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)";
+          };
+
+    };

