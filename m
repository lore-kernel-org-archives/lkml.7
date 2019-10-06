Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0113C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957D120862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383694;
	bh=XBtLILC1EqGpUwxx8Twbl8rVA44ne2zeh7juqbZ4Re4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8wBxTj+HefCw8FP1Q7WQs97Mr9+N7dPTMgiCdp9UKiPwKE4WdVWX8Txe2rST7hRG
	 RxGm5Cc7aKBpliPYKiTTymfhQ2oSn0eT8vYayRE0LwTWjWk9Gr/7GYTxrSgGEMiQo2
	 3xW7v7X2lClrGIpF1T1nDQOKO3sARtrsuKAxX6Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfJFRld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731207AbfJFRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:41:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E2D2053B;
        Sun,  6 Oct 2019 17:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383687;
        bh=XBtLILC1EqGpUwxx8Twbl8rVA44ne2zeh7juqbZ4Re4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3uJhtWFJM+X6O3FMpbCdI5j0LKVajNqOhKgEJv/e3grJRj3V6bQx6TTZU2u/pN3K
         sCrAHf4+8L7lQVhIs6scqw2wpdz8u5RmrdTpBkevj2T9OCDNQDPZmTEeS8vT0FjWDo
         WlublA+8J1w+9TDlesCeKvafzpciIKtCw1maI+Gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 058/166] drm/amd/display: fix trigger not generated for freesync
Date:   Sun,  6 Oct 2019 19:20:24 +0200
Message-Id: <20191006171218.023647315@linuxfoundation.org>
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



