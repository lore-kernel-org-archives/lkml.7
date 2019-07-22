Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D48CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF16421903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfGVRrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:47:21 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.97]:44984 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbfGVRrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:47:21 -0400
X-Greylist: delayed 5612 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 13:47:20 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E11B4EB30
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:47:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pcP9hExV490onpcP9h7sww; Mon, 22 Jul 2019 12:47:19 -0500
X-Authority-Reason: nr=8
Received: from cablelink149-185.telefonia.intercable.net ([201.172.149.185]:46480 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hpcP8-001wiZ-Fq; Mon, 22 Jul 2019 12:47:18 -0500
Date:   Mon, 22 Jul 2019 12:47:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Cox@embeddedor, Philip <Philip.Cox@amd.com>, Liu@embeddedor,
        Shaoyun <Shaoyun.Liu@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through warning
Message-ID: <20190722174716.GA17037@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.149.185
X-Source-L: No
X-Exim-ID: 1hpcP8-001wiZ-Fq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink149-185.telefonia.intercable.net (embeddedor) [201.172.149.185]:46480
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, this patch silences
the following warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c: In function ‘mqd_manager_init_v10’:
./include/linux/dynamic_debug.h:122:52: warning: this statement may fall through [-Wimplicit-fallthrough=]
 #define __dynamic_func_call(id, fmt, func, ...) do { \
                                                    ^
./include/linux/dynamic_debug.h:143:2: note: in expansion of macro ‘__dynamic_func_call’
  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:153:2: note: in expansion of macro ‘_dynamic_func_call’
  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:336:2: note: in expansion of macro ‘dynamic_pr_debug’
  dynamic_pr_debug(fmt, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c:432:3: note: in expansion of macro ‘pr_debug’
   pr_debug("%s@%i\n", __func__, __LINE__);
   ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_mqd_manager_v10.c:433:2: note: here
  case KFD_MQD_TYPE_COMPUTE:
  ^~~~

by removing the call to pr_debug() in KFD_MQD_TYPE_CP:

"The mqd init for CP and COMPUTE will have the same  routine." [1]

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

[1] https://lore.kernel.org/lkml/c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@amd.com/

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 4f8a6ffc5775..9cd3eb2d90bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -429,7 +429,6 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 
 	switch (type) {
 	case KFD_MQD_TYPE_CP:
-		pr_debug("%s@%i\n", __func__, __LINE__);
 	case KFD_MQD_TYPE_COMPUTE:
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		mqd->allocate_mqd = allocate_mqd;
-- 
2.22.0

