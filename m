Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABEE23FC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188684;
	bh=WrdlPj9JlrIxJXVWJ9NMP0Y9QTf6mIL8LMV3pc2dYiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ow/kiC4Jdi01hBTJlvuoMOTMlnaEKu6lCNP/+g90LIQzvZjME1cFdeXeoX5QDDMj4
	 KxnzA4x8YQq8MoPS9qW0JiRiKjIlyIvnw8wuLP0/yy+jh8SKyVoz3tO2PpNla+AnY1
	 ElpBiHdOHm6o9Tj4T0GTt/lxhO+9NrZYR2mdX6rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfE3D6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbfE3DSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:47 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815E0247E6;
        Thu, 30 May 2019 03:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186326;
        bh=WrdlPj9JlrIxJXVWJ9NMP0Y9QTf6mIL8LMV3pc2dYiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT2jHjQhipDnw7JvpxaVWyfjpW1+2n0U4W0Ih5XvzJDK3SobeIZnMK+zH3eFe6ybM
         tBNjP3ePOqH8D4DT7QEys7iBYkdd7Kkb2jTmvvtOVNSZWCd/ax4nQbbLevSCDmuzNX
         MRbeJZrOUapckKWePZ7gLFwBS0D3nlcGhGJ5LhH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 023/193] brcmfmac: assure SSID length from firmware is limited
Date:   Wed, 29 May 2019 20:04:37 -0700
Message-Id: <20190530030452.055518332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arend van Spriel <arend.vanspriel@broadcom.com>

commit 1b5e2423164b3670e8bc9174e4762d297990deff upstream.

The SSID length as received from firmware should not exceed
IEEE80211_MAX_SSID_LEN as that would result in heap overflow.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3581,6 +3581,8 @@ brcmf_wowl_nd_results(struct brcmf_if *i
 	}
 
 	netinfo = brcmf_get_netinfo_array(pfn_result);
+	if (netinfo->SSID_len > IEEE80211_MAX_SSID_LEN)
+		netinfo->SSID_len = IEEE80211_MAX_SSID_LEN;
 	memcpy(cfg->wowl.nd->ssid.ssid, netinfo->SSID, netinfo->SSID_len);
 	cfg->wowl.nd->ssid.ssid_len = netinfo->SSID_len;
 	cfg->wowl.nd->n_channels = 1;


