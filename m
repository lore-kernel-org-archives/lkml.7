Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91444C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73F21A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696886;
	bh=EnWOWXgtHqr3dAFC04IlHKFxsfEX7VQ3jS4M3PIxfbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9SPdZ8Jkc2t/+khIeO9n/O5IJ5aaD5Fwk2NSfLY51dFEw3ff5Ujv5r07Q932WgdI
	 i98ErwFjb6rBD1Uwl3Ebe397ytOPQ5gnsdH7WKDuI8ZPVi7HOMvwhIzB7rdWat8Ucb
	 byv+6EMpCxlPvaS/u91bgMR909lB51u1SOcDArsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbfJJIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388308AbfJJIlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:41:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B332054F;
        Thu, 10 Oct 2019 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696882;
        bh=EnWOWXgtHqr3dAFC04IlHKFxsfEX7VQ3jS4M3PIxfbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyo+w8nWTDuxTYaUcJJ59o2qCAB87VhbU16r3d1uSjKCN11oBmjZeEOCusSONlM58
         W8SjGN69Bxs94l9/P8gWTUN3HG5iBageBg9pp8V/jsNt2cLolMBkDzRZWLfNu42oL9
         0Qi+ZCUZL8U1KcwhaVrBZemQCQfQvr0kzj7oYLek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.3 080/148] sched: Add __ASSEMBLY__ guards around struct clone_args
Date:   Thu, 10 Oct 2019 10:35:41 +0200
Message-Id: <20191010083616.174108522@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seth Forshee <seth.forshee@canonical.com>

commit 61129dd29f7962f278b618a2a3e8fdb986a66dc8 upstream.

The addition of struct clone_args to uapi/linux/sched.h is not protected
by __ASSEMBLY__ guards, causing a failure to build from source for glibc
on RISC-V. Add the guards to fix this.

Fixes: 7f192e3cd316 ("fork: add clone3")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Cc: <stable@vger.kernel.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20190917071853.12385-1-seth.forshee@canonical.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/sched.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -33,6 +33,7 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+#ifndef __ASSEMBLY__
 /*
  * Arguments for the clone3 syscall
  */
@@ -46,6 +47,7 @@ struct clone_args {
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
 };
+#endif
 
 /*
  * Scheduling policies


