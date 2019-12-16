Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D3D24684
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520502;
	bh=Mztc72BHnmEsloLyPFd/5QdIkJ/8JsaIrOr2c3E22Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zg7hRCx+H9Q0l/UDdMQViSI8N1F8yQDQBFojs1p/7zHuUFrcz/MsgEgxbWhCmJPlZ
	 O3XNiK8avlXKM7sx8mT+qPi4w0bAnmqo/iaGfVcY7Y8iheMttp98yx/TwJjAhJIzOf
	 s1oVyj6oEY9/v9iKlWAAzrbK3+Pg6kuFwOxy3gIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfLPSVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:21:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732110AbfLPSVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:21:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C94E206EC;
        Mon, 16 Dec 2019 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520497;
        bh=Mztc72BHnmEsloLyPFd/5QdIkJ/8JsaIrOr2c3E22Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egp7GGV9p9wZ+JFQK3cKlGZ9K6pI8DEyK1iTEk/beDK68HuHGzcvrMj8iIIG/Y6R6
         okuC0+plGUFua/NDVy6+7Okel37SzEXMehRUKW2ADBgJRklu3n4mFStF/QtoXvecHO
         AgABnUMOjJ6H2014f+48EeS4YPSIXD/8U1zqT9zE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        ppc syzbot c/o Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 5.4 172/177] powerpc: Define arch_is_kernel_initmem_freed() for lockdep
Date:   Mon, 16 Dec 2019 18:50:28 +0100
Message-Id: <20191216174850.685064994@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 6f07048c00fd100ed8cab66c225c157e0b6c0a50 upstream.

Under certain circumstances, we hit a warning in lockdep_register_key:

        if (WARN_ON_ONCE(static_obj(key)))
                return;

This occurs when the key falls into initmem that has since been freed
and can now be reused. This has been observed on boot, and under
memory pressure.

Define arch_is_kernel_initmem_freed(), which allows lockdep to
correctly identify this memory as dynamic.

This fixes a bug picked up by the powerpc64 syzkaller instance where
we hit the WARN via alloc_netdev_mqs.

Reported-by: Qian Cai <cai@lca.pw>
Reported-by: ppc syzbot c/o Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Daniel Axtens <dja@axtens.net>
Link: https://lore.kernel.org/r/87lfs4f7d6.fsf@dja-thinkpad.axtens.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/sections.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -5,8 +5,22 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
+
 #include <asm-generic/sections.h>
 
+extern bool init_mem_is_free;
+
+static inline int arch_is_kernel_initmem_freed(unsigned long addr)
+{
+	if (!init_mem_is_free)
+		return 0;
+
+	return addr >= (unsigned long)__init_begin &&
+		addr < (unsigned long)__init_end;
+}
+
 extern char __head_end[];
 
 #ifdef __powerpc64__


