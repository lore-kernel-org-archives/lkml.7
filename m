Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18552C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9423218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355288;
	bh=OdXnkbYzIilheGRQJreA8qSSX3nM22mjWgP5K8TUasg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JO6jrv5h1Codoia5xbfjw1vn2dV7wXpPc7tGPjlQRXmrCWOEM2PhMHgMLamw93QN9
	 y2yZsUI7ghsYzALWrODU6f7Sk3k78FYTbCzFDJp6hYOmiC7mkRJhgSDFW5cyEk2mpR
	 ofxfKAqcXbCZiSTKpx2c6WTETbcJ3aqX0/P6REC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfDOTIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730365AbfDOTIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D682087C;
        Mon, 15 Apr 2019 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355283;
        bh=OdXnkbYzIilheGRQJreA8qSSX3nM22mjWgP5K8TUasg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iatnDfaoG42NISzbCyl/dyvoLS/qshQ/PI9s5n2xY7A3qOp32ofoii+h83qznlMA7
         Qrrs5CvsZEXXwUMT7/PArOLvZkWqrnIp+QnL0HCRTap53IjES7Cpg1vF6j1pAGtnTj
         fxhg3zTQchDm3lV97h/87gVJgMLnqUHqGjXN8pDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhenyuw@linux.intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 4.19 060/101] drm/i915/gvt: do not deliver a workload if its creation fails
Date:   Mon, 15 Apr 2019 20:58:58 +0200
Message-Id: <20190415183743.677961420@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -1389,8 +1389,9 @@ intel_vgpu_create_workload(struct intel_
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


