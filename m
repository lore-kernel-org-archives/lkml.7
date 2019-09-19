Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB815C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970042196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbfISQKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:10:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48390 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391755AbfISQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:10:46 -0400
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8JGAi2E014571
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:10:44 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8JGAdf4005247
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:10:44 -0400
Received: by mail-qk1-f200.google.com with SMTP id q80so4454421qke.22
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=d848aOTCyaHonxdkJdo2W7ZTuLzZ7sxhyBnfJKAw9iQ=;
        b=BTh2c6QV4c94Y21wWmEEXFAKF2SRj+cGRtMVBVIR71SKRFK/9yP6Lxtw3zPBXgjeMG
         uUkAEG10ZFJMJ021iBJTTy5PXIdtSjt7g+ouhg24jxEvkZNkZ8sE/TIaqQNeRH7xJ+V6
         9FA8A8vWfAnOVDd0koukdQmGexahb8mvhOcfizXXNqL930o0Jwh5lLq20rH9YcFJ5tO1
         VSYqE09/Z+gbZVIxGMf7JZtJuNMOL3Fk0Q02E/Vqzlqqks5IpgrbtR/9EhYO+ZHiSd+Z
         dqOPGmQv8Eq2SKXWALjouBiEzQW3jzmgbUloif/KF0eLw46yUHYeHxIzV2/pcKUqvvLU
         zMpQ==
X-Gm-Message-State: APjAAAVR1/m4N8MTl0Zp43pu7eUdUlcHBio54TtkVIziPM8uzacjBJ3K
        EOrmhQJqs2rsogqGzJw077WE1Q/DAcNNBYqI3MdrbOcvVvQGP027XC2CAkDAgoFnCQhWefhvU1r
        UDfpqEuyM36Wlgh9auY8uzUtfiYEVG9Y6k1I=
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr3686712qkk.39.1568909439653;
        Thu, 19 Sep 2019 09:10:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkXJdVVXmRPQhIsbZnbrmdExU8iXSQF5ptZOSLJ3XrawqDbaICnvtFOdLoVF6yrXl5Lp2wiQ==
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr3686690qkk.39.1568909439412;
        Thu, 19 Sep 2019 09:10:39 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id e5sm5912788qtk.35.2019.09.19.09.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 09:10:38 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] samples/watch_test - fix build error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 19 Sep 2019 12:10:37 -0400
Message-ID: <61479.1568909437@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're missing a depends in the Kconfig, which can lead to trying to
build without the required headers being present..

  HOSTCC  samples/watch_queue/watch_test
samples/watch_queue/watch_test.c:23:10: fatal error: linux/watch_queue.h: No such file or directory
   23 | #include <linux/watch_queue.h>
      |          ^~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.host:107: samples/watch_queue/watch_test] Error 1

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/samples/Kconfig b/samples/Kconfig
index 2c3e07addd38..d0761f29ccb0 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -171,6 +171,7 @@ config SAMPLE_VFS
 
 config SAMPLE_WATCH_QUEUE
 	bool "Build example /dev/watch_queue notification consumer"
+	depends on HEADERS_INSTALL
 	help
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.

