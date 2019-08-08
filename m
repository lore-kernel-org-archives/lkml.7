Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C0FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F772086D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbfHHDnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:43:14 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44282 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728461AbfHHDnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:43:13 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x783hCLe020083
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:43:12 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x783h7eg012959
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:43:12 -0400
Received: by mail-qk1-f197.google.com with SMTP id c207so81092828qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=34FBdfks8oZeUDT01/sr/q7uElIvwz0ixxEG0Z2FOJY=;
        b=ctjqTBprKJrdOxo5ztgmPU/DWzBEcAJc/rujBM+vAioZRRt+4WIXe0BKhT9a5brDQT
         or2UPJzsWJQpZQac44iFbb3qx8i6DdOXbnCC3MT/YQaPc13BSREc8Wd094sd05mkXrK6
         zXxS9DdHpvfQNYnaz+8sF3QifvXwI656p+9yhxYT+bntEeZxZWj/6vgMlg93knxbhoeA
         rm7g+rkMO+FtmlBGl1LdEd01lxpBK/hsGEjEdCymDYKAIgxY4fGv1YPhEaYFi6H+inmI
         +JeCZJKk2ALro+F7WpS8Ew0ZkVXvWi7G6gE/i1c25cI3ZvClhVsWbbKJ0sl5nj8WbjiV
         XfQg==
X-Gm-Message-State: APjAAAXYhEnBwZiCvuTkwoQjwK8pEMIQvBoZJDbt5fngEkIDohQ5BTmN
        FGbMm6Wjn9A4TAo2A2ohEjlv3h9m8kMb79fecAQmgqSd314OGueaKQQhb48My3uicQ2GBwgtIqI
        Zjogxk/6x/yI+ooxgwh28QL9xhwHA643qgiY=
X-Received: by 2002:ac8:317a:: with SMTP id h55mr11297770qtb.105.1565235787116;
        Wed, 07 Aug 2019 20:43:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy5PD2Ou1paun3GU00mg+4b/y1jbdQOU9GJjJrghuNV+mDGp9JJIk4X6XbFfSKbMtfYOaUVuA==
X-Received: by 2002:ac8:317a:: with SMTP id h55mr11297757qtb.105.1565235786872;
        Wed, 07 Aug 2019 20:43:06 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id j50sm1361463qtj.30.2019.08.07.20.43.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 20:43:05 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/extable.c - add missing prototypes.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 07 Aug 2019 23:43:04 -0400
Message-ID: <45574.1565235784@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, a number of warnings are issued:

  CC      lib/extable.o
lib/extable.c:63:6: warning: no previous prototype for 'sort_extable' [-Wmissing-prototypes]
   63 | void sort_extable(struct exception_table_entry *start,
      |      ^~~~~~~~~~~~
lib/extable.c:75:6: warning: no previous prototype for 'trim_init_extable' [-Wmissing-prototypes]
   75 | void trim_init_extable(struct module *m)
      |      ^~~~~~~~~~~~~~~~~
lib/extable.c:115:1: warning: no previous prototype for 'search_extable' [-Wmissing-prototypes]
  115 | search_extable(const struct exception_table_entry *base,
      | ^~~~~~~~~~~~~~

Add the missing #include for the prototypes.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/lib/extable.c b/lib/extable.c
index 25da4071122a..c3e59caf7ffa 100644
--- a/lib/extable.c
+++ b/lib/extable.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/sort.h>
 #include <linux/uaccess.h>
+#include <linux/extable.h>
 
 #ifndef ARCH_HAS_RELATIVE_EXTABLE
 #define ex_to_insn(x)	((x)->insn)

