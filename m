Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEBCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555BA20640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437626;
	bh=1Ua/KLz2Zw5RYyuFpUKjROxfwsvNuH6AFnFVSVl/NgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/P07xxoKoCv+rjMWfvIrJPYFvy2mgAugMqerKWC5ms59uYh3OV6lAsfgd+1AeeLj
	 gXsYqPqgKbtvE0oc+82tjawDJMd3lgYo0D9gc4htDJuZ72JkNF4e19eKU9pNS288qH
	 F7H3xxoZldaHYL1ycnPZVhrj4yTTfiWHnPL3Eu9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfJRWEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfJRWEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F4D222CD;
        Fri, 18 Oct 2019 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436241;
        bh=1Ua/KLz2Zw5RYyuFpUKjROxfwsvNuH6AFnFVSVl/NgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G85yZd9Q0ViYogTu/46KZIAuWwtO/Ed4V5yXLK46wOx85xqTKPV5RsaooYURqfQ+R
         XzGIrpKyo64MmgVpnSIqDUsaAgslI54EVDpwa4Su8xpDB5Xm+Uekw1Km1JZoeneMaP
         vz/XFqhba2gU2LWMnYPZyBNJdtMcL4Azx0Ev5LHY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 26/89] arm64: Fix incorrect irqflag restore for priority masking for compat
Date:   Fri, 18 Oct 2019 18:02:21 -0400
Message-Id: <20191018220324.8165-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit f46f27a576cc3b1e3d45ea50bc06287aa46b04b2 ]

Commit bd82d4bd2188 ("arm64: Fix incorrect irqflag restore for priority
masking") added a macro to the entry.S call paths that leave the
PSTATE.I bit set. This tells the pPNMI masking logic that interrupts
are masked by the CPU, not by the PMR. This value is read back by
local_daif_save().

Commit bd82d4bd2188 added this call to el0_svc, as el0_svc_handler
is called with interrupts masked. el0_svc_compat was missed, but should
be covered in the same way as both of these paths end up in
el0_svc_common(), which expects to unmask interrupts.

Fixes: bd82d4bd2188 ("arm64: Fix incorrect irqflag restore for priority masking")
Signed-off-by: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 84a822748c84e..e304fe04b098d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -775,6 +775,7 @@ el0_sync_compat:
 	b.ge	el0_dbg
 	b	el0_inv
 el0_svc_compat:
+	gic_prio_kentry_setup tmp=x1
 	mov	x0, sp
 	bl	el0_svc_compat_handler
 	b	ret_to_user
-- 
2.20.1

