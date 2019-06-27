Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75331C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5099B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfF0O7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:59:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0O7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:59:06 -0400
Received: from orion.localdomain ([77.7.61.149]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVdYY-1i5mVZ1PfQ-00Rc8B; Thu, 27 Jun 2019 16:59:05 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net
Subject: [PATCH] scripts: helper for mailing patches from git to the maintainers
Date:   Thu, 27 Jun 2019 16:59:04 +0200
Message-Id: <1561647544-12685-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:pMuQmD+ZCt5STZ64P7Q6XVgeqWXwAT+iisU+o0IdWGbel7Kgtjb
 1ShGfoakZ3o685RfMWCqoaNfoh3VzNSp2pLfOMIIhxWRXtjuYRBYn36w8yrUwB0R3J6VPyy
 JXoZJvhBt+mQMenx+L3VRsEYPlw/90kwcdM7e2Qf0ui9t/Nn8G1DoYundAuHwfq2lUNOVwR
 RzkuWSFvednSJoKQhoJPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/e67JiFsa80=:YWO2yIIVMOMYjs58MLMmSf
 USmEIJbpvex/HqSYZs9/0oeOT2v2cp3LYyJ1hzxm4C8GXV6kmoutDhmI7vE2KLO/WZ/5s4jPm
 JGYRQwruakXV/BXtoclf9GvKBjNVE4re7mhobbreW2NKVs3niAeCnNVfLw6RYIw5l3aTqcJBL
 oDq5FkzrX/nL9Zyql/8V2Nj2zlmavEBzqtALkgAcSnL/pnaVvieoou7VJ2GQ30rp0VT11wghF
 NdoRaXrtXSC6qM5Fyfn87dN5xvlV9DH1ZIvAFsTrnw3ikA/aEaLlT2nOQ8ey31YIo5uXLf7JJ
 jhT9g8pYajJLyI1bTMHFacGutdhXkSx6G45uhiKaBB1nrjw3aP9AHS57PztUCaqNgf7dEpAnv
 OCBYqcExWCEY9W3CiyyLnoKe3+grb4b/GgMdg/1uCqvtS0Phr9oLsBg9yC6TaVZ/l7uuNyItr
 w2a3qzwfYvZ9D7xTauNO00W5PsOXhjlqnHOMpjU3DP9L+dacEykOURy033bwnGWn13smnlXIa
 ayf8PeTPRcsMapQa8dyUe9u/qXaekpEX3gvpoZEOtWKQhFvP2s1RMo65nAVK/gLihIsp1Ge+Q
 ragTp9gue3pZ4EkToKP4bhchHfw6SaU3uVjBEVdrZA6PuD9umVk1SmzsLDz8+PryrGT/qt5MP
 fQ8wFIjTYZKfoRQTa1BlEYxIctcyVVc+2GEIZGlSEqOrAg92bxF8ceSfvbkCr6Nhe0OlTyGz1
 qyBcwZjvlgk54nPMEVd9Lxcs67TxRDCwStiAbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a little helper script for mailing patches out of a git
branch to the corresponding maintainers.

Essentially, it scans the touched files, asks get_maintainer.pl
for their maintainers and calls git-send-email for mailing out
the patches.

Syntax:

  ./scripts/git-send-patch <ref> [<optional git-send-email args>]

Examples:

  ./scripts/git-send-patch HEAD^
  ./scripts/git-send-patch linus/master --dry-run

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 MAINTAINERS            |  5 ++++
 scripts/git-send-patch | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100755 scripts/git-send-patch

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735..b075c4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6694,6 +6694,11 @@ F:	Documentation/isdn/README.gigaset
 F:	drivers/isdn/gigaset/
 F:	include/uapi/linux/gigaset_dev.h
 
+GIT_SEND_PATCH SCRIPT
+M:	Enrico Weigelt, metux IT consult <info@metux.net>
+F:	scripts/git-send-patch
+S:	Maintained
+
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git
diff --git a/scripts/git-send-patch b/scripts/git-send-patch
new file mode 100755
index 0000000..b54790f
--- /dev/null
+++ b/scripts/git-send-patch
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+[ -x "$GIT" ]       || export GIT=git
+[ -d "$KERNELSRC" ] || export KERNELSRC=.
+
+LKML="linux-kernel@vger.kernel.org"
+
+check_ksrc() {
+    if [ -d $KERNELSRC/arch ] && \
+       [ -d $KERNELSRC/block ] && \
+       [ -d $KERNELSRC/init ] && \
+       [ -d $KERNELSRC/kernel ] && \
+       [ -d $KERNELSRC/sound ] && \
+       [ -d $KERNELSRC/drivers ] && \
+       [ -d $KERNELSRC/net ] && \
+       [ -d $KERNELSRC/include ] && \
+       [ -f $KERNELSRC/COPYING ] && \
+       [ -f $KERNELSRC/MAINTAINERS ] && \
+       [ -f $KERNELSRC/CREDITS ] && \
+       [ -f $KERNELSRC/Kconfig ] && \
+       [ -f $KERNELSRC/Makefile ]; then
+        return 0
+    else
+        echo "$0: cant find the kernel source tree. please call me from the topdir" >&2
+        exit 1
+    fi
+}
+
+check_ksrc
+
+get_files() {
+    $GIT diff --name-only "$REF"
+}
+
+get_maintainers() {
+    $KERNELSRC/scripts/get_maintainer.pl --m --l --remove-duplicates `get_files` |
+        grep -v "$LKML" | \
+        grep -E "(maintainer|reviewer|open list)" | \
+        grep -o '[[:alnum:]+\.\_\-]*@[[:alnum:]+\.\_\-]*'
+}
+
+construct_params() {
+    echo -n "--to=$LKML "
+    for a in `get_maintainers`; do
+        echo -n "--cc=$a "
+    done
+}
+
+if [ ! "$1" ]; then
+    echo "$0: missing git revision to send out" >&2
+    echo "" >&2
+    echo "for example: 'HEAD^' for sending just the last patch" >&2
+    echo >&2
+    echo "$0 <git-ref> [<extra params for git-send-mail>]"
+    exit 1
+fi
+
+REF="$1"
+shift
+
+$GIT send-email `construct_params` "$REF" "$@"
-- 
1.9.1

