Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E02622CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GtQvOCyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfIAOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 10:55:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfIAOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 10:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gzNIRsi5fka2Azb8Q+JkTPje+EpM76dSKkMbcgP2DRM=; b=GtQvOCyiqI9ncx8WA+gscqpaV
        6+HxDMCzqt8RUbMnmRuI9svYZahqhzyw5axFB+hmlwgkipmkc59kmpMnd7odTmWAi2r6OflrO18kW
        VHDWMj4edvA5Iam1hXVeGxM/YIpmpfzkgTNEWOfEVpYsdBMN+EgGg8SL4HP35BaB5z5EvPHCMmr/a
        4x20e0qcJjmFrIccm4AGV5+qtweNCEsZwlZpcEXDtkXbHDGRJTRuUmQVw7R83dIpGIPU5u37AgiOv
        DiuZsV0M3LEWnHxY/JFhEygOMG2Xks8HCOmfoFDNPeftjlc0rry3Kp3ak6RvhPwlbSg7nybMJdxBK
        Fnn3GasaA==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4RGk-0007vy-I9; Sun, 01 Sep 2019 14:55:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] arch/microblaze: add support for get_user() of size 8
 bytes
Message-ID: <5a3e440f-4ec5-65d7-b2a4-c57fec0df973@infradead.org>
Date:   Sun, 1 Sep 2019 07:55:53 -0700
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
Cc: Doug Ledford <dledford@redhat.com>
---
v3: fix return value in error case (comments from Linus).

What is a reasonable path for having this patch merged?
I have sent several emails to Micahl Simek but he seems to have
dropped active maintenance of arch/microblaze/.

 arch/microblaze/include/asm/uaccess.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- lnx-53-rc6.orig/arch/microblaze/include/asm/uaccess.h
+++ lnx-53-rc6/arch/microblaze/include/asm/uaccess.h
@@ -186,6 +186,11 @@ extern long __user_bad(void);
 			__get_user_asm("lw", __gu_addr, __gu_val,	\
 				       __gu_err);			\
 			break;						\
+		case 8:							\
+			__gu_err = __copy_from_user(&__gu_val, __gu_addr, 8);\
+			if (__gu_err) /* bytes remaining */		\
+				__gu_err = -EFAULT;			\
+			break;						\
 		default:						\
 			__gu_err = __user_bad();			\
 			break;						\
@@ -212,6 +217,11 @@ extern long __user_bad(void);
 	case 4:								\
 		__get_user_asm("lw", (ptr), __gu_val, __gu_err);	\
 		break;							\
+	case 8:								\
+		__gu_err = __copy_from_user(&__gu_val, ptr, 8);		\
+		if (__gu_err) /* bytes remaining */			\
+			__gu_err = -EFAULT;				\
+		break;							\
 	default:							\
 		/* __gu_val = 0; __gu_err = -EINVAL;*/ __gu_err = __user_bad();\
 	}								\


