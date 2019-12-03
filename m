Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B40C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D0E214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413539;
	bh=tGR4MvCBLeI6lQWpNWyqFTW0hb+j4u+7X8UgrF2QNrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nd3fwLW2bT4UL1BNFBX1qvywJuBSKpNVUjAjJyaF7JYmcwtQucHPP7FWagEIssnD+
	 O/bf84AXF7cb3XiFcKUwmuenhDcmdFa9h8+b6qI+OlmLM8PUbjJe9Xw6Dnbsn+v0GQ
	 OfzhXCc5A6IHnvDDIQFdncedfyRR4zpjSE6cTUm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfLCWwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729846AbfLCWwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:52:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CFFD2084B;
        Tue,  3 Dec 2019 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413528;
        bh=tGR4MvCBLeI6lQWpNWyqFTW0hb+j4u+7X8UgrF2QNrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4Vt8khHS3Ckd/oCOq6HioHWQOrLg6nOUh9Mrg8B5kV3M28LjkoHuy7PzfqUURbuF
         QjNGfEWGHeaPySA//VqIdL25ETg5661YkIK5XvrTfKWV7wesZaJ4IGSsa3QoN5oO4n
         8drwUHyfldaOy9oadfCojmI8pmybtp/9s//QjyKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 161/321] brcmfmac: Fix access point mode
Date:   Tue,  3 Dec 2019 23:33:47 +0100
Message-Id: <20191203223435.516546795@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 861cb5eb467f5e38dce1aabe4e8db379255bd89b ]

Since commit 1204aa17f3b4 ("brcmfmac: set WIPHY_FLAG_HAVE_AP_SME flag")
the Raspberry Pi 3 A+ (BCM43455) isn't able to operate in AP mode with
hostapd (device_ap_sme=1 use_monitor=0):

brcmfmac: brcmf_cfg80211_stop_ap: setting AP mode failed -52

So add the missing mgmt_stypes for AP mode to fix this.

Fixes: 1204aa17f3b4 ("brcmfmac: set WIPHY_FLAG_HAVE_AP_SME flag")
Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index c7c520f327f2b..bbdc6000afb9b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6314,6 +6314,16 @@ brcmf_txrx_stypes[NUM_NL80211_IFTYPES] = {
 		.tx = 0xffff,
 		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
 		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_AP] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4)
 	}
 };
 
-- 
2.20.1



