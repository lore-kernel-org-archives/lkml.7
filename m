Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE64AC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933BC205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100087;
	bh=XONFkhvklEDy0qBqvx2NkPgKJUQtzHBtKYVtk9U+114=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pq3sk1xJcrtcnWzGreXw+0pVlY95Cu9l1OgKfs8PZExosbK7dgKIUWb2HOY0JLZk4
	 nGNX1F/h0qLL6euNYyGiQ+EX6te3p9sf+nuEI4MqK5lnNKnY9YyQ6iOz6A8y0IKpjX
	 jTG3OxCmxLqhGSzzfARdxu09XEd1ejnvfXmsGSOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbfFIRIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388896AbfFIRFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:05:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681E0206C3;
        Sun,  9 Jun 2019 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099946;
        bh=XONFkhvklEDy0qBqvx2NkPgKJUQtzHBtKYVtk9U+114=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXLDe+gApzvVDumsm5AC7vdmHRoCtfSaOSx9am/Mmz2uKD6bM8f+vltNpicud4IBw
         BjKfPYdPytg4yCJ8IECrka0EVPkj3AFq03N5lRtNd3UIwQV+TPCHCITWrE8WaW6KV8
         C+va24BX8DQU0MTdqabONDFTuqU3YHiCTpUp0b+4=
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
Subject: [PATCH 4.4 222/241] brcmfmac: add length checks in scheduled scan result handler
Date:   Sun,  9 Jun 2019 18:42:44 +0200
Message-Id: <20190609164155.095136210@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arend Van Spriel <arend.vanspriel@broadcom.com>

commit 4835f37e3bafc138f8bfa3cbed2920dd56fed283 upstream.

Assure the event data buffer is long enough to hold the array
of netinfo items and that SSID length does not exceed the maximum
of 32 characters as per 802.11 spec.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 4.4:
 - Move the assignment to "data" along with the assignment to "netinfo_start"
   that depends on it
 - Adjust filename, context, indentation]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c
@@ -3328,6 +3328,7 @@ brcmf_notify_sched_scan_results(struct b
 	struct brcmf_pno_scanresults_le *pfn_result;
 	u32 result_count;
 	u32 status;
+	u32 datalen;
 
 	brcmf_dbg(SCAN, "Enter\n");
 
@@ -3354,6 +3355,14 @@ brcmf_notify_sched_scan_results(struct b
 	if (result_count > 0) {
 		int i;
 
+		data += sizeof(struct brcmf_pno_scanresults_le);
+		netinfo_start = (struct brcmf_pno_net_info_le *)data;
+		datalen = e->datalen - ((void *)netinfo_start - (void *)pfn_result);
+		if (datalen < result_count * sizeof(*netinfo)) {
+			brcmf_err("insufficient event data\n");
+			goto out_err;
+		}
+
 		request = kzalloc(sizeof(*request), GFP_KERNEL);
 		ssid = kcalloc(result_count, sizeof(*ssid), GFP_KERNEL);
 		channel = kcalloc(result_count, sizeof(*channel), GFP_KERNEL);
@@ -3363,9 +3372,6 @@ brcmf_notify_sched_scan_results(struct b
 		}
 
 		request->wiphy = wiphy;
-		data += sizeof(struct brcmf_pno_scanresults_le);
-		netinfo_start = (struct brcmf_pno_net_info_le *)data;
-
 		for (i = 0; i < result_count; i++) {
 			netinfo = &netinfo_start[i];
 			if (!netinfo) {
@@ -3375,6 +3381,8 @@ brcmf_notify_sched_scan_results(struct b
 				goto out_err;
 			}
 
+			if (netinfo->SSID_len > IEEE80211_MAX_SSID_LEN)
+				netinfo->SSID_len = IEEE80211_MAX_SSID_LEN;
 			brcmf_dbg(SCAN, "SSID:%s Channel:%d\n",
 				  netinfo->SSID, netinfo->channel);
 			memcpy(ssid[i].ssid, netinfo->SSID, netinfo->SSID_len);


