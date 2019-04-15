Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F0C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8279218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354048;
	bh=gsrIuS87PKHpdBIKiY8Xbmm9wek4Xo2YlcKMxhytBu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IR+hftD27WRQZfxBK/ApHfu0CUemXhM7JvvOnmUrs4NeNMFz6L3bg+ogWjpwhiolU
	 KHPfXBGoRHIWH7PMEKlHieluSD0nhTbedNlKgcWa0TeaNIVl8oJ/7qw0c95nrckJAl
	 C5/y9+PmvNsqiDaX8WXGVO5fiUs2uuClWHqMFvAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfDOSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbfDOSrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C93218D3;
        Mon, 15 Apr 2019 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354042;
        bh=gsrIuS87PKHpdBIKiY8Xbmm9wek4Xo2YlcKMxhytBu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+xxLirf70W6ERC7wD7YjiVfBzHhsXDW2p5RzvuOpvx9Lqb6W6I9Yqnt+wqckPYMg
         m5AX5U7Sbt8ncy4pumily56I57bm+Rt+UCwpbGZeUWe8E9X9KFT1gAxhobu7YVjTPJ
         AtOyNj6qcL4l/qZSR5aHoZa4IeNoknswI8COKmDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 41/76] powerpc/fsl: Update Spectre v2 reporting
Date:   Mon, 15 Apr 2019 20:44:05 +0200
Message-Id: <20190415183718.146987235@linuxfoundation.org>
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

commit dfa88658fb0583abb92e062c7a9cd5a5b94f2a46 upstream.

Report branch predictor state flush as a mitigation for
Spectre variant 2.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 6dc5cdc2b87c..43ce800e73bf 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -213,8 +213,11 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
 			seq_buf_printf(&s, "(hardware accelerated)");
-	} else
+	} else if (btb_flush_enabled) {
+		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+	} else {
 		seq_buf_printf(&s, "Vulnerable");
+	}
 
 	seq_buf_printf(&s, "\n");
 
-- 
2.19.1



