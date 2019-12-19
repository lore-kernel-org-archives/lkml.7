Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3841C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9368F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hER6opfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSNaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:30:46 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:48014 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLSNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:30:46 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5DB70405D4;
        Thu, 19 Dec 2019 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576762245; bh=CwpIHUsLSwWgfRfilgxCCE00b6aVv9KpT49ou2/oTLI=;
        h=From:To:Cc:Subject:Date:From;
        b=hER6opfXJxcbx+tkUxHY5+je+3Okwntz9LcihPHUs+oD9kfAF9Rruw7T4LK1V1r6s
         z81OPiVRoFUeKDDabUygcXzeNPRKFiV5+H47dn5L0VgOB9lm9YUV2lrJEgLtcwu+aT
         5XWq7wIUE1HV+6itz8ybsuCq2S/ZkpEHjbzW1ujVpplY8L3NI/e+ep4aexKQ4CbS95
         i6TpM3rk+mi2n9NgjoDTEs8MkaGiVJRE74anC3fhknrtmSeCK3VR2iyS2+F6LcHz8N
         mjVzNTjkJ6LX+QL8cEzX2NUmZFwdl0qvrbl9l+LWLQrOdeTn1vMhUMiA1QOV028Ukh
         5A3SY9K8FVzJw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 18ED4A0066;
        Thu, 19 Dec 2019 13:30:42 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: asm-offsets: remove duplicate entry
Date:   Thu, 19 Dec 2019 16:30:40 +0300
Message-Id: <20191219133040.12736-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define 'PT_user_r25' twice in asm-offsets.c
It's not a big issue as we define it to the same value, however
let's fix it.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index 1f621e416521..631ebb5d3458 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -66,7 +66,6 @@ int main(void)
 
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
-	DEFINE(PT_user_r25, offsetof(struct pt_regs, user_r25));
 
 	return 0;
 }
-- 
2.21.0

