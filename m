Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FECC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC4721479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054925;
	bh=FHZuVNPHrPEskjr4ytkC96O85qWn+vClIozAy1WdJBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EkDQwMNnjzmi++Tvjl2v/R+NQ7Hs60ZnnG51rw2mIYYoIeaGl/2wg5TYPQKMNZOdE
	 bX91LTNUu4PrKzDjxGW9dJBUKwRXoErg2oXL7epMLsMBK+A6ZNcCmYiSZz318N/Jlr
	 RCVd+pX7PfoffVlFkHlCfQWXClgQfZN0143vAq7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfGBIIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbfGBIIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D042521855;
        Tue,  2 Jul 2019 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054919;
        bh=FHZuVNPHrPEskjr4ytkC96O85qWn+vClIozAy1WdJBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3+yXiiPd88E2WpfMYtBYq0+faZNMO9rSzJaX8bKE8inTeiwsSsuyQGB0WrLBlMlk
         UIG7jRfA8j7LH39dQ1oAGGNrhgrjkqIK5NaTr2n0zAdedn9yFAXY/2IU+gtGzrfKKH
         d7Z2TJMmkTFHfMFkFtFfnjcrjyaAK/dpyq2uV8w4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 70/72] futex: Update comments and docs about return values of arch futex code
Date:   Tue,  2 Jul 2019 10:02:11 +0200
Message-Id: <20190702080128.275446262@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 427503519739e779c0db8afe876c1b33f3ac60ae upstream.

The architecture implementations of 'arch_futex_atomic_op_inuser()' and
'futex_atomic_cmpxchg_inatomic()' are permitted to return only -EFAULT,
-EAGAIN or -ENOSYS in the case of failure.

Update the comments in the asm-generic/ implementation and also a stray
reference in the robust futex documentation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/robust-futexes.txt |    3 +--
 include/asm-generic/futex.h      |    8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

--- a/Documentation/robust-futexes.txt
+++ b/Documentation/robust-futexes.txt
@@ -218,5 +218,4 @@ All other architectures should build jus
 the new syscalls yet.
 
 Architectures need to implement the new futex_atomic_cmpxchg_inatomic()
-inline function before writing up the syscalls (that function returns
--ENOSYS right now).
+inline function before writing up the syscalls.
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -23,7 +23,9 @@
  *
  * Return:
  * 0 - On success
- * <0 - On error
+ * -EFAULT - User access resulted in a page fault
+ * -EAGAIN - Atomic operation was unable to complete due to contention
+ * -ENOSYS - Operation not supported
  */
 static inline int
 arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
@@ -85,7 +87,9 @@ out_pagefault_enable:
  *
  * Return:
  * 0 - On success
- * <0 - On error
+ * -EFAULT - User access resulted in a page fault
+ * -EAGAIN - Atomic operation was unable to complete due to contention
+ * -ENOSYS - Function not implemented (only if !HAVE_FUTEX_CMPXCHG)
  */
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,


