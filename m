Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46056C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7BE21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498616;
	bh=ekbT4M/PN4RaJ9uYvW4D3NCXS6rF2nmfZb2FfG5+pTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4D/x+X1J386LBILIA+6hlZWH1d93EwpVAqUW3PyBCZ4MQhgNuMRA3+Pcq1SM8jDe
	 K8rnyTJUMffivcsfSghIxfEw33Q4mI7Cr3SQU5DCY54k3otS9iqHkiuffjufU4dV5M
	 ArV3GjdP/gb53Q/qD4KKI5QLo66m8+jyzDHTcMJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfKKS4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfKKS4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:56:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903C921783;
        Mon, 11 Nov 2019 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498609;
        bh=ekbT4M/PN4RaJ9uYvW4D3NCXS6rF2nmfZb2FfG5+pTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZG1Bb5QPvN1nGMcZmmrHic7163EVC0DId4ZzT36expti8Thy7pRV3Kn+mXMyBWS+N
         xHn4lsE2uSyIHRxvBkDlRk34coUkF9ol/SywzcnGGYVaP0+2qySEUpKtRd+n/O/dp5
         tEvOjgOENMpm91wmNAeyzaYDAyUNdGqNG8gMQejk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        zhongshiqi <zhong.shiqi@zte.com.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 170/193] dc.c:use kzalloc without test
Date:   Mon, 11 Nov 2019 19:29:12 +0100
Message-Id: <20191111181513.675535590@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhongshiqi <zhong.shiqi@zte.com.cn>

[ Upstream commit 364593f3ee5fdefc6efd89475e1804c928b4e6ba ]

dc.c:583:null check is needed after using kzalloc function

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: zhongshiqi <zhong.shiqi@zte.com.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 730f97ba8dbbe..dd4731ab935cd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -566,6 +566,10 @@ static bool construct(struct dc *dc,
 #ifdef CONFIG_DRM_AMD_DC_DCN2_0
 	// Allocate memory for the vm_helper
 	dc->vm_helper = kzalloc(sizeof(struct vm_helper), GFP_KERNEL);
+	if (!dc->vm_helper) {
+		dm_error("%s: failed to create dc->vm_helper\n", __func__);
+		goto fail;
+	}
 
 #endif
 	memcpy(&dc->bb_overrides, &init_params->bb_overrides, sizeof(dc->bb_overrides));
-- 
2.20.1



