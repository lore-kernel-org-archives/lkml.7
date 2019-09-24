Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0926C21928
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343482;
	bh=XBtLILC1EqGpUwxx8Twbl8rVA44ne2zeh7juqbZ4Re4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jzBkttsEgrqGR6J2UhVoMNenrAxUlA4ScmbZoIYn1GPHhJ3PyU8KhZIRNdpfB1Qj9
	 dfQ+NxJTrBIrOUbFDiZ4MejNZ/wkgypq9uog6DxAlKI6dQw3aMpjjdgyXCf97/vnE6
	 ngaPHwtUmtgRFFIe/EWkXFuRQnpQkwlHLMBoyQ6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404882AbfIXQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409865AbfIXQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:44:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC5B217D9;
        Tue, 24 Sep 2019 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343477;
        bh=XBtLILC1EqGpUwxx8Twbl8rVA44ne2zeh7juqbZ4Re4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRZK+rpPdZoD6LRxhDXDRs1Y7n+CEvlecBOxjSOeX8Gev3eh6uebuJcGXffFNYzIV
         H3gMzaU2UbZ2isOQ3lYfOecec5kLSR/9bbKVNVwvWzbWZL3oClCVpMYf2ld+/qwWRy
         wp3VJod7J1Ul1ktlXb/W1VV8Cy5jXpEf9EQhDSKA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.3 62/87] drm/amd/display: fix trigger not generated for freesync
Date:   Tue, 24 Sep 2019 12:41:18 -0400
Message-Id: <20190924164144.25591-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>

[ Upstream commit 1e7f100ce8c0640634b794604880d9204480c9f1 ]

[Why]
In newer hardware MANUAL_FLOW_CONTROL is not a trigger bit. Due to this
front porch is fixed and in these hardware freesync does not work.

[How]
Change the programming to generate a pulse so that the event will be
triggered, front porch will be cut short and freesync will work.

Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index a546c2bc9129c..e365f2dd7f9a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -824,6 +824,9 @@ void optc1_program_manual_trigger(struct timing_generator *optc)
 
 	REG_SET(OTG_MANUAL_FLOW_CONTROL, 0,
 			MANUAL_FLOW_CONTROL, 1);
+
+	REG_SET(OTG_MANUAL_FLOW_CONTROL, 0,
+			MANUAL_FLOW_CONTROL, 0);
 }
 
 
-- 
2.20.1

