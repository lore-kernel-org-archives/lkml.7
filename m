Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42EC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638A6205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKPUcC07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEIRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:47:30 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:45817 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:47:28 -0400
Received: by mail-qt1-f171.google.com with SMTP id t1so3460199qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=99hNsfwv1wBSWemPF3ysQllU+bttu/2/09vasul1uFo=;
        b=gKPUcC07KUUITJXrTtyiy604O5ynb+fTQXDHCzVwaTcA3BXzEAfC2K3COyJE+rhRMC
         V1FeF0uppaPFKf4VhTBLqeSGxQytLS1YQiahW/JsUPP7wMdlIqvVRuQtUzk8L9+9BNq9
         aVzbHIviKeULqCCC5429hgwyTDhYm0Bd+I5fcI6w2TC+QB9tEb50Phmd3y/predNAAWk
         VnDNTOpYyisMnjjLV/UglIj/PrJFf1F+rPjv8RJl7d7lD4E5lNlmOOZBrF1/UMZm4HlF
         YK3GW1XboDLuzV+aBXJzJlHXU6bRHi3J0aw7wOyHKhJP2pKb6e5akucNQ70xD5WUcKZ7
         c/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=99hNsfwv1wBSWemPF3ysQllU+bttu/2/09vasul1uFo=;
        b=oC0wM41xoAiWfgWDU/zZlKWo63DNS47Webb5141jlSnt7+M/zJdmfJm+UaI1B2Xi5e
         Ddve6x6iUua4aGOD9tHBMVXfwqvOVx8WE0VDlE37O4xcPlESm5Ck6J6YJtdPbKqn87V7
         hNSVsvgokQy5+Uu8bfjFjw2gXa9OEV6MT+LHSDDiY1AAtjqhBrOI8bUKLE2WPicK1sSq
         PyPlxxTjARg7v/z1n8570h1yi29y7Yyo4A77Na4PA/NWY+xalkQM0wdQL1lEK2H+C4sR
         7ja8BWVYUpK1zR6pryQZAV11jH26X2H8pZF4bqfbbkUKTAfEVXs+eVygNUVmCVOm4eb3
         wbBg==
X-Gm-Message-State: APjAAAVYGY5Ld1LPOdIKDuXUex2WQwWP6QlJYs5DZ2do6V8qJSig75AA
        EFh1r7YC+6PdmX9jPMdWfd1HPRw=
X-Google-Smtp-Source: APXvYqxMR4mdwnJ9Al6Wtc6PGOV8dSF9ScqjJEAqIK+8B34hxmDNuBy/3+Lb4rLnPSOmIcDlIBayPg==
X-Received: by 2002:a0c:b99c:: with SMTP id v28mr4835816qvf.10.1557424047369;
        Thu, 09 May 2019 10:47:27 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z11sm1262953qki.95.2019.05.09.10.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:47:26 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ktest: update sample.conf for grub2bls
Date:   Thu,  9 May 2019 13:46:30 -0400
Message-Id: <20190509174630.26713-6-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509174630.26713-1-msys.mizuma@gmail.com>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Update sample.conf for grub2bls.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/sample.conf | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 8c893a58b68e..5ac32ab1f3bc 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -349,13 +349,13 @@
 # option to boot to with GRUB_REBOOT
 #GRUB_FILE = /boot/grub2/grub.cfg
 
-# The tool for REBOOT_TYPE = grub2 to set the next reboot kernel
+# The tool for REBOOT_TYPE = grub2 or grub2bls to set the next reboot kernel
 # to boot into (one shot mode).
 # (default grub2_reboot)
 #GRUB_REBOOT = grub2_reboot
 
 # The grub title name for the test kernel to boot
-# (Only mandatory if REBOOT_TYPE = grub or grub2)
+# (Only mandatory if REBOOT_TYPE = grub or grub2 or grub2bls)
 #
 # Note, ktest.pl will not update the grub menu.lst, you need to
 # manually add an option for the test. ktest.pl will search
@@ -374,6 +374,10 @@
 # do a: GRUB_MENU = 'Test Kernel'
 # For customizing, add your entry in /etc/grub.d/40_custom.
 #
+# For grub2bls, a search of "title"s are done. The menu is found
+# by searching for the contents of GRUB_MENU in the line that starts
+# with "title".
+#
 #GRUB_MENU = Test Kernel
 
 # For REBOOT_TYPE = syslinux, the name of the syslinux executable
@@ -593,6 +597,8 @@
 # For REBOOT_TYPE = grub2, you must define both GRUB_MENU and
 # GRUB_FILE.
 #
+# For REBOOT_TYPE = grub2bls, you must define GRUB_MENU.
+#
 # For REBOOT_TYPE = syslinux, you must define SYSLINUX_LABEL, and
 # perhaps modify SYSLINUX (default extlinux) and SYSLINUX_PATH
 # (default /boot/extlinux)
-- 
2.20.1

