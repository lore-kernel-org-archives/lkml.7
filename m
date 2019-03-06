Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08E20652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfCFSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:06:26 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:45559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbfCFSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:06:26 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1YtP-1h4c8p0uPT-00350Y; Wed, 06 Mar 2019 19:06:24 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
Subject: [PATCH] scripts: helper for mailing patches from git to the maintainers
Date:   Wed,  6 Mar 2019 19:06:23 +0100
Message-Id: <1551895583-11955-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:y6AkdZqgk0jTwkHyflm0vA7WDmN9D/SVdtm9mPfwcukuYeJ5bT9
 HJhXxWQZ7HFpJJgsAJnYvjwIF/gpuv8Me2bMa847l+jy0p+V89l1SSv1HtyDqhYxL6GYpYJ
 w61fR1SRKmaPDLsmw7c8aO58WdZFO2yU7k/Rfqq/ssKsw0XubxY+yZsn0K53OyBXl++vzIB
 F5djdset4R65EM3ypB2BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+4MhfhsuG8=:jAjbrC6mAggqp8jlJHSzmx
 UWBm7HvuSw6gQWGf2TjLizU9vw8UVN77hCk9JElxJmjPVS7MOZjIN/qP/s0FGK7Kp3275psd3
 MRbmY4UZ/HDelWJlyfnjirVAkxDz1eRUHmSE+QfM765Nn7QFKmDMPgJcFKr9xHnjx2loftzki
 Va7To6VHl/MKFYZVrFoIx77lS/YUIif/7lx0hAraHXNlYJGu8aevtrjwTG0i2wfYLZh0i+eNK
 tZGs7MH/a9w/ehsqpW1bABwbyVTBclDTcGpfVtb5dF3Xn92Gf93wekFGSOdHVDwqk0Yrf60K+
 PLjZKLPpJAHcdj41KXzYV/O4QoEAm8bWMNDbTaLDlzxfoRXHAh9ESiCTUXoA7Qx7sJCMEk8+A
 JC05XoSh+BpF0bJ4TJ+S2gjaYejcNIh6rvxHSmOyI7JXmMh5ylr53xwBl0IATDaErI+2UFgsV
 gRfzzq3pf8wJhWvv/oo+CPFZiqXBORW1Jn2+wecuareQabH79dTOKY5VigYIBZwZSmPas4N44
 cuRwnGYimwSh49KCVOFsm2Mvn8uU2zb0mxPxiroM4p9Ury0qbZYlZElMeNzdG5B+lD9bll2JD
 J5vh+Go070B1gdVIjEh5wHRLpn1jZBibKvn014EfY5nzMQF2hCmArDqm9vVibOq91Xrsuwgx4
 92LcNqEAbJGMVpRoGiv98CDMhdgpEeG1fcb43oLGotjUvvTOPFumZ7GBpGXBr31S5TEMEwEt0
 HqJieEiCYRGy/K+y2T4zWxdqCepQR2W+fICsYQ==
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
 scripts/git-send-patch | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 scripts/git-send-patch

diff --git a/scripts/git-send-patch b/scripts/git-send-patch
new file mode 100755
index 0000000..bd3a538
--- /dev/null
+++ b/scripts/git-send-patch
@@ -0,0 +1,63 @@
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
+       [ -d $KERNELSRC/firmware ] && \
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

