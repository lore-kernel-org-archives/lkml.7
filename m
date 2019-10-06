Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441B0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E94D20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383645;
	bh=p/LTZv2Rg4AcXfx4nYRbWpJmu7o4xkjBC4qUBZfeDW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1d7zycMCZDLwxZNv7nC9zBBtaJi038bVSTe44wWTN44GZ3GSHauqvS5YQLFRAQ/4F
	 pePAAmQD+mmAp3gy3jwKtsx5nwlj26Ua5ogNkppSoPtiHQ7g4fsfM0sciPTgW0rrvb
	 mgbZj1b8u53wVi61xQgh/M0ikkiYodXPwfe3zbAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfJFRkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfJFRkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:40:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBBA20700;
        Sun,  6 Oct 2019 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383639;
        bh=p/LTZv2Rg4AcXfx4nYRbWpJmu7o4xkjBC4qUBZfeDW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3zUrfqvQtjkvnQelTKXHm7KNgfogEsU68anl0oPR5/KnNv93OXUIF8vh4ZgTEZqE
         JGBWtPFTECT2o5HzsoqPWVcfMSMBh2baTSj5dZpvBItzccgs6STsLqynbwtQjJV82T
         WJFJxNCGTOOMAsV0LH5pK8qM4QwzaG3xiwfwkOaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikola Cornij <nikola.cornij@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 007/166] drm/amd/display: Power-gate all DSCs at driver init time
Date:   Sun,  6 Oct 2019 19:19:33 +0200
Message-Id: <20191006171213.316022291@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikola Cornij <nikola.cornij@amd.com>

[ Upstream commit 75c35000235f3662f2810e9a59b0c8eed045432e ]

[why]
DSC should be powered-on only on as-needed basis, i.e. if the mode
requires it

[how]
Loop over all the DSCs at driver init time and power-gate each

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index d810c8940129b..2627e0a98a96a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -585,6 +585,10 @@ static void dcn20_init_hw(struct dc *dc)
 		}
 	}
 
+	/* Power gate DSCs */
+	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
+		dcn20_dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
+
 	/* Blank pixel data with OPP DPG */
 	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 		struct timing_generator *tg = dc->res_pool->timing_generators[i];
-- 
2.20.1



