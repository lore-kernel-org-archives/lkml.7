Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B1C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D574B217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfEJP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:28:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60268 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfEJP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:28:15 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 76C5572CCD0;
        Fri, 10 May 2019 18:28:13 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 4B2F97CCE09; Fri, 10 May 2019 18:28:13 +0300 (MSK)
Date:   Fri, 10 May 2019 18:28:13 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/7] parisc: define syscall_get_error()
Message-ID: <20190510152812.GD28558@altlinux.org>
References: <20190510152640.GA28529@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510152640.GA28529@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_error() is required to be implemented on all
architectures in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_return_value(), and
syscall_get_arch() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Acked-by: Helge Deller <deller@gmx.de> # parisc
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v11: unchanged
    v10: unchanged
    v9: unchanged
    v8: added Acked-by from https://lore.kernel.org/lkml/1abba4b1-82ef-c23c-c59e-5562dcb5b1bb@gmx.de/
    v7: unchanged
    v6: unchanged
    v5: initial revision

 arch/parisc/include/asm/syscall.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index 80757e43cf2c..00b127a5e09b 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -29,6 +29,13 @@ static inline void syscall_get_arguments(struct task_struct *tsk,
 	args[0] = regs->gr[26];
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	unsigned long error = regs->gr[28];
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
 static inline long syscall_get_return_value(struct task_struct *task,
 						struct pt_regs *regs)
 {
-- 
ldv
