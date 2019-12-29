Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA27AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B26F206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642188;
	bh=MbfCp7FYhrRyAXgygA+7bgcWbcMz9I2Z9I4Vf83In5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vta+nBTvdkF9NwwAKL+gXJdj+HvOZWFMRRXi7IgIQPTZ2ahEU1r9tVpaHePM7D84K
	 No8YHH7n+GS42Le6DYL8EbePsng2fI1DFvEKyN/uLx1WgfiDj15VmcLYHXWqwwWtgU
	 PsdKiPeZwyXERvbK4hA/e+8N5cd0/BRir54yYI98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbfL2R40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733055AbfL2R4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:56:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 548A621D7E;
        Sun, 29 Dec 2019 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642179;
        bh=MbfCp7FYhrRyAXgygA+7bgcWbcMz9I2Z9I4Vf83In5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIGSLVIP8FR1XRHrdTvfOR6DMEutiIEbWoZndLvWoNTcDjS42+WkgnZSd4IqtQHih
         cVNKkiAubNTip/T4ErBmnFqPyTcfZxQ+GJJetQgMRmlkt09dydahBNVj/Kculpya43
         poq2713FEkPoQmEsSJQImfoDgPItW1aAi5A4L7sU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 332/434] brcmfmac: remove monitor interface when detaching
Date:   Sun, 29 Dec 2019 18:26:25 +0100
Message-Id: <20191229172724.022883934@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 4f61563da075bc8faefddfd5f8fc0cc14c49650a ]

This fixes a minor WARNING in the cfg80211:
[  130.658034] ------------[ cut here ]------------
[  130.662805] WARNING: CPU: 1 PID: 610 at net/wireless/core.c:954 wiphy_unregister+0xb4/0x198 [cfg80211]

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 406b367c284c..85cf96461dde 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1350,6 +1350,11 @@ void brcmf_detach(struct device *dev)
 	brcmf_fweh_detach(drvr);
 	brcmf_proto_detach(drvr);
 
+	if (drvr->mon_if) {
+		brcmf_net_detach(drvr->mon_if->ndev, false);
+		drvr->mon_if = NULL;
+	}
+
 	/* make sure primary interface removed last */
 	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
 		if (drvr->iflist[i])
-- 
2.20.1



