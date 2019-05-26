Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D7EC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918F2175B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfEZTTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfEZTSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB1E21744;
        Sun, 26 May 2019 19:18:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfP-0004b2-Ot; Sun, 26 May 2019 15:18:47 -0400
Message-Id: <20190526191847.658663935@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 08/16] perf-probe: Add user memory access attribute support
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add user memory access attribute for kprobe event arguments.
If a given 'local variable' is in user-space, User can
specify memory access method by '@user' suffix. This is
not only for string but also for data structure.

If we access a field of data structure in user memory from
kernel on some arch, it will fail. e.g.

 perf probe -a "sched_setscheduler param->sched_priority"

This will fail to access the "param->sched_priority" because
the param is __user pointer. Instead, we can now specify
@user suffix for such argument.

 perf probe -a "sched_setscheduler param->sched_priority@user"

Note that kernel memory access with "@user" must always fail
on any arch.

Link: http://lkml.kernel.org/r/155789874562.26965.10836126971405890891.stgit@devnote2

Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/perf/Documentation/perf-probe.txt |  3 ++-
 tools/perf/util/probe-event.c           | 11 +++++++++++
 tools/perf/util/probe-event.h           |  2 ++
 tools/perf/util/probe-file.c            |  7 +++++++
 tools/perf/util/probe-file.h            |  1 +
 tools/perf/util/probe-finder.c          | 19 ++++++++++++-------
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index b6866a05edd2..ed3ecfa422e1 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -194,12 +194,13 @@ PROBE ARGUMENT
 --------------
 Each probe argument follows below syntax.
 
- [NAME=]LOCALVAR|$retval|%REG|@SYMBOL[:TYPE]
+ [NAME=]LOCALVAR|$retval|%REG|@SYMBOL[:TYPE][@user]
 
 'NAME' specifies the name of this argument (optional). You can use the name of local variable, local data structure member (e.g. var->field, var.field2), local array with fixed index (e.g. array[1], var->array[0], var->pointer[2]), or kprobe-tracer argument format (e.g. $retval, %ax, etc). Note that the name of this argument will be set as the last member name if you specify a local data structure member (e.g. field2 for 'var->field1.field2'.)
 '$vars' and '$params' special arguments are also available for NAME, '$vars' is expanded to the local variables (including function parameters) which can access at given probe point. '$params' is expanded to only the function parameters.
 'TYPE' casts the type of this argument (optional). If omitted, perf probe automatically set the type based on debuginfo (*). Currently, basic types (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal integers (x/x8/x16/x32/x64), signedness casting (u/s), "string" and bitfield are supported. (see TYPES for detail)
 On x86 systems %REG is always the short form of the register: for example %AX. %RAX or %EAX is not valid.
+"@user" is a special attribute which means the LOCALVAR will be treated as a user-space memory. This is only valid for kprobe event.
 
 TYPES
 -----
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 198e09ff611e..a7ca17be5fc5 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1577,6 +1577,17 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
 		str = tmp + 1;
 	}
 
+	tmp = strchr(str, '@');
+	if (tmp && tmp != str && strcmp(tmp + 1, "user")) { /* user attr */
+		if (!user_access_is_supported()) {
+			semantic_error("ftrace does not support user access\n");
+			return -EINVAL;
+		}
+		*tmp = '\0';
+		arg->user_access = true;
+		pr_debug("user_access ");
+	}
+
 	tmp = strchr(str, ':');
 	if (tmp) {	/* Type setting */
 		*tmp = '\0';
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 05c8d571a901..96a319cd2378 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -37,6 +37,7 @@ struct probe_trace_point {
 struct probe_trace_arg_ref {
 	struct probe_trace_arg_ref	*next;	/* Next reference */
 	long				offset;	/* Offset value */
+	bool				user_access;	/* User-memory access */
 };
 
 /* kprobe-tracer and uprobe-tracer tracing argument */
@@ -82,6 +83,7 @@ struct perf_probe_arg {
 	char				*var;	/* Variable name */
 	char				*type;	/* Type name */
 	struct perf_probe_arg_field	*field;	/* Structure fields */
+	bool				user_access;	/* User-memory access */
 };
 
 /* Perf probe probing event (point + arg) */
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 4062bc4412a9..89ce1a9c3798 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -1015,6 +1015,7 @@ enum ftrace_readme {
 	FTRACE_README_PROBE_TYPE_X = 0,
 	FTRACE_README_KRETPROBE_OFFSET,
 	FTRACE_README_UPROBE_REF_CTR,
+	FTRACE_README_USER_ACCESS,
 	FTRACE_README_END,
 };
 
@@ -1027,6 +1028,7 @@ static struct {
 	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
 	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
 	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
+	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -1087,3 +1089,8 @@ bool uprobe_ref_ctr_is_supported(void)
 {
 	return scan_ftrace_readme(FTRACE_README_UPROBE_REF_CTR);
 }
+
+bool user_access_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_USER_ACCESS);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 2a249182f2a6..986c1c94f64f 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -70,6 +70,7 @@ int probe_cache__show_all_caches(struct strfilter *filter);
 bool probe_type_is_available(enum probe_type type);
 bool kretprobe_offset_is_supported(void);
 bool uprobe_ref_ctr_is_supported(void);
+bool user_access_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c37fbef1711d..c202027716d0 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -294,7 +294,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 
 static int convert_variable_type(Dwarf_Die *vr_die,
 				 struct probe_trace_arg *tvar,
-				 const char *cast)
+				 const char *cast, bool user_access)
 {
 	struct probe_trace_arg_ref **ref_ptr = &tvar->ref;
 	Dwarf_Die type;
@@ -334,7 +334,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	pr_debug("%s type is %s.\n",
 		 dwarf_diename(vr_die), dwarf_diename(&type));
 
-	if (cast && strcmp(cast, "string") == 0) {	/* String type */
+	if (cast && (!strcmp(cast, "string") || !strcmp(cast, "ustring"))) {
+		/* String type */
 		ret = dwarf_tag(&type);
 		if (ret != DW_TAG_pointer_type &&
 		    ret != DW_TAG_array_type) {
@@ -357,6 +358,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 				pr_warning("Out of memory error\n");
 				return -ENOMEM;
 			}
+			(*ref_ptr)->user_access = user_access;
 		}
 		if (!die_compare_name(&type, "char") &&
 		    !die_compare_name(&type, "unsigned char")) {
@@ -411,7 +413,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 				    struct perf_probe_arg_field *field,
 				    struct probe_trace_arg_ref **ref_ptr,
-				    Dwarf_Die *die_mem)
+				    Dwarf_Die *die_mem, bool user_access)
 {
 	struct probe_trace_arg_ref *ref = *ref_ptr;
 	Dwarf_Die type;
@@ -448,6 +450,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 				*ref_ptr = ref;
 		}
 		ref->offset += dwarf_bytesize(&type) * field->index;
+		ref->user_access = user_access;
 		goto next;
 	} else if (tag == DW_TAG_pointer_type) {
 		/* Check the pointer and dereference */
@@ -519,17 +522,18 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		}
 	}
 	ref->offset += (long)offs;
+	ref->user_access = user_access;
 
 	/* If this member is unnamed, we need to reuse this field */
 	if (!dwarf_diename(die_mem))
 		return convert_variable_fields(die_mem, varname, field,
-						&ref, die_mem);
+						&ref, die_mem, user_access);
 
 next:
 	/* Converting next field */
 	if (field->next)
 		return convert_variable_fields(die_mem, field->name,
-					field->next, &ref, die_mem);
+				field->next, &ref, die_mem, user_access);
 	else
 		return 0;
 }
@@ -555,11 +559,12 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 	else if (ret == 0 && pf->pvar->field) {
 		ret = convert_variable_fields(vr_die, pf->pvar->var,
 					      pf->pvar->field, &pf->tvar->ref,
-					      &die_mem);
+					      &die_mem, pf->pvar->user_access);
 		vr_die = &die_mem;
 	}
 	if (ret == 0)
-		ret = convert_variable_type(vr_die, pf->tvar, pf->pvar->type);
+		ret = convert_variable_type(vr_die, pf->tvar, pf->pvar->type,
+					    pf->pvar->user_access);
 	/* *expr will be cached in libdw. Don't free it. */
 	return ret;
 }
-- 
2.20.1


