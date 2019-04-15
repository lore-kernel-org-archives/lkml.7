Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42575C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1123920880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355657;
	bh=y415yd9EL1Lt0z+HCuKYnaHLlFNuLTqjRyDtcz5lvtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqK9+aTeDReMmFO3bku1osR77if65Ap+5Xjev6V0fkEoeWP9ICv0EGgzVtbTf3puG
	 e38ZGSeDfi3L0JkbGyeEyOOmhEWmGyck2/qLzmwJbfrRul/wEkttE0rOMfOhj7BHtK
	 fqwDaNMK1LpxwWIDPZkmb9J0tzGEw8y7B5ma5VrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfDOTOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731696AbfDOTOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB652075B;
        Mon, 15 Apr 2019 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355648;
        bh=y415yd9EL1Lt0z+HCuKYnaHLlFNuLTqjRyDtcz5lvtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wG88J/THYlZCoW6br/W8zUUJSD26Y0B2XrUEs/ZQZXwEf5x/ZkjDcZpNa2t/oXvYk
         uMqQOnCrG0JdaRpRcfRLm1jyt4CuAl5DNwujuzp7bK0gJdw7ECNaWFFZKMscX5WC2Y
         OUEy+LVDvcYf6sjKhbBRX8VFH1otnmNUILDFrhJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Guo Ren <ren_guo@c-sky.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 100/117] csky: Fix syscall_get_arguments() and syscall_set_arguments()
Date:   Mon, 15 Apr 2019 21:01:10 +0200
Message-Id: <20190415183749.871406757@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry V. Levin <ldv@altlinux.org>

commit ed3bb007021b9bddb90afae28a19f08ed8890add upstream.

C-SKY syscall arguments are located in orig_a0,a1,a2,a3,regs[0],regs[1]
fields of struct pt_regs.

Due to an off-by-one bug and a bug in pointer arithmetic
syscall_get_arguments() was reading orig_a0,regs[1..5] fields instead.
Likewise, syscall_set_arguments() was writing orig_a0,regs[1..5] fields
instead.

Link: http://lkml.kernel.org/r/20190329171230.GB32456@altlinux.org

Fixes: 4859bfca11c7d ("csky: System Call")
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: stable@vger.kernel.org # v4.20+
Tested-by: Guo Ren <ren_guo@c-sky.com>
Acked-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/csky/include/asm/syscall.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -49,10 +49,11 @@ syscall_get_arguments(struct task_struct
 	if (i == 0) {
 		args[0] = regs->orig_a0;
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+	memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
 }
 
 static inline void
@@ -63,10 +64,11 @@ syscall_set_arguments(struct task_struct
 	if (i == 0) {
 		regs->orig_a0 = args[0];
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
 }
 
 static inline int


