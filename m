Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59200C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266962184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893053;
	bh=zOFzaPp3tC6o+qncWuZ6pg4/tqSgJwxflaLtgkbW6hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ls2lz3tXULnvbcuXY70FsFvEl3y1BeHTwyp2yCevrmHd9/T458citMlQ/nisPedS
	 rqd4cwmWX7O1PR0JGqDiIpTYC8YgXy3D3ISLjHpiTXVPal/N4u82vy+oZAtwVYNsx4
	 AZPCGKeoRV2hvNEFGgM1foOydYcMLiAcmmv4RosA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfH0IEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbfH0IEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:04:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93E6206BA;
        Tue, 27 Aug 2019 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893044;
        bh=zOFzaPp3tC6o+qncWuZ6pg4/tqSgJwxflaLtgkbW6hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KL+LRDby6EL6caFXckAYL/zLQCB5c4ecI/8dnEJNRosesRTSVlHhDl9EGDR0rIbwD
         P1BJoDUUuatV6yTkjs/ODPBGkPW44eOvuiNxXOqGhCCyNIqiNcrqvSvYQYg5hNWaNQ
         8vUd5oDM/BfKdWFg3V4GjV3By0NqWRDlfyAEpEgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 099/162] x86/lib/cpu: Address missing prototypes warning
Date:   Tue, 27 Aug 2019 09:50:27 +0200
Message-Id: <20190827072741.681322652@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 04f5bda84b0712d6f172556a7e8dca9ded5e73b9 ]

When building with W=1, warnings about missing prototypes are emitted:

  CC      arch/x86/lib/cpu.o
arch/x86/lib/cpu.c:5:14: warning: no previous prototype for 'x86_family' [-Wmissing-prototypes]
    5 | unsigned int x86_family(unsigned int sig)
      |              ^~~~~~~~~~
arch/x86/lib/cpu.c:18:14: warning: no previous prototype for 'x86_model' [-Wmissing-prototypes]
   18 | unsigned int x86_model(unsigned int sig)
      |              ^~~~~~~~~
arch/x86/lib/cpu.c:33:14: warning: no previous prototype for 'x86_stepping' [-Wmissing-prototypes]
   33 | unsigned int x86_stepping(unsigned int sig)
      |              ^~~~~~~~~~~~

Add the proper include file so the prototypes are there.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/42513.1565234837@turing-police
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/cpu.c b/arch/x86/lib/cpu.c
index 04967cdce5d12..7ad68917a51e8 100644
--- a/arch/x86/lib/cpu.c
+++ b/arch/x86/lib/cpu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/types.h>
 #include <linux/export.h>
+#include <asm/cpu.h>
 
 unsigned int x86_family(unsigned int sig)
 {
-- 
2.20.1



