Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E5C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9D621852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfGEAQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 20:16:02 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:38772 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbfGEAQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 20:16:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6C2E7181D3377;
        Fri,  5 Jul 2019 00:16:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lace17_6e747616f8753
X-Filterd-Recvd-Size: 2600
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jul 2019 00:15:58 +0000 (UTC)
Message-ID: <d1524130f91d7cfd61bc736623409693d2895f57.camel@perches.com>
Subject: [RFC PATCH] string.h: Add stracpy/stracpy_pad (was: Re: [PATCH]
 checkpatch: Added warnings in favor of strscpy().)
From:   Joe Perches <joe@perches.com>
To:     Nitin Gote <nitin.r.gote@intel.com>, akpm@linux-foundation.org
Cc:     corbet@lwn.net, apw@canonical.com, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date:   Thu, 04 Jul 2019 17:15:57 -0700
In-Reply-To: <f6a4c2b601bb59179cb2e3b8f4d836a1c11379a3.camel@perches.com>
References: <1562219683-15474-1-git-send-email-nitin.r.gote@intel.com>
         <f6a4c2b601bb59179cb2e3b8f4d836a1c11379a3.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 13:46 -0700, Joe Perches wrote:
> On Thu, 2019-07-04 at 11:24 +0530, Nitin Gote wrote:
> > Added warnings in checkpatch.pl script to :
> > 
> > 1. Deprecate strcpy() in favor of strscpy().
> > 2. Deprecate strlcpy() in favor of strscpy().
> > 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> > 
> > Updated strncpy() section in Documentation/process/deprecated.rst
> > to cover strscpy_pad() case.

[]

I sent a patch series for some strscpy/strlcpy misuses.

How about adding a macro helper to avoid the misuses like:
---
 include/linux/string.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4deb11f7976b..ef01bd6f19df 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -35,6 +35,22 @@ ssize_t strscpy(char *, const char *, size_t);
 /* Wraps calls to strscpy()/memset(), no arch specific code required */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count);
 
+#define stracpy(to, from)					\
+({								\
+	size_t size = ARRAY_SIZE(to);				\
+	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
+								\
+	strscpy(to, from, size);				\
+})
+
+#define stracpy_pad(to, from)					\
+({								\
+	size_t size = ARRAY_SIZE(to);				\
+	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
+								\
+	strscpy_pad(to, from, size);				\
+})
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif


