Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF53CC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C390721897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419547;
	bh=VMg1/960H4bCLiSqQuRmtOfD/J5GiPUM3gDgYzGj8gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xyApZQ8cjeAQBgZuevycPoUj0eNp0APNuYxVyy6+xBSpnxqEcyYE03eGxCSCv141d
	 XxIoBon9kbBYIdMohyf8qXlU7Bj2RFWFukTLOBhhCnTIwJwn3QhxQryyk33Pvu2TFu
	 t8tN+6FDromfQwDgthIWDlXYmnn3zHTD9Qq9BbWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390938AbfGRDMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403790AbfGRDMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:12:18 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2758521852;
        Thu, 18 Jul 2019 03:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419537;
        bh=VMg1/960H4bCLiSqQuRmtOfD/J5GiPUM3gDgYzGj8gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTPraqncXuDgKdxOeSlt26/a6g3vUQitTLbdofiCJ6QgPVOgQbPFkKDE0FREUi/uq
         MxKSFHkYrF1ObwjDgeKDkgbQzmCk2/s4K72mRl/Vrw36lFRkYDx3gIYt6VBBDL5cDL
         H/0K/rpI8qHG2YlVbzJummhCgOfH++JbPn/rszH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huangwen <huangwen@venustech.com.cn>,
        Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 07/54] mwifiex: Fix possible buffer overflows at parsing bss descriptor
Date:   Thu, 18 Jul 2019 12:01:37 +0900
Message-Id: <20190718030049.677256432@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 13ec7f10b87f5fc04c4ccbd491c94c7980236a74 ]

mwifiex_update_bss_desc_with_ie() calls memcpy() unconditionally in
a couple places without checking the destination size.  Since the
source is given from user-space, this may trigger a heap buffer
overflow.

Fix it by putting the length check before performing memcpy().

This fix addresses CVE-2019-3846.

Reported-by: huangwen <huangwen@venustech.com.cn>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 78d59a67f7e1..674ad3405646 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1236,6 +1236,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 		}
 		switch (element_id) {
 		case WLAN_EID_SSID:
+			if (element_len > IEEE80211_MAX_SSID_LEN)
+				return -EINVAL;
 			bss_entry->ssid.ssid_len = element_len;
 			memcpy(bss_entry->ssid.ssid, (current_ptr + 2),
 			       element_len);
@@ -1245,6 +1247,8 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			break;
 
 		case WLAN_EID_SUPP_RATES:
+			if (element_len > MWIFIEX_SUPPORTED_RATES)
+				return -EINVAL;
 			memcpy(bss_entry->data_rates, current_ptr + 2,
 			       element_len);
 			memcpy(bss_entry->supported_rates, current_ptr + 2,
-- 
2.20.1



