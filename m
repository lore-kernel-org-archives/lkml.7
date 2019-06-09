Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50313C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206AF205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100571;
	bh=A8xkqdpR4tPykWeXqBfTyv/djCndgNj/nZYpSbk3Edw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FkVj6UqcMqeejr174h0symGZSoabWh2nKhSE+kgv49MfHUo5mo4+LW037Nx8nRn8P
	 p6Jxz9T3fdraQuMIYBODp7UzDQZGFL810SzN3OQwQjnJ69X7+0unwVvT8rtNfcy/80
	 4lIsxpFTgwkQFH3ocxC6mu/Kz3RYHEsLACQ2JYk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfFIQxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732421AbfFIQxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B58C2084A;
        Sun,  9 Jun 2019 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099214;
        bh=A8xkqdpR4tPykWeXqBfTyv/djCndgNj/nZYpSbk3Edw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wjc8OHZIhyjUDg3tUy6WoN0k9xWOflo9MfadsfXkaFkqY0llcncEtd8EWJsblNqKi
         Zc0jaCdVGeQJSCIZodbVexZpd1YC4mxJZc/HYOFe9L4hwW4SphXsA6WmI2OEU2i50o
         1sDNbfW6PMjaJkZA1BmU4wpXNFerkAil08SbQnDY=
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
Subject: [PATCH 4.9 50/83] brcmfmac: assure SSID length from firmware is limited
Date:   Sun,  9 Jun 2019 18:42:20 +0200
Message-Id: <20190609164132.220496606@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
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
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3579,6 +3579,8 @@ brcmf_wowl_nd_results(struct brcmf_if *i
 
 	data += sizeof(struct brcmf_pno_scanresults_le);
 	netinfo = (struct brcmf_pno_net_info_le *)data;
+	if (netinfo->SSID_len > IEEE80211_MAX_SSID_LEN)
+		netinfo->SSID_len = IEEE80211_MAX_SSID_LEN;
 	memcpy(cfg->wowl.nd->ssid.ssid, netinfo->SSID, netinfo->SSID_len);
 	cfg->wowl.nd->ssid.ssid_len = netinfo->SSID_len;
 	cfg->wowl.nd->n_channels = 1;


