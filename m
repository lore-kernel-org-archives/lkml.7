Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4014C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD322CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfICKid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:38:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:46896 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727969AbfICKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:38:33 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x83AcVOR030408
        for <linux-kernel@vger.kernel.org>; Tue, 3 Sep 2019 06:38:31 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x83AcQr7002493
        for <linux-kernel@vger.kernel.org>; Tue, 3 Sep 2019 06:38:31 -0400
Received: by mail-qk1-f197.google.com with SMTP id m2so18568095qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 03:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=5NzM42bVBs/7E1wOe1xuaPM9MIvXN3HbYxHW7n917YA=;
        b=IWOP2VQcGN06soEJDaPxbfKTiPQPnaKg2Xh+QLlNqIJWyGLM2p2aDLPr2RLe9T3ceL
         aCeBBckzISHSXpsR1iFYP1n1Wp1IEpSXfyXp1Uvi7+KtLD4XQyhx88K8HV0yvo+7NB8t
         rfxx8U8qxLKnpRinhY9OvhqeiCXkLuTCmCc+kFgHgnhrka+z0cWhr9wEXLbgaFDw5tG/
         XQSphOxCW85VugBmQ3PLcegMEGZRi5oADl4HRmoRQsQP7mCoMa5odB/xdjxOkGK2MZh8
         Y7DTf4jfAzV1+3wwdf9c/PBxdFLf7WKrH2ujGB0UDrq+kYk1HQr7ixNHoPJLMYwfPpPr
         qFlQ==
X-Gm-Message-State: APjAAAXIXWx+7waNuOWVQTpGp7jjoB6e7Ai+F9MbudErnoDyC439EfGq
        EnLJDIySb057zNFtXN/vYba/IoONqu9zH8McAN6lGl2xREtUTQX9svIFwEJ+X3wLE+R9osrF2Ox
        jw7xLH+Orf1QJdTm+QGTXSTOvaqQZJOZJVXE=
X-Received: by 2002:ae9:f707:: with SMTP id s7mr6182268qkg.195.1567507105962;
        Tue, 03 Sep 2019 03:38:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxWzAd/YkPdEwKrKndHsYVVM6A2kzLmUcxv8tYM8Rx+8yEZ8dsBvvPMA5hbgaaKxPYWJ0qAZA==
X-Received: by 2002:ae9:f707:: with SMTP id s7mr6182250qkg.195.1567507105758;
        Tue, 03 Sep 2019 03:38:25 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id n12sm254398qkk.78.2019.09.03.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 03:38:24 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
cc:     Pablo Pellecchia <pablo9891@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/checkpatch.pl - don't check for const structs if list is empty
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 03 Sep 2019 06:38:23 -0400
Message-ID: <542749.1567507103@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the list of structures we expect to be const is empty (due to file permissions,
or the file being empty, etc), we get odd complaints about structures:

[/usr/src/linux-next] scripts/checkpatch.pl -f drivers/staging/netlogic/platform_net.h
No structs that should be const will be found - file '/usr/src/linux-next/scripts/const_structs.checkpatch': Permission denied
WARNING: struct  should normally be const
#9: FILE: drivers/staging/netlogic/platform_net.h:9:
+struct xlr_net_data {

WARNING: struct  should normally be const
#20: FILE: drivers/staging/netlogic/platform_net.h:20:
+	struct xlr_fmn_info *gmac_fmn_info;

total: 0 errors, 2 warnings, 0 checks, 21 lines checked

Fix it so that it actually *obeys* what it said about not finding structures.

Reported-by: Pablo Pellecchia <pablo9891@gmail.com>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f4b6127ff469..103c67665f61 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6497,7 +6497,7 @@ sub process {
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
 # and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
+		if ($line !~ /\bconst\b/ && $const_structs ne "" &&
 		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
 			WARN("CONST_STRUCT",
 			     "struct $1 should normally be const\n" . $herecurr);

