Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B46C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECED424679
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326865;
	bh=nu1jE/H7rHT2fpp8aNOGuD3LPxmkTi476iyaTxukteI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOuAYDlHaIeD+fcId6fVbY85uQH3jmTJ+Ihiq2mJQeR5khs/4WkYARTE6qMMsU2YV
	 hP1P/Bo6G3gqTU89H14anV1ngQCUzvbgtANG/biIBBK7S1ihRtcMbpFsopjDHDFckj
	 0KVKCig0duac6VRSWj6C64GAqrRJc2RBy2D8EKT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgAFQHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgAFQHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:41 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B1721744;
        Mon,  6 Jan 2020 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326860;
        bh=nu1jE/H7rHT2fpp8aNOGuD3LPxmkTi476iyaTxukteI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4B9hXCgAhn7tIs4eciLEhhx/vItzMsWsf/SaMcyu5Qd41k9qFVh5XEUizukU48Zj
         NSs3e5DV5GyjUzYSxu31WFZXw85VHa6CB7B+YAijsUMtKzdfLTLfqaG85sQAxJAHMA
         PWdEOlnoshqan0Pn+3WRB758qzs5JVyfHJ1H6nOc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/20] libperf: Add man pages
Date:   Mon,  6 Jan 2020 13:06:52 -0300
Message-Id: <20200106160705.10899-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Change the man page generation to asciidoc, because it's easier to use
and has been more commonly used in related projects. Remove the current
rst pages.

Add 3 man pages to have a base for more additions:

  libperf.3          - overall description
  libperf-counting.7 - counting basics explained on simple example
  libperf-sampling.7 - sampling basics explained on simple example

The plan is to add more man pages to cover the basic API.

The build generates html and man pages:

  $ cd tools/lib/perf/Documentation
  $ make
    ASCIIDOC libperf.xml
    XMLTO    libperf.3
    ASCIIDOC libperf-counting.xml
    XMLTO    libperf-counting.7
    ASCIIDOC libperf-sampling.xml
    XMLTO    libperf-sampling.7
    ASCIIDOC libperf.html
    ASCIIDOC libperf-counting.html
    ASCIIDOC libperf-sampling.html

Add the following install targets:

   install-man      - man pages
   install-html     - html version of man pages
   install-examples - examples mentioned in the man pages

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191206210612.8676-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/Documentation/Makefile         | 159 ++++++++++-
 tools/lib/perf/Documentation/asciidoc.conf    | 120 +++++++++
 .../perf/Documentation/examples/sampling.c    | 119 +++++++++
 .../perf/Documentation/libperf-counting.txt   | 211 +++++++++++++++
 .../perf/Documentation/libperf-sampling.txt   | 243 +++++++++++++++++
 tools/lib/perf/Documentation/libperf.txt      | 246 ++++++++++++++++++
 tools/lib/perf/Documentation/man/libperf.rst  | 100 -------
 tools/lib/perf/Documentation/manpage-1.72.xsl |  14 +
 tools/lib/perf/Documentation/manpage-base.xsl |  35 +++
 .../Documentation/manpage-bold-literal.xsl    |  17 ++
 .../lib/perf/Documentation/manpage-normal.xsl |  13 +
 .../Documentation/manpage-suppress-sp.xsl     |  21 ++
 .../perf/Documentation/tutorial/tutorial.rst  | 123 ---------
 tools/lib/perf/Makefile                       |   5 +-
 14 files changed, 1197 insertions(+), 229 deletions(-)
 create mode 100644 tools/lib/perf/Documentation/asciidoc.conf
 create mode 100644 tools/lib/perf/Documentation/examples/sampling.c
 create mode 100644 tools/lib/perf/Documentation/libperf-counting.txt
 create mode 100644 tools/lib/perf/Documentation/libperf-sampling.txt
 create mode 100644 tools/lib/perf/Documentation/libperf.txt
 delete mode 100644 tools/lib/perf/Documentation/man/libperf.rst
 create mode 100644 tools/lib/perf/Documentation/manpage-1.72.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-base.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-bold-literal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-normal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-suppress-sp.xsl
 delete mode 100644 tools/lib/perf/Documentation/tutorial/tutorial.rst

diff --git a/tools/lib/perf/Documentation/Makefile b/tools/lib/perf/Documentation/Makefile
index 586425a88795..972754082a85 100644
--- a/tools/lib/perf/Documentation/Makefile
+++ b/tools/lib/perf/Documentation/Makefile
@@ -1,7 +1,156 @@
-all:
-	rst2man man/libperf.rst > man/libperf.7
-	rst2pdf tutorial/tutorial.rst
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Most of this file is copied from tools/perf/Documentation/Makefile
+
+include ../../../scripts/Makefile.include
+include ../../../scripts/utilities.mak
+
+MAN3_TXT  = libperf.txt
+MAN7_TXT  = libperf-counting.txt libperf-sampling.txt
+MAN_EX    = examples/*.c
+
+MAN_TXT   = $(MAN3_TXT) $(MAN7_TXT)
+
+_MAN_XML  = $(patsubst %.txt,%.xml,$(MAN_TXT))
+_MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
+_MAN_3    = $(patsubst %.txt,%.3,$(MAN3_TXT))
+_MAN_7    = $(patsubst %.txt,%.7,$(MAN7_TXT))
+
+MAN_XML   = $(addprefix $(OUTPUT),$(_MAN_XML))
+MAN_HTML  = $(addprefix $(OUTPUT),$(_MAN_HTML))
+MAN_3     = $(addprefix $(OUTPUT),$(_MAN_3))
+MAN_7     = $(addprefix $(OUTPUT),$(_MAN_7))
+MAN_X     = $(MAN_3) $(MAN_7)
+
+# Make the path relative to DESTDIR, not prefix
+ifndef DESTDIR
+  prefix ?=$(HOME)
+endif
+
+mandir  ?= $(prefix)/share/man
+man3dir  = $(mandir)/man3
+man7dir  = $(mandir)/man7
+
+docdir  ?= $(prefix)/share/doc/libperf
+htmldir  = $(docdir)/html
+exdir    = $(docdir)/examples
+
+ASCIIDOC        = asciidoc
+ASCIIDOC_EXTRA  = --unsafe -f asciidoc.conf
+ASCIIDOC_HTML   = xhtml11
+MANPAGE_XSL     = manpage-normal.xsl
+XMLTO_EXTRA     =
+XMLTO           =xmlto
+
+INSTALL ?= install
+RM      ?= rm -f
+
+# For asciidoc ...
+#	-7.1.2,	no extra settings are needed.
+#	8.0-,	set ASCIIDOC8.
+#
+
+# For docbook-xsl ...
+#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
+#	1.69.0,		no extra settings are needed?
+#	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
+#	1.71.1,		no extra settings are needed?
+#	1.72.0,		set DOCBOOK_XSL_172.
+#	1.73.0-,	set ASCIIDOC_NO_ROFF
+
+# If you had been using DOCBOOK_XSL_172 in an attempt to get rid
+# of 'the ".ft C" problem' in your generated manpages, and you
+# instead ended up with weird characters around callouts, try
+# using ASCIIDOC_NO_ROFF instead (it works fine with ASCIIDOC8).
+
+ifdef ASCIIDOC8
+  ASCIIDOC_EXTRA += -a asciidoc7compatible
+endif
+ifdef DOCBOOK_XSL_172
+  ASCIIDOC_EXTRA += -a libperf-asciidoc-no-roff
+  MANPAGE_XSL = manpage-1.72.xsl
+else
+  ifdef ASCIIDOC_NO_ROFF
+    # docbook-xsl after 1.72 needs the regular XSL, but will not
+    # pass-thru raw roff codes from asciidoc.conf, so turn them off.
+    ASCIIDOC_EXTRA += -a libperf-asciidoc-no-roff
+  endif
+endif
+ifdef MAN_BOLD_LITERAL
+  XMLTO_EXTRA += -m manpage-bold-literal.xsl
+endif
+ifdef DOCBOOK_SUPPRESS_SP
+  XMLTO_EXTRA += -m manpage-suppress-sp.xsl
+endif
+
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+export DESTDIR DESTDIR_SQ
+
+# Please note that there is a minor bug in asciidoc.
+# The version after 6.0.3 _will_ include the patch found here:
+#   http://marc.theaimsgroup.com/?l=libtraceevent&m=111558757202243&w=2
+#
+# Until that version is released you may have to apply the patch
+# yourself - yes, all 6 characters of it!
+
+QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1  =
+
+ifneq ($(findstring $(MAKEFLAGS),w),w)
+  PRINT_DIR = --no-print-directory
+else # "make -w"
+  NO_SUBDIR = :
+endif
+
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+  ifneq ($(V),1)
+    QUIET_ASCIIDOC = @echo '  ASCIIDOC '$@;
+    QUIET_XMLTO    = @echo '  XMLTO    '$@;
+  endif
+endif
+
+all: $(MAN_X) $(MAN_HTML)
+
+$(MAN_HTML) $(MAN_X): asciidoc.conf
+
+install-man: all
+	$(call QUIET_INSTALL, man) \
+		$(INSTALL) -d -m 755 $(DESTDIR)$(man3dir); \
+		$(INSTALL) -m 644 $(MAN_3) $(DESTDIR)$(man3dir); \
+		$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir); \
+		$(INSTALL) -m 644 $(MAN_7) $(DESTDIR)$(man7dir);
+
+install-html:
+	$(call QUIET_INSTALL, html) \
+		$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir); \
+		$(INSTALL) -m 644 $(MAN_HTML) $(DESTDIR)$(htmldir); \
+
+install-examples:
+	$(call QUIET_INSTALL, examples) \
+		$(INSTALL) -d -m 755 $(DESTDIR)$(exdir); \
+		$(INSTALL) -m 644 $(MAN_EX) $(DESTDIR)$(exdir); \
+
+CLEAN_FILES =					\
+	$(MAN_XML) $(addsuffix +,$(MAN_XML))	\
+	$(MAN_HTML) $(addsuffix +,$(MAN_HTML))	\
+	$(MAN_X)
 
 clean:
-	rm -f man/libperf.7
-	rm -f tutorial/tutorial.pdf
+	$(call QUIET_CLEAN, Documentation) $(RM) $(CLEAN_FILES)
+
+$(MAN_3): $(OUTPUT)%.3: %.xml
+	$(QUIET_XMLTO)$(XMLTO) -o $(OUTPUT). -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+
+$(MAN_7): $(OUTPUT)%.7: %.xml
+	$(QUIET_XMLTO)$(XMLTO) -o $(OUTPUT). -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+
+$(MAN_XML): $(OUTPUT)%.xml: %.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b docbook -d manpage \
+		$(ASCIIDOC_EXTRA) -alibperf_version=$(EVENT_PARSE_VERSION) -o $@+ $< && \
+	mv $@+ $@
+
+$(MAN_HTML): $(OUTPUT)%.html: %.txt
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage \
+	$(ASCIIDOC_EXTRA) -aperf_version=$(EVENT_PARSE_VERSION) -o $@+ $< && \
+	mv $@+ $@
diff --git a/tools/lib/perf/Documentation/asciidoc.conf b/tools/lib/perf/Documentation/asciidoc.conf
new file mode 100644
index 000000000000..9d5a5a5ee091
--- /dev/null
+++ b/tools/lib/perf/Documentation/asciidoc.conf
@@ -0,0 +1,120 @@
+## linktep: macro
+#
+# Usage: linktep:command[manpage-section]
+#
+# Note, {0} is the manpage section, while {target} is the command.
+#
+# Show TEP link as: <command>(<section>); if section is defined, else just show
+# the command.
+
+[macros]
+(?su)[\\]?(?P<name>linktep):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
+
+[attributes]
+asterisk=&#42;
+plus=&#43;
+caret=&#94;
+startsb=&#91;
+endsb=&#93;
+tilde=&#126;
+
+ifdef::backend-docbook[]
+[linktep-inlinemacro]
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
+endif::backend-docbook[]
+
+ifdef::backend-docbook[]
+ifndef::tep-asciidoc-no-roff[]
+# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
+# v1.72 breaks with this because it replaces dots not in roff requests.
+[listingblock]
+<example><title>{title}</title>
+<literallayout>
+ifdef::doctype-manpage[]
+&#10;.ft C&#10;
+endif::doctype-manpage[]
+|
+ifdef::doctype-manpage[]
+&#10;.ft&#10;
+endif::doctype-manpage[]
+</literallayout>
+{title#}</example>
+endif::tep-asciidoc-no-roff[]
+
+ifdef::tep-asciidoc-no-roff[]
+ifdef::doctype-manpage[]
+# The following two small workarounds insert a simple paragraph after screen
+[listingblock]
+<example><title>{title}</title>
+<literallayout>
+|
+</literallayout><simpara></simpara>
+{title#}</example>
+
+[verseblock]
+<formalpara{id? id="{id}"}><title>{title}</title><para>
+{title%}<literallayout{id? id="{id}"}>
+{title#}<literallayout>
+|
+</literallayout>
+{title#}</para></formalpara>
+{title%}<simpara></simpara>
+endif::doctype-manpage[]
+endif::tep-asciidoc-no-roff[]
+endif::backend-docbook[]
+
+ifdef::doctype-manpage[]
+ifdef::backend-docbook[]
+[header]
+template::[header-declarations]
+<refentry>
+<refmeta>
+<refentrytitle>{mantitle}</refentrytitle>
+<manvolnum>{manvolnum}</manvolnum>
+<refmiscinfo class="source">libperf</refmiscinfo>
+<refmiscinfo class="version">{libperf_version}</refmiscinfo>
+<refmiscinfo class="manual">libperf Manual</refmiscinfo>
+</refmeta>
+<refnamediv>
+  <refname>{manname1}</refname>
+  <refname>{manname2}</refname>
+  <refname>{manname3}</refname>
+  <refname>{manname4}</refname>
+  <refname>{manname5}</refname>
+  <refname>{manname6}</refname>
+  <refname>{manname7}</refname>
+  <refname>{manname8}</refname>
+  <refname>{manname9}</refname>
+  <refname>{manname10}</refname>
+  <refname>{manname11}</refname>
+  <refname>{manname12}</refname>
+  <refname>{manname13}</refname>
+  <refname>{manname14}</refname>
+  <refname>{manname15}</refname>
+  <refname>{manname16}</refname>
+  <refname>{manname17}</refname>
+  <refname>{manname18}</refname>
+  <refname>{manname19}</refname>
+  <refname>{manname20}</refname>
+  <refname>{manname21}</refname>
+  <refname>{manname22}</refname>
+  <refname>{manname23}</refname>
+  <refname>{manname24}</refname>
+  <refname>{manname25}</refname>
+  <refname>{manname26}</refname>
+  <refname>{manname27}</refname>
+  <refname>{manname28}</refname>
+  <refname>{manname29}</refname>
+  <refname>{manname30}</refname>
+  <refpurpose>{manpurpose}</refpurpose>
+</refnamediv>
+endif::backend-docbook[]
+endif::doctype-manpage[]
+
+ifdef::backend-xhtml11[]
+[linktep-inlinemacro]
+<a href="{target}.html">{target}{0?({0})}</a>
+endif::backend-xhtml11[]
diff --git a/tools/lib/perf/Documentation/examples/sampling.c b/tools/lib/perf/Documentation/examples/sampling.c
new file mode 100644
index 000000000000..8e1a926a9cfe
--- /dev/null
+++ b/tools/lib/perf/Documentation/examples/sampling.c
@@ -0,0 +1,119 @@
+#include <linux/perf_event.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
+#include <perf/cpumap.h>
+#include <perf/threadmap.h>
+#include <perf/mmap.h>
+#include <perf/core.h>
+#include <perf/event.h>
+#include <stdio.h>
+#include <unistd.h>
+
+static int libperf_print(enum libperf_print_level level,
+                         const char *fmt, va_list ap)
+{
+	return vfprintf(stderr, fmt, ap);
+}
+
+union u64_swap {
+	__u64 val64;
+	__u32 val32[2];
+};
+
+int main(int argc, char **argv)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_mmap *map;
+	struct perf_cpu_map *cpus;
+	struct perf_event_attr attr = {
+		.type        = PERF_TYPE_HARDWARE,
+		.config      = PERF_COUNT_HW_CPU_CYCLES,
+		.disabled    = 1,
+		.freq        = 1,
+		.sample_freq = 10,
+		.sample_type = PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_CPU|PERF_SAMPLE_PERIOD,
+	};
+	int err = -1;
+	union perf_event *event;
+
+	libperf_init(libperf_print);
+
+	cpus = perf_cpu_map__new(NULL);
+	if (!cpus) {
+		fprintf(stderr, "failed to create cpus\n");
+		return -1;
+	}
+
+	evlist = perf_evlist__new();
+	if (!evlist) {
+		fprintf(stderr, "failed to create evlist\n");
+		goto out_cpus;
+	}
+
+	evsel = perf_evsel__new(&attr);
+	if (!evsel) {
+		fprintf(stderr, "failed to create cycles\n");
+		goto out_cpus;
+	}
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, NULL);
+
+	err = perf_evlist__open(evlist);
+	if (err) {
+		fprintf(stderr, "failed to open evlist\n");
+		goto out_evlist;
+	}
+
+	err = perf_evlist__mmap(evlist, 4);
+	if (err) {
+		fprintf(stderr, "failed to mmap evlist\n");
+		goto out_evlist;
+	}
+
+	perf_evlist__enable(evlist);
+	sleep(3);
+	perf_evlist__disable(evlist);
+
+	perf_evlist__for_each_mmap(evlist, map, false) {
+		if (perf_mmap__read_init(map) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(map)) != NULL) {
+			int cpu, pid, tid;
+			__u64 ip, period, *array;
+			union u64_swap u;
+
+			array = event->sample.array;
+
+			ip = *array;
+			array++;
+
+			u.val64 = *array;
+			pid = u.val32[0];
+			tid = u.val32[1];
+			array++;
+
+			u.val64 = *array;
+			cpu = u.val32[0];
+			array++;
+
+			period = *array;
+
+			fprintf(stdout, "cpu %3d, pid %6d, tid %6d, ip %20llx, period %20llu\n",
+				cpu, pid, tid, ip, period);
+
+			perf_mmap__consume(map);
+		}
+
+		perf_mmap__read_done(map);
+	}
+
+out_evlist:
+	perf_evlist__delete(evlist);
+out_cpus:
+	perf_cpu_map__put(cpus);
+	return err;
+}
diff --git a/tools/lib/perf/Documentation/libperf-counting.txt b/tools/lib/perf/Documentation/libperf-counting.txt
new file mode 100644
index 000000000000..cae9757f49c1
--- /dev/null
+++ b/tools/lib/perf/Documentation/libperf-counting.txt
@@ -0,0 +1,211 @@
+libperf-counting(7)
+===================
+
+NAME
+----
+libperf-counting - counting interface
+
+DESCRIPTION
+-----------
+The counting interface provides API to meassure and get count for specific perf events.
+
+The following test tries to explain count on `counting.c` example.
+
+It is by no means complete guide to counting, but shows libperf basic API for counting.
+
+The `counting.c` comes with libbperf package and can be compiled and run like:
+
+[source,bash]
+--
+$ gcc -o counting counting.c -lperf
+$ sudo ./counting
+count 176792, enabled 176944, run 176944
+count 176242, enabled 176242, run 176242
+--
+
+It requires root access, because of the `PERF_COUNT_SW_CPU_CLOCK` event,
+which is available only for root.
+
+The `counting.c` example monitors two events on the current process and displays their count, in a nutshel it:
+
+* creates events
+* adds them to the event list
+* opens and enables events through the event list
+* does some workload
+* disables events
+* reads and displays event counts
+* destroys the event list
+
+The first thing you need to do before using libperf is to call init function:
+
+[source,c]
+--
+  8 static int libperf_print(enum libperf_print_level level,
+  9                          const char *fmt, va_list ap)
+ 10 {
+ 11         return vfprintf(stderr, fmt, ap);
+ 12 }
+
+ 14 int main(int argc, char **argv)
+ 15 {
+ ...
+ 35         libperf_init(libperf_print);
+--
+
+It will setup the library and sets function for debug output from library.
+
+The `libperf_print` callback will receive any message with its debug level,
+defined as:
+
+[source,c]
+--
+enum libperf_print_level {
+        LIBPERF_ERR,
+        LIBPERF_WARN,
+        LIBPERF_INFO,
+        LIBPERF_DEBUG,
+        LIBPERF_DEBUG2,
+        LIBPERF_DEBUG3,
+};
+--
+
+Once the setup is complete we start by defining specific events using the `struct perf_event_attr`.
+
+We create software events for cpu and task:
+
+[source,c]
+--
+ 20         struct perf_event_attr attr1 = {
+ 21                 .type        = PERF_TYPE_SOFTWARE,
+ 22                 .config      = PERF_COUNT_SW_CPU_CLOCK,
+ 23                 .read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING,
+ 24                 .disabled    = 1,
+ 25         };
+ 26         struct perf_event_attr attr2 = {
+ 27                 .type        = PERF_TYPE_SOFTWARE,
+ 28                 .config      = PERF_COUNT_SW_TASK_CLOCK,
+ 29                 .read_format = PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING,
+ 30                 .disabled    = 1,
+ 31         };
+--
+
+The `read_format` setup tells perf to include timing details together with each count.
+
+Next step is to prepare threads map.
+
+In this case we will monitor current process, so we create threads map with single pid (0):
+
+[source,c]
+--
+ 37         threads = perf_thread_map__new_dummy();
+ 38         if (!threads) {
+ 39                 fprintf(stderr, "failed to create threads\n");
+ 40                 return -1;
+ 41         }
+ 42
+ 43         perf_thread_map__set_pid(threads, 0, 0);
+--
+
+Now we create libperf's event list, which will serve as holder for the events we want:
+
+[source,c]
+--
+ 45         evlist = perf_evlist__new();
+ 46         if (!evlist) {
+ 47                 fprintf(stderr, "failed to create evlist\n");
+ 48                 goto out_threads;
+ 49         }
+--
+
+We create libperf's events for the attributes we defined earlier and add them to the list:
+
+[source,c]
+--
+ 51         evsel = perf_evsel__new(&attr1);
+ 52         if (!evsel) {
+ 53                 fprintf(stderr, "failed to create evsel1\n");
+ 54                 goto out_evlist;
+ 55         }
+ 56
+ 57         perf_evlist__add(evlist, evsel);
+ 58
+ 59         evsel = perf_evsel__new(&attr2);
+ 60         if (!evsel) {
+ 61                 fprintf(stderr, "failed to create evsel2\n");
+ 62                 goto out_evlist;
+ 63         }
+ 64
+ 65         perf_evlist__add(evlist, evsel);
+--
+
+Configure event list with the thread map and open events:
+
+[source,c]
+--
+ 67         perf_evlist__set_maps(evlist, NULL, threads);
+ 68
+ 69         err = perf_evlist__open(evlist);
+ 70         if (err) {
+ 71                 fprintf(stderr, "failed to open evsel\n");
+ 72                 goto out_evlist;
+ 73         }
+--
+
+Both events are created as disabled (note the `disabled = 1` assignment above),
+so we need to enable the whole list explicitely (both events).
+
+From this moment events are counting and we can do our workload.
+
+When we are done we disable the events list.
+
+[source,c]
+--
+ 75         perf_evlist__enable(evlist);
+ 76
+ 77         while (count--);
+ 78
+ 79         perf_evlist__disable(evlist);
+--
+
+Now we need to get the counts from events, following code iterates throught the events list and read counts:
+
+[source,c]
+--
+ 81         perf_evlist__for_each_evsel(evlist, evsel) {
+ 82                 perf_evsel__read(evsel, 0, 0, &counts);
+ 83                 fprintf(stdout, "count %llu, enabled %llu, run %llu\n",
+ 84                         counts.val, counts.ena, counts.run);
+ 85         }
+--
+
+And finaly cleanup.
+
+We close the whole events list (both events) and remove it together with the threads map:
+
+[source,c]
+--
+ 87         perf_evlist__close(evlist);
+ 88
+ 89 out_evlist:
+ 90         perf_evlist__delete(evlist);
+ 91 out_threads:
+ 92         perf_thread_map__put(threads);
+ 93         return err;
+ 94 }
+--
+
+REPORTING BUGS
+--------------
+Report bugs to <linux-perf-users@vger.kernel.org>.
+
+LICENSE
+-------
+libperf is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+
+SEE ALSO
+--------
+libperf(3), libperf-sampling(7)
diff --git a/tools/lib/perf/Documentation/libperf-sampling.txt b/tools/lib/perf/Documentation/libperf-sampling.txt
new file mode 100644
index 000000000000..d71a7b4fcf5f
--- /dev/null
+++ b/tools/lib/perf/Documentation/libperf-sampling.txt
@@ -0,0 +1,243 @@
+libperf-sampling(7)
+===================
+
+NAME
+----
+libperf-sampling - sampling interface
+
+
+DESCRIPTION
+-----------
+The sampling interface provides API to meassure and get count for specific perf events.
+
+The following test tries to explain count on `sampling.c` example.
+
+It is by no means complete guide to sampling, but shows libperf basic API for sampling.
+
+The `sampling.c` comes with libbperf package and can be compiled and run like:
+
+[source,bash]
+--
+$ gcc -o sampling sampling.c -lperf
+$ sudo ./sampling
+cpu   0, pid      0, tid      0, ip     ffffffffad06c4e6, period                    1
+cpu   0, pid   4465, tid   4469, ip     ffffffffad118748, period             18322959
+cpu   0, pid      0, tid      0, ip     ffffffffad115722, period             33544846
+cpu   0, pid   4465, tid   4470, ip         7f84fe0cdad6, period             23687474
+cpu   0, pid      0, tid      0, ip     ffffffffad9e0349, period             34255790
+cpu   0, pid   4465, tid   4469, ip     ffffffffad136581, period             38664069
+cpu   0, pid      0, tid      0, ip     ffffffffad9e55e2, period             21922384
+cpu   0, pid   4465, tid   4470, ip         7f84fe0ebebf, period             17655175
+...
+--
+
+It requires root access, because it uses hardware cycles event.
+
+The `sampling.c` example profiles/samples all CPUs with hardware cycles, in a nutshel it:
+
+- creates events
+- adds them to the event list
+- opens and enables events through the event list
+- sleeps for 3 seconds
+- disables events
+- reads and displays recorded samples
+- destroys the event list
+
+The first thing you need to do before using libperf is to call init function:
+
+[source,c]
+--
+ 12 static int libperf_print(enum libperf_print_level level,
+ 13                          const char *fmt, va_list ap)
+ 14 {
+ 15         return vfprintf(stderr, fmt, ap);
+ 16 }
+
+ 23 int main(int argc, char **argv)
+ 24 {
+ ...
+ 40         libperf_init(libperf_print);
+--
+
+It will setup the library and sets function for debug output from library.
+
+The `libperf_print` callback will receive any message with its debug level,
+defined as:
+
+[source,c]
+--
+enum libperf_print_level {
+        LIBPERF_ERR,
+        LIBPERF_WARN,
+        LIBPERF_INFO,
+        LIBPERF_DEBUG,
+        LIBPERF_DEBUG2,
+        LIBPERF_DEBUG3,
+};
+--
+
+Once the setup is complete we start by defining cycles event using the `struct perf_event_attr`:
+
+[source,c]
+--
+ 29         struct perf_event_attr attr = {
+ 30                 .type        = PERF_TYPE_HARDWARE,
+ 31                 .config      = PERF_COUNT_HW_CPU_CYCLES,
+ 32                 .disabled    = 1,
+ 33                 .freq        = 1,
+ 34                 .sample_freq = 10,
+ 35                 .sample_type = PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_CPU|PERF_SAMPLE_PERIOD,
+ 36         };
+--
+
+Next step is to prepare cpus map.
+
+In this case we will monitor all the available CPUs:
+
+[source,c]
+--
+ 42         cpus = perf_cpu_map__new(NULL);
+ 43         if (!cpus) {
+ 44                 fprintf(stderr, "failed to create cpus\n");
+ 45                 return -1;
+ 46         }
+--
+
+Now we create libperf's event list, which will serve as holder for the cycles event:
+
+[source,c]
+--
+ 48         evlist = perf_evlist__new();
+ 49         if (!evlist) {
+ 50                 fprintf(stderr, "failed to create evlist\n");
+ 51                 goto out_cpus;
+ 52         }
+--
+
+We create libperf's event for the cycles attribute we defined earlier and add it to the list:
+
+[source,c]
+--
+ 54         evsel = perf_evsel__new(&attr);
+ 55         if (!evsel) {
+ 56                 fprintf(stderr, "failed to create cycles\n");
+ 57                 goto out_cpus;
+ 58         }
+ 59
+ 60         perf_evlist__add(evlist, evsel);
+--
+
+Configure event list with the cpus map and open event:
+
+[source,c]
+--
+ 62         perf_evlist__set_maps(evlist, cpus, NULL);
+ 63
+ 64         err = perf_evlist__open(evlist);
+ 65         if (err) {
+ 66                 fprintf(stderr, "failed to open evlist\n");
+ 67                 goto out_evlist;
+ 68         }
+--
+
+Once the events list is open, we can create memory maps AKA perf ring buffers:
+
+[source,c]
+--
+ 70         err = perf_evlist__mmap(evlist, 4);
+ 71         if (err) {
+ 72                 fprintf(stderr, "failed to mmap evlist\n");
+ 73                 goto out_evlist;
+ 74         }
+--
+
+The event is created as disabled (note the `disabled = 1` assignment above),
+so we need to enable the events list explicitely.
+
+From this moment the cycles event is sampling.
+
+We will sleep for 3 seconds while the ring buffers get data from all CPUs, then we disable the events list.
+
+[source,c]
+--
+ 76         perf_evlist__enable(evlist);
+ 77         sleep(3);
+ 78         perf_evlist__disable(evlist);
+--
+
+Following code walks through the ring buffers and reads stored events/samples:
+
+[source,c]
+--
+ 80         perf_evlist__for_each_mmap(evlist, map, false) {
+ 81                 if (perf_mmap__read_init(map) < 0)
+ 82                         continue;
+ 83
+ 84                 while ((event = perf_mmap__read_event(map)) != NULL) {
+
+                            /* process event */
+
+108                         perf_mmap__consume(map);
+109                 }
+110                 perf_mmap__read_done(map);
+111         }
+
+--
+
+Each sample needs to get parsed:
+
+[source,c]
+--
+ 85                         int cpu, pid, tid;
+ 86                         __u64 ip, period, *array;
+ 87                         union u64_swap u;
+ 88
+ 89                         array = event->sample.array;
+ 90
+ 91                         ip = *array;
+ 92                         array++;
+ 93
+ 94                         u.val64 = *array;
+ 95                         pid = u.val32[0];
+ 96                         tid = u.val32[1];
+ 97                         array++;
+ 98
+ 99                         u.val64 = *array;
+100                         cpu = u.val32[0];
+101                         array++;
+102
+103                         period = *array;
+104
+105                         fprintf(stdout, "cpu %3d, pid %6d, tid %6d, ip %20llx, period %20llu\n",
+106                                 cpu, pid, tid, ip, period);
+--
+
+And finaly cleanup.
+
+We close the whole events list (both events) and remove it together with the threads map:
+
+[source,c]
+--
+113 out_evlist:
+114         perf_evlist__delete(evlist);
+115 out_cpus:
+116         perf_cpu_map__put(cpus);
+117         return err;
+118 }
+--
+
+REPORTING BUGS
+--------------
+Report bugs to <linux-perf-users@vger.kernel.org>.
+
+LICENSE
+-------
+libperf is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+
+SEE ALSO
+--------
+libperf(3), libperf-counting(7)
diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
new file mode 100644
index 000000000000..5a6bb512789d
--- /dev/null
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -0,0 +1,246 @@
+libperf(3)
+==========
+
+NAME
+----
+libperf - Linux kernel perf event library
+
+
+SYNOPSIS
+--------
+*Generic API:*
+
+[source,c]
+--
+  #include <perf/core.h>
+
+  enum libperf_print_level {
+          LIBPERF_ERR,
+          LIBPERF_WARN,
+          LIBPERF_INFO,
+          LIBPERF_DEBUG,
+          LIBPERF_DEBUG2,
+          LIBPERF_DEBUG3,
+  };
+
+  typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
+                                    const char *, va_list ap);
+
+  void libperf_init(libperf_print_fn_t fn);
+--
+
+*API to handle cpu maps:*
+
+[source,c]
+--
+  #include <perf/cpumap.h>
+
+  struct perf_cpu_map;
+
+  struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+  struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
+  struct perf_cpu_map *perf_cpu_map__read(FILE *file);
+  struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
+  struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+                                           struct perf_cpu_map *other);
+  void perf_cpu_map__put(struct perf_cpu_map *map);
+  int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+  int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+  bool perf_cpu_map__empty(const struct perf_cpu_map *map);
+  int perf_cpu_map__max(struct perf_cpu_map *map);
+
+  #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+--
+
+*API to handle thread maps:*
+
+[source,c]
+--
+  #include <perf/threadmap.h>
+
+  struct perf_thread_map;
+
+  struct perf_thread_map *perf_thread_map__new_dummy(void);
+
+  void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
+  char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
+  int perf_thread_map__nr(struct perf_thread_map *threads);
+  pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
+
+  struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
+  void perf_thread_map__put(struct perf_thread_map *map);
+--
+
+*API to handle event lists:*
+
+[source,c]
+--
+  #include <perf/evlist.h>
+
+  struct perf_evlist;
+
+  void perf_evlist__add(struct perf_evlist *evlist,
+                        struct perf_evsel *evsel);
+  void perf_evlist__remove(struct perf_evlist *evlist,
+                           struct perf_evsel *evsel);
+  struct perf_evlist *perf_evlist__new(void);
+  void perf_evlist__delete(struct perf_evlist *evlist);
+  struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
+                                       struct perf_evsel *evsel);
+  int perf_evlist__open(struct perf_evlist *evlist);
+  void perf_evlist__close(struct perf_evlist *evlist);
+  void perf_evlist__enable(struct perf_evlist *evlist);
+  void perf_evlist__disable(struct perf_evlist *evlist);
+
+  #define perf_evlist__for_each_evsel(evlist, pos)
+
+  void perf_evlist__set_maps(struct perf_evlist *evlist,
+                             struct perf_cpu_map *cpus,
+                             struct perf_thread_map *threads);
+  int perf_evlist__poll(struct perf_evlist *evlist, int timeout);
+  int perf_evlist__filter_pollfd(struct perf_evlist *evlist,
+                                 short revents_and_mask);
+
+  int perf_evlist__mmap(struct perf_evlist *evlist, int pages);
+  void perf_evlist__munmap(struct perf_evlist *evlist);
+
+  struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
+                                           struct perf_mmap *map,
+                                           bool overwrite);
+
+  #define perf_evlist__for_each_mmap(evlist, pos, overwrite)
+--
+
+*API to handle events:*
+
+[source,c]
+--
+  #include <perf/evsel.h>*
+
+  struct perf_evsel;
+
+  struct perf_counts_values {
+          union {
+                  struct {
+                          uint64_t val;
+                          uint64_t ena;
+                          uint64_t run;
+                  };
+                  uint64_t values[3];
+          };
+  };
+
+  struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
+  void perf_evsel__delete(struct perf_evsel *evsel);
+  int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+                       struct perf_thread_map *threads);
+  void perf_evsel__close(struct perf_evsel *evsel);
+  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+                       struct perf_counts_values *count);
+  int perf_evsel__enable(struct perf_evsel *evsel);
+  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__disable(struct perf_evsel *evsel);
+  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
+  struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
+  struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
+  struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
+--
+
+*API to handle maps (perf ring buffers):*
+
+[source,c]
+--
+  #include <perf/mmap.h>
+
+  struct perf_mmap;
+
+  void perf_mmap__consume(struct perf_mmap *map);
+  int perf_mmap__read_init(struct perf_mmap *map);
+  void perf_mmap__read_done(struct perf_mmap *map);
+  union perf_event *perf_mmap__read_event(struct perf_mmap *map);
+--
+
+*Structures to access perf API events:*
+
+[source,c]
+--
+  #include <perf/event.h>
+
+  struct perf_record_mmap;
+  struct perf_record_mmap2;
+  struct perf_record_comm;
+  struct perf_record_namespaces;
+  struct perf_record_fork;
+  struct perf_record_lost;
+  struct perf_record_lost_samples;
+  struct perf_record_read;
+  struct perf_record_throttle;
+  struct perf_record_ksymbol;
+  struct perf_record_bpf_event;
+  struct perf_record_sample;
+  struct perf_record_switch;
+  struct perf_record_header_attr;
+  struct perf_record_record_cpu_map;
+  struct perf_record_cpu_map_data;
+  struct perf_record_cpu_map;
+  struct perf_record_event_update_cpus;
+  struct perf_record_event_update_scale;
+  struct perf_record_event_update;
+  struct perf_trace_event_type;
+  struct perf_record_header_event_type;
+  struct perf_record_header_tracing_data;
+  struct perf_record_header_build_id;
+  struct perf_record_id_index;
+  struct perf_record_auxtrace_info;
+  struct perf_record_auxtrace;
+  struct perf_record_auxtrace_error;
+  struct perf_record_aux;
+  struct perf_record_itrace_start;
+  struct perf_record_thread_map_entry;
+  struct perf_record_thread_map;
+  struct perf_record_stat_config_entry;
+  struct perf_record_stat_config;
+  struct perf_record_stat;
+  struct perf_record_stat_round;
+  struct perf_record_time_conv;
+  struct perf_record_header_feature;
+  struct perf_record_compressed;
+--
+
+DESCRIPTION
+-----------
+The libperf library provides an API to access the linux kernel perf
+events subsystem.
+
+Following objects are key to the libperf interface:
+
+[horizontal]
+
+struct perf_cpu_map:: Provides a cpu list abstraction.
+
+struct perf_thread_map:: Provides a thread list abstraction.
+
+struct perf_evsel:: Provides an abstraction for single a perf event.
+
+struct perf_evlist:: Gathers several struct perf_evsel object and performs functions on all of them.
+
+struct perf_mmap:: Provides an abstraction for accessing perf ring buffer.
+
+The exported API functions bind these objects together.
+
+REPORTING BUGS
+--------------
+Report bugs to <linux-perf-users@vger.kernel.org>.
+
+LICENSE
+-------
+libperf is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+
+SEE ALSO
+--------
+libperf-sampling(7), libperf-counting(7)
diff --git a/tools/lib/perf/Documentation/man/libperf.rst b/tools/lib/perf/Documentation/man/libperf.rst
deleted file mode 100644
index 09a270fccb9c..000000000000
--- a/tools/lib/perf/Documentation/man/libperf.rst
+++ /dev/null
@@ -1,100 +0,0 @@
-.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-libperf
-
-The libperf library provides an API to access the linux kernel perf
-events subsystem. It provides the following high level objects:
-
-  - struct perf_cpu_map
-  - struct perf_thread_map
-  - struct perf_evlist
-  - struct perf_evsel
-
-reference
-=========
-Function reference by header files:
-
-perf/core.h
------------
-.. code-block:: c
-
-  typedef int (\*libperf_print_fn_t)(enum libperf_print_level level,
-                                     const char \*, va_list ap);
-
-  void libperf_set_print(libperf_print_fn_t fn);
-
-perf/cpumap.h
--------------
-.. code-block:: c
-
-  struct perf_cpu_map \*perf_cpu_map__dummy_new(void);
-  struct perf_cpu_map \*perf_cpu_map__new(const char \*cpu_list);
-  struct perf_cpu_map \*perf_cpu_map__read(FILE \*file);
-  struct perf_cpu_map \*perf_cpu_map__get(struct perf_cpu_map \*map);
-  void perf_cpu_map__put(struct perf_cpu_map \*map);
-  int perf_cpu_map__cpu(const struct perf_cpu_map \*cpus, int idx);
-  int perf_cpu_map__nr(const struct perf_cpu_map \*cpus);
-  perf_cpu_map__for_each_cpu(cpu, idx, cpus)
-
-perf/threadmap.h
-----------------
-.. code-block:: c
-
-  struct perf_thread_map \*perf_thread_map__new_dummy(void);
-  void perf_thread_map__set_pid(struct perf_thread_map \*map, int thread, pid_t pid);
-  char \*perf_thread_map__comm(struct perf_thread_map \*map, int thread);
-  struct perf_thread_map \*perf_thread_map__get(struct perf_thread_map \*map);
-  void perf_thread_map__put(struct perf_thread_map \*map);
-
-perf/evlist.h
--------------
-.. code-block::
-
-  void perf_evlist__init(struct perf_evlist \*evlist);
-  void perf_evlist__add(struct perf_evlist \*evlist,
-                      struct perf_evsel \*evsel);
-  void perf_evlist__remove(struct perf_evlist \*evlist,
-                         struct perf_evsel \*evsel);
-  struct perf_evlist \*perf_evlist__new(void);
-  void perf_evlist__delete(struct perf_evlist \*evlist);
-  struct perf_evsel\* perf_evlist__next(struct perf_evlist \*evlist,
-                                     struct perf_evsel \*evsel);
-  int perf_evlist__open(struct perf_evlist \*evlist);
-  void perf_evlist__close(struct perf_evlist \*evlist);
-  void perf_evlist__enable(struct perf_evlist \*evlist);
-  void perf_evlist__disable(struct perf_evlist \*evlist);
-  perf_evlist__for_each_evsel(evlist, pos)
-  void perf_evlist__set_maps(struct perf_evlist \*evlist,
-                           struct perf_cpu_map \*cpus,
-                           struct perf_thread_map \*threads);
-
-perf/evsel.h
-------------
-.. code-block:: c
-
-  struct perf_counts_values {
-        union {
-                struct {
-                        uint64_t val;
-                        uint64_t ena;
-                        uint64_t run;
-                };
-                uint64_t values[3];
-        };
-  };
-
-  void perf_evsel__init(struct perf_evsel \*evsel,
-                      struct perf_event_attr \*attr);
-  struct perf_evsel \*perf_evsel__new(struct perf_event_attr \*attr);
-  void perf_evsel__delete(struct perf_evsel \*evsel);
-  int perf_evsel__open(struct perf_evsel \*evsel, struct perf_cpu_map \*cpus,
-                     struct perf_thread_map \*threads);
-  void perf_evsel__close(struct perf_evsel \*evsel);
-  int perf_evsel__read(struct perf_evsel \*evsel, int cpu, int thread,
-                     struct perf_counts_values \*count);
-  int perf_evsel__enable(struct perf_evsel \*evsel);
-  int perf_evsel__disable(struct perf_evsel \*evsel);
-  int perf_evsel__apply_filter(struct perf_evsel \*evsel, const char \*filter);
-  struct perf_cpu_map \*perf_evsel__cpus(struct perf_evsel \*evsel);
-  struct perf_thread_map \*perf_evsel__threads(struct perf_evsel \*evsel);
-  struct perf_event_attr \*perf_evsel__attr(struct perf_evsel \*evsel);
diff --git a/tools/lib/perf/Documentation/manpage-1.72.xsl b/tools/lib/perf/Documentation/manpage-1.72.xsl
new file mode 100644
index 000000000000..b4d315cb8c47
--- /dev/null
+++ b/tools/lib/perf/Documentation/manpage-1.72.xsl
@@ -0,0 +1,14 @@
+<!-- manpage-1.72.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     handles peculiarities in docbook-xsl 1.72.0 -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<xsl:import href="manpage-base.xsl"/>
+
+<!-- these are the special values for the roff control characters
+     needed for docbook-xsl 1.72.0 -->
+<xsl:param name="git.docbook.backslash">&#x2593;</xsl:param>
+<xsl:param name="git.docbook.dot"      >&#x2302;</xsl:param>
+
+</xsl:stylesheet>
diff --git a/tools/lib/perf/Documentation/manpage-base.xsl b/tools/lib/perf/Documentation/manpage-base.xsl
new file mode 100644
index 000000000000..a264fa616093
--- /dev/null
+++ b/tools/lib/perf/Documentation/manpage-base.xsl
@@ -0,0 +1,35 @@
+<!-- manpage-base.xsl:
+     special formatting for manpages rendered from asciidoc+docbook -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- these params silence some output from xmlto -->
+<xsl:param name="man.output.quietly" select="1"/>
+<xsl:param name="refentry.meta.get.quietly" select="1"/>
+
+<!-- convert asciidoc callouts to man page format;
+     git.docbook.backslash and git.docbook.dot params
+     must be supplied by another XSL file or other means -->
+<xsl:template match="co">
+	<xsl:value-of select="concat(
+			      $git.docbook.backslash,'fB(',
+			      substring-after(@id,'-'),')',
+			      $git.docbook.backslash,'fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:value-of select="$git.docbook.dot"/>
+	<xsl:text>sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat(
+			      $git.docbook.backslash,'fB',
+			      substring-after(@arearefs,'-'),
+			      '. ',$git.docbook.backslash,'fR')"/>
+	<xsl:apply-templates/>
+	<xsl:value-of select="$git.docbook.dot"/>
+	<xsl:text>br&#10;</xsl:text>
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/tools/lib/perf/Documentation/manpage-bold-literal.xsl b/tools/lib/perf/Documentation/manpage-bold-literal.xsl
new file mode 100644
index 000000000000..608eb5df6281
--- /dev/null
+++ b/tools/lib/perf/Documentation/manpage-bold-literal.xsl
@@ -0,0 +1,17 @@
+<!-- manpage-bold-literal.xsl:
+     special formatting for manpages rendered from asciidoc+docbook -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- render literal text as bold (instead of plain or monospace);
+     this makes literal text easier to distinguish in manpages
+     viewed on a tty -->
+<xsl:template match="literal">
+	<xsl:value-of select="$git.docbook.backslash"/>
+	<xsl:text>fB</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:value-of select="$git.docbook.backslash"/>
+	<xsl:text>fR</xsl:text>
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/tools/lib/perf/Documentation/manpage-normal.xsl b/tools/lib/perf/Documentation/manpage-normal.xsl
new file mode 100644
index 000000000000..a48f5b11f3dc
--- /dev/null
+++ b/tools/lib/perf/Documentation/manpage-normal.xsl
@@ -0,0 +1,13 @@
+<!-- manpage-normal.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     handles anything we want to keep away from docbook-xsl 1.72.0 -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<xsl:import href="manpage-base.xsl"/>
+
+<!-- these are the normal values for the roff control characters -->
+<xsl:param name="git.docbook.backslash">\</xsl:param>
+<xsl:param name="git.docbook.dot"	>.</xsl:param>
+
+</xsl:stylesheet>
diff --git a/tools/lib/perf/Documentation/manpage-suppress-sp.xsl b/tools/lib/perf/Documentation/manpage-suppress-sp.xsl
new file mode 100644
index 000000000000..a63c7632a87d
--- /dev/null
+++ b/tools/lib/perf/Documentation/manpage-suppress-sp.xsl
@@ -0,0 +1,21 @@
+<!-- manpage-suppress-sp.xsl:
+     special settings for manpages rendered from asciidoc+docbook
+     handles erroneous, inline .sp in manpage output of some
+     versions of docbook-xsl -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- attempt to work around spurious .sp at the tail of the line
+     that some versions of docbook stylesheets seem to add -->
+<xsl:template match="simpara">
+  <xsl:variable name="content">
+    <xsl:apply-templates/>
+  </xsl:variable>
+  <xsl:value-of select="normalize-space($content)"/>
+  <xsl:if test="not(ancestor::authorblurb) and
+                not(ancestor::personblurb)">
+    <xsl:text>&#10;&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/tools/lib/perf/Documentation/tutorial/tutorial.rst b/tools/lib/perf/Documentation/tutorial/tutorial.rst
deleted file mode 100644
index 7be7bc27b385..000000000000
--- a/tools/lib/perf/Documentation/tutorial/tutorial.rst
+++ /dev/null
@@ -1,123 +0,0 @@
-.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-
-libperf tutorial
-================
-
-Compile and install libperf from kernel sources
-===============================================
-.. code-block:: bash
-
-  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-  cd linux/tools/perf/lib
-  make
-  sudo make install prefix=/usr
-
-Libperf object
-==============
-The libperf library provides several high level objects:
-
-struct perf_cpu_map
-  Provides a cpu list abstraction.
-
-struct perf_thread_map
-  Provides a thread list abstraction.
-
-struct perf_evsel
-  Provides an abstraction for single a perf event.
-
-struct perf_evlist
-  Gathers several struct perf_evsel object and performs functions on all of them.
-
-The exported API binds these objects together,
-for full reference see the libperf.7 man page.
-
-Examples
-========
-Examples aim to explain libperf functionality on simple use cases.
-They are based in on a checked out linux kernel git tree:
-
-.. code-block:: bash
-
-  $ cd tools/perf/lib/Documentation/tutorial/
-  $ ls -d  ex-*
-  ex-1-compile  ex-2-evsel-stat  ex-3-evlist-stat
-
-ex-1-compile example
-====================
-This example shows the basic usage of *struct perf_cpu_map*,
-how to create it and display its cpus:
-
-.. code-block:: bash
-
-  $ cd ex-1-compile/
-  $ make
-  gcc -o test test.c -lperf
-  $ ./test
-  0 1 2 3 4 5 6 7
-
-
-The full code listing is here:
-
-.. code-block:: c
-
-   1 #include <perf/cpumap.h>
-   2
-   3 int main(int argc, char **Argv)
-   4 {
-   5         struct perf_cpu_map *cpus;
-   6         int cpu, tmp;
-   7
-   8         cpus = perf_cpu_map__new(NULL);
-   9
-  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
-  11                 fprintf(stdout, "%d ", cpu);
-  12
-  13         fprintf(stdout, "\n");
-  14
-  15         perf_cpu_map__put(cpus);
-  16         return 0;
-  17 }
-
-
-First you need to include the proper header to have *struct perf_cpumap*
-declaration and functions:
-
-.. code-block:: c
-
-   1 #include <perf/cpumap.h>
-
-
-The *struct perf_cpumap* object is created by *perf_cpu_map__new* call.
-The *NULL* argument asks it to populate the object with the current online CPUs list:
-
-.. code-block:: c
-
-   8         cpus = perf_cpu_map__new(NULL);
-
-This is paired with a *perf_cpu_map__put*, that drops its reference at the end, possibly deleting it.
-
-.. code-block:: c
-
-  15         perf_cpu_map__put(cpus);
-
-The iteration through the *struct perf_cpumap* CPUs is done using the *perf_cpu_map__for_each_cpu*
-macro which requires 3 arguments:
-
-- cpu  - the cpu numer
-- tmp  - iteration helper variable
-- cpus - the *struct perf_cpumap* object
-
-.. code-block:: c
-
-  10         perf_cpu_map__for_each_cpu(cpu, tmp, cpus)
-  11                 fprintf(stdout, "%d ", cpu);
-
-ex-2-evsel-stat example
-=======================
-
-TBD
-
-ex-3-evlist-stat example
-========================
-
-TBD
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 768dd423730b..3718d65cffac 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -181,7 +181,10 @@ install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
 		$(call do_install,$(LIBPERF_PC),$(libdir_SQ)/pkgconfig,644)
 
-install: install_lib install_headers install_pkgconfig
+install_doc:
+	$(Q)$(MAKE) -C Documentation install-man install-html install-examples
+
+install: install_lib install_headers install_pkgconfig install_doc
 
 FORCE:
 
-- 
2.21.1

