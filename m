Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDB3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A2A21924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787927;
	bh=yyMYnl9xVKxxHpTJhZhw2/F9RlZGrcbZgSK3AlEtctQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MlySa7BvF9MIXIQoT5AjMeXYBB93dLEhwWk/E8eHhDOL8duVIkuiowN7CwyBAaYB/
	 AKkndxFQOFzoaZbONAy8bytw9kMrKtzBHz2WkRfAR8bEW4tE6mgoRfEsm7sG1gzcMi
	 NBDcY0U/iNen2EJmXJN0gOJbJ196XKAQghqsEwBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfIRGZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbfIRGZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:25:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAA221920;
        Wed, 18 Sep 2019 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787922;
        bh=yyMYnl9xVKxxHpTJhZhw2/F9RlZGrcbZgSK3AlEtctQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n69BJ+bupaNXrHhohn2IJ5BWlJOEwRFD4GY7TucnrstU7CSk4mINwESpl5ijq915V
         6a6N6UwK0UFCSxGRHHkWBBuuFHBfcQG9Xw+I0M7Ft3nXHElrSQ+ahvB524zM7lKdux
         Qlyt++XRkANUJQhepa8t8BPSNoCWPMuVN4I336dM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
        Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 5.2 32/85] drm/lima: fix lima_gem_wait() return value
Date:   Wed, 18 Sep 2019 08:18:50 +0200
Message-Id: <20190918061235.169875025@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

commit 21670bd78a25001cf8ef2679b378c73fb73b904f upstream.

drm_gem_reservation_object_wait() returns 0 if it succeeds and -ETIME
if it timeouts, but lima driver assumed that 0 is error.

Cc: stable@vger.kernel.org
Fixes: a1d2a6339961e ("drm/lima: driver for ARM Mali4xx GPUs")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190908024800.23229-1-anarsoul@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/lima/lima_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -342,7 +342,7 @@ int lima_gem_wait(struct drm_file *file,
 	timeout = drm_timeout_abs_to_jiffies(timeout_ns);
 
 	ret = drm_gem_reservation_object_wait(file, handle, write, timeout);
-	if (ret == 0)
+	if (ret == -ETIME)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
 
 	return ret;


