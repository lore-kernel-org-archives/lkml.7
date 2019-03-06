Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB720661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCFN6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:58:13 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCFN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:58:13 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mvbr4-1hHHSR1m8U-00sduC; Wed, 06 Mar 2019 14:58:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Osipenko <digetx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] gpu: host1x: avoid IOMMU_API build error
Date:   Wed,  6 Mar 2019 14:57:43 +0100
Message-Id: <20190306135800.3982681-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xvKcHd6PvYh7acwo26CW8xOVhQciHOtPMkcgEiMsl2IH70PTok9
 zok150Tb1Ztpp+YZF40KXv+SqMit6hh/mQ9/V8X2Pu7tkaxk8my2ejc5m1aDXulh1/xYNDb
 h4nzt9AXHKXxQv/YIDF7QbEiOWa8EKHtxwwCJSWttvTvNpUYogIOPtR1ko54QuxnS/Ch7QO
 MxfSIasYZvK1C9vO5zw3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zLwu35DqAgc=:m2Y5Jq0qxPPYcjka5jTums
 poo7bvG+WN8c3vENfefE6la4Ccm0+GLpZ9Flx4T3zd7TVAJkj7MaNUi9MjI8uIHfEdB4XPhss
 zCoX7C96trMQlVWAj1xTAbHLd1jeuPGreb6Lizl4tD3oWPjJQJWmZwJOuclt2JPFgYzNWcBZR
 0PzE6fFtF7eTeqGyxX7vfGKtdC5HvA7EoLprHck/4N1Ui8m4aDgteKnTotgQ1ug7GMMKl8BUy
 Kcne9l/Anbuz4gGsyJoTc4ZkOvHGqXQITilybEYVZOJrWHpcbRw+iabRI7TE3zVGCydc7p9e8
 lYR87TFc/DqPoF+HJtymPuZKqPsTIpINKdY1XsuIKiqcomSEtsg7nA9IEHlwgfNHk2OI0YxDM
 pX3gi896G7xNrX4Uvd4GmocI6M6+kFTGuy4fmZqwMobWSulG0OuF816b4hZbrBMAJz8LSbqpU
 LJNNnzFFW8cxKdQOnSKlGWMuQS9RNPcqxnIbjb+VS1QwnrGYj6YSsR0eZMyCTiQezyBGloszh
 CnHOFh2w2iddmV55g9MxlisUoHa55svJSJL17QL6GR4QxTVt8FpaRYes1jujVZ8iGu9CrBWIa
 HMqiU17fr3M/0FOxPLbZqA/DMSf/Ae7bfQ4/w0TNrd/nSS86bPrPDuQX5JyZ7+YklDpexomPM
 TxFBjcV1AQP9KusQYU0oUNc8ncQspNmputpHVzQKPXVdf1yoTgCEad58bIT8g/okZsy105jC5
 eCQc47Lnex9XQXeTmwf5NEwte+KYSDEGuv6Olg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the iommu API is disabled, the host1x driver fails to build:

drivers/gpu/host1x/hw/channel_hw.c: In function 'host1x_channel_set_streamid':
drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit declaration of function 'dev_iommu_fwspec_get'; did you mean 'iommu_fwspec_free'? [-Werror=implicit-function-declaration]
  struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
                              ^~~~~~~~~~~~~~~~~~~~
                              iommu_fwspec_free
drivers/gpu/host1x/hw/channel_hw.c:118:30: error: initialization of 'struct iommu_fwspec *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
drivers/gpu/host1x/hw/channel_hw.c:119:23: error: 'struct iommu_fwspec' has no member named 'ids'
  u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
                       ^~
cc1: all warnings being treated as errors

As Mikko explains, we should program SMMU bypass (0x7f) if that
happens.

Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
v2: fall back to 0x7f sid
---
 drivers/gpu/host1x/hw/channel_hw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 27101c04a827..0c0eb43abf65 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -115,8 +115,12 @@ static inline void synchronize_syncpt_base(struct host1x_job *job)
 static void host1x_channel_set_streamid(struct host1x_channel *channel)
 {
 #if HOST1X_HW >= 6
+	u32 sid = 0x7f;
+#ifdef CONFIG_IOMMU_API
 	struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
-	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
+	if (spec)
+		sid = spec->ids[0] & 0xffff;
+#endif
 
 	host1x_ch_writel(channel, sid, HOST1X_CHANNEL_SMMU_STREAMID);
 #endif
-- 
2.20.0

