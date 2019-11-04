Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2871CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 03:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC5321D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 03:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfKDDel convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 22:34:41 -0500
Received: from mx7.zte.com.cn ([202.103.147.169]:59622 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfKDDel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 22:34:41 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 1C669989B3F1B7C30B8C;
        Mon,  4 Nov 2019 11:34:38 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id xA43XC9q090748;
        Mon, 4 Nov 2019 11:33:12 +0800 (GMT-8)
        (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019110411331571-271048 ;
          Mon, 4 Nov 2019 11:33:15 +0800 
From:   zhongshiqi <zhong.shiqi@zte.com.cn>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, corbet@lwn.net, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: [PATCH v6] coccicheck: Support search for SmPL scripts within selected directory hierarchy
Date:   Mon, 4 Nov 2019 11:35:55 +0800
Message-Id: <1572838555-12101-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-11-04 11:33:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-11-04 11:33:13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl1.zte.com.cn xA43XC9q090748
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Allow defining the environment variable “COCCI” as a directory to
search SmPL scripts.

*Start a corresponding file determination if it contains an acceptable
path.

*Update coccinelle.rst documents for use coccicheck with a directory
selection

Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
---
Changes in v6:
	update coccinelle.rst documents and add instructions for use this

Changes in v5:
	rewrite change description as an enumeration

Changes in v4:
	rewrite change description in another wording

Changes in v3:
	1:rewrite change description
	2:fix patch subject
	3:modify commit log

Changes in v2:
	1.fix patch subject according to the reply by Markus
	<Markus.Elfring@web.de>
	2.change description in “imperative mood”

 Documentation/dev-tools/coccinelle.rst | 51 ++++++++++++++++++++++------------
 scripts/coccicheck                     |  4 +++
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 00a3409..6af3201 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -100,8 +100,8 @@ Two other modes provide some common combinations of these modes.
   It should be used with the C option (described later)
   which checks the code on a file basis.
 
-Examples
-~~~~~~~~
+Using Coccinelle with defalut value
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To make a report for every semantic patch, run the following command::
 
@@ -127,6 +127,38 @@ To enable verbose messages set the V= variable, for example::
 
    make coccicheck MODE=report V=1
 
+Using Coccinelle with a single file selection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The optional make variable COCCI can be used to check a single
+semantic patch. In that case, the variable must be initialized with
+the name of the semantic patch to apply.
+
+For instance::
+
+	make coccicheck COCCI=<my_SP.cocci> MODE=patch
+
+or::
+
+	make coccicheck COCCI=<my_SP.cocci> MODE=report
+
+
+Using Coccinelle with directory selection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The optional make variable COCCI can be used to search SmPL scripts in a
+directory. In that case, the variable must be initialized with the name of
+a directory which contains scripts for the semantic patch language.
+
+For instance::
+
+	make coccicheck COCCI=<my_SPDIR> MODE=patch
+
+or::
+
+	make coccicheck COCCI=<my_SPDIR> MODE=report
+
+
 Coccinelle parallelization
 ---------------------------
 
@@ -148,21 +180,6 @@ When parmap is enabled, if an error occurs in Coccinelle, this error
 value is propagated back, the return value of the ``make coccicheck``
 captures this return value.
 
-Using Coccinelle with a single semantic patch
----------------------------------------------
-
-The optional make variable COCCI can be used to check a single
-semantic patch. In that case, the variable must be initialized with
-the name of the semantic patch to apply.
-
-For instance::
-
-	make coccicheck COCCI=<my_SP.cocci> MODE=patch
-
-or::
-
-	make coccicheck COCCI=<my_SP.cocci> MODE=report
-
 
 Controlling Which Files are Processed by Coccinelle
 ---------------------------------------------------
diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328..bfe0c94 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -257,6 +257,10 @@ if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
 	coccinelle $f
     done
+elif [ -d "$COCCI" ] ; then
+    for f in `find $COCCI/ -name '*.cocci' -type f | sort`; do
+       coccinelle $f
+    done
 else
     coccinelle $COCCI
 fi
-- 
2.9.5

