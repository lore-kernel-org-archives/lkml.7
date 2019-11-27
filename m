Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD82C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC37C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888638;
	bh=xdFKgEX7Pl/f6BxecuW2mYaqqpQDVVagDCzXcf2Qhhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aa4Hp7yO4oMp4aMGJZ2WB4Q63qYI63gjzfCJLN198quv1mOtyY4v4D/jTLDjZVDLg
	 N1XcVadfxGvds4I7wTXyGKlxBl99maG6ZQxW1WT6Rv6qo3SDUVnYWAGWqUXtLgGbSH
	 P+5ETI2OoHYlhV097hYkC4kKof+a/Yqd/e/qBHeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfK0VD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:03:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbfK0VDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:03:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF3B2086A;
        Wed, 27 Nov 2019 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888634;
        bh=xdFKgEX7Pl/f6BxecuW2mYaqqpQDVVagDCzXcf2Qhhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZuMosX03f82FCfzURRLVVZcIyg80LJ/40bGcyb4rr8wBoJP65Tqs52/SVu0UF3y1
         CzA9HLkPvtekQVZeiWAximJmIi8DI+ozsofus6Ak9fFI0OiNaFYAkP3s5n6Rkvj6pj
         k9JelaDizUbUtrQhsg30RlYwK8nL4CIvBE2qGaTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nickhu <nickhu@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 210/306] nds32: Fix bug in bitfield.h
Date:   Wed, 27 Nov 2019 21:31:00 +0100
Message-Id: <20191127203130.474147252@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickhu <nickhu@andestech.com>

[ Upstream commit 9aaafac8cffa1c1edb66e19a63841b7c86be07ca ]

There two bitfield bug for perfomance counter
in bitfield.h:

	PFM_CTL_offSEL1		21 --> 16
	PFM_CTL_offSEL2		27 --> 22

This commit fix it.

Signed-off-by: Nickhu <nickhu@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/nds32/include/asm/bitfield.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 8e84fc385b946..19b2841219adf 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -692,8 +692,8 @@
 #define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
 #define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
 #define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
-#define PFM_CTL_offSEL1		21	/* The event selection for PFMC1 */
-#define PFM_CTL_offSEL2		27	/* The event selection for PFMC2 */
+#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
+#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
 /* bit 28:31 reserved */
 
 #define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
-- 
2.20.1



