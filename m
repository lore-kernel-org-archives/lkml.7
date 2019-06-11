Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19ACC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767D32183F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279912;
	bh=4+n99SbidNoVxVVA/z7mFrDd5ZHT5MGz6j3Y8RAm8fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HX8eVgsjb6k+XcTugz8KFI+Ce52NIgMQ+1oBFdhrqFVHPHkbl52TX5escbhKXYxsG
	 8PtvJA6RYt/IgbXpTeh/Q/SKuytSo+LOqJDYgiqsuOj+rBIhUqwuc+dzaHIAzZuHvd
	 kTUMgRcXtjLgMuVdFjg3o5gJ3+3KnlmJLqRLMmXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406622AbfFKTFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407398AbfFKTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:05:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D7C21871;
        Tue, 11 Jun 2019 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279907;
        bh=4+n99SbidNoVxVVA/z7mFrDd5ZHT5MGz6j3Y8RAm8fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufuY9Vdc25lClgxPc1q192P7eZQCrvsZUY7pNmS9dlLKARnm3Adm8z3HmfjQt96E9
         7H5z+8OwNFicZgH5Gl6pOijI0hEwPXq9GxeVNchDiKMggzA3bgqqK1su3Z0i7rTCcz
         q3W407NuBd3ppZcGGNC/nQODzAkjAZ1NqxrZ8LJA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 84/85] perf report: Support s390 diag event display on x86
Date:   Tue, 11 Jun 2019 15:59:10 -0300
Message-Id: <20190611185911.11645-85-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Perf report fails to display s390 specific event numbered bd000
on an x86 platform. For example on s390 this works without error:

[root@m35lp76 perf]# uname -m
s390x
[root@m35lp76 perf]# ./perf record -e rbd000 -- find / >/dev/null
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.549 MB perf.data ]
[root@m35lp76 perf]# ./perf report -D --stdio  > /dev/null
[root@m35lp76 perf]#

Transfering this perf.data file to an x86 platform and executing
the same report command produces:

[root@f29 perf]# uname -m
x86_64
[root@f29 perf]# ./perf report -i ~/perf.data.m35lp76 --stdio
interpreting bpf_prog_info from systems with endianity is not yet supported
interpreting btf from systems with endianity is not yet supported
0x8c890 [0x8]: failed to process type: 68
Error:
failed to process sample

Event bd000 generates auxiliary data which is stored in big endian
format in the perf data file.
This error is caused by missing endianess handling on the x86 platform
when the data is displayed. Fix this by handling s390 auxiliary event
data depending on the local platform endianness.

Output after on x86:

[root@f29 perf]# ./perf report -D -i ~/perf.data.m35lp76 --stdio > /dev/null
interpreting bpf_prog_info from systems with endianity is not yet supported
interpreting btf from systems with endianity is not yet supported
[root@f29 perf]#

Committer notes:

Fix build breakage on older systems, such as CentOS:6 where using
nesting calls to the endian.h macros end up redefining local variables:

  util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
  util/s390-cpumsf.c:333: error: declaration of '__v' shadows a previous local
  util/s390-cpumsf.c:333: error: shadowed declaration is here
  util/s390-cpumsf.c:333: error: declaration of '__x' shadows a previous local
  util/s390-cpumsf.c:333: error: shadowed declaration is here
  util/s390-cpumsf.c:334: error: declaration of '__v' shadows a previous local
  util/s390-cpumsf.c:334: error: shadowed declaration is here
  util/s390-cpumsf.c:334: error: declaration of '__x' shadows a previous local
  util/s390-cpumsf.c:334: error: shadowed declaration is here

  [perfbuilder@455a63ef60dc perf]$ gcc -v |& tail -1
  gcc version 4.4.7 20120313 (Red Hat 4.4.7-23) (GCC)
  [perfbuilder@455a63ef60dc perf]$

Since there are several uses of

  be64toh(te->flags)

Introduce a variable to hold that and then use it, avoiding this case
that causes the above problems:

  -       local.bsdes = be16toh((be64toh(te->flags) >> 16 & 0xffff));
  +       local.bsdes = be16toh((flags >> 16 & 0xffff));

Its the same construct used in s390_cpumsf_diag_show() where we have a
'word' variable that is used just once, s390_cpumsf_basic_show() has
lots of uses and also uses a variable to hold the result of be16toh().

Some of those temp variables needed to be converted from 'unsigned long'
to 'unsigned long long' so as to build on 32-bit arches such as
debian:experimental-x-mipsel, the android NDK ones and
fedora:24-x-ARC-uClibc.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190522064325.25596-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 96 ++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index c215704931dc..10d36d9b7909 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -17,8 +17,8 @@
  *	see Documentation/perf.data-file-format.txt.
  * PERF_RECORD_AUXTRACE_INFO:
  *	Defines a table of contains for PERF_RECORD_AUXTRACE records. This
- *	record is generated during 'perf record' command. Each record contains up
- *	to 256 entries describing offset and size of the AUXTRACE data in the
+ *	record is generated during 'perf record' command. Each record contains
+ *	up to 256 entries describing offset and size of the AUXTRACE data in the
  *	perf.data file.
  * PERF_RECORD_AUXTRACE_ERROR:
  *	Indicates an error during AUXTRACE collection such as buffer overflow.
@@ -237,10 +237,33 @@ static int s390_cpumcf_dumpctr(struct s390_cpumsf *sf,
 	return rc;
 }
 
-/* Display s390 CPU measurement facility basic-sampling data entry */
+/* Display s390 CPU measurement facility basic-sampling data entry
+ * Data written on s390 in big endian byte order and contains bit
+ * fields across byte boundaries.
+ */
 static bool s390_cpumsf_basic_show(const char *color, size_t pos,
-				   struct hws_basic_entry *basic)
+				   struct hws_basic_entry *basicp)
 {
+	struct hws_basic_entry *basic = basicp;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	struct hws_basic_entry local;
+	unsigned long long word = be64toh(*(unsigned long long *)basicp);
+
+	memset(&local, 0, sizeof(local));
+	local.def = be16toh(basicp->def);
+	local.prim_asn = word & 0xffff;
+	local.CL = word >> 30 & 0x3;
+	local.I = word >> 32 & 0x1;
+	local.AS = word >> 33 & 0x3;
+	local.P = word >> 35 & 0x1;
+	local.W = word >> 36 & 0x1;
+	local.T = word >> 37 & 0x1;
+	local.U = word >> 40 & 0xf;
+	local.ia = be64toh(basicp->ia);
+	local.gpp = be64toh(basicp->gpp);
+	local.hpp = be64toh(basicp->hpp);
+	basic = &local;
+#endif
 	if (basic->def != 1) {
 		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
 		return false;
@@ -258,10 +281,22 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 	return true;
 }
 
-/* Display s390 CPU measurement facility diagnostic-sampling data entry */
+/* Display s390 CPU measurement facility diagnostic-sampling data entry.
+ * Data written on s390 in big endian byte order and contains bit
+ * fields across byte boundaries.
+ */
 static bool s390_cpumsf_diag_show(const char *color, size_t pos,
-				  struct hws_diag_entry *diag)
+				  struct hws_diag_entry *diagp)
 {
+	struct hws_diag_entry *diag = diagp;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	struct hws_diag_entry local;
+	unsigned long long word = be64toh(*(unsigned long long *)diagp);
+
+	local.def = be16toh(diagp->def);
+	local.I = word >> 32 & 0x1;
+	diag = &local;
+#endif
 	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
 		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
 		return false;
@@ -272,35 +307,52 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
 }
 
 /* Return TOD timestamp contained in an trailer entry */
-static unsigned long long trailer_timestamp(struct hws_trailer_entry *te)
+static unsigned long long trailer_timestamp(struct hws_trailer_entry *te,
+					    int idx)
 {
 	/* te->t set: TOD in STCKE format, bytes 8-15
 	 * to->t not set: TOD in STCK format, bytes 0-7
 	 */
 	unsigned long long ts;
 
-	memcpy(&ts, &te->timestamp[te->t], sizeof(ts));
-	return ts;
+	memcpy(&ts, &te->timestamp[idx], sizeof(ts));
+	return be64toh(ts);
 }
 
 /* Display s390 CPU measurement facility trailer entry */
 static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
 				     struct hws_trailer_entry *te)
 {
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	struct hws_trailer_entry local;
+	const unsigned long long flags = be64toh(te->flags);
+
+	memset(&local, 0, sizeof(local));
+	local.f = flags >> 63 & 0x1;
+	local.a = flags >> 62 & 0x1;
+	local.t = flags >> 61 & 0x1;
+	local.bsdes = be16toh((flags >> 16 & 0xffff));
+	local.dsdes = be16toh((flags & 0xffff));
+	memcpy(&local.timestamp, te->timestamp, sizeof(te->timestamp));
+	local.overflow = be64toh(te->overflow);
+	local.clock_base = be64toh(te->progusage[0]) >> 63 & 1;
+	local.progusage2 = be64toh(te->progusage2);
+	te = &local;
+#endif
 	if (te->bsdes != sizeof(struct hws_basic_entry)) {
 		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
 		return false;
 	}
 	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
 		      " dsdes:%d Overflow:%lld Time:%#llx\n"
-		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
+		      "\t\tC:%d TOD:%#lx\n",
 		      pos,
 		      te->f ? 'F' : ' ',
 		      te->a ? 'A' : ' ',
 		      te->t ? 'T' : ' ',
 		      te->bsdes, te->dsdes, te->overflow,
-		      trailer_timestamp(te), te->clock_base, te->progusage2,
-		      te->progusage[0], te->progusage[1]);
+		      trailer_timestamp(te, te->clock_base),
+		      te->clock_base, te->progusage2);
 	return true;
 }
 
@@ -327,13 +379,13 @@ static bool s390_cpumsf_validate(int machine_type,
 	*dsdes = *bsdes = 0;
 	if (len & (S390_CPUMSF_PAGESZ - 1))	/* Illegal size */
 		return false;
-	if (basic->def != 1)		/* No basic set entry, must be first */
+	if (be16toh(basic->def) != 1)	/* No basic set entry, must be first */
 		return false;
 	/* Check for trailer entry at end of SDB */
 	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
 					      - sizeof(*te));
-	*bsdes = te->bsdes;
-	*dsdes = te->dsdes;
+	*bsdes = be16toh(te->bsdes);
+	*dsdes = be16toh(te->dsdes);
 	if (!te->bsdes && !te->dsdes) {
 		/* Very old hardware, use CPUID */
 		switch (machine_type) {
@@ -495,19 +547,27 @@ static bool s390_cpumsf_make_event(size_t pos,
 static unsigned long long get_trailer_time(const unsigned char *buf)
 {
 	struct hws_trailer_entry *te;
-	unsigned long long aux_time;
+	unsigned long long aux_time, progusage2;
+	bool clock_base;
 
 	te = (struct hws_trailer_entry *)(buf + S390_CPUMSF_PAGESZ
 					      - sizeof(*te));
 
-	if (!te->clock_base)	/* TOD_CLOCK_BASE value missing */
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	clock_base = be64toh(te->progusage[0]) >> 63 & 0x1;
+	progusage2 = be64toh(te->progusage[1]);
+#else
+	clock_base = te->clock_base;
+	progusage2 = te->progusage2;
+#endif
+	if (!clock_base)	/* TOD_CLOCK_BASE value missing */
 		return 0;
 
 	/* Correct calculation to convert time stamp in trailer entry to
 	 * nano seconds (taken from arch/s390 function tod_to_ns()).
 	 * TOD_CLOCK_BASE is stored in trailer entry member progusage2.
 	 */
-	aux_time = trailer_timestamp(te) - te->progusage2;
+	aux_time = trailer_timestamp(te, clock_base) - progusage2;
 	aux_time = (aux_time >> 9) * 125 + (((aux_time & 0x1ff) * 125) >> 9);
 	return aux_time;
 }
-- 
2.20.1

