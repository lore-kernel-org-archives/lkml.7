Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E9321734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552891464;
	bh=Kc+YwceEiYyGS4ZOSSE3BO1AFawJ0vr2GBRfKfzfVR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xwr8ha3/DW+ojhdzylVu5u6z6ZZ11TGAnCsuRiTMzAvRGukV6kc5ZeYOg2qbMR6MM
	 Z63/3n56Izebo+0184UrwJPRi90lbqZa0uqtGONLsTe7jmf2xhh0VZDHk9+Hh0liBF
	 smcblA3lJieuxJaLzhcnwKvw2WXEXS2B2LMTPiwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfCRGoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfCRGoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:44:22 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91D520643;
        Mon, 18 Mar 2019 06:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552891460;
        bh=Kc+YwceEiYyGS4ZOSSE3BO1AFawJ0vr2GBRfKfzfVR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2R8JrUBhzVN8YGjOYHJHPIhxCooSVlV77X2XUvTWBrGAMVPvtrCKPXnujXmAm4yX
         M8uVwZBY1UuxwIUFKDZZKLMVqG2iua5LGMqBWf/FeFsR/8H9Deez3m6RuI/hyU5Zy3
         E12GkY7ZWkcWNKxlcDGHsU/Wt2Fdz65PtqcJ3LBY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [RFC PATCH v6 6/6] perf-probe: Add user memory access attribute support
Date:   Mon, 18 Mar 2019 15:44:14 +0900
Message-Id: <155289145457.7218.6429478717507811817.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155289137555.7218.9282784065958321058.stgit@devnote2>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/Documentation/perf-probe.txt |    3 ++-
 tools/perf/util/probe-event.c           |   11 +++++++++++
 tools/perf/util/probe-event.h           |    2 ++
 tools/perf/util/probe-file.c            |    7 +++++++
 tools/perf/util/probe-file.h            |    1 +
 tools/perf/util/probe-finder.c          |   19 ++++++++++++-------
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
index a1b8d9649ca7..845109aad686 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1575,6 +1575,17 @@ static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
 		str = tmp + 1;
 	}
 
+	tmp = strchr(str, '@');
+	if (tmp && tmp != str && strcmp(tmp + 1, "user")) { /* user attr */
+		if (!user_access_is_supported()) {
+			semantic_error("ftrace does not support user access\n");
+			return -EINVAL;
+		}
+		*tmp = '\0';
+		arg->user = true;
+		pr_debug("user ");
+	}
+
 	tmp = strchr(str, ':');
 	if (tmp) {	/* Type setting */
 		*tmp = '\0';
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 05c8d571a901..155f8741b32e 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -37,6 +37,7 @@ struct probe_trace_point {
 struct probe_trace_arg_ref {
 	struct probe_trace_arg_ref	*next;	/* Next reference */
 	long				offset;	/* Offset value */
+	bool				user;	/* User-memory access */
 };
 
 /* kprobe-tracer and uprobe-tracer tracing argument */
@@ -82,6 +83,7 @@ struct perf_probe_arg {
 	char				*var;	/* Variable name */
 	char				*type;	/* Type name */
 	struct perf_probe_arg_field	*field;	/* Structure fields */
+	bool				user;	/* User-memory */
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
index c37fbef1711d..390a69dd0887 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -294,7 +294,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 
 static int convert_variable_type(Dwarf_Die *vr_die,
 				 struct probe_trace_arg *tvar,
-				 const char *cast)
+				 const char *cast, bool user)
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
+			(*ref_ptr)->user = user;
 		}
 		if (!die_compare_name(&type, "char") &&
 		    !die_compare_name(&type, "unsigned char")) {
@@ -411,7 +413,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 				    struct perf_probe_arg_field *field,
 				    struct probe_trace_arg_ref **ref_ptr,
-				    Dwarf_Die *die_mem)
+				    Dwarf_Die *die_mem, bool user)
 {
 	struct probe_trace_arg_ref *ref = *ref_ptr;
 	Dwarf_Die type;
@@ -448,6 +450,7 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 				*ref_ptr = ref;
 		}
 		ref->offset += dwarf_bytesize(&type) * field->index;
+		ref->user = user;
 		goto next;
 	} else if (tag == DW_TAG_pointer_type) {
 		/* Check the pointer and dereference */
@@ -519,17 +522,18 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		}
 	}
 	ref->offset += (long)offs;
+	ref->user = user;
 
 	/* If this member is unnamed, we need to reuse this field */
 	if (!dwarf_diename(die_mem))
 		return convert_variable_fields(die_mem, varname, field,
-						&ref, die_mem);
+						&ref, die_mem, user);
 
 next:
 	/* Converting next field */
 	if (field->next)
 		return convert_variable_fields(die_mem, field->name,
-					field->next, &ref, die_mem);
+					field->next, &ref, die_mem, user);
 	else
 		return 0;
 }
@@ -555,11 +559,12 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 	else if (ret == 0 && pf->pvar->field) {
 		ret = convert_variable_fields(vr_die, pf->pvar->var,
 					      pf->pvar->field, &pf->tvar->ref,
-					      &die_mem);
+					      &die_mem, pf->pvar->user);
 		vr_die = &die_mem;
 	}
 	if (ret == 0)
-		ret = convert_variable_type(vr_die, pf->tvar, pf->pvar->type);
+		ret = convert_variable_type(vr_die, pf->tvar, pf->pvar->type,
+					    pf->pvar->user);
 	/* *expr will be cached in libdw. Don't free it. */
 	return ret;
 }

