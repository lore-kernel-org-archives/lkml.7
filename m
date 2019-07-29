Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6328E20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429583;
	bh=CsgfY+e1u5uoRmZEQN7hZu88CVLTpMRvfIJ9CDmdiWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wiotli2QjNPJ179uxLy7C85q8INXxMaP1PUG9Fe2KkPR27rM99dllPntmRp1Mhc/L
	 E/QGaKDD7pRQYPiXdga3XnvdwKbti8H+gDR7NjPijo93b/H8w31qSaAh8+6CVHThPu
	 IZY2jhHH0ZSNaYvI3YYxr3SxthD/My5c1kkR17B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbfG2TqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390067AbfG2TqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EBB217D4;
        Mon, 29 Jul 2019 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429578;
        bh=CsgfY+e1u5uoRmZEQN7hZu88CVLTpMRvfIJ9CDmdiWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYAXgo0fwI9DEfvFF3lq7AsjCWZvFLt3RblFznifRS1UO1+p3p3UKG9sCnOx7sW7/
         57FjRO31VUd6bhalJeSJncNM12MlP7zesxGCFggE/mYbC6jl535AdUx8PU6EfmtgxU
         4W7uT52TkOhd+siMCVYpUYEaVZBF2byDdkym3XZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Hsieh <paul.hsieh@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 028/215] drm/amd/display: Disable ABM before destroy ABM struct
Date:   Mon, 29 Jul 2019 21:20:24 +0200
Message-Id: <20190729190744.923661551@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
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
index da96229db53a..2959c3c9390b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -473,6 +473,8 @@ void dce_abm_destroy(struct abm **abm)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(*abm);
 
+	abm_dce->base.funcs->set_abm_immediate_disable(*abm);
+
 	kfree(abm_dce);
 	*abm = NULL;
 }
-- 
2.20.1



