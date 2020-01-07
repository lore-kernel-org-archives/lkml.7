Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD87C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402C02080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432223;
	bh=SkUyblwU99iMDKO/k+Wj2C3RYecw+KxgIPrwyZ+Sh90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBE0zgi1kVukqo76+8fckoB8AD/3iNfywLA3dA5DG3xxDbPcv5IZmrUq5KI9lJ+g2
	 viilCj963FS00qAgIDstqGelKJV2bniCyuilW6yhV02GmV/POMl9HDZkLqXlXaw7B9
	 Nt58zYBgcKptlW8h/nclrsscuh39O/J57zxrHlE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgAGVXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgAGVBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:01:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4118F24672;
        Tue,  7 Jan 2020 21:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430874;
        bh=SkUyblwU99iMDKO/k+Wj2C3RYecw+KxgIPrwyZ+Sh90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bage4CU+UYCi0YMjJhNWBhehanUbVrkAddaVebJsqm98WSBajsdv5STGtoKzvh77K
         SQJg63/EhpQFI4ndQvDzVCKhUpAbqyx+Iaz71Em9rpwVHd5KQ6D12vIwFjDBwTmE6C
         fhe2UnZ2qq2pl7ibIOC7eE3GF5bd54/ZI/Xjwmhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH 5.4 133/191] drm/msm: include linux/sched/task.h
Date:   Tue,  7 Jan 2020 21:54:13 +0100
Message-Id: <20200107205340.088032750@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 70082a52f96a45650dfc3d8cdcd2c42bdac9f6f0 upstream.

Without this header file, compile-testing may run into a missing
declaration:

drivers/gpu/drm/msm/msm_gpu.c:444:4: error: implicit declaration of function 'put_task_struct' [-Werror,-Wimplicit-function-declaration]

Fixes: 482f96324a4e ("drm/msm: Fix task dump in gpu recovery")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/msm_gpu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -16,6 +16,7 @@
 #include <linux/pm_opp.h>
 #include <linux/devfreq.h>
 #include <linux/devcoredump.h>
+#include <linux/sched/task.h>
 
 /*
  * Power Management:


