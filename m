Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEBDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BED20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355566;
	bh=Vz8KbsA856eixBnZPa6MMuWXetH6Ks8A6nEY7kkIr2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dqPJsp//e4CsX3aEJfur7aAqvYEgsRjfFzFyehhppTqokm0n0MXrxUKEqkiM/+iY/
	 v2nXun4Xd7H8srchRcHF54XIK75WSiFhEYl3OwBagU0dIPHbdrBvmUAdA3oZtJB0LM
	 B44F2vwCVe1HCkxMkX1FG4Vl9RVxuknrQJ/YtzAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfDOTMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbfDOTMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BAC218A1;
        Mon, 15 Apr 2019 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355560;
        bh=Vz8KbsA856eixBnZPa6MMuWXetH6Ks8A6nEY7kkIr2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEnrDIUqfm8APYEAd6qqUM15JjxWLbxdAvPV2z9VOOoLbf3cQwfi79OSIXIQX9Qh1
         PHP8uLY5zFxQhXZYuKPAagzFl3/wlNpSLo6u559CIAlpDnZVuZ786zn2GASC45RhJX
         XCPLEcngObG8Lo8h09K6PKiAzDkXIMmBiDALMhC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhenyuw@linux.intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 5.0 066/117] drm/i915/gvt: do not deliver a workload if its creation fails
Date:   Mon, 15 Apr 2019 21:00:36 +0200
Message-Id: <20190415183748.303894546@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

commit dade58ed5af6365ac50ff4259c2a0bf31219e285 upstream.

in workload creation routine, if any failure occurs, do not queue this
workload for delivery. if this failure is fatal, enter into failsafe
mode.

Fixes: 6d76303553ba ("drm/i915/gvt: Move common vGPU workload creation into scheduler.c")
Cc: stable@vger.kernel.org #4.19+
Cc: zhenyuw@linux.intel.com
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/scheduler.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -1475,8 +1475,9 @@ intel_vgpu_create_workload(struct intel_
 		intel_runtime_pm_put(dev_priv);
 	}
 
-	if (ret && (vgpu_is_vm_unhealthy(ret))) {
-		enter_failsafe_mode(vgpu, GVT_FAILSAFE_GUEST_ERR);
+	if (ret) {
+		if (vgpu_is_vm_unhealthy(ret))
+			enter_failsafe_mode(vgpu, GVT_FAILSAFE_GUEST_ERR);
 		intel_vgpu_destroy_workload(workload);
 		return ERR_PTR(ret);
 	}


