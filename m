Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70410C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEE8206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfIPPDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:03:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbfIPPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:03:42 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1i9sXV-0003VF-Be
        for linux-kernel@vger.kernel.org; Mon, 16 Sep 2019 15:03:41 +0000
Received: by mail-wm1-f72.google.com with SMTP id r187so123922wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpaiSLVZTJH//yVMd4hniWSWY+v8c4Nt+/1LTwDfd60=;
        b=O1MzUgqJofrnIlY9xfpvtwMuPCQrJgl/AzNxnG4v6yGO/mB9eq87xLfMXW9HjGS9CR
         S0hJB/f7SGUlLoCLZHqJXqK7PQBrKCwm/RspXr2Iw9lPDqqQ0cpKVCQqNAXNIpWjPMhf
         KuuEpqsG6OuitIOxR06Bg0pq4Ls8CFphu90WiHgsneV55n7WNJfn+Wn3/LSm6ErIRdgn
         JcqvUlFq/2VgLtYmDVhQkp7JeF5f52HoAdMBEO+58AQibu4yblqRoivrp/vkTePyXvEV
         yer6Z9sIldsRDqIMd8ShrO4Pcl3fDeNLiR3iGJD/AKJmjAErNQE3D4MCm83CZAhSfspJ
         +f5g==
X-Gm-Message-State: APjAAAVce+B7Aiilt6XRFVgZTuBSZW2UZX4rQBOv0j26aW50BHOOvN4D
        i7sWSI5r9ESwWg5TkPR+VWMGjroDEU+SxPzwy4Yx43B8H4K+Nk4PbKAabPKULcReHvpKs612yGd
        Yl9FZzNniPHHNUyNfEjIfKoHGtMfDis1OLkh07eKN
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr159041wrs.191.1568646220537;
        Mon, 16 Sep 2019 08:03:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQBkINemvJ4SG/cnXsg6i1JejX1kLd5HO272cp1ciclatRAjNPd1icxSBzVQh00CQOmLtm2A==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr159015wrs.191.1568646220250;
        Mon, 16 Sep 2019 08:03:40 -0700 (PDT)
Received: from localhost.localdomain (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id w125sm121823wmg.32.2019.09.16.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:03:39 -0700 (PDT)
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: replace AF_MAX with INT_MAX in socket.c
Date:   Mon, 16 Sep 2019 12:03:37 -0300
Message-Id: <20190916150337.18049-1-marcelo.cerri@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INT_MAX instead of AF_MAX, since libc might have a smaller value
of AF_MAX than the kernel, what causes the test to fail.

Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
---
 tools/testing/selftests/net/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
index afca1ead677f..10e75ba90124 100644
--- a/tools/testing/selftests/net/socket.c
+++ b/tools/testing/selftests/net/socket.c
@@ -6,6 +6,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
+#include <limits.h>
 
 struct socket_testcase {
 	int	domain;
@@ -24,7 +25,10 @@ struct socket_testcase {
 };
 
 static struct socket_testcase tests[] = {
-	{ AF_MAX,  0,           0,           -EAFNOSUPPORT,    0 },
+	/* libc might have a smaller value of AF_MAX than the kernel
+	 * actually supports, so use INT_MAX instead.
+	 */
+	{ INT_MAX, 0,           0,           -EAFNOSUPPORT,    0  },
 	{ AF_INET, SOCK_STREAM, IPPROTO_TCP, 0,                1  },
 	{ AF_INET, SOCK_DGRAM,  IPPROTO_TCP, -EPROTONOSUPPORT, 1  },
 	{ AF_INET, SOCK_DGRAM,  IPPROTO_UDP, 0,                1  },
-- 
2.20.1

