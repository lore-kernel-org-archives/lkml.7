Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED4D20409
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKUNft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:35:49 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKUNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:35:48 -0500
Received: from orion.localdomain ([95.115.120.75]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2wbS-1iYtcV1qLk-003OCr; Thu, 21 Nov 2019 14:35:47 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net
Subject: [PATCH] scripts: helper for mailing patches from git to the maintainers
Date:   Thu, 21 Nov 2019 14:35:30 +0100
Message-Id: <20191121133530.14534-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:EovKbd9C5qnt3jveiYswu6hvjcPpeZqFssM86sVmNum3/T4khqQ
 jllKIxc1TzgHBTWEfKPl5vgAdyn3NHLfHNvvMgkXpcdaPJxIu20Fl8PyAo1j1x+J9eLw1Yj
 09IFUF60V6CHATPIco4ZfD0m8gpESpwPchXe5YPYI53kyFvAetqvk4A/WMr+HE2ZcpzFxWc
 fL611uKoRYZrqiTrinmAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1mDJSTJSYFg=:d8BL5ZwGjojbGioBvZdmyi
 RYU9UyOFeBj2c2SmfDzOMek2Rp+zl08X7bA8eHldX1+NTc2WcKjTS57z4AUk9+goeneF57kRh
 BVSY2e/6Ers4Nof/j8llWII6XdstN/YhtzygaAGdVqRWrE3QKlSFSFNWn1KM1azC8VLhhyUB6
 DzS0Q+TpcNydGHZv2/aiFAVuarJoak9McR+erKNYBhflW91JG8tlDVliN7IIBK+/ErQi4eafB
 PCEI2AaKP5TE/8eEXW21IdCIePJlAv68TGd8L18o0mEdMAr1leicfvzRs0jkXQ9Q4RQK+hygA
 LmXp8FZDGRDZznkhuTZexmNT0T7h517Nm1dEEU5TmkdxPCPjYhP1rk2gAelbv+bthJohkmJDS
 A0dongG86FricHRXxPnM4+Lb1BxkH/KZLZxbXN76mrJTdzcZ4N9L+QARsIYsWVc8tGo9kf6Mo
 jwa8w6V1yaLY76lpt/1d3l5Xvk0YZlgqxUKCEmJ89tgcqnPuDkNXSf133N6YL3lgeAVg3b7bX
 OQcwJhfjqU01e39Ne347WOOifEVp1PUyONucdEN7vues8E6zrby1vpnk5Xt3EXFlqJqstCb2B
 c7vtiqgO5mNNeZKaBqaJ9uXzv9rO/VQlq95OJMMX/nESck76VDdl+h+CvH8me97nYqCZLcENa
 wDwUxX8AopjTz8qzV8yu1OxqlqDpxhnUsEyoMAWQTeNE00B7xor0FZtreLW8FWyFXSHnEJB/X
 qtebs1cEzq/s3jO/zle19zbFOQIt9R2PRys8iH4VKgHdn39LKviZtPyjQOwA+XbCafIvED8Q1
 JBVM2K6FgWuHFoMF/+avklPFRgKUoACSE4wKCBSthE8xMKR11Oiyd+yUXLh0DbsKfpZ5hXNoW
 Rx8bucyaevImOA2dvWqw==
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
index e4f170d8bc29..b47973c922d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6929,6 +6929,11 @@ F:	Documentation/filesystems/gfs2*.txt
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 
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
index 000000000000..b54790fd1cc1
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
2.11.0

