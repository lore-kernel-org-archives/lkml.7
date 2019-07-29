Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF672054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429169;
	bh=iOEROdCnpiC/RJj4ZK4tu8PJjLIQIf1mL34rnqhYWcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ldFaNMzsfvHSDY4LhmcJiD6Q4dKBApTQ0VpkFmso5OjlxMkSc5/o8G0K7REQSC56T
	 zKoeKNETA0rDd+Nh2QH+OX0PJWXlDZMlqt29oktThSjJMeh17TqTnjdZK2NA5zkEKp
	 VgciIID+IR2L//F1nz/DFFJZnkMwOhvsxl00ZHXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbfG2Tj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388638AbfG2TjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:39:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E7820C01;
        Mon, 29 Jul 2019 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429163;
        bh=iOEROdCnpiC/RJj4ZK4tu8PJjLIQIf1mL34rnqhYWcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IckrkHvAJ6QBs54IY1S97YigR7FXN5CbqCdiYudwFC8xQ8rYGcTNxeGHZwB/SP4Sd
         XNs6iA3cN9eCPGHKjLELp42L2Hm5RPr++30AXX9TfLWFHmmcVPTxRNJD2XSDwWxfLy
         oG6V2ASo11mQsYLWJZArUvmajXVoR2rZomRBZbTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Hsieh <paul.hsieh@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/113] drm/amd/display: Disable ABM before destroy ABM struct
Date:   Mon, 29 Jul 2019 21:21:39 +0200
Message-Id: <20190729190658.718717454@linuxfoundation.org>
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

[ Upstream commit 1090d58d4815b1fcd95a80987391006c86398b4c ]

[Why]
When disable driver, OS will set backlight optimization
then do stop device.  But this flag will cause driver to
enable ABM when driver disabled.

[How]
Send ABM disable command before destroy ABM construct

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 29294db1a96b..070ab56a8aca 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -474,6 +474,8 @@ void dce_abm_destroy(struct abm **abm)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(*abm);
 
+	abm_dce->base.funcs->set_abm_immediate_disable(*abm);
+
 	kfree(abm_dce);
 	*abm = NULL;
 }
-- 
2.20.1



