Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77835C76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F4B20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 03:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfGPDIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 23:08:12 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:46754 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfGPDIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:08:11 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 6A39F8A7F9E7858D8137;
        Tue, 16 Jul 2019 11:08:08 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6G37mQK057592;
        Tue, 16 Jul 2019 11:07:48 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071611075612-2367600 ;
          Tue, 16 Jul 2019 11:07:56 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr
Subject: [PATCH v3] coccinelle: semantic code search for missing of_node_put
Date:   Tue, 16 Jul 2019 11:05:47 +0800
Message-Id: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-16 11:07:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-16 11:07:51,
        Serialize complete at 2019-07-16 11:07:51
X-MAIL: mse-fl2.zte.com.cn x6G37mQK057592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are functions which increment a reference counter for a device node.
These functions belong to a programming interface for the management
of information from device trees.
The counter must be decremented after the last usage of a device node.
We find these functions by using the following script:

<SmPL>
@initialize:ocaml@
@@

let relevant_str = "use of_node_put() on it when done"

let contains s1 s2 =
    let re = Str.regexp_string s2
    in
        try ignore (Str.search_forward re s1 0); true
        with Not_found -> false

let relevant_functions = ref []

let add_function f c =
    if not (List.mem f !relevant_functions)
    then
      begin
        let s = String.concat " "
          (
            (List.map String.lowercase_ascii
              (List.filter
                (function x ->
                  Str.string_match
                  (Str.regexp "[a-zA-Z_\\(\\)][-a-zA-Z0-9_\\(\\)]*$")
                x 0) (Str.split (Str.regexp "[ .;\t\n]+") c)))) in
             if contains s relevant_str
             then
               Printf.printf "Found relevant function: %s\n" f;
               relevant_functions := f :: !relevant_functions;
      end

@r@
identifier fn;
comments c;
type T = struct device_node *;
@@

T@c fn(...) {
...
}

@script:ocaml@
f << r.fn;
c << r.c;
@@

let (cb,cm,ca) = List.hd c in
let c = String.concat " " cb in
add_function f c
</SmPL>

Then copy the function names found by the above script to the r_miss_put
rule. This rule checks for missing of_node_put.

And this patch also looks for places where an of_node_put() call is on some
paths but not on others (implemented by the r_miss_put_ext rule).

Finally, this patch finds use-after-free issues for a node.
(implemented by the r_use_after_put rule)

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@systeme.lip6.fr
---
v3: delete the global set, add a rule that checks for use-after-free.
v2: improve the commit description and delete duplicate code.

 scripts/coccinelle/free/of_node_put.cocci | 192 ++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100644 scripts/coccinelle/free/of_node_put.cocci

diff --git a/scripts/coccinelle/free/of_node_put.cocci b/scripts/coccinelle/free/of_node_put.cocci
new file mode 100644
index 0000000..cda43fa
--- /dev/null
+++ b/scripts/coccinelle/free/of_node_put.cocci
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Find missing of_node_put
+///
+// Confidence: Moderate
+// Copyright: (C) 2018-2019 Wen Yang, ZTE.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@initialize:python@
+@@
+
+report_miss_prefix = "ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line "
+report_miss_suffix = ", but without a corresponding object release within this function."
+org_miss_main = "acquired a node pointer with refcount incremented"
+org_miss_sec = "needed of_node_put"
+report_use_after_put = "ERROR: use-after-free; reference preceded by of_node_put on line "
+org_use_after_put_main = "of_node_put"
+org_use_after_put_sec = "reference"
+
+@r_miss_put exists@
+local idexpression struct device_node *x;
+expression e, e1;
+position p1, p2;
+statement S;
+type T, T1;
+@@
+
+* x = @p1\(of_find_all_nodes\|
+         of_get_cpu_node\|
+         of_get_parent\|
+         of_get_next_parent\|
+         of_get_next_child\|
+         of_get_next_cpu_node\|
+         of_get_compatible_child\|
+         of_get_child_by_name\|
+         of_find_node_opts_by_path\|
+         of_find_node_by_name\|
+         of_find_node_by_type\|
+         of_find_compatible_node\|
+         of_find_node_with_property\|
+         of_find_matching_node_and_match\|
+         of_find_node_by_phandle\|
+         of_parse_phandle\|
+         of_find_next_cache_node\|
+         of_get_next_available_child\)(...);
+...
+if (x == NULL || ...) S
+... when != e = (T)x
+    when != of_node_put(x)
+    when != of_get_next_parent(x)
+    when != of_find_matching_node(x, ...)
+    when != if (x) { ... return x; }
+    when != v4l2_async_notifier_add_fwnode_subdev(..., <+...x...+>, ...)
+    when != e1 = of_fwnode_handle(x)
+(
+ if (x) { ... when forall
+         of_node_put(x) ... }
+|
+ return (T1)x;
+|
+ return of_fwnode_handle(x);
+|
+* return@p2 ...;
+)
+
+@script:python depends on report && r_miss_put@
+p1 << r_miss_put.p1;
+p2 << r_miss_put.p2;
+@@
+
+coccilib.report.print_report(p2[0], report_miss_prefix + p1[0].line + report_miss_suffix)
+
+@script:python depends on org && r_miss_put@
+p1 << r_miss_put.p1;
+p2 << r_miss_put.p2;
+@@
+
+cocci.print_main(org_miss_main, p1)
+cocci.print_secs(org_miss_sec, p2)
+
+@r_miss_put_ext exists@
+local idexpression struct device_node *x;
+expression e, e1;
+position p1 != r_miss_put.p1, p2 != r_miss_put.p2;
+identifier f;
+statement S;
+type T, T1;
+@@
+
+(
+* x = f@p1(...);
+... when != e = (T)x
+    when != true x == NULL
+    when != of_node_put(x)
+    when != of_get_next_parent(x)
+    when != of_find_matching_node(x, ...)
+    when != if (x) { ... return x; }
+    when != v4l2_async_notifier_add_fwnode_subdev(..., <+...x...+>, ...)
+    when != e1 = of_fwnode_handle(x)
+(
+ if (x) { ... when forall
+         of_node_put(x) ... }
+|
+ return (T1)x;
+|
+ return of_fwnode_handle(x);
+|
+* return@p2 ...;
+)
+&
+x = f(...)
+...
+if (<+...x...+>) S
+...
+of_node_put(x);
+)
+
+@script:python depends on report && r_miss_put_ext@
+p1 << r_miss_put_ext.p1;
+p2 << r_miss_put_ext.p2;
+@@
+
+coccilib.report.print_report(p2[0], report_miss_prefix + p1[0].line + report_miss_suffix)
+
+@script:python depends on org && r_miss_put_ext@
+p1 << r_miss_put_ext.p1;
+p2 << r_miss_put_ext.p2;
+@@
+cocci.print_main(org_miss_main, p1)
+cocci.print_secs(org_miss_sec, p2)
+
+@r_put@
+expression E;
+position p1;
+@@
+
+* of_node_put@p1(E)
+
+@r_use_after_put exists@
+expression r_put.E, subE<=r_put.E;
+constant char [] c;
+expression E1;
+iterator iter;
+identifier f;
+statement S;
+type T;
+position r_put.p1, p2;
+@@
+
+* of_node_put@p1(E,...)
+...
+(
+  iter(...,subE,...) S
+|
+ subE = (T)E1
+|
+ &(T)subE
+|
+ f(...,c,...,(T)E,...)
+|
+ E == (T)E1
+|
+ E != (T)E1
+|
+ E1 == (T)E
+|
+ E1 != (T)E
+|
+ !E
+|
+ (T)E || ...
+|
+* (T)E@p2
+)
+
+@script:python depends on r_use_after_put && report@
+p1 << r_put.p1;
+p2 << r_use_after_put.p2;
+@@
+
+coccilib.report.print_report(p2[0], report_use_after_put + p1[0].line)
+
+@script:python depends on r_use_after_put && org@
+p1 << r_put.p1;
+p2 << r_use_after_put.p2;
+@@
+
+cocci.print_main(org_use_after_put_main, p1)
+cocci.print_secs(org_use_after_put_sec, p2)
-- 
2.9.5

