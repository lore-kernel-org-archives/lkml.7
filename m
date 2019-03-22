Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B254C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9B6218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254866;
	bh=JrR32pRW0j3ryJbpI2Xrvg7qw9kTKIDc1eE4AjiVMQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dD9O+JM4bgdouXf2pI8qKXGaNgwNMOykVLCpx6mttXztuc1ClfoHwW565rJ8QDOnL
	 58S5FfIRcCMY7yINoUkaWjyaNhct4JYhGLRETaNRTbyv9xfRsmimOnehd+iJNZzpS7
	 oS5v75jwWxNjznKRfKfeSBBsQODpH/w/HvrzTBds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfCVLlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbfCVLlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:41:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39DF218B0;
        Fri, 22 Mar 2019 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254863;
        bh=JrR32pRW0j3ryJbpI2Xrvg7qw9kTKIDc1eE4AjiVMQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZL7bu3QgGRFhhC5tN9fV2IepybvXJ66rzMeiLN1azeUKNoBYngSVawCqozotiTsva
         wKyb7gXqEmVK7IR7BAKSbD1IUC2XPL6sodWLQVorv+H2VxK3n8UN44J3O5crb2usJv
         d5ds/08qkWPib0utY5BGA4SeTYjcjyGLFjeLfNlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 034/118] ARC: uacces: remove lp_start, lp_end from clobber list
Date:   Fri, 22 Mar 2019 12:15:06 +0100
Message-Id: <20190322111218.585203189@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d5e3c55e01d8b1774b37b4647c30fb22f1d39077 ]

Newer ARC gcc handles lp_start, lp_end in a different way and doesn't
like them in the clobber list.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 0684fd2f42e8..f82393f89215 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -209,7 +209,7 @@ __arc_copy_from_user(void *to, const void __user *from, unsigned long n)
 		*/
 		  "=&r" (tmp), "+r" (to), "+r" (from)
 		:
-		: "lp_count", "lp_start", "lp_end", "memory");
+		: "lp_count", "memory");
 
 		return n;
 	}
@@ -438,7 +438,7 @@ __arc_copy_to_user(void __user *to, const void *from, unsigned long n)
 		 */
 		  "=&r" (tmp), "+r" (to), "+r" (from)
 		:
-		: "lp_count", "lp_start", "lp_end", "memory");
+		: "lp_count", "memory");
 
 		return n;
 	}
@@ -658,7 +658,7 @@ static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
 	"	.previous			\n"
 	: "+r"(d_char), "+r"(res)
 	: "i"(0)
-	: "lp_count", "lp_start", "lp_end", "memory");
+	: "lp_count", "memory");
 
 	return res;
 }
@@ -691,7 +691,7 @@ __arc_strncpy_from_user(char *dst, const char __user *src, long count)
 	"	.previous			\n"
 	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
 	: "g"(-EFAULT), "r"(count)
-	: "lp_count", "lp_start", "lp_end", "memory");
+	: "lp_count", "memory");
 
 	return res;
 }
-- 
2.19.1



