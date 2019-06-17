Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FDC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A75E2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jaRDiqop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfFQTxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:53:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:53:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJqt0q3570833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:52:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJqt0q3570833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560801175;
        bh=PdhgCAi3HNnNxfVMn6sjweHCfmuEHDK6AG/lbCuJUE0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jaRDiqopdb1qBFvOLJqkPMmq5Xcu+fuD44C+r1Ny34SwsJ+CRa1KH5mVHScvkGDB2
         Dgj+6p5qGHcpFkwyVTX9ZEbXXGip7B0YbHJwohxoprBs9UOoImdkAXuOh6ocivPGLk
         DZYuVBeKMB5OMdLY22jSI2691KqdaMEQdGep2W0ihLVIYCYEwvxfFsacZG4JksV5D2
         h/k80IvzNA020RPDG3lOEppR/IbFoMvmvt/N/akJAp2T5LazVSdx4nXZpe1wD5tFEZ
         DwKyNcswWsrucpery5UlkdFBOdEyAz5leKYqhoeV4LWXUORkcV5PLgl4X/RpQzNnVY
         tERbQSVVo/zfA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJqtOg3570830;
        Mon, 17 Jun 2019 12:52:55 -0700
Date:   Mon, 17 Jun 2019 12:52:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-180ca71cf1be6030ba7eb4515bf2224c07b62631@git.kernel.org>
Cc:     schwidefsky@de.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        acme@redhat.com, hpa@zytor.com, brueckner@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com, brueckner@linux.ibm.com,
        mingo@kernel.org
Reply-To: brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
          brueckner@linux.ibm.com, mingo@kernel.org,
          schwidefsky@de.ibm.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
          acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190522064325.25596-1-tmricht@linux.ibm.com>
References: <20190522064325.25596-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Support s390 diag event display on x86
Git-Commit-ID: 180ca71cf1be6030ba7eb4515bf2224c07b62631
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  180ca71cf1be6030ba7eb4515bf2224c07b62631
Gitweb:     https://git.kernel.org/tip/180ca71cf1be6030ba7eb4515bf2224c07b62631
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Wed, 22 May 2019 08:43:25 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 17:48:30 -0300

perf report: Support s390 diag event display on x86

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
 tools/perf/util/s390-cpumsf.c | 96 +++++++++++++++++++++++++++++++++++--------
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
