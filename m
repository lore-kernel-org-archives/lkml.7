Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5EFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C469920721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142544;
	bh=fTe/6jv6vp2P2ZrGxFtNky6NeEAfIueFoy7sJP/UR2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lR/eSgzG77ACblBmaOFiRzqTvOFOz8k+oBPIdZdSmZi27vmikriJxagGAdrpgNbiF
	 3tdnOC5NNVaga2j/yQql+MQTF3M7dlBqKFROYxdvyP+SxLUHtuWyM/C6e8IkBtW6ct
	 RgHCtUhJIa8ZDcfHOxIsOvn/vzDuj3zKl7MyWBww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfKSFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbfKSFs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:48:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CAD320862;
        Tue, 19 Nov 2019 05:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142538;
        bh=fTe/6jv6vp2P2ZrGxFtNky6NeEAfIueFoy7sJP/UR2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMRCAfJbeR52VIJi9GXGRhulBK0q/D5p6NiR7p6Qf6BjfjaqEpzssxbq28YHEZ+Cp
         W25hIjUIlqeIm0v/0oli0lhI2ybsS4kZvECZt4RzFzULnl9t9C7qj50kgLBNcEYp/8
         5RJtYeEUmBW2RixX6yP8WIX0tscWNfI2UaAmrQQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 114/239] soc: qcom: wcnss_ctrl: Avoid string overflow
Date:   Tue, 19 Nov 2019 06:18:34 +0100
Message-Id: <20191119051328.514908397@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 4c96ed170d658d8826d94edec8ac93ee777981a2 ]

'chinfo.name' is used as a NUL-terminated string, but using strncpy() with
the length equal to the buffer size may result in lack of the termination:

drivers//soc/qcom/wcnss_ctrl.c: In function 'qcom_wcnss_open_channel':
drivers//soc/qcom/wcnss_ctrl.c:284:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  strncpy(chinfo.name, name, sizeof(chinfo.name));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes it to use the safer strscpy() instead.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/wcnss_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index df3ccb30bc2dd..373400dd816d6 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -281,7 +281,7 @@ struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
 	struct rpmsg_channel_info chinfo;
 	struct wcnss_ctrl *_wcnss = wcnss;
 
-	strncpy(chinfo.name, name, sizeof(chinfo.name));
+	strscpy(chinfo.name, name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = RPMSG_ADDR_ANY;
 
-- 
2.20.1



