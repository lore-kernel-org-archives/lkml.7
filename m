Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73131C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441AC20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140389;
	bh=yHMU7kjTEr+vxQB8KMqdUMwESHOjOjoZDvV50YGdh8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfKcODRpa1807P+fXB0N1BE3txzPatxODNvlmlfiOdUy79oaxCnm9haR8j4N8TZ1x
	 KFIgJwwMHBi90I/EMlmukVvy9vxyMuoNoVNyMFYbpGTELE+wOsuT9haXmUr+mNtbS9
	 y2cuShjEjQKzW/eA3OxWT8M5S94pEnl8dc8hoFb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfDARjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbfDARjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40CE20880;
        Mon,  1 Apr 2019 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140383;
        bh=yHMU7kjTEr+vxQB8KMqdUMwESHOjOjoZDvV50YGdh8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUU09ZDV5E6GtBKqMq6Xeu+UO7djejWXxVaXP3dDlxG6XC7n+WAYTsFieCZEhZM5a
         fGxDElHBCootig2WwBL3U+GmNbl1Uqj8B1CBrCpfQskYAgGqk+SkQaNZ+Dl73ah0N0
         xyjRNweBmdUB147QxtXztBmiXeYvHfre9lEnx880=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 50/50] arm64: support keyctl() system call in 32-bit mode
Date:   Mon,  1 Apr 2019 19:03:33 +0200
Message-Id: <20190401170046.691371018@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5c2a625937ba49bc691089370638223d310cda9a ]

As is the case for a number of other architectures that have a 32-bit
compat mode, enable KEYS_COMPAT if both COMPAT and KEYS are enabled.
This allows AArch32 programs to use the keyctl() system call when
running on an AArch64 kernel.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e8d81283c4fe..4ddf817f4a5c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -558,6 +558,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config KEYS_COMPAT
+	def_bool y
+	depends on COMPAT && KEYS
+
 endmenu
 
 menu "Power management options"
-- 
2.19.1



