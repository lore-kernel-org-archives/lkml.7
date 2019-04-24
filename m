Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E39C21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127448;
	bh=RUdoTbn+AXWKDT3myebl57SBPvuh2ZdAivLPWEwG6ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SI4SLh29yWYcEOk/iXKQ+BMZ0O5TvnSqlHhov1ILQDRnAhdR8BiOgds4XNzomiQNS
	 lwU5HhUUI7D/5Bop6YBGVv5hm7O3b/uPseOs4mEq7QMyEdfJHe/eeWBjGkKIM70S+x
	 /jgA3AA2h4YPPRXY7epS8QUtzxyCSLuLGwWHxBV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392201AbfDXRh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbfDXRhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:25 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1F521907;
        Wed, 24 Apr 2019 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127445;
        bh=RUdoTbn+AXWKDT3myebl57SBPvuh2ZdAivLPWEwG6ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bti6Y384BTbf3dRuwjEqaPib66rRBCKo3Fv1Ku4OjC6dFDFr/WQIh22mRjDpMOmTN
         zBO6I0xp5+OiS3eC69nmIgt1bDFZPLhKCgxczG1tFlqSai2QjL062YIONjt+DFT6aP
         CgQFNnpDrkFjVSwzThDHLr1aNSA90h+UIomFyoTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.0 094/115] drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming
Date:   Wed, 24 Apr 2019 19:10:30 +0200
Message-Id: <20190424170930.324287765@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 1925e7d3d4677e681cc2e878c2bdbeaee988c8e2 upstream.

Got accidently dropped when 2+1 level support was added.

Fixes: 6a42fd6fbf534096 ("drm/amdgpu: implement 2+1 PD support for Raven v3")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -182,6 +182,7 @@ static void mmhub_v1_0_init_cache_regs(s
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
 				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
 	}
+	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL3, tmp);
 
 	tmp = mmVM_L2_CNTL4_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);


