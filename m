Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06F20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bhKhjRg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDJWq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:46:56 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56054 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJWq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:46:56 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::360])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4125B5C062C;
        Thu, 11 Apr 2019 00:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554936413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=AFE2C6yZSCer3XVYw7g8fJ6fBDG37VSELxp7La10+ew=;
        b=bhKhjRg9sLUsQAdSSQReqOD8LmM/kBjkArZsQ4ASvkjIOsHxnBB+kwGlb8BrrSkzb310IH
        Pk8yFFn4Sa9b/NseUBk3gOHzZQNwQ8k8ValXFeCoQEFAimcJ64xgHKDBrrLSZUAMin0bMX
        VT6IEds3IYjrV80H89QznDqdGpEk8y4=
From:   Stefan Agner <stefan@agner.ch>
To:     thierry.reding@gmail.com
Cc:     digetx@gmail.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] gpu: host1x: fix compile error when IOMMU API is not available
Date:   Thu, 11 Apr 2019 00:47:46 +0200
Message-Id: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the IOMMU API is not available compiling host1x fails with
the following error:
  In file included from drivers/gpu/host1x/hw/host1x06.c:27:
  drivers/gpu/host1x/hw/channel_hw.c: In function ‘host1x_channel_set_streamid’:
  drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit declaration of function
    ‘dev_iommu_fwspec_get’; did you mean ‘iommu_fwspec_free’?  [-Werror=implicit-function-declaration]
  struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
                              ^~~~~~~~~~~~~~~~~~~~
                              iommu_fwspec_free

Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/host1x/hw/channel_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 27101c04a827..4030d64916f0 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -114,7 +114,7 @@ static inline void synchronize_syncpt_base(struct host1x_job *job)
 
 static void host1x_channel_set_streamid(struct host1x_channel *channel)
 {
-#if HOST1X_HW >= 6
+#if IS_ENABLED(CONFIG_IOMMU_API) &&  HOST1X_HW >= 6
 	struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
 	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
 
-- 
2.21.0

