Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91425C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7A32175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfEWQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:07:51 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.140]:19366 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730782AbfEWQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:07:51 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 4D23547AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:07:50 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TqFyhsNLR4FKpTqFyhEl5U; Thu, 23 May 2019 11:07:50 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=40558 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hTqFx-002N04-8L; Thu, 23 May 2019 11:07:49 -0500
Date:   Thu, 23 May 2019 11:07:48 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: qdsp6: q6core: Use struct_size() in kmemdup()
Message-ID: <20190523160748.GA4844@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hTqFx-002N04-8L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:40558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

sizeof(*fwk) + fwk->num_services * sizeof(fwk->svc_api_info[0]);

with:

struct_size(fwk, svc_api_info, fwk->num_services)

and so on...

Notice that variables bytes and len are unnecessary, hence they are
removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/qcom/qdsp6/q6core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index cdfc8ab6cfc0..ae314a652efe 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -98,13 +98,13 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 	}
 	case AVCS_CMDRSP_GET_FWK_VERSION: {
 		struct avcs_cmdrsp_get_fwk_version *fwk;
-		int bytes;
 
 		fwk = data->payload;
-		bytes = sizeof(*fwk) + fwk->num_services *
-				sizeof(fwk->svc_api_info[0]);
 
-		core->fwk_version = kmemdup(data->payload, bytes, GFP_ATOMIC);
+		core->fwk_version = kmemdup(data->payload,
+					    struct_size(fwk, svc_api_info,
+							fwk->num_services),
+					    GFP_ATOMIC);
 		if (!core->fwk_version)
 			return -ENOMEM;
 
@@ -115,13 +115,13 @@ static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 	}
 	case AVCS_GET_VERSIONS_RSP: {
 		struct avcs_cmdrsp_get_version *v;
-		int len;
 
 		v = data->payload;
 
-		len = sizeof(*v) + v->num_services * sizeof(v->svc_api_info[0]);
-
-		core->svc_version = kmemdup(data->payload, len, GFP_ATOMIC);
+		core->svc_version = kmemdup(data->payload,
+					    struct_size(v, svc_api_info,
+							v->num_services),
+					    GFP_ATOMIC);
 		if (!core->svc_version)
 			return -ENOMEM;
 
-- 
2.21.0

