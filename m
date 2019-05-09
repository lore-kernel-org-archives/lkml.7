Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99112C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D702177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiRI1PmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfEIVhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46985 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfEIVhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id i31so4267345qti.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7btbbR7c/vPtht4PUO7krhfX4YX9xNNnfzzgtfFhs3M=;
        b=EiRI1PmKY/H4MM2Pxy1fqstG9RoZS3ea9LXQ6k3D1gQTfu/FZSnwICtMQCb3oKdnbe
         /C4qDU6MyrjZ3MtRJWjP3yeNjDYGcGR5Xo0qqc24V+aDeeWAW0hXLC4vy4Rt4JQhMDtk
         zr+vBZEC8nDKt0PUYh+2gm874xSw4UXHeTvydHqtabORZ0C3ZfcgoPGi1ojtRgnoEUgB
         gtyt9YjPb2c+8SPRhJFS9EL3T0w7MWpp8bx3nRF9A+D65Z2h7VgnvsRAAS5jTn3YMH/r
         kpWLejK+VBlV9soPbCjE0XyCu27WV/S4a3dzPU+6UttYEUsSlsWELa6VJ96ue5VCLbVf
         X/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7btbbR7c/vPtht4PUO7krhfX4YX9xNNnfzzgtfFhs3M=;
        b=YZNsauQbD2L3BRi8Kv5T9qEJfljA525nMZmO14ojhm76LMRH/8Ga/6rA40v/bQw5OI
         XoLaoRCS9OHU+p5Qab+HkFbEeFLgcVHBS87KGvt2no9og5Nv8pcTtvhHtRJX1tUcwvCv
         YkPFSgHZKDhKzh58gOO7YBBbdUMVYtUWtc3luliRDMfXsRq7EqiRmUJtdjD5zdVLhV4f
         V+SQNqjysDrBvnGDWoyGOzaCnjCPLc70WN6aBVMb979nnAjhtfBXUJjo1Rxyfxidl4c/
         9jAec07jdKaVkx3+23TDk/KKNNjgJhwbDcfXTPGqnl9amghDjYvoaTGxpFxJ4EdiqVXg
         v06w==
X-Gm-Message-State: APjAAAUMnzPUY36HGc7rOx+Mvofi0HuPC1cDPdiqClDQgrt6iS7Q33OU
        1bzFVPUeRenu9bw7D5ebyJfhn+E=
X-Google-Smtp-Source: APXvYqyDAuX0Eva6Q7a7gbNl1fSMMmb8SvyJuPLD9BtsJEdHQLsIXp+Sf/N23Tb+ZIfKBoR2xt705g==
X-Received: by 2002:a0c:b99d:: with SMTP id v29mr5587476qvf.3.1557437840955;
        Thu, 09 May 2019 14:37:20 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:20 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ktest: pass KERNEL_VERSION to POST_KTEST
Date:   Thu,  9 May 2019 17:36:45 -0400
Message-Id: <20190509213647.6276-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509213647.6276-1-msys.mizuma@gmail.com>
References: <20190509213647.6276-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

For BLS, kernel entry is added by kernel-install command through
POST_INSALL, for example,

POST_INSTALL = ssh root@Test "/usr/bin/kernel-install \
    add $KERNEL_VERSION /boot/vmlinuz-$KERNEL_VERSION"

The entry is removed by kernel-install command and the kernel
version is needed for the argument. 

Pass KERNEL_VERSION variable to POST_KTEST so that kernel-install
command can remove the entry like as follows:

POST_KTEST = ssh root@Test "/usr/bin/kernel-install remove $KERNEL_VERSION"

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index df0c609c7c50..abd6f37b0561 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4456,7 +4456,9 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 }
 
 if (defined($final_post_ktest)) {
-    run_command $final_post_ktest;
+
+    my $cp_final_post_ktest = eval_kernel_version $final_post_ktest;
+    run_command $cp_final_post_ktest;
 }
 
 if ($opt{"POWEROFF_ON_SUCCESS"}) {
-- 
2.20.1

