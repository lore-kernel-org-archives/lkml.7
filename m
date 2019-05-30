Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B7C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A64247F6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186328;
	bh=TGNn3w8UnNTGFgYzmWMeqqAhTOy7qEZ3VF+fUmhdAb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LzfmB1ez6BVMnSXySF4SzjlLwLUAP6hy4Mgu5zWCRNYh5CrII+G/qMjPfYdao5sjE
	 iaj+EQGRTjqWNTd2KmyuzUvWziDbXUsNmOJ2oTkD2uPqvD1WzVYRHzezSnILAz9RXG
	 9Ozp0/vR08X3BOrpobpn9Fj0srCqDlivYVj+4Bwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfE3DSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbfE3DOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:54 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C3632456F;
        Thu, 30 May 2019 03:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186093;
        bh=TGNn3w8UnNTGFgYzmWMeqqAhTOy7qEZ3VF+fUmhdAb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/ogOevLP2HqSkAjCgcgC3bQbqEb40csgofO3BbzwX/9F1rlnr0CWEwm2uxTpDLQg
         qQkzR6RpC7J1dzobp7zvEVWTHE9OJ6bAMUONKeZPHDNo9YOo+60aZZZWU103fRZIRp
         PHh4muqTvTbqR85Gm28jKe2GieIu+OS0vCQtqPWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 225/346] brcmfmac: fix missing checks for kmemdup
Date:   Wed, 29 May 2019 20:04:58 -0700
Message-Id: <20190530030552.468522421@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 46953f97224d56a12ccbe9c6acaa84ca0dab2780 ]

In case kmemdup fails, the fix sets conn_info->req_ie_len and
conn_info->resp_ie_len to zero to avoid buffer overflows.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 9f85eec3d79f4..ded629460fc05 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5376,6 +5376,8 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		conn_info->req_ie =
 		    kmemdup(cfg->extra_buf, conn_info->req_ie_len,
 			    GFP_KERNEL);
+		if (!conn_info->req_ie)
+			conn_info->req_ie_len = 0;
 	} else {
 		conn_info->req_ie_len = 0;
 		conn_info->req_ie = NULL;
@@ -5392,6 +5394,8 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		conn_info->resp_ie =
 		    kmemdup(cfg->extra_buf, conn_info->resp_ie_len,
 			    GFP_KERNEL);
+		if (!conn_info->resp_ie)
+			conn_info->resp_ie_len = 0;
 	} else {
 		conn_info->resp_ie_len = 0;
 		conn_info->resp_ie = NULL;
-- 
2.20.1



