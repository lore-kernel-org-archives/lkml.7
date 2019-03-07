Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA6FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DA320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCGC21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:28:27 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:59795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfCGC20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:28:26 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4sD3-1h3eRi12bH-001wYu for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019
 03:28:25 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts: helper for mailing patches from git to the maintainers
Date:   Thu,  7 Mar 2019 03:28:19 +0100
Message-Id: <1551925699-22445-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551925699-22445-1-git-send-email-info@metux.net>
References: <1551895583-11955-1-git-send-email-info@metux.net>
 <1551925699-22445-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:eLq08S9yJi/7NjfcPCnymgRHnGBC5hPYxgXrn55rntWKm09+lEo
 eCy5LR0tJHC36OdA4rUpCXGOJ0b5QJcnKCLf92hMFBvEwHWSaQ3Kisv9PN/IaeyuJ09d/Ir
 ii1z3KY1lS5232OsklZlW0LxYFCHZX06w2AqsP6ZsR62xPNgliVZIa8lJeW8u4AffRl4zG3
 aNBxz9KvpyX2HkwV2GKtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yd2YEll4ngc=:RqABgsP05HnLsds2nBHBNQ
 IaoiMe4nnkV40BQjuO02b3ccNu3oSGLXumpAh8pXFZPwDLR4exj0DstT3gJkDhebm5NNkpsyS
 FpPOVjMCA0d35aTAwOHdmIl6DnlqFJWRXFSJTPZhpmeIu6DfyCBpzjjkb5cQClJ2BOk5gfUSR
 HRCSAIBjF8LafUC9OgH1qiSADnstVBP0MM+7GEUkyaP7gebyjlG/0XoAxrO/o6Bqk3PW897uu
 aSY4ypRJdIVY5eng9scYmuwTS8xXZlcvGoSdJfoxeUQPejQF9g0il0H4JnkJKLFSqWRigpabz
 FrzVBYG4XjbSs63Xu3CtUcihD6ZaVJvMRkSFQBEvkeZNxMLV1NO7PNUmyjg43XNZohMLmesnA
 0YbvnpAATpD7/J0fsafZkQfxdxVC9xwwwo1AqEtKhFluQuUgjOwAD5xdbm836MZP/LkOmcuDL
 OfrG9JfXXfkz6j9j3gew9/vnGtaqArZvB43Uhr/QvVUhVeb3Cl6qk2/3vnLHJGrTTCqyuO4i7
 4t7Akk5D7GdzQZwla382qAvINx0lo13cOYiGvCyLLbvDQ0+LXMIRZ+e+9n/ROa4TWa2ImB1qO
 HnWrV0cciB4rd6apTv9zb+p5MTYPQBTUHCT5FW9sOaAQSvw5m/kw00uYvZHrVN9YAqsULaN0H
 G5b7C1GMUjBSEahNfwlJgasAm4teQlU+TGqttPrwxbd97bR1aiT5YHRx+i2MOoE8uxCZxikwC
 aa7XOQYLZXHHj+hUOO+5cpmGHKMpyabddiv24A==
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
 scripts/git-send-patch | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 scripts/git-send-patch

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

