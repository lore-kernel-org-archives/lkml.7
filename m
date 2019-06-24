Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47ED20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niuOD7/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfFXK30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:29:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39251 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFXK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:29:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so6647300pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ruy4YoZoNy/tVEiTS0Tvm5WFg6c0N/QDLB40V4mMtvs=;
        b=niuOD7/2sWlUiSgtZ5102zomOMlMwnGNUwjyUrziDEjrwzNyqhJFHxc3Iq1aWwmvQj
         QP6AVrdcheIF8Yje/FY9HH/qXEe8LUc38Onbrr6NPUAU6K8TT4OzMOvU4I0JUp3T4Rf+
         etPn/u16pnRfIeCj/jCFzcPlpTx20Hi48q/0elu9LhPHulW1ur8qtwdv45MpyVdfpVZJ
         1wv9P5e9FxYswdjWgX50ISptdOmJ2VYVtAq/SX3QE+oJqGt/T4iJiEo40Z4qTMLNjm+V
         ZykWSR7Dvyy7cvbIpmlqONU3yqvcKH4J5NN/aJZR8+bEt6Nj4i+L961/Lp2XSmB0aVC+
         +5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ruy4YoZoNy/tVEiTS0Tvm5WFg6c0N/QDLB40V4mMtvs=;
        b=LUpkuCOuw/nfyc/XGxMX5Lgo2pX2CzSmk4Db0k7xtJDzaoSrh3Tq0P6GkM6Tf9dLM3
         n/NJJafHCq1SYb0W2zeJ0kEOHuRbvR0pdUjFJF4HChwmrqfgy4O18FTUDRJvbsM9IgAB
         FUX0XprLBuw3+ZtR3asy54k8s4Jhc+B1HCRIZujB5SBUrynbi6qs1zi4FexltX6Ponf9
         7C9VC5WVPe5eBsIS3gyt/R+ovl8qBoWFjT9cL0G9KlG6wCM/YV3AKrLvrXCuvueg6pX3
         UhyPXCAUD1F1cK4A6g1y3TtqSMoEFvnO/X88Sf3OK4iA9NtcsA/QJWDuxX2vmSVsQMlR
         MSIw==
X-Gm-Message-State: APjAAAWi6bSYXLZpA801TjzXcxLWfU6g6PTvgCpFoteLKcroWuOYhC8u
        hQU2qPLw7XkZoBUmgeK409M=
X-Google-Smtp-Source: APXvYqy/Kzae7ns02OOgKpPb3Qi1vTsZsPXKfyT9aIgbov/gWc6/4+LbUzzAFtGANvuhjNzHQUGEHQ==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr75376209plp.109.1561372165701;
        Mon, 24 Jun 2019 03:29:25 -0700 (PDT)
Received: from masabert (150-66-68-254m5.mineo.jp. [150.66.68.254])
        by smtp.gmail.com with ESMTPSA id 135sm14766896pfb.137.2019.06.24.03.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 03:29:25 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id DDCFC2011C8; Mon, 24 Jun 2019 19:29:21 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, allison@lohutok.net,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, rostedt@goodmis.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] linux-next: ktest: Fix typo in ktest.pl
Date:   Mon, 24 Jun 2019 19:29:15 +0900
Message-Id: <20190624102915.25839-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.190.ga6a95cd1b46e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix some spelling typo in ktest.pl

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/ktest/config-bisect.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
index 72525426654b..6fd864935319 100755
--- a/tools/testing/ktest/config-bisect.pl
+++ b/tools/testing/ktest/config-bisect.pl
@@ -663,7 +663,7 @@ while ($#ARGV >= 0) {
     }
 
     else {
-	die "Unknow option $opt\n";
+	die "Unknown option $opt\n";
     }
 }
 
@@ -732,7 +732,7 @@ if ($start) {
 	}
     }
     run_command "cp $good_start $good" or die "failed to copy to $good\n";
-    run_command "cp $bad_start $bad" or die "faield to copy to $bad\n";
+    run_command "cp $bad_start $bad" or die "failed to copy to $bad\n";
 } else {
     if ( ! -f $good ) {
 	die "Can not find file $good\n";
-- 
2.22.0.190.ga6a95cd1b46e

