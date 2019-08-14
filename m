Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ECA2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802451;
	bh=WHKWy/SELvbnwK3ZMPJTjrcQrATzISOSMmmKEDqbyOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uLri5d46fuFlKAlW+bEivE+8rWkHNj0nK/UWUSEuFEBHwIkS8MuhAbVBisnjMGPgj
	 vedUh3m2k9xKNolvP2pc57BbQfeRPqe37jEJQgVl0IuRezjfO5aLPUbD9+pWGR9WpM
	 BuWZPDH3hpnlLpeM/JJ4/TQWssgPT6MXVvgnI7KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHNRHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbfHNRH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:07:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1805217F4;
        Wed, 14 Aug 2019 17:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802447;
        bh=WHKWy/SELvbnwK3ZMPJTjrcQrATzISOSMmmKEDqbyOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ccom8LSARbMc2W7EjkGLDfKbWzrhoS2YdrbaxGwDGZP5UHurLQx1vjXX1vWJd6GF7
         +61HwfpCTCuKhylXmMu/UtVa+n1iGfeZ09avY25YXVxYH8VIxKhiAvP1ie10TxDuXz
         ssjw8lSNdmPR/rOKea2uyGhKmKtxAQRkg4f76Y4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.2 130/144] mac80211: dont WARN on short WMM parameters from AP
Date:   Wed, 14 Aug 2019 19:01:26 +0200
Message-Id: <20190814165805.381502877@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

commit 05aaa5c97dce4c10a9e7eae2f1569a684e0c5ced upstream.

In a very similar spirit to commit c470bdc1aaf3 ("mac80211: don't WARN
on bad WMM parameters from buggy APs"), an AP may not transmit a
fully-formed WMM IE. For example, it may miss or repeat an Access
Category. The above loop won't catch that and will instead leave one of
the four ACs zeroed out. This triggers the following warning in
drv_conf_tx()

  wlan0: invalid CW_min/CW_max: 0/0

and it may leave one of the hardware queues unconfigured. If we detect
such a case, let's just print a warning and fall back to the defaults.

Tested with a hacked version of hostapd, intentionally corrupting the
IEs in hostapd_eid_wmm().

Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/r/20190726224758.210953-1-briannorris@chromium.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/mlme.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2041,6 +2041,16 @@ ieee80211_sta_wmm_params(struct ieee8021
 		ieee80211_regulatory_limit_wmm_params(sdata, &params[ac], ac);
 	}
 
+	/* WMM specification requires all 4 ACIs. */
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		if (params[ac].cw_min == 0) {
+			sdata_info(sdata,
+				   "AP has invalid WMM params (missing AC %d), using defaults\n",
+				   ac);
+			return false;
+		}
+	}
+
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		mlme_dbg(sdata,
 			 "WMM AC=%d acm=%d aifs=%d cWmin=%d cWmax=%d txop=%d uapsd=%d, downgraded=%d\n",


