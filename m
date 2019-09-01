Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F99C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 03:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F272187F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 03:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqcNBBOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfIADkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 23:40:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfIADkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 23:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Cc:Subject:From:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oCApBRnlYw3+yzwJ3ybINzbSrgzbb2xvvxZOpSTpA3Y=; b=rqcNBBOfFzF+E7Y+wWWsElfz9
        fvDGc+2uMkExl6hJkVMjVNoM5pLCx3z+aIcax2YveZjqMYkhDrkr1RsbJt4wf6T6P3xKPW1ergL0i
        7+Q9IHtu+jkBQlL/6m12sLueL3InXD410YD8kZ8TwJshJGr8MqIpJWNZxQOk2SSLji/Ruh5Oydenr
        IN/3GqTOlqYWlb9BPzYV1nqnZElq0OjAeRy9LyCGdmv0amr2deM+R5js9VKTwkFQ4TqM5eK83UBop
        YMxWZEB6kYE1ArxUvL+diFBEwN0mUoqv5WQzixRP6vLVqD6LUQQtfgBV4YdvuYH6fNIhsioH+OzhI
        LC1dkrDQw==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4Gil-0003pM-P5; Sun, 01 Sep 2019 03:40:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RESEND] arch/microblaze: add support for get_user() of size 8
 bytes
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Michal Simek <monstr@monstr.eu>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Message-ID: <99f83474-3e71-4325-ddff-cf23a172b984@infradead.org>
Date:   Sat, 31 Aug 2019 20:40:05 -0700
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
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
What is a reasonable path for having this patch merged?
Leon Romanovsky <leonro@mellanox.com> has tested it.
I have sent several emails to Micahl Simek but he seems to have
dropped active maintenance of arch/microblaze/.

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

