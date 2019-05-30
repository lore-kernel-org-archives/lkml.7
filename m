Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB6C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CB825079
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189183;
	bh=xNydASI18Rj2zLvBaJytxcUwe6gFezTCWCARsuFWbys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMJp42gVMwAIMdvUKMsqauEmsGuzGwoCu7TQv/2ZMYea8hbPS33+IYYy9K58mRZVB
	 ECkbscF20RVBh9yce5HzY6mupDTP3jfiD56colK3/oi3Wt+aQkSbUMTgoCH1zGoddi
	 bOtfuTeZ0oZvRfB7T9czfAoxEVtYLNOsMpzKrS08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfE3EGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbfE3DRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:35 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0458D246EE;
        Thu, 30 May 2019 03:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186255;
        bh=xNydASI18Rj2zLvBaJytxcUwe6gFezTCWCARsuFWbys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rx43P8SqF9Czn9kYPEX5u0IrTVeMmLWayk1ETrTcFBma+YOQ3wUgPcQo4/PDGLR1c
         zgJ9gE17jp/XeQbcukueJOnXIirTB2p1Ijkis5r3GthKYYQ7qnd5E0K/vITMKHEIXP
         MYdkXj1ZEhTCFQ6nbw2AP1E0d2OP0FKrtitdBnBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 174/276] x86/microcode: Fix the ancient deprecated microcode loading method
Date:   Wed, 29 May 2019 20:05:32 -0700
Message-Id: <20190530030536.226687991@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 24613a04ad1c0588c10f4b5403ca60a73d164051 ]

Commit

  2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")

added the new define UCODE_NEW to denote that an update should happen
only when newer microcode (than installed on the system) has been found.

But it missed adjusting that for the old /dev/cpu/microcode loading
interface. Fix it.

Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Link: https://lkml.kernel.org/r/20190405133010.24249-3-bp@alien8.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b9bc8a1a584e3..b43ddefd77f45 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -418,8 +418,9 @@ static int do_microcode_update(const void __user *buf, size_t size)
 		if (ustate == UCODE_ERROR) {
 			error = -1;
 			break;
-		} else if (ustate == UCODE_OK)
+		} else if (ustate == UCODE_NEW) {
 			apply_microcode_on_target(cpu);
+		}
 	}
 
 	return error;
-- 
2.20.1



