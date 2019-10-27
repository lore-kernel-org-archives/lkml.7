Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9868CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F112208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210232;
	bh=BHaZ0thSrMkWnwFdeveFtEwkntjlCLP6ZJzV+98U+qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=alY7oH90dq4Pi7QWeQw1XMnXHEgeQwsHUT/JVEja9UV2fYm75nn1cKA/ku23so2zI
	 QKCtNjtCVHPj/FEIw/Nf/b17TzUmVr0kWrM7jlYS27C/EMjputwt91Ig4Hr6AVG0Ii
	 JmeTHM6wmiVuXxawUX3m8dEyfZg2jbUadKZXwHXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfJ0VDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfJ0VDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:48 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B50208C0;
        Sun, 27 Oct 2019 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210228;
        bh=BHaZ0thSrMkWnwFdeveFtEwkntjlCLP6ZJzV+98U+qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wmw9++qlOFzLJfTdNP56cee+jQ2Th7lDRgwGMKWpYudJKrZCQbcgAetqW3sfboglD
         ZcleJG2k/gfWKqTeuUIPYrJv7OJWser2JmzqGZWDGh49B/VEe6dX73yfaBxoDsgofj
         5hj8q/OsAZood1VHPqBrOSFAlFl7m3jAVzXbtx7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicolas Waisman <nico@semmle.com>,
        Will Deacon <will@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 27/41] cfg80211: wext: avoid copying malformed SSIDs
Date:   Sun, 27 Oct 2019 22:01:05 +0100
Message-Id: <20191027203123.034455639@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
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
@@ -225,6 +225,7 @@ int cfg80211_mgd_wext_giwessid(struct ne
 			       struct iw_point *data, char *ssid)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int ret = 0;
 
 	/* call only for station! */
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
@@ -242,7 +243,10 @@ int cfg80211_mgd_wext_giwessid(struct ne
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
@@ -252,7 +256,7 @@ int cfg80211_mgd_wext_giwessid(struct ne
 	}
 	wdev_unlock(wdev);
 
-	return 0;
+	return ret;
 }
 
 int cfg80211_mgd_wext_siwap(struct net_device *dev,


