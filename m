Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EECC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601452053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419294;
	bh=Rco+cMlzC9IAhIErmrGsZyUHE87YUacoyF9rlYIfRL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0kI1bhRTF55TpENGuNN3p2iHHu8e/14nbarMRGLSCm2y+3LmtV3dypYlEtMUMaxd
	 N7Mx0Z/PAwrlSiPniGYG4xldpahX+HdFTRlnjFScR1dwZqYca8LfhXlsgOX+8dRPfz
	 rhJ1S5bKiMOKKs/dD3QLlyDNKZw4Bn/VFz7XvfBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbfGRDIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390648AbfGRDIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:08:09 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D412077C;
        Thu, 18 Jul 2019 03:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419288;
        bh=Rco+cMlzC9IAhIErmrGsZyUHE87YUacoyF9rlYIfRL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpYFFwfS1Y4BbTtszo8nu71hnaZ1AWl/bv9nZziJCW1Ps0qQMGnJY1jT8rs+5Rkr6
         Kaz+G1MZBU+B+bzbb0dg6Cu2hm/Ef6d34rwkcTVXlCx1KY/GMxz4eEi/M0Nm8WPNA4
         lQOqd8UIVlTMG7qJPPx1ZfDY6tkCJoRJ7wVpjWFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/47] linux/kernel.h: fix overflow for DIV_ROUND_UP_ULL
Date:   Thu, 18 Jul 2019 12:01:43 +0900
Message-Id: <20190718030051.200640741@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8f9fab480c7a87b10bb5440b5555f370272a5d59 ]

DIV_ROUND_UP_ULL adds the two arguments and then invokes
DIV_ROUND_DOWN_ULL.  But on a 32bit system the addition of two 32 bit
values can overflow.  DIV_ROUND_DOWN_ULL does it correctly and stashes
the addition into a unsigned long long so cast the result to unsigned
long long here to avoid the overflow condition.

[akpm@linux-foundation.org: DIV_ROUND_UP_ULL must be an rval]
Link: http://lkml.kernel.org/r/20190625100518.30753-1-vkoul@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kernel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3d83ebb302cf..f6f94e54ab96 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -118,7 +118,8 @@
 #define DIV_ROUND_DOWN_ULL(ll, d) \
 	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
 
-#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))
+#define DIV_ROUND_UP_ULL(ll, d) \
+	DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
 
 #if BITS_PER_LONG == 32
 # define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
-- 
2.20.1



