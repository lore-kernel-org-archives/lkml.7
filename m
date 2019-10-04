Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C64BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407A6215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="RWgHCOpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfJDKkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:40:18 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:36480 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfJDKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:40:16 -0400
Date:   Fri, 04 Oct 2019 10:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1570185611;
        bh=jcjMzfd4m+XfL4rmlu4IOvLrfeypogFn7NmUoqG8CF0=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=RWgHCOpTrMaUH32uevd5OxbmiZBGUXsPuGCjBJVJYAEeYVvsx9Zr2Xz++GaeylX9g
         vvf+RVO+I1C7OCpFDUCX60tstIZ7btsSxBwo+8S0MAbwEPyvhHGXmXjjyZoLg2CAQE
         PhGJMjzIYRFzETPU6iCcaffCeZG2GPqGbNXa7q3Y=
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Reply-To: Dmitry Goldin <dgoldin@protonmail.ch>
Subject: [PATCH v2] kheaders: making headers archive reproducible
Message-ID: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
Feedback-ID: Z14zYPZ70AFJyYagXjx-jk2Vw9RTvF5p9C9xp4Pq6DJAMFg9PDsfB7GoMmtR_dfa0BaFgToZb9Q4V0UiY2YiMQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>

In commit 43d8ce9d65a5 ("Provide in-kernel headers to make
extending kernel easier") a new mechanism was introduced, for kernels
>=3D5.2, which embeds the kernel headers in the kernel image or a module
and exposes them in procfs for use by userland tools.

The archive containing the header files has nondeterminism caused by
header files metadata. This patch normalizes the metadata and utilizes
KBUILD_BUILD_TIMESTAMP if provided and otherwise falls back to the
default behaviour.

In commit f7b101d33046 ("kheaders: Move from proc to sysfs") it was
modified to use sysfs and the script for generation of the archive was
renamed to what is being patched.

Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>

---

v1: Initial fix

v2: Added a bit of info about kheaders to the reproducible builds
documentation and used the opportunity to fix a few typos in the
original patch.

---
 Documentation/kbuild/reproducible-builds.rst | 13 +++++++++----
 kernel/gen_kheaders.sh                       |  5 ++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/k=
build/reproducible-builds.rst
index ab92e98c89c8..ce6a408b3303 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -16,16 +16,21 @@ the kernel may be unreproducible, and how to avoid them=
.
 Timestamps
 ----------

-The kernel embeds a timestamp in two places:
+The kernel embeds timestamps in three places:

 * The version string exposed by ``uname()`` and included in
   ``/proc/version``

 * File timestamps in the embedded initramfs

-By default the timestamp is the current time.  This must be overridden
-using the `KBUILD_BUILD_TIMESTAMP`_ variable.  If you are building
-from a git commit, you could use its commit date.
+* If enabled via ``CONFIG_IKHEADERS``, file timestamps of kernel
+  headers embedded in the kernel or respective module,
+  exposed via ``/sys/kernel/kheaders.tar.xz``
+
+By default the timestamp is the current time and in the case of
+``kheaders`` the various files' modification times. This must
+be overridden using the `KBUILD_BUILD_TIMESTAMP`_ variable.
+If you are building from a git commit, you could use its commit date.

 The kernel does *not* use the ``__DATE__`` and ``__TIME__`` macros,
 and enables warnings if they are used.  If you incorporate external
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 9ff449888d9c..aff79e461fc9 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -71,7 +71,10 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
 find $cpio_dir -type f -print0 |
 =09xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\=
///smg;'

-tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
+# Create archive and try to normalize metadata for reproducibility
+tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
+    --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner \
+    -Jcf $tarfile -C $cpio_dir/ . > /dev/null

 echo "$src_files_md5" >  kernel/kheaders.md5
 echo "$obj_files_md5" >> kernel/kheaders.md5
--
2.23.0
