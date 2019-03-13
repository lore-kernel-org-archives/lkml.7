Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BBBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E1F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504468;
	bh=R6RrP25jlRbI18W8S12OnQCbBlBTAkswK+zzLwILP4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gCu7A9fomg6FjnG+MXucDHrW95oS+XVyYlycJgFlh8CKRs+Kgu/H2ZCN2RNd3/kP5
	 ycXjLYdlQ7JlCNKYYMS2wli6MMom0fzUFRN830nR8cNClYTzbqcy79jBG0y+26QjuH
	 9530upwlC1wI59FPTzpZdmLHxK7hAueNfaIOORBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCMTO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfCMTOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175C22075C;
        Wed, 13 Mar 2019 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504463;
        bh=R6RrP25jlRbI18W8S12OnQCbBlBTAkswK+zzLwILP4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mkg6g+6ycInVb7T4gjEwtSH1g+vG0HdO4rDeJgAwZmPOEvguyU9gcV/ZYpoOELfth
         i7f/ATasdr4PCz5HozR/fIBuoWPW219Z8GbXZ+fPnCdIEllvuOOC7nHaxBeiqJdPtT
         kJIXMxJtZVXYIYsv9QiadAyN25FPb6gXc3E3pu3M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 34/48] ARC: uacces: remove lp_start, lp_end from clobber list
Date:   Wed, 13 Mar 2019 15:12:36 -0400
Message-Id: <20190313191250.158955-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

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

