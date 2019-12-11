Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D4C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578CE2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080124;
	bh=fqApEpiJswPrQQE2UddJFG1LKaOvkhQp23n/8LhV2U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVSVXNf3KoEOzQ8+07L7WJw5dv5dOBj1QUvaBVtmn7Z5SJmlP5ESEpkqhVdyBeze7
	 gips1bQsfNIIO8KuSr/5Pp0SfhzYAcnTNAaY381zhs+Xu5xB8zFp5Pgq+4M9WhpGdC
	 jU7yQ49Ow/vU1qQu7ULlzhizSce71wOXLu9OSIjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfLKPNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731373AbfLKPNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00C02464B;
        Wed, 11 Dec 2019 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077192;
        bh=fqApEpiJswPrQQE2UddJFG1LKaOvkhQp23n/8LhV2U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2Q196js8RagPb3WngA5flGQu8/gX7bkB3fTCJ9I9BnzAf6SoLyc+Fua53ysR34h6
         rQT1A84mbFEIqNxCSgqlGhiyiX9nKYX+0wFaj1WLjNw9PibVrT14RA/rUHhpXGHK9q
         YFsz57kirW4TsEHQwefbueaPQDEL2xIGeGuum/sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.3 006/105] time: Zero the upper 32-bits in __kernel_timespec on 32-bit
Date:   Wed, 11 Dec 2019 16:04:55 +0100
Message-Id: <20191211150222.848046258@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>

commit 7b8474466ed97be458c825f34a85f2c2b84c3f95 upstream.

On compat interfaces, the high order bits of nanoseconds should be zeroed
out. This is because the application code or the libc do not guarantee
zeroing of these. If used without zeroing, kernel might be at risk of using
timespec values incorrectly.

Originally it was handled correctly, but lost during is_compat_syscall()
cleanup. Revert the condition back to check CONFIG_64BIT.

Fixes: 98f76206b335 ("compat: Cleanup in_compat_syscall() callers")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191121000303.126523-1-dima@arista.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/time.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -881,7 +881,8 @@ int get_timespec64(struct timespec64 *ts
 	ts->tv_sec = kts.tv_sec;
 
 	/* Zero out the padding for 32 bit systems or in compat mode */
-	if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) ||
+					      in_compat_syscall()))
 		kts.tv_nsec &= 0xFFFFFFFFUL;
 
 	ts->tv_nsec = kts.tv_nsec;


