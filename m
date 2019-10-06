Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B1EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF80920700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383358;
	bh=szCeKCu1HOCfG8Xa5dhnSRI7Vdwm04GAxX3XtKErotk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wjClCMNHQrsr8BzT683aq53DECrsd1PoGMdqE+O+Pv6z1oF7+YMm6xZf5TEiWotmO
	 cKyCFS84eiyKHl2q8xGq8yUJkppKqqkCEF1+c38h3omFJktFMRZnNhx2PTtct9TN+b
	 T5MKs0q+1B0ADSJ+Z0gJRSOfmpdn1lo2FCTLG7BI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfJFRf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfJFRfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:35:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF66720700;
        Sun,  6 Oct 2019 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383346;
        bh=szCeKCu1HOCfG8Xa5dhnSRI7Vdwm04GAxX3XtKErotk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noxuRWHocBIeRk65ezZ3g7w4tHRp8TpxatpWK4MrdAj1VgW2Ds8189fRrnB/48SGU
         BN3GaM/SKkr82BmMjzDu3i2W57KoGa5t4LI5g5WgEkV1iPt8Bz1fx5GuAn/t5yQGIL
         MIaaxzKhoC1uL2u9xEjkRlwl9tnXfud1x9T3BLFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
        Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 069/137] selftests/powerpc: Retry on host facility unavailable
Date:   Sun,  6 Oct 2019 19:20:53 +0200
Message-Id: <20191006171214.928589488@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Romero <gromero@linux.vnet.ibm.com>

[ Upstream commit 6652bf6408895b09d31fd4128a1589a1a0672823 ]

TM test tm-unavailable must take into account aborts due to host aborting
a transactin because of a facility unavailable exception, just like it
already does for aborts on reschedules (TM_CAUSE_KVM_RESCHED).

Reported-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
Tested-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1566341651-19747-1-git-send-email-gromero@linux.vnet.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/tm/tm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index 97f9f491c541a..c402464b038fc 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -55,7 +55,8 @@ static inline bool failure_is_unavailable(void)
 static inline bool failure_is_reschedule(void)
 {
 	if ((failure_code() & TM_CAUSE_RESCHED) == TM_CAUSE_RESCHED ||
-	    (failure_code() & TM_CAUSE_KVM_RESCHED) == TM_CAUSE_KVM_RESCHED)
+	    (failure_code() & TM_CAUSE_KVM_RESCHED) == TM_CAUSE_KVM_RESCHED ||
+	    (failure_code() & TM_CAUSE_KVM_FAC_UNAV) == TM_CAUSE_KVM_FAC_UNAV)
 		return true;
 
 	return false;
-- 
2.20.1



