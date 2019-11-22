Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F7C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6287E207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420335;
	bh=UVaB9uRriPUJ3gCh//YHEKoxCmJWEb6T3hdy2VJoApU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNvdQafHeGqJ9Mfps0Q7IdvHgBcNda8JuARUuB3L+GDpJTCbLh3zT0YSeNlSP1mq1
	 xLfQyoUVELaJyxVMdIKqLDMlae0vmDHqHSl9JMYmWYQ231itWX1OGAPxfpceKSnOhf
	 hSw2WZKR0ZG520BnIWSWsU7ohSwIDjaEgBuYI3ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfKVK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbfKVK6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:58:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CB720721;
        Fri, 22 Nov 2019 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420330;
        bh=UVaB9uRriPUJ3gCh//YHEKoxCmJWEb6T3hdy2VJoApU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaREX8G7/NDrKY7oqQDFYYDlzvBMMs7erh2V9e2tFrgjNnI7hqzNAJtD0ZUKHnGyM
         2Ip9H8PRWa2k/xPh0YRTLeWsEGi+BLVxmgd9d5vCgxaVJdkGMv4rnhkRjg9tfGLK25
         d29lfOXEljRwLi/iDP89DbHq+PadBVYg8+nf+4iQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/220] powerpc/pseries: Fix how we iterate over the DTL entries
Date:   Fri, 22 Nov 2019 11:27:13 +0100
Message-Id: <20191122100917.052524496@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit 9258227e9dd1da8feddb07ad9702845546a581c9 ]

When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set, we look up dtl_idx in
the lppaca to determine the number of entries in the buffer. Since
lppaca is in big endian, we need to do an endian conversion before using
this in our calculation to determine the number of entries in the
buffer. Without this, we do not iterate over the existing entries in the
DTL buffer properly.

Fixes: 7c105b63bd98 ("powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/dtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index c762689e0eb33..ef6595153642e 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -184,7 +184,7 @@ static void dtl_stop(struct dtl *dtl)
 
 static u64 dtl_current_index(struct dtl *dtl)
 {
-	return lppaca_of(dtl->cpu).dtl_idx;
+	return be64_to_cpu(lppaca_of(dtl->cpu).dtl_idx);
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
-- 
2.20.1



