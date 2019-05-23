Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DDAC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8E12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfEWR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:28:03 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:50946 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfEWR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:28:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id DC1683F811;
        Thu, 23 May 2019 19:27:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZdUfp-asuTA7; Thu, 23 May 2019 19:27:59 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5CAC33F247;
        Thu, 23 May 2019 19:27:59 +0200 (CEST)
Date:   Thu, 23 May 2019 19:27:58 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Jan Beulich <jbeulich@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jessica Yu <jeyu@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC] sscanf: Fix integer overflow with sscanf field width
Message-ID: <20190523172758.GA54373@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes 53809751ac23 ("sscanf: don't ignore field widths for numeric
conversions"). sscanf overflows integers with simple strings such as dates.
As an example, consider

	r = sscanf("20190523123456", "%4d%2d%2d%2d%2d%2d",
		&year, &month, &day,
		&hour, &minute, &second);

	pr_info("%d %04d-%02d-%2d %02d:%02d:%02d\n",
		r,
		year, month, day,
		hour, minute, second);

On a 32-bit machine this prints

	6 0000-05-23 12:34:56

where the year is zero, and not 2019 as expected. The reason is that sscanf
attempts to read 20190523123456 as a whole integer and then divide it with
10^10 to obtain 2019, which obviously fails. Of course, 64-bit machines fail
similarly on longer numerical strings.

I'm offering a simple patch to correct this below. The idea is to have a
variant of _parse_integer() called _parse_integer_end(), with the ability
to stop consuming digits. The functions

	simple_{strtol,strtoll,strtoul,strtoull}()

now have the corresponding

	sscanf_{strtol,strtoll,strtoul,strtoull}()

taking a field width into account. There are some code duplication issues
etc. so one might consider making more extensive changes than these.

What are your thoughts?

Fredrik

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -45,14 +45,15 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
  *
  * Don't you dare use this function.
  */
-unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+unsigned int _parse_integer_end(const char *s, const char *e,
+	unsigned int base, unsigned long long *p)
 {
 	unsigned long long res;
 	unsigned int rv;
 
 	res = 0;
 	rv = 0;
-	while (1) {
+	while (!e || s < e) {
 		unsigned int c = *s;
 		unsigned int lc = c | 0x20; /* don't tolower() this line */
 		unsigned int val;
@@ -82,6 +83,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
 	return rv;
 }
 
+unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+{
+	return _parse_integer_end(s, NULL, base, p);
+}
+
 static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
 	unsigned long long _res;
diff --git a/lib/kstrtox.h b/lib/kstrtox.h
--- a/lib/kstrtox.h
+++ b/lib/kstrtox.h
@@ -4,6 +4,8 @@
 
 #define KSTRTOX_OVERFLOW	(1U << 31)
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base);
+unsigned int _parse_integer_end(const char *s, const char *e,
+	unsigned int base, unsigned long long *p);
 unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *res);
 
 #endif
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -123,6 +123,48 @@ long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoll);
 
+static unsigned long long sscanf_strtoull(const char *cp, int field_width,
+	char **endp, unsigned int base)
+{
+	const char *e = field_width > 0 ? &cp[field_width] : NULL;
+	unsigned long long result;
+	unsigned int rv;
+
+	cp = _parse_integer_fixup_radix(cp, &base);
+	rv = _parse_integer_end(cp, e, base, &result);
+	/* FIXME */
+	cp += (rv & ~KSTRTOX_OVERFLOW);
+
+	if (endp)
+		*endp = (char *)cp;
+
+	return result;
+}
+
+static unsigned long sscanf_strtoul(const char *cp, int field_width,
+	char **endp, unsigned int base)
+{
+	return sscanf_strtoull(cp, field_width, endp, base);
+}
+
+static long sscanf_strtol(const char *cp, int field_width,
+	char **endp, unsigned int base)
+{
+	if (*cp == '-')
+		return -sscanf_strtoul(cp + 1, field_width - 1, endp, base);
+
+	return sscanf_strtoul(cp, field_width, endp, base);
+}
+
+static long long sscanf_strtoll(const char *cp, int field_width,
+	char **endp, unsigned int base)
+{
+	if (*cp == '-')
+		return -sscanf_strtoull(cp + 1, field_width - 1, endp, base);
+
+	return sscanf_strtoull(cp, field_width, endp, base);
+}
+
 static noinline_for_stack
 int skip_atoi(const char **s)
 {
@@ -3330,24 +3372,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 
 		if (is_sign)
 			val.s = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
+				sscanf_strtol(str, field_width, &next, base) :
+				sscanf_strtoll(str, field_width, &next, base);
 		else
 			val.u = qualifier != 'L' ?
-				simple_strtoul(str, &next, base) :
-				simple_strtoull(str, &next, base);
-
-		if (field_width > 0 && next - str > field_width) {
-			if (base == 0)
-				_parse_integer_fixup_radix(str, &base);
-			while (next - str > field_width) {
-				if (is_sign)
-					val.s = div_s64(val.s, base);
-				else
-					val.u = div_u64(val.u, base);
-				--next;
-			}
-		}
+				sscanf_strtoul(str, field_width, &next, base) :
+				sscanf_strtoull(str, field_width, &next, base);
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
