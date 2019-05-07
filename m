Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B020578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207663;
	bh=1ldGnMoVIE7IfFksfZrcv0xOBczTvmrB4Lnn1lZl4ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QhkjlRjSF+GhS8Kk9rCj8ugtFAuWcNyFAaquUyJVQbLPn2Aj0mgmjMfys3vCR5jhI
	 xITu7krd7aAztOG0sHRwGMiPJQ0uRwK5GJetz+bILwUMkrZ17oEG/bLDMj25MqSxGu
	 /5S169yIrbYQuEnsAUfkMKkzCvqm4NH8DKC1MH4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfEGFlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbfEGFk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AF52087F;
        Tue,  7 May 2019 05:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207657;
        bh=1ldGnMoVIE7IfFksfZrcv0xOBczTvmrB4Lnn1lZl4ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGPSZrDyvWWtQbWcZmKQMw7Urg1U3p72VXFB2u2VXt8xVWhk3xSwAKJYLm9Jl+sLY
         78HkcdI8+BVpqRld+BBkUpVOVdmE/oPUIczUfMbgaFQrdH6eWwh0kqm8LNUPAls7fh
         KSZtK0CmsUt/w+lT8gFR8lFZZkP+bGYJvw67VCW0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damian Kos <dkos@cadence.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 82/95] drm/rockchip: fix for mailbox read validation.
Date:   Tue,  7 May 2019 01:38:11 -0400
Message-Id: <20190507053826.31622-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damian Kos <dkos@cadence.com>

[ Upstream commit e4056bbb6719fe713bfc4030ac78e8e97ddf7574 ]

This is basically the same fix as in
commit fa68d4f8476b ("drm/rockchip: fix for mailbox read size")
but for cdn_dp_mailbox_validate_receive function.

See patchwork.kernel.org/patch/10671981/ for details.

Signed-off-by: Damian Kos <dkos@cadence.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/1542640463-18332-1-git-send-email-dkos@cadence.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 0ed7e91471f6..4df201d21f27 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -113,7 +113,7 @@ static int cdp_dp_mailbox_write(struct cdn_dp_device *dp, u8 val)
 
 static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 					   u8 module_id, u8 opcode,
-					   u8 req_size)
+					   u16 req_size)
 {
 	u32 mbox_size, i;
 	u8 header[4];
-- 
2.20.1

