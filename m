Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2AC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F96218A6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HmxtQdZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfHFWgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:36:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfHFWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+aGylB31P6D/nIlNaEFR+0PCAreRmaph6pqKhavESjE=; b=HmxtQdZzEnq8nfYZq+zrSYqD+4
        dXytf63V8sjZZwA8ZIPZ582xJDZOJJWLB2S+CRkv9S0GguOgPyv/lxjB+qN90XYTSyYY1pnWL38ex
        189P+LVbpB7kNPdBdca9RcV7R32mXtXoF8OiUHoK8Y/XYkSLYMjxfFq6TjJmI+oR+lh6A9uN/5+7o
        4IPS54k0zpPy0X9MgX5q8uF9yzXe0ncmOkGQ73WWucyEIoNDyxt14DLM+/P5Z2L2+rATRrHEtLSu5
        SXDR8+t6DVoK05HunEDq4LnAjYpaRkDe/iGqxsTWVgKW5Hn58R2VhuwnFXfCTjsA/ccjfOj56W7NI
        qK4exTkA==;
Received: from [208.71.200.96] (helo=[172.16.195.104])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv84N-0008BO-Nr; Tue, 06 Aug 2019 22:36:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/microblaze: add support for get_user() of size 8 bytes
Message-ID: <a6f97040-b021-c787-65da-9a10b7597238@infradead.org>
Date:   Tue, 6 Aug 2019 15:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

arch/microblaze/ is missing support for get_user() of size 8 bytes,
so add it by using __copy_from_user().

Fixes these build errors:
   drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
   drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefined reference to `__user_bad'
   drivers/android/binder.o: In function `binder_thread_write':
   drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference to `__user_bad'
   drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference to `__user_bad'
   drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea78): more undefined references to `__user_bad' follow

'make allmodconfig' now builds successfully for arch/microblaze/.

Fixes: 538722ca3b76 ("microblaze: fix get_user/put_user side-effects")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven J. Magnani <steve@digidescorp.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/microblaze/include/asm/uaccess.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- lnx-53-rc3.orig/arch/microblaze/include/asm/uaccess.h
+++ lnx-53-rc3/arch/microblaze/include/asm/uaccess.h
@@ -186,6 +186,9 @@ extern long __user_bad(void);
 			__get_user_asm("lw", __gu_addr, __gu_val,	\
 				       __gu_err);			\
 			break;						\
+		case 8:							\
+			__gu_err = __copy_from_user(&__gu_val, __gu_addr, 8);\
+			break;						\
 		default:						\
 			__gu_err = __user_bad();			\
 			break;						\
@@ -212,6 +215,9 @@ extern long __user_bad(void);
 	case 4:								\
 		__get_user_asm("lw", (ptr), __gu_val, __gu_err);	\
 		break;							\
+	case 8:								\
+		__gu_err = __copy_from_user(&__gu_val, ptr, 8);		\
+		break;							\
 	default:							\
 		/* __gu_val = 0; __gu_err = -EINVAL;*/ __gu_err = __user_bad();\
 	}								\


