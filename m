Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A07521852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508741;
	bh=P9FI1vSDEZdFtFFk2JRYGZXrq9Wle4jHE5Ji9OXBHjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J0tntHJ0IK4SoiM9YG9mw1r6msk+ex3iYJI2YIefspCjHBi3ZbDTOb+vdnftJFUwa
	 R3oQuqk7cd5z6rXhqXDzshS8V0vcwqsE3qkSm9oOQpo0kE8SqeEpD/F4lajoK2z/nM
	 1jmua27PHO9aU9uRCYs60rV3XzYcctIHCYTFjS+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGSD7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfGSD6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:58:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC4821852;
        Fri, 19 Jul 2019 03:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508734;
        bh=P9FI1vSDEZdFtFFk2JRYGZXrq9Wle4jHE5Ji9OXBHjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmv/DS2YQy+Dza9awzTRwOIUcFogAbKJ25MBOb63g4q/b5/rL2rfFzGP0xxiGF7az
         wyqo7gCWKxaHeY5NkMqEK7xlePG1qUy2tIO5zugnP0rAj0z7am7oBj8ehwAijSCCk+
         cVYXp6SnD3cC8gxwGXayQDnlk6BMdxExsREd+rCI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 057/171] drm/amd/display: fix compilation error
Date:   Thu, 18 Jul 2019 23:54:48 -0400
Message-Id: <20190719035643.14300-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Kelam <hariprasad.kelam@gmail.com>

[ Upstream commit 88099f53cc3717437f5fc9cf84205c5b65118377 ]

this patch fixes below compilation error

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In
function ‘dcn10_apply_ctx_for_surface’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3:
error: implicit declaration of function ‘udelay’
[-Werror=implicit-function-declaration]
   udelay(underflow_check_delay_us);

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 33d311cea28c..9e4d70a0055e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include <linux/delay.h>
 #include "dm_services.h"
 #include "core_types.h"
 #include "resource.h"
-- 
2.20.1

