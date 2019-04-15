Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E201C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BF22073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354273;
	bh=p5gIG5UlrbX8YkrtDcb/hPiyTgFAqBj4ksReZ10xB7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SPl11vx4TVihRtwrlSJtBpgOX1g4/g7jFsk9LARKPwoEPYLVOFegO6LlySg47TCl5
	 v+QD8Q8ArOAq49Gx96vYgF4HWUZSuqRMejCZF2LCx84qZOFwW6PxTTQyVD+RYcCiN5
	 1u80OZJU1cbm1R7sroqLXVf4EMjA5kXhWeAty8Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfDOSvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfDOSqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7901C218A1;
        Mon, 15 Apr 2019 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353961;
        bh=p5gIG5UlrbX8YkrtDcb/hPiyTgFAqBj4ksReZ10xB7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMGZ7vyddmaHFwwbJdXNeBqE2TSJ+kqtLQZoMn5IZnabozd15ukfXvXUZ7iU48VHa
         I92wvQdrxENuvLkhhTb+1yoeS7AkWcAqkUvlXzfLvM4EbpNKjFi7uFaIkuz5NUtbLn
         5JgZN4lQrD85Im1avqC5VqWE+KcVA5HEAnDGAq0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 34/76] powerpc/fsl: Fix spectre_v2 mitigations reporting
Date:   Mon, 15 Apr 2019 20:43:58 +0200
Message-Id: <20190415183716.387216249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7d8bad99ba5a22892f0cad6881289fdc3875a930 upstream.

Currently for CONFIG_PPC_FSL_BOOK3E the spectre_v2 file is incorrect:

  $ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
  "Mitigation: Software count cache flush"

Which is wrong. Fix it to report vulnerable for now.

Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache flush")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index fd4703b6ddc0..fc41bccd9ab6 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -23,7 +23,7 @@ enum count_cache_flush_type {
 	COUNT_CACHE_FLUSH_SW	= 0x2,
 	COUNT_CACHE_FLUSH_HW	= 0x4,
 };
-static enum count_cache_flush_type count_cache_flush_type;
+static enum count_cache_flush_type count_cache_flush_type = COUNT_CACHE_FLUSH_NONE;
 
 bool barrier_nospec_enabled;
 static bool no_nospec;
-- 
2.19.1



