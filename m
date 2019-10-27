Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C6C21850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210910;
	bh=G8fdBiczYjP1dj+XAo4W0fgeejN6M3is5d/XqM9NW8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RMyzJcPA6kxJFErjznYBFsgdAdafpAUSWX+aIN0imUsF7S0uMyg9TBzc7dGl4P5oK
	 iOxrp56sByEORPITjJlj3goi21sUuYCel7bbPzlmQbpXEY1xFMgSAjfOkOpzxAWYgv
	 LwNCJR0VYbx4attX/V45fKEUY9iED0KwYbK1aK5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfJ0VPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbfJ0VPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:15:04 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723A4214AF;
        Sun, 27 Oct 2019 21:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210904;
        bh=G8fdBiczYjP1dj+XAo4W0fgeejN6M3is5d/XqM9NW8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgFlJlfz4YN+ch7uqjnif8a362U5NHr47cTt8jvI35WLdQ5qfCQuCpnZGDf4tfL9q
         OxcFi0fcYPw5HwBq1L8q3DFqLi3C3+KSenrxcng8f6GtM8lFiC6G9hKcAXQJZxKI1J
         YVRgATe9YBe9MINd8+npcVv3zo/PAs0UhRaXj1z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicolas Waisman <nico@semmle.com>,
        Will Deacon <will@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 57/93] cfg80211: wext: avoid copying malformed SSIDs
Date:   Sun, 27 Oct 2019 22:01:09 +0100
Message-Id: <20191027203303.102049509@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 4ac2813cc867ae563a1ba5a9414bfb554e5796fa upstream.

Ensure the SSID element is bounds-checked prior to invoking memcpy()
with its length field, when copying to userspace.

Cc: <stable@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Reported-by: Nicolas Waisman <nico@semmle.com>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20191004095132.15777-2-will@kernel.org
[adjust commit log a bit]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/wext-sme.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -202,6 +202,7 @@ int cfg80211_mgd_wext_giwessid(struct ne
 			       struct iw_point *data, char *ssid)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int ret = 0;
 
 	/* call only for station! */
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
@@ -219,7 +220,10 @@ int cfg80211_mgd_wext_giwessid(struct ne
 		if (ie) {
 			data->flags = 1;
 			data->length = ie[1];
-			memcpy(ssid, ie + 2, data->length);
+			if (data->length > IW_ESSID_MAX_SIZE)
+				ret = -EINVAL;
+			else
+				memcpy(ssid, ie + 2, data->length);
 		}
 		rcu_read_unlock();
 	} else if (wdev->wext.connect.ssid && wdev->wext.connect.ssid_len) {
@@ -229,7 +233,7 @@ int cfg80211_mgd_wext_giwessid(struct ne
 	}
 	wdev_unlock(wdev);
 
-	return 0;
+	return ret;
 }
 
 int cfg80211_mgd_wext_siwap(struct net_device *dev,


