Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54064206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKHlv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:41:51 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:49780 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfKKHlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:41:51 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 9E3E6162B64E7E894F6A;
        Mon, 11 Nov 2019 15:41:40 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id xAB7d6ej071507;
        Mon, 11 Nov 2019 15:39:06 +0800 (GMT-8)
        (envelope-from zhong.shiqi@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019111115391041-386045 ;
          Mon, 11 Nov 2019 15:39:10 +0800 
From:   zhongshiqi <zhong.shiqi@zte.com.cn>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, corbet@lwn.net, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, zhongshiqi <zhong.shiqi@zte.com.cn>
Subject: [PATCH v7] coccicheck: Support search for SmPL scripts within selected directory hierarchy
Date:   Mon, 11 Nov 2019 15:42:04 +0800
Message-Id: <1573458124-14528-1-git-send-email-zhong.shiqi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-11-11 15:39:10,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-11-11 15:39:07
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl1.zte.com.cn xAB7d6ej071507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Allow defining the environment variable “COCCI” as a directory to
 search SmPL scripts.

*Start a corresponding file determination if it contains an acceptable
 path.

*Adjust software documentation for using coccicheck with
 a selected directory.

Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
---
Changes in v7:
        1:adjust coccinelle.rst documentation
        2:fix a repo of "default"

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

---
 Documentation/dev-tools/coccinelle.rst | 69 +++++++++++++++++++++-------------
 scripts/coccicheck                     |  4 ++
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 00a3409..90abe21 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -100,8 +100,8 @@ Two other modes provide some common combinations of these modes.
   It should be used with the C option (described later)
   which checks the code on a file basis.
 
-Examples
-~~~~~~~~
+Using Coccinelle with the default configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To make a report for every semantic patch, run the following command::
 
@@ -127,41 +127,36 @@ To enable verbose messages set the V= variable, for example::
 
    make coccicheck MODE=report V=1
 
-Coccinelle parallelization
----------------------------
+Using Coccinelle with a single file selection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-By default, coccicheck tries to run as parallel as possible. To change
-the parallelism, set the J= variable. For example, to run across 4 CPUs::
+The optional make variable COCCI can be used to check a single
+semantic patch. In that case, the variable must be initialized with
+the name of the semantic patch to apply.
 
-   make coccicheck MODE=report J=4
+For instance::
 
-As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization,
-if support for this is detected you will benefit from parmap parallelization.
+	make coccicheck COCCI=<my_SP.cocci> MODE=patch
 
-When parmap is enabled coccicheck will enable dynamic load balancing by using
-``--chunksize 1`` argument, this ensures we keep feeding threads with work
-one by one, so that we avoid the situation where most work gets done by only
-a few threads. With dynamic load balancing, if a thread finishes early we keep
-feeding it more work.
+or::
 
-When parmap is enabled, if an error occurs in Coccinelle, this error
-value is propagated back, the return value of the ``make coccicheck``
-captures this return value.
+	make coccicheck COCCI=<my_SP.cocci> MODE=report
 
-Using Coccinelle with a single semantic patch
----------------------------------------------
 
-The optional make variable COCCI can be used to check a single
-semantic patch. In that case, the variable must be initialized with
-the name of the semantic patch to apply.
+Using Coccinelle with directory selection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The optional make variable COCCI can be used to search semantic patch in a
+directory. In that case, the variable must be initialized with the name of
+a directory which contains semantic patches.
 
 For instance::
 
-	make coccicheck COCCI=<my_SP.cocci> MODE=patch
+	make coccicheck COCCI=<my_SPDIR> MODE=patch
 
 or::
 
-	make coccicheck COCCI=<my_SP.cocci> MODE=report
+	make coccicheck COCCI=<my_SPDIR> MODE=report
 
 
 Controlling Which Files are Processed by Coccinelle
@@ -187,12 +182,34 @@ In these modes, which works on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
 
 This runs every semantic patch in scripts/coccinelle by default. The
-COCCI variable may additionally be used to only apply a single
-semantic patch as shown in the previous section.
+COCCI variable may additionally be used to apply a single semantic
+patch or a directory which contains semantic patches as shown in the
+previous section.
 
 The "report" mode is the default. You can select another one with the
 MODE variable explained above.
 
+Coccinelle parallelization
+--------------------------
+
+By default, coccicheck tries to run as parallel as possible. To change
+the parallelism, set the J= variable. For example, to run across 4 CPUs::
+
+   make coccicheck MODE=report J=4
+
+As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization,
+if support for this is detected you will benefit from parmap parallelization.
+
+When parmap is enabled coccicheck will enable dynamic load balancing by using
+``--chunksize 1`` argument, this ensures we keep feeding threads with work
+one by one, so that we avoid the situation where most work gets done by only
+a few threads. With dynamic load balancing, if a thread finishes early we keep
+feeding it more work.
+
+When parmap is enabled, if an error occurs in Coccinelle, this error
+value is propagated back, the return value of the ``make coccicheck``
+captures this return value.
+
 Debugging Coccinelle SmPL patches
 ---------------------------------
 
diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328..e64a22e 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -257,6 +257,10 @@ if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
 	coccinelle $f
     done
+elif [ -d "$COCCI" ] ; then
+    for f in `find $COCCI/ -name '*.cocci' -type f | sort`; do
+    coccinelle $f
+    done
 else
     coccinelle $COCCI
 fi
-- 
2.9.5

