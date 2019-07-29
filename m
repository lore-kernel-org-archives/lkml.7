Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C33C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660FD21773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429227;
	bh=fz3oG+MIkOSlceaFC6ct5RIz5EJWnIue6pM3kyVI7+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bZWs66pYu2otMVlZuPbpqda2p/R1OCrjV5xxjor+4h54oqw3dVXUrYKF93ZlWi4OQ
	 HAbYy/ly08Esvce77LhQNWTcwWcACf5bK3lDSWImMBUdaJ7nGknpY8qsR/9GVn0hm7
	 KCAW1FJApZ2BftfdZEBjTB9Eus6EKeHnmdbz07kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfG2Tk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389145AbfG2TkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:40:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA25217D4;
        Mon, 29 Jul 2019 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429220;
        bh=fz3oG+MIkOSlceaFC6ct5RIz5EJWnIue6pM3kyVI7+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGvsO8H7yj3DbEi54cA0LSLqqa+chnK4S6mvC3JQSdm66PHcBlQuJ412RZbLuQ0jF
         80uXa302TAYZRsPqwWmb1L2mWNVZEZu7YchzmU8GeQZQ2IRyw1Wl4hhLmJbolm6nMP
         GVSeGOGdEQp1Dip7xL2t9E6uNTUrMjvkyjRc8zXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/113] drm/amd/display: fix compilation error
Date:   Mon, 29 Jul 2019 21:21:56 +0200
Message-Id: <20190729190702.842161237@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 7736ef123e9b..ead221ccb93e 100644
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



