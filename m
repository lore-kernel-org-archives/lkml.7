Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD25C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592E23401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613000;
	bh=yLnWCBzURFYaphma3SALcWe00G9AD5Jynb2Nanj3EW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ottRgFdHmKbRq5e7ICiJq/Qz18moqZyYoWzqozIFoy8xhjFWuc9h6HY+YXqEZl39z
	 pNvRpqIdToheIQzMysTnVUBAh+MTbsTgAgQ1+K2BbFyjwqv+WINZfUTDMTNw8W4xtK
	 BhHiK2L66fnsmYiuLTpr8qS6088BU4MawjDL40zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfIDQDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732901AbfIDQDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:03:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6561022CF5;
        Wed,  4 Sep 2019 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612993;
        bh=yLnWCBzURFYaphma3SALcWe00G9AD5Jynb2Nanj3EW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIlRVpVnzyJklvGyQj1ZUI5TaOx7dDGd+6IscsR04rdk4AGs2Xe+8vFU773JPSV09
         ZKpl/wxTze2IKrymsieIqlleyNEeS1FJV/qCCetnuLN/UQ0unk+aXLfIkp4ZiJfZI8
         XxRGR1zBVRA1ouE7Y8JJ+rzyIbP0r2teqv5TErxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>, Laura Abbott <labbott@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Peng Fan <peng.fan@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 07/20] ARM: 8874/1: mm: only adjust sections of valid mm structures
Date:   Wed,  4 Sep 2019 12:02:50 -0400
Message-Id: <20190904160303.5062-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160303.5062-1-sashal@kernel.org>
References: <20190904160303.5062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit c51bc12d06b3a5494fbfcbd788a8e307932a06e9 ]

A timing hazard exists when an early fork/exec thread begins
exiting and sets its mm pointer to NULL while a separate core
tries to update the section information.

This commit ensures that the mm pointer is not NULL before
setting its section parameters. The arguments provided by
commit 11ce4b33aedc ("ARM: 8672/1: mm: remove tasklist locking
from update_sections_early()") are equally valid for not
requiring grabbing the task_lock around this check.

Fixes: 08925c2f124f ("ARM: 8464/1: Update all mm structures with section adjustments")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a9f6705aea238..731b7e64715b9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -691,7 +691,8 @@ static void update_sections_early(struct section_perm perms[], int n)
 		if (t->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(t, s)
-			set_section_perms(perms, n, true, s->mm);
+			if (s->mm)
+				set_section_perms(perms, n, true, s->mm);
 	}
 	read_unlock(&tasklist_lock);
 	set_section_perms(perms, n, true, current->active_mm);
-- 
2.20.1

