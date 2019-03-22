Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16DC21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCVP3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:29:40 -0400
Received: from retiisi.org.uk ([95.216.213.190]:37904 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbfCVP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:29:37 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 4E83F634C85;
        Fri, 22 Mar 2019 17:27:25 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for printing fwnode names
Date:   Fri, 22 Mar 2019 17:29:30 +0200
Message-Id: <20190322152930.16642-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
support printing full path of the node, including its name ("f") and only
the node's name ("P") in the printk family of functions. The two flags
have equivalent functionality to existing %pOF with the same two modifiers
("f" and "P") on OF based systems. The ability to do the same on ACPI
based systems is added by this patch.

On ACPI based systems the resulting strings look like

	\_SB.PCI0.CIO2.port@1.endpoint@0

where the nodes are separated by a dot (".") and the first three are
ACPI device nodes and the latter two ACPI data nodes.

Depends-on: ("vsprintf: Remove support for %pF and %pf in favour of %pS and %ps")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst | 24 ++++++++++++++
 lib/vsprintf.c                            | 52 +++++++++++++++++++++++++++++++
 scripts/checkpatch.pl                     |  2 +-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c90826a1ff17..209625e0c61d 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -410,6 +410,30 @@ Examples::
 
 Passed by reference.
 
+Fwnode handles
+--------------
+
+::
+
+	%pfw[fP]
+
+For printing information on fwnode handles. The default is to print the full
+node name, including the path. The modifiers are functionally equivalent to
+%pOF above.
+
+	- f - full name of the node, including the path
+	- P - the name of the node including an address (if there is one)
+
+Examples (ACPI):
+
+	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
+	%pfwP	endpoint@0				- Node name
+
+Examples (OF):
+
+	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
+	%pfwP	endpoint				- Node name
+
 Time and date (struct rtc_time)
 -------------------------------
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 91f2a3e4892e..b94013413b11 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1834,6 +1834,48 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+static noinline_for_stack
+char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
+		    struct printf_spec spec, const char *fmt)
+{
+	const char * const modifiers = "fP";
+	struct printf_spec str_spec = spec;
+	char *buf_start = buf;
+	bool pass;
+
+	str_spec.field_width = -1;
+
+	if ((unsigned long)fwnode < PAGE_SIZE)
+		return string(buf, end, "(null)", spec);
+
+	/* simple case without anything any more format specifiers */
+	fmt++;
+	if (fmt[0] == '\0' || strcspn(fmt, modifiers) > 0)
+		fmt = "f";
+
+	for (pass = false; strspn(fmt, modifiers); fmt++, pass = true) {
+		if (pass) {
+			if (buf < end)
+				*buf = ':';
+			buf++;
+		}
+
+		switch (*fmt) {
+		case 'f':	/* full_name */
+			buf = fwnode_gen_full_name(fwnode, buf, end);
+			break;
+		case 'P':	/* name */
+			buf = string(buf, end, fwnode_get_name(fwnode),
+				     str_spec);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return widen_string(buf, buf - buf_start, end, spec);
+}
+
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -1936,6 +1978,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  *                  F device node flags
  *                  c major compatible string
  *                  C full compatible string
+ * - 'fw[fP]'	For a firmware node (struct fwnode_handle) pointer
+ *		Without an option prints the full name of the node
+ *		f full name
+ *		P node name, including a possible unit address
  * - 'x' For printing the address. Equivalent to "%lx".
  *
  * ** When making changes please also update:
@@ -2060,6 +2106,12 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			return device_node_string(buf, end, ptr, spec, fmt + 1);
 		}
 		break;
+	case 'f':
+		switch (fmt[1]) {
+		case 'w':
+			return fwnode_string(buf, end, ptr, spec, fmt + 1);
+		}
+		break;
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b4e456b48fd7..10db4354d61b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5977,7 +5977,7 @@ sub process {
 				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
 					$specifier = $1;
 					$extension = $2;
-					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOx]/) {
+					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxf]/) {
 						$bad_specifier = $specifier;
 						last;
 					}
-- 
2.11.0

