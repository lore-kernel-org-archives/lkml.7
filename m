Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001ACC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5552253D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004474;
	bh=av8gZuq+0abHRu6UaGoeAMPxv9tgYdnnG/MRCOMyuMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KB44BRDFkFss3dskj42k6ehYJ7m7FXMY/sql7819a31rMw/jgkJggn9KIdpABzj2R
	 lk4gBCnUqOjHfKqoWOIQ07WQXnJwxtTrWHzp63jwDwV01KFCE8gUFn92c7Js7B+stG
	 wtJSfmaymR8t0YcjeCsmoly/DMKmyDFDeWP11MDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgABWed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730532AbgABWeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:34:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E59722314;
        Thu,  2 Jan 2020 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004470;
        bh=av8gZuq+0abHRu6UaGoeAMPxv9tgYdnnG/MRCOMyuMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIuM25O8pkroRB7yMKcuiY1srKbQZ2VgMmpO0y/SvMrY0ZuAiPZBjZW6+6y8VtxyS
         uez+wXHxj4gUg9fm33hDccp1ldbG/xhjcLVGtCCX0jOtOelUWMmP/M/wMQBI02W1bP
         TeBn21bc5vbffQrVIOywq6xlT2VDaQ4odCF+9otw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Daniel T. Lee" <danieltimlee@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 020/137] samples: pktgen: fix proc_cmd command result check logic
Date:   Thu,  2 Jan 2020 23:06:33 +0100
Message-Id: <20200102220549.375314349@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel T. Lee <danieltimlee@gmail.com>

[ Upstream commit 3cad8f911575191fb3b81d8ed0e061e30f922223 ]

Currently, proc_cmd is used to dispatch command to 'pg_ctrl', 'pg_thread',
'pg_set'. proc_cmd is designed to check command result with grep the
"Result:", but this might fail since this string is only shown in
'pg_thread' and 'pg_set'.

This commit fixes this logic by grep-ing the "Result:" string only when
the command is not for 'pg_ctrl'.

For clarity of an execution flow, 'errexit' flag has been set.

To cleanup pktgen on exit, trap has been added for EXIT signal.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/pktgen/functions.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/samples/pktgen/functions.sh b/samples/pktgen/functions.sh
index 205e4cde4601..065a7e296ee3 100644
--- a/samples/pktgen/functions.sh
+++ b/samples/pktgen/functions.sh
@@ -5,6 +5,8 @@
 # Author: Jesper Dangaaard Brouer
 # License: GPL
 
+set -o errexit
+
 ## -- General shell logging cmds --
 function err() {
     local exitcode=$1
@@ -58,6 +60,7 @@ function pg_set() {
 function proc_cmd() {
     local result
     local proc_file=$1
+    local status=0
     # after shift, the remaining args are contained in $@
     shift
     local proc_ctrl=${PROC_DIR}/$proc_file
@@ -73,13 +76,13 @@ function proc_cmd() {
 	echo "cmd: $@ > $proc_ctrl"
     fi
     # Quoting of "$@" is important for space expansion
-    echo "$@" > "$proc_ctrl"
-    local status=$?
+    echo "$@" > "$proc_ctrl" || status=$?
 
-    result=$(grep "Result: OK:" $proc_ctrl)
-    # Due to pgctrl, cannot use exit code $? from grep
-    if [[ "$result" == "" ]]; then
-	grep "Result:" $proc_ctrl >&2
+    if [[ "$proc_file" != "pgctrl" ]]; then
+        result=$(grep "Result: OK:" $proc_ctrl) || true
+        if [[ "$result" == "" ]]; then
+            grep "Result:" $proc_ctrl >&2
+        fi
     fi
     if (( $status != 0 )); then
 	err 5 "Write error($status) occurred cmd: \"$@ > $proc_ctrl\""
@@ -105,6 +108,8 @@ function pgset() {
     fi
 }
 
+[[ $EUID -eq 0 ]] && trap 'pg_ctrl "reset"' EXIT
+
 ## -- General shell tricks --
 
 function root_check_run_with_sudo() {
-- 
2.20.1



