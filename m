Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F8BC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC659222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570062439;
	bh=baLTMdx07iCqRCWMuubQkKARX70LMzRzCtll0Y/P/5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QkhLc9XXNkGxx4Pg2z81MQBUeNBMWl2o28mgfyIn1tnu+7s026ohFiyAGKlvqTVEX
	 lf4LBWuz9qhhlVpSoMYjT00jphGuuMcGFHk9er2HGSxXv9qKu2WVr9AMCHQWzM+mfZ
	 p6WEOAmhHiza2s36mgrYQvxBPw7KpyJI6r/1WsTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfJCA1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbfJCA06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A70B2245B;
        Thu,  3 Oct 2019 00:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062417;
        bh=baLTMdx07iCqRCWMuubQkKARX70LMzRzCtll0Y/P/5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEh8njNzMoJkMJy7mckQqaagh1d/ebBYfp02Cmc1X7IlTiSuEXUVHyqOx4ni66g90
         UTqumMFrnLoRpSHBIPNRnuWyudBrzbuprvqvfMPByIv1ww2L7ggy6tv1rE+PWbmu90
         woTLJZmZSzy85DL9e3G7UhYJbcxdtXCmxaV1z4Ds=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 17/32] tools/memory-model: Make runlitmus.sh generate .litmus.out for --hw
Date:   Wed,  2 Oct 2019 17:26:35 -0700
Message-Id: <20191003002650.11249-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

In the absence of "Result:" comments, the runlitmus.sh script relies on
litmus.out files from prior LKMM runs.  This can be a bit user-hostile,
so this commit makes runlitmus.sh generate any needed .litmus.out files
that don't already exist.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/runlitmus.sh | 54 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index 91af859..2865a96 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -28,42 +28,48 @@ if test -f "$litmus" -a -r "$litmus"
 then
 	:
 else
-	echo ' --- ' error: \"$litmus\" is not a readable file
+	echo ' !!! ' error: \"$litmus\" is not a readable file
 	exit 255
 fi
 
-if test -z "$LKMM_HW_MAP_FILE"
+if test -z "$LKMM_HW_MAP_FILE" -o ! -e $LKMM_DESTDIR/$litmus.out
 then
 	# LKMM run
 	herdoptions=${LKMM_HERD_OPTIONS--conf linux-kernel.cfg}
 	echo Herd options: $herdoptions > $LKMM_DESTDIR/$litmus.out
 	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 $herdoptions $litmus >> $LKMM_DESTDIR/$litmus.out 2>&1
-else
-	# Hardware run
+	ret=$?
+	if test -z "$LKMM_HW_MAP_FILE"
+	then
+		exit $ret
+	fi
+	echo " --- " Automatically generated LKMM output for '"'--hw $LKMM_HW_MAP_FILE'"' run
+fi
 
-	T=/tmp/checklitmushw.sh.$$
-	trap 'rm -rf $T' 0 2
-	mkdir $T
+# Hardware run
 
-	# Generate filenames
-	catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
-	mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
-	themefile="$T/${LKMM_HW_MAP_FILE}.theme"
-	herdoptions="-model $LKMM_HW_CAT_FILE"
-	hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
-	hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
+T=/tmp/checklitmushw.sh.$$
+trap 'rm -rf $T' 0 2
+mkdir $T
 
-	# Don't run on litmus tests with complex synchronization
-	if ! scripts/simpletest.sh $litmus
-	then
-		echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
-		exit 254
-	fi
+# Generate filenames
+catfile="`echo $LKMM_HW_MAP_FILE | tr '[A-Z]' '[a-z]'`.cat"
+mapfile="Linux2${LKMM_HW_MAP_FILE}.map"
+themefile="$T/${LKMM_HW_MAP_FILE}.theme"
+herdoptions="-model $LKMM_HW_CAT_FILE"
+hwlitmus=`echo $litmus | sed -e 's/\.litmus$/.'${LKMM_HW_MAP_FILE}'.litmus/'`
+hwlitmusfile=`echo $hwlitmus | sed -e 's,^.*/,,'`
 
-	# Generate the assembly code and run herd on it.
-	gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-	jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-	/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+# Don't run on litmus tests with complex synchronization
+if ! scripts/simpletest.sh $litmus
+then
+	echo ' --- ' error: \"$litmus\" contains locking, RCU, or SRCU
+	exit 254
 fi
 
+# Generate the assembly code and run herd7 on it.
+gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
+jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+
 exit $?
-- 
2.9.5

