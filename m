Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB63E217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429634;
	bh=6QaELTbwQbtaIaO1JQK52n+zDukXO9dsqnUxU40CLM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x0c/uhM1ALKguUFzurNfLULL2HYkIxaYhqSZVhI9kZytkRv0Oztl9a5VGLFL8FH/t
	 2IMWZ4A8xItnjHXYDLgap1S/Bvdw/+KOYllofqggW2WfB6NHXXdOw9nx6Oe9I7fXyZ
	 gFwYAredWfT9e66Zj4ViCD0J5mM6FLSS/BVJqjJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfDECAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:00:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40169 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDECAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:00:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E415524DCA;
        Thu,  4 Apr 2019 22:00:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2019 22:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=OIh1i/pL/R2We4uoijWBpxzbz97WTIRfGNaCQuscgvI=; b=lszIUx6u
        jJGS7X7yfDaSzs+c3ppze2GzSDgeT/w7dqte0GCsalY/Dg1QEEVvMKTtjTe0PDIH
        ICtohuJkBnoeBaws59JZUjnQVGgkLqO1BSScS/H5Ha5l55dDWVdmfD+2rVR5LeeE
        q940Vbd+YqwTRKtypp/peE2IrWXjn9re4fqA2WRdK6b4kAcUW6F4Bo+27ZmIYMmg
        H8pr3itIl64lsz51CPdkj7v7G16Bl0dWhwjZBCGG2D8EoUf6iK3bcbbb+e2t/KlN
        9st2MH7PiPRSuyMdDCmVV89Jz95HO1AaC5mngYT9UE5ggq15ljfmlDdXycxqbDxr
        w+hQnaHIrZbEaQ==
X-ME-Sender: <xms:v7amXB-GG9ufhd-OOXy2gf3C_usBfmb1HrglG6Rjzf7YrEiirhlV-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigdehtdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudegledruddugedrkeeinecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeeg
X-ME-Proxy: <xmx:v7amXAbOca749zNLam6qrYjhrIZ4MrQrI02TTLxLXscWqM4c7gT1Zg>
    <xmx:v7amXFrP1bPPwszTQgunwqUVPm7cLPfUDucAvb3wxXVbfVOXTE9DnQ>
    <xmx:v7amXAbBdHrzVD9RI9sqczoBabqAthexGEn5q1g7ZFt1-2DQxJR9AQ>
    <xmx:v7amXDicIv87Il8vsO-K3tN6H90FoQmtqZDVq5D5hn2YI-oeWpQl9w>
Received: from eros.localdomain (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7B8D10310;
        Thu,  4 Apr 2019 22:00:25 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] lib/string: Add strscpy_pad() function
Date:   Fri,  5 Apr 2019 12:58:58 +1100
Message-Id: <20190405015859.32755-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
References: <20190405015859.32755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a function to copy strings safely and we have a function to copy
strings and zero the tail of the destination (if source string is
shorter than destination buffer) but we do not have a function to do
both at once.  This means developers must write this themselves if they
desire this functionality.  This is a chore, and also leaves us open to
off by one errors unnecessarily.

Add a function that calls strscpy() then memset()s the tail to zero if
the source string is shorter than the destination buffer.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/string.h |  4 ++++
 lib/string.c           | 47 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..bfe95bf5d07e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
+
+/* Wraps calls to strscpy()/memset(), no arch specific code required */
+ssize_t strscpy_pad(char *dest, const char *src, size_t count);
+
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..3a3353512184 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -159,11 +159,9 @@ EXPORT_SYMBOL(strlcpy);
  * @src: Where to copy the string from
  * @count: Size of destination buffer
  *
- * Copy the string, or as much of it as fits, into the dest buffer.
- * The routine returns the number of characters copied (not including
- * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
- * The behavior is undefined if the string buffers overlap.
- * The destination buffer is always NUL terminated, unless it's zero-sized.
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always NUL terminated, unless it's zero-sized.
  *
  * Preferred to strlcpy() since the API doesn't require reading memory
  * from the src string beyond the specified "count" bytes, and since
@@ -173,8 +171,10 @@ EXPORT_SYMBOL(strlcpy);
  *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
- * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
- * with an overflow test, then just memset() the tail of the dest buffer.
+ * zeroed.  If zeroing is desired please use strscpy_pad().
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
  */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
@@ -237,6 +237,39 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strscpy);
 #endif
 
+/**
+ * strscpy_pad() - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer.  The
+ * behavior is undefined if the string buffers overlap.  The destination
+ * buffer is always %NUL terminated, unless it's zero-sized.
+ *
+ * If the source string is shorter than the destination buffer, zeros
+ * the tail of the destination buffer.
+ *
+ * For full explanation of why you may want to consider using the
+ * 'strscpy' functions please see the function docstring for strscpy().
+ *
+ * Return: The number of characters copied (not including the trailing
+ *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
+ */
+ssize_t strscpy_pad(char *dest, const char *src, size_t count)
+{
+	ssize_t written;
+
+	written = strscpy(dest, src, count);
+	if (written < 0 || written == count - 1)
+		return written;
+
+	memset(dest + written + 1, 0, count - written - 1);
+
+	return written;
+}
+EXPORT_SYMBOL(strscpy_pad);
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another
-- 
2.21.0

