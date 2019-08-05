Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96702147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wDvshsv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfHEXtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:49:31 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.1]:43967 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbfHEXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:49:31 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 3CAC0B4BCB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2019 18:49:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id umjKhHJd73Qi0umjKh0kO4; Mon, 05 Aug 2019 18:49:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9li+YhxHo8+AujwqhsMZd9x+rcO10TXeZqodcMKx7qo=; b=wDvshsv1z+1fXiJZtY4PyLHNww
        TX8STZuvfNMy65c16V2YqeJF4e8e/HsisSBSRMNAYeBJY66xYI/a5XrZfQP5O40mD+yeXeHv8mhGF
        /W+BkPEqN7tqKgN4uGAsH1ddru52eG7RKMGdhbMA68N7j/W90G6NeAxsM+j0UroIzheN1fD8VsZFI
        sA/k0BthKK/9Zm04QwPf2oMN8gM7gjlYuj/OllN0eoj7w5ZOZWXvKUz9mCf309++jkyGM+YRn46r6
        5P/kqFvhARxma5FJxkO5SiwELWfYONvsDrQNS5FCEC9Xm8TJyI6CRkGjHeBRV/2krkJOt1cspawIF
        VSuTx2Wg==;
Received: from [187.192.11.120] (port=40464 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1humjJ-000yz7-1L; Mon, 05 Aug 2019 18:49:29 -0500
Date:   Mon, 5 Aug 2019 18:49:28 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/msm: Use struct_size() helper
Message-ID: <20190805234928.GA2785@embeddedor>
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
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1humjJ-000yz7-1L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:40464
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct msm_gem_submit {
	...
        struct {
		...
        } bos[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*submit) + ((u64)nr_bos * sizeof(submit->bos[0]))

with:

struct_size(submit, bos, nr_bos)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 348f8c2be806..7c17c6154058 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -26,8 +26,8 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 		uint32_t nr_cmds)
 {
 	struct msm_gem_submit *submit;
-	uint64_t sz = sizeof(*submit) + ((u64)nr_bos * sizeof(submit->bos[0])) +
-		((u64)nr_cmds * sizeof(submit->cmd[0]));
+	uint64_t sz = struct_size(submit, bos, nr_bos) +
+				  ((u64)nr_cmds * sizeof(submit->cmd[0]));
 
 	if (sz > SIZE_MAX)
 		return NULL;
-- 
2.22.0

