Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B48520880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140189;
	bh=uFkmO86BwOND/pQlE8dErLGSIvdi/3eIka1E5dSLFcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWntsBQS1SHiXeatXoMOsPC4iC1lDWXU23VM2dahgaRwOJ5K68JO6+YL05YiNZLeH
	 USVbcxxHybpgbiZl0+1beGFQAXyRvT4JPFt4I+0qz9BLz+M1+sTKSXZBGdKpnZcMa9
	 CZp6YeJWePxmQf3w3atChlXKnEkgKI8uDqGoKo6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfDARg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbfDARgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF5820880;
        Mon,  1 Apr 2019 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140183;
        bh=uFkmO86BwOND/pQlE8dErLGSIvdi/3eIka1E5dSLFcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bS7c5dC0QBfpoW2DuizFA/Y3L5Y+cxJBNxO+BNqBRM/g3YCGETe/EC5tpRyTW9LJ3
         YNDErA/2gpU2x7aThRSNAfKLBUaMMX3HSrShAufQIgX5sJ9xABRE5ZRtZ5JPXRdeKM
         8VD0UH8VN5wIK6A0RsijucaUgLzpLUaoGbjceN8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 131/131] stm class: Hide STM-specific options if STM is disabled
Date:   Mon,  1 Apr 2019 19:03:21 +0200
Message-Id: <20190401170102.337774778@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4a2e2b19f96acfc037a9773c7729d133ce1e7e3b ]

If STM=n, it doesn't make sense to ask about STM_DUMMY and
STM_SOURCE_CONSOLE support, which are not even built when enabled
anyway. Hence hide these options if STM=n.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index e7a348807f0c..e0ac75395526 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -9,6 +9,8 @@ config STM
 
 	  Say Y here to enable System Trace Module device support.
 
+if STM
+
 config STM_DUMMY
 	tristate "Dummy STM driver"
 	help
@@ -25,3 +27,5 @@ config STM_SOURCE_CONSOLE
 
 	  If you want to send kernel console messages over STM devices,
 	  say Y.
+
+endif
-- 
2.19.1



