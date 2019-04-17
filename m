Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1736C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700820651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcWBjlU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfDQUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:15:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38770 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:15:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so28881201qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6v6KcEkS75wpAGqPcJpaPyTimG1OBw8fyJVHX7mRFl8=;
        b=XcWBjlU0atGDp0IkBW8UtiiKtCtoNHVtKPiCZ7+Ub+mfp5wddAP2LaJUYwnFEr6PMe
         Md83s6scLr1gKQP3i5Q66MwR0DW+RmCotvEoo+vHYUTOGwWZptv76A68IADVmkuVlqdB
         2HUBK/xmedLSrcZJgTTx3GV6+VdBuawX+GkyfYwte9FJvh2ROLqCw5Cv2/JY12xrUvxW
         BMsN2ZHcYvaSc5t+IABrlSZ3UhU5lF9qogxP2TZEMzx+EeWjFGI9Pq3/Q8ZREgbC8PCx
         GEacCPbHaFf63UnC5ivQiopPhn3OX3V+U666ZVyL05eH4VTD++SuFNmyYBtZeP8jOlce
         SYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6v6KcEkS75wpAGqPcJpaPyTimG1OBw8fyJVHX7mRFl8=;
        b=Y0LBjGvPkpXDaH4aoVP3XjdZ6vzykJcHjC/efbqstUCME194oFl5t24JuT9YlXx7o2
         v8exWL7iW3NtCbZqdJEi4s8Bq+dhSMIX/FEcXXJdyf4DC27XiRpJP2vTDcSFEgZVkkgd
         +SLmr2Pn6ILvtzhyyLYNrO07gZI3jT2/ytMy0JjyX4XuNnEFjFIOwxe30zfTR5xSZXgX
         pLRVQZEmCY5bzv66YfV2B2Qzbd7XuupX6qfdtZwhOq8hezPxOrWrSleWAlpe6WgmoRkc
         XH4oKrTQSeirqj9zfHreTtGRwgTug/9FbcsBRLMn37Nkq/8KvzhMlLiNyUphfGqqUV28
         AuCw==
X-Gm-Message-State: APjAAAUX9Z5FtmWzAnXodgZFy4I8KHqAzd4DfSXMiID22n/hucV8eMAx
        WPIRpGep5Q1+KZr4o1iO9w==
X-Google-Smtp-Source: APXvYqzrpIL0bqEkASajBDK29j5zI+5qFMLS+ALUtP5dVfiocqagFld+UWOCA3oeIQVkvDxnLykWwA==
X-Received: by 2002:ac8:4685:: with SMTP id g5mr73338754qto.242.1555532101502;
        Wed, 17 Apr 2019 13:15:01 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d142sm35319783qke.20.2019.04.17.13.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:15:00 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ktest: Add workaround to avoid unexpected power cycle
Date:   Wed, 17 Apr 2019 16:14:42 -0400
Message-Id: <20190417201442.15030-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Unexpected power cycle occurs while the installation of the
kernel.

That is because the default reboot command, "ssh $SSH_USER@$MACHINE
reboot" exits as 255 even if the reboot is successfully done,
like as:

  ]# ssh root@Test reboot
  Connection to Test closed by remote host.
  ]# echo $?
  255
  ]#

To avoid the unexpected power cycle, the reboot is considered as
successfully done if the reboot is the default command and the
return code is 255.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ea07d43856b8..765c6bc83ab4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1737,6 +1737,11 @@ sub run_command {
     my $dord = 0;
     my $dostdout = 0;
     my $pid;
+    my $is_default_reboot = 0;
+
+    if ($command eq $default{REBOOT}) {
+	$is_default_reboot = 1;
+    }
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
@@ -1791,6 +1796,10 @@ sub run_command {
     # shift 8 for real exit status
     $run_command_status = $? >> 8;
 
+    if ($run_command_status == 255 && $is_default_reboot) {
+	$run_command_status = 0;
+    }
+
     close(CMD);
     close(LOG) if ($dolog);
     close(RD)  if ($dord);
-- 
2.20.1

