Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B8C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6821821479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEIONW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:13:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46920 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfEIONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:13:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hOjnI-000122-EU; Thu, 09 May 2019 15:13:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hOjnI-0006Lr-9G; Thu, 09 May 2019 15:13:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Date:   Thu, 09 May 2019 15:08:17 +0100
Message-ID: <lsq.1557410897.311064425@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 01/10] Revert "brcmfmac: assure SSID length from
 firmware is limited"
In-Reply-To: <lsq.1557410896.171359878@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.67-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

This reverts commit 9657f3abd17772d3290a3545dfb4811d945e84e1, which
was similar to commit 1b5e2423164b3670e8bc9174e4762d297990deff
upstream.  The function fixed upstream doesn't exist in 3.16 and the
similar bug that does exist here needs a different fix.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
@@ -3082,8 +3082,6 @@ brcmf_notify_sched_scan_results(struct b
 
 			brcmf_dbg(SCAN, "SSID:%s Channel:%d\n",
 				  netinfo->SSID, netinfo->channel);
-			if (netinfo->SSID_len > IEEE80211_MAX_SSID_LEN)
-				netinfo->SSID_len = IEEE80211_MAX_SSID_LEN;
 			memcpy(ssid[i].ssid, netinfo->SSID, netinfo->SSID_len);
 			ssid[i].ssid_len = netinfo->SSID_len;
 			request->n_ssids++;

