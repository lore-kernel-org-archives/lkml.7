Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A880C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889709;
	bh=/owAWAfWpzYBTAYkM82lVwXJD9Kz4nA/JxzbBtagY9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pNtpXVTb8Ss5SIU3UaGqx4nJj/MEiXIk2E8D/Zb7Z6Fzbvu3omw2BW+18Z8YSIGAe
	 qCj6DPsWCgOfZZoAzYzrpBPfI+/RqpYgnCESGdh+BqFkho0R6SHxg0H3uA1maiVBw0
	 KQp1/zyNT1UDetV4X8gKOx3iYRECtM6LTWhDu5j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfK0VGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732473AbfK0VGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:06:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647B62080F;
        Wed, 27 Nov 2019 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888801;
        bh=/owAWAfWpzYBTAYkM82lVwXJD9Kz4nA/JxzbBtagY9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5DZ015a4XIhWIyj6ynOx2JauxTOOu6/13S7R16G28MW3loOnSI+ue3NcIeebmGuT
         gnwc2YfVOh/6lphokBZ7qUprcmwjebBhw3JnoxXyGGEk5ujERuDJcavfOOsVzLeoWp
         QuCYMCAUMlUh5+XYSKDSfj47msjN/Uiyybp2cfww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org
Subject: [PATCH 4.19 273/306] x86/cpu_entry_area: Add guard page for entry stack on 32bit
Date:   Wed, 27 Nov 2019 21:32:03 +0100
Message-Id: <20191127203134.762505647@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 880a98c339961eaa074393e3a2117cbe9125b8bb upstream.

The entry stack in the cpu entry area is protected against overflow by the
readonly GDT on 64-bit, but on 32-bit the GDT needs to be writeable and
therefore does not trigger a fault on stack overflow.

Add a guard page.

Fixes: c482feefe1ae ("x86/entry/64: Make cpu_entry_area.tss read-only")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/cpu_entry_area.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -20,8 +20,12 @@ struct cpu_entry_area {
 
 	/*
 	 * The GDT is just below entry_stack and thus serves (on x86_64) as
-	 * a a read-only guard page.
+	 * a read-only guard page. On 32-bit the GDT must be writeable, so
+	 * it needs an extra guard page.
 	 */
+#ifdef CONFIG_X86_32
+	char guard_entry_stack[PAGE_SIZE];
+#endif
 	struct entry_stack_page entry_stack_page;
 
 	/*


