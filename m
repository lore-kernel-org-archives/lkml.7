Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A1C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE01B21929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930827;
	bh=xHZeo9vhS2BI1Gc35dfmKtmJEAlCNthIPihqclJ5Xwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9l/1Y1X9KoNAjbm9ETpA/eQSJ1vYYEFdoTTj41GmM6I9RV3VkT1h2IJmvt6ux8k1
	 SWkiTufyFLRtVq63f9LPqoUO/9nBB/E0mRMdqt2h16Pf5eSIXWtjNPLa7esmnCxczL
	 Lzi9YrnTyTFHj4VGV4c/g5zDvQWz1oqnkSg8pzV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393142AbfISWHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393123AbfISWHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:07:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1A721907;
        Thu, 19 Sep 2019 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930822;
        bh=xHZeo9vhS2BI1Gc35dfmKtmJEAlCNthIPihqclJ5Xwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZFi5lqR7Glmh/wXtXWSOcYmzHsu0oQnouDcseXrBtcgjmdQrnP906DfjAHGE61/i
         gPDH90hKdWNVgiCJ5ERUBhg+q4HJ8lG9eeufurcPGB6Dev+3OzGXgep8vu/Vg6NIOS
         nCWqtySjGtx5iJXd5GV/MJLx3aepp8qvZDZuDTvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Masashi Honma <masashi.honma@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.2 026/124] nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds
Date:   Fri, 20 Sep 2019 00:01:54 +0200
Message-Id: <20190919214820.003228381@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

commit 4b2c5a14cd8005a900075f7dfec87473c6ee66fb upstream.

commit 1222a1601488 ("nl80211: Fix possible Spectre-v1 for CQM
RSSI thresholds") was incomplete and requires one more fix to
prevent accessing to rssi_thresholds[n] because user can control
rssi_thresholds[i] values to make i reach to n. For example,
rssi_thresholds = {-400, -300, -200, -100} when last is -34.

Cc: stable@vger.kernel.org
Fixes: 1222a1601488 ("nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Link: https://lore.kernel.org/r/20190908005653.17433-1-masashi.honma@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10640,9 +10640,11 @@ static int cfg80211_cqm_rssi_update(stru
 	hyst = wdev->cqm_config->rssi_hyst;
 	n = wdev->cqm_config->n_rssi_thresholds;
 
-	for (i = 0; i < n; i++)
+	for (i = 0; i < n; i++) {
+		i = array_index_nospec(i, n);
 		if (last < wdev->cqm_config->rssi_thresholds[i])
 			break;
+	}
 
 	low_index = i - 1;
 	if (low_index >= 0) {


