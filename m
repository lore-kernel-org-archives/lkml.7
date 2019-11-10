Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC25C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33E1206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354320;
	bh=youHC11LHjAs4CWKcmpmT/pWr3+p84Nsi0dY0gcXfR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aeRkK+KiADYMfxFfR9K6N4LGT/NWFP+qd4rsNS30vOffW/5ugpZtDWJxyqDMetZPS
	 GNjor9yEiC1RRZ5itwAUHzuc6mF4xP+payvX5TUFElTYD4eJ3kym85NDxexoQD7dU1
	 mMWjlERm8hEZYgNYsjgJUISFhryfMq2ws9qhW0bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfKJCvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbfKJCvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:51:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9829C22583;
        Sun, 10 Nov 2019 02:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354301;
        bh=youHC11LHjAs4CWKcmpmT/pWr3+p84Nsi0dY0gcXfR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltsF3wRNvGeXBriGZr5AY7RnZ1AnsF1UF9kPMJ5RJRBB+jABKRhjNgTHNjZAooRRw
         tjIWRgS9ikX4Kv6wwpup5UoY3TsAFnRbHRD+JZqu2PtNQ2jsJjHOm1GhjMe3IQ0TNi
         S0uIjcvvKI2tps3RMQJrvupOGe1ijKcRR+S/bG3o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>,
        Russ Anderson <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 37/40] EDAC: Raise the maximum number of memory controllers
Date:   Sat,  9 Nov 2019 21:50:29 -0500
Message-Id: <20191110025032.827-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Ernst <justin.ernst@hpe.com>

[ Upstream commit 6b58859419554fb824e09cfdd73151a195473cbc ]

We observe an oops in the skx_edac module during boot:

  EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0
  EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
  EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
  ...
  EDAC MC13: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
  EDAC MC14: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
  EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
  Too many memory controllers: 16
  EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0

We observe there are two memory controllers per socket, with a limit
of 16. Raise the maximum number of memory controllers from 16 to 2 *
MAX_NUMNODES (1024).

[ bp: This is just a band-aid fix until we've sorted out the whole issue
  with the bus_type association and handling in EDAC and can get rid of
  this arbitrary limit. ]

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Russ Anderson <russ.anderson@hpe.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Link: https://lkml.kernel.org/r/20180925143449.284634-1-justin.ernst@hpe.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/edac.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index 4fe67b853de04..9bb4f3311e137 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -17,6 +17,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
+#include <linux/numa.h>
 
 struct device;
 
@@ -778,6 +779,6 @@ struct mem_ctl_info {
 /*
  * Maximum number of memory controllers in the coherent fabric.
  */
-#define EDAC_MAX_MCS	16
+#define EDAC_MAX_MCS	2 * MAX_NUMNODES
 
 #endif
-- 
2.20.1

