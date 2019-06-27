Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C65AC5B577
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BDF2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561678466;
	bh=DhbXS/lRJ0YKCR7QiNLqZ6ehzZ/Unb45HFzo6/0VNuQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qdWl26dog/EHplAEgJuts18tSZf2/tCIdR9OwiJ0EAC9xUC/1EvVD4qhkl2/c+jly
	 cvkQN/2L5MPFhpoTieF0NQKci6UPwbTA2ApWnxHZ05yr1S9kMK2DSHijFdyjPv5da4
	 eSoB2kE3TwtRATSFbZ6pLbJoGk06/h/M2Hlhr7rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF0XeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:34:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33740 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF0XeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:34:24 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so8654550iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l89hBvZrEHLPxhxyxMlfDGOIe5uXPNhT8ICPgxlxf2E=;
        b=LaEBtdw97EYwVjhQ2He+QVwcePOM+u4DJj74JjBzsoEmaYokSHAj68OTsYT1baTKfn
         0CpDvbNi+OFuNBVzKms0fRzzPcUbOQPoKyCTOXBKfdq9EjiNpTBFupVWEeGRNzo40xcq
         BQTtO2ZMq69zkSGlhefUHt3X8816bflaE3pSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l89hBvZrEHLPxhxyxMlfDGOIe5uXPNhT8ICPgxlxf2E=;
        b=jMIuG16hvGKORE3yaiEAMOsXhtJi4l+65knW543gP602VCWEQLLcPZA1L2oT8KypZ5
         AgqdmEfoFL30nFHkEwD/S0C5iaWVA/0uGjgx/1GkFHnhRZ9e1A51z/D4mUSyFbH4EzsZ
         u3ZI0Fg1CFRPSU6d3kTXgI3iO7wZSUn7Ajh3roCJYe8AX0MPUIqn1sNBo4AR4hlx0iRg
         EqxWzviQZozPN2LXZX3MvGLT1QTQGalJh1bpGRmydS0Q1pdq09PXRtPeEUobsgKi7dbK
         wY0US9nAfdkrWx90DmTgjZz9l0AIjv6NmhrJs3mDsCfNaEbcKmaG3lPruptzHKQfED4J
         EClQ==
X-Gm-Message-State: APjAAAXh163mk+YzVaSKcnrVk1atLhu2T/ksDzOZeL75T5HWNk1wCj+d
        scZ5YuoKuhlIv99IyqaRoGYMHw==
X-Google-Smtp-Source: APXvYqwj4rkWd8isFJNVQVTJ3enNTztWl/NXzCy6FgXuC6/2rhi87XUFdhvu6dzltHCuykaP0MNqJA==
X-Received: by 2002:a5d:885a:: with SMTP id t26mr3561199ios.218.1561678463873;
        Thu, 27 Jun 2019 16:34:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i23sm538506ioj.24.2019.06.27.16.34.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:34:23 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, allison@lohutok.net, gregkh@linuxfoundation.org,
        alexios.zavras@intel.com, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: timestamping: Fix SIOCGSTAMP undeclared build failure
Date:   Thu, 27 Jun 2019 17:34:21 -0600
Message-Id: <20190627233421.30340-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing linux/sockios.h include to fix the following SIOCGSTAMP
undeclared build error. In addition, remove the local defines for
SIOCGSTAMPNS and SIOCSHWTSTAMP and pick them up from linux/sockios.h.

timestamping.c:249:19: error: SIOCGSTAMP undeclared
   if (ioctl(sock, SIOCGSTAMP, &tv))

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../selftests/networking/timestamping/timestamping.c     | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/networking/timestamping/timestamping.c b/tools/testing/selftests/networking/timestamping/timestamping.c
index 0fbed67bf4f6..aca3491174a1 100644
--- a/tools/testing/selftests/networking/timestamping/timestamping.c
+++ b/tools/testing/selftests/networking/timestamping/timestamping.c
@@ -32,6 +32,7 @@
 #include <asm/types.h>
 #include <linux/net_tstamp.h>
 #include <linux/errqueue.h>
+#include <linux/sockios.h>
 
 #ifndef SO_TIMESTAMPING
 # define SO_TIMESTAMPING         37
@@ -42,14 +43,6 @@
 # define SO_TIMESTAMPNS 35
 #endif
 
-#ifndef SIOCGSTAMPNS
-# define SIOCGSTAMPNS 0x8907
-#endif
-
-#ifndef SIOCSHWTSTAMP
-# define SIOCSHWTSTAMP 0x89b0
-#endif
-
 static void usage(const char *error)
 {
 	if (error)
-- 
2.17.1

