Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC073C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706D4218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259338;
	bh=fopUBq+COHX+VXQ133pEF43Moj5Z92BbMz7cQibPKmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H78jm+iEhAt2c0NdewgQCi/EGFB3vO0Y0WZgJJdGeOBtcqZftc/jRysw+0Dl2ljpt
	 OuL7OMO0kcyXiOF8TLF7d56LHaXgHimqZDll9iO8QLYqysu5a9Fm+xj6yfsmXxfPk/
	 2BN9BtAFbxtluELs0qyKROn/8AANzcJwmazLLC+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbfCVLtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732003AbfCVLtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8024520693;
        Fri, 22 Mar 2019 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255386;
        bh=fopUBq+COHX+VXQ133pEF43Moj5Z92BbMz7cQibPKmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKuYKCdEqEfdYtYe+USTEFo80Tp1d7F5bFIZTywj+XLJBdVkZq1ZKbSlIp/njbIAM
         P8VSKj1B5W2gKfMviY6ZRU5djeGbXB8nC7d2BwpMj91awpHyDfFl56ulz/CDL87uHr
         BC4hPX4tOxLOFeNEtG1WRUDCu1qCX4AJmSVoyJ58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 057/183] ARC: uacces: remove lp_start, lp_end from clobber list
Date:   Fri, 22 Mar 2019 12:14:45 +0100
Message-Id: <20190322111245.848460349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index c9173c02081c..eabc3efa6c6d 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -207,7 +207,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 		*/
 		  "=&r" (tmp), "+r" (to), "+r" (from)
 		:
-		: "lp_count", "lp_start", "lp_end", "memory");
+		: "lp_count", "memory");
 
 		return n;
 	}
@@ -433,7 +433,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 		 */
 		  "=&r" (tmp), "+r" (to), "+r" (from)
 		:
-		: "lp_count", "lp_start", "lp_end", "memory");
+		: "lp_count", "memory");
 
 		return n;
 	}
@@ -653,7 +653,7 @@ static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
 	"	.previous			\n"
 	: "+r"(d_char), "+r"(res)
 	: "i"(0)
-	: "lp_count", "lp_start", "lp_end", "memory");
+	: "lp_count", "memory");
 
 	return res;
 }
@@ -686,7 +686,7 @@ __arc_strncpy_from_user(char *dst, const char __user *src, long count)
 	"	.previous			\n"
 	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
 	: "g"(-EFAULT), "r"(count)
-	: "lp_count", "lp_start", "lp_end", "memory");
+	: "lp_count", "memory");
 
 	return res;
 }
-- 
2.19.1



