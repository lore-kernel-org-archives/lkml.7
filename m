Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C695FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7542075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCSQwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:52:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:52:04 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6bo8-1gx9Gh3uwg-0185ri; Tue, 19 Mar 2019 17:51:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-api@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, netdev@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fw@deneb.enyo.de>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
Date:   Tue, 19 Mar 2019 17:51:09 +0100
Message-Id: <20190319165123.3967889-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9c6ua1+avFyWCBxiOJ8wr7i2NCjA9m8sxVPnpzEziAPVOqkO9TB
 jH94v4CaVDwDy2nhKbcoqr2MpO7GnCR1WEiwf3PVc2jX9g55Tw8pndUzp7817pW8cwIcH7f
 1l1u+p2vIXD1V+qlThaq6H7uVBIoZBGIasl3cYp2+jst0OeDAQxXMoORN0CxC91tZAQr9XX
 0g3vkGop8l6gVFn/V9BZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yN9VZMfyfjw=:tojk5vDX75dpWby3Z9wnf1
 oBTmAuEbS7qqnmpeEEoeY+wWGsdwOCoNb8jW+sg9BrENNb71xGLUyZO8eoFEu5hJfv9UVGlC8
 OCy48YS4FY+RLTzbzR1WcBBe3gsLHkq4KSosaV6vPZRQvDepSEFRiWkakK04z6Mu9DjV0fNp7
 6HMaOfUmY/vDjnw25FAcOr/iShPOvrJc7+s4veAlV6Xhvig2phEMCWh22XTspo+CtO5bcEFS4
 rAlJGWYX2+UFcfMwsIKn56PsnkOM+6ZxAZueaGr2gR8knIw2Hg5WsjpZ05Z0qDb4gfdAAP3yS
 iD1o7op7rFlEu0k/Em3tvEHZR0iRy+thn0L9NoQz54cLV25VTx+kYpTomkz0oJpvK8+fSzJin
 9xoDZHl9v8Dm5PIFFcPPIxzL56nPyhH2pXRNV+PxbVN7bBmZPc4VXSXvM5WxSVoLiiWSYO7+N
 iEqQ/vQs9QxlPB6XIIG3XMCfGECcDuqG5jN4BiKl3/hkNJlw+ucadM/4OvM+Z5tijtHDPLMqJ
 vmTJMUrfODtiLMlxabMTUBNGFW9UXr6l1pzOOINZWfisncjooX1mJsfkgeAXiJ+wa6kBC47Yp
 8FusZPRFE3sGhK/A3b4JBp1gvjie5L9VLprb1xeunv7Zve97k9a0P06bx+lclFBZ/mSP6uFX+
 JTzuaCiobgZeqHhcrxiLXPMVaaTzLHYZS996H4abmAjM99ruC/0dupN8XeRu3plTUb39+ZZma
 Rd5wsDQeEQdpgKVV9M1OLV4PjijNOtu3YMkwFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer points out an issue with including linux/posix_types.h
from arbitrary other headers: if an application has defined a macro
named 'fds_bits', it may stop compiling after a change in the kernel
headers. Since fds_bits is a non-reserved identifier in C, that is
considered a bug in the kernel headers.

The structure definition does not really seem to be helpful here,
as the kernel no longer provides macros to manipulate it.

The only user of the structure that we could find was in libsanitize.
This usage is actually broken, as discussed in the email thread,
but this means we cannot just remove the definition from the exported
headers, but we can use the __kernel_* namespace for it, to avoid
the namespace conflict. The kernel itself just uses bit operations
on the typedef without accessing the field by name.
This change should also help with the many other kernel headers that
include linux/posix_types.h directly or through linux/types.h.

Similarly, the definition of __kernel_fsid_t uses a structure with
field identifier 'val' that may have the same problem. Again, user
space should not rely on the specific field name but instead treat
an fsid_t as an opaque identifier. I'm using an #ifdef __KERNEL__
guard here to save us from having to change all kernel code accessing
the field.
Glibc has changed this from 'val' to '__val' back in 1996/97 when
they moved away from using the kernel types directly, it it
is likely that nothing uses __kernel_fsid_t any more. MIPS still
has another copy of __kernel_fsid_t, but that is in the process
of being removed as well.

Link: https://lore.kernel.org/lkml/87a7hvded7.fsf@mid.deneb.enyo.de/
Link: https://lore.kernel.org/lkml/20190314173900.25454-1-paul.burton@mips.com/
Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Paul Burton <pburton@wavecomp.com>
Fixes: a623a7a1a567 ("y2038: fix socket.h header inclusion")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There was another bug report for the same change just now, so
I wouldn't apply this patch yet before we have fully understood
the other issue. Sending this for review now since the two
problems are most likely independent.
---
 include/uapi/asm-generic/posix_types.h | 4 ++++
 include/uapi/linux/posix_types.h       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index f0733a26ebfc..2a8c68ac88ca 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -77,7 +77,11 @@ typedef __kernel_long_t	__kernel_ptrdiff_t;
 
 #ifndef __kernel_fsid_t
 typedef struct {
+#ifdef __KERNEL__
 	int	val[2];
+#else
+	int	__kernel_val[2];
+#endif
 } __kernel_fsid_t;
 #endif
 
diff --git a/include/uapi/linux/posix_types.h b/include/uapi/linux/posix_types.h
index 9a7a740b35a2..a5a5cfc38bbf 100644
--- a/include/uapi/linux/posix_types.h
+++ b/include/uapi/linux/posix_types.h
@@ -23,7 +23,7 @@
 #define __FD_SETSIZE	1024
 
 typedef struct {
-	unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
+	unsigned long __kernel_fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
 } __kernel_fd_set;
 
 /* Type of a signal handler.  */
-- 
2.20.0

