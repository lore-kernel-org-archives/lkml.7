Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBA2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CEC206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371488;
	bh=v7I6ciQfvTlvvf5jL4azmw9jcynwdPjFOVEzmLvj1fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xaACPJlzqcvbBqSQbU/CYAuh2VT8P+IFtfmxY/vmynFFxroCWPKou7CvKMr4uT2pM
	 lOMlplY70r3KzDzeVJ/QByphPimZU8R9l6Y4/fX4IruZK6K4So/hXQ1kAgjlc0DfZw
	 vs+JRJS8aKOy2CsHvUx8GqDBVl8yBYe4r25WRxN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfDDJv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730155AbfDDIzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E81020693;
        Thu,  4 Apr 2019 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368099;
        bh=v7I6ciQfvTlvvf5jL4azmw9jcynwdPjFOVEzmLvj1fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltp3pFVrHCiY+YuiP9oG4JGstg0QoHSeA40b9Y7GqGJ0fuAgfp8Yo2AL9pOHBFQg6
         M9ftKdCJtuDxvVB7g6N0jXIdG8y9Wecy+hSGwx/85mEbcCYmyw5CQMHephpkSPQ6Fv
         v8kSJgR9ghDxxyiqx+Zw7+1W7v+NMKJvcXUdfV7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 037/121] wil6210: check null pointer in _wil_cfg80211_merge_extra_ies
Date:   Thu,  4 Apr 2019 10:47:05 +0200
Message-Id: <20190404084547.323916592@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit de77a53c2d1e8fb3621e63e8e1f0f0c9a1a99ff7 ]

ies1 or ies2 might be null when code inside
_wil_cfg80211_merge_extra_ies access them.
Add explicit check for null and make sure ies1/ies2 are not
accessed in such a case.

spos might be null and be accessed inside
_wil_cfg80211_merge_extra_ies.
Add explicit check for null in the while condition statement
and make sure spos is not accessed in such a case.

Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 85d5c04618eb..c374ed311520 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1224,6 +1224,12 @@ static int _wil_cfg80211_merge_extra_ies(const u8 *ies1, u16 ies1_len,
 	u8 *buf, *dpos;
 	const u8 *spos;
 
+	if (!ies1)
+		ies1_len = 0;
+
+	if (!ies2)
+		ies2_len = 0;
+
 	if (ies1_len == 0 && ies2_len == 0) {
 		*merged_ies = NULL;
 		*merged_len = 0;
@@ -1233,17 +1239,19 @@ static int _wil_cfg80211_merge_extra_ies(const u8 *ies1, u16 ies1_len,
 	buf = kmalloc(ies1_len + ies2_len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	memcpy(buf, ies1, ies1_len);
+	if (ies1)
+		memcpy(buf, ies1, ies1_len);
 	dpos = buf + ies1_len;
 	spos = ies2;
-	while (spos + 1 < ies2 + ies2_len) {
+	while (spos && (spos + 1 < ies2 + ies2_len)) {
 		/* IE tag at offset 0, length at offset 1 */
 		u16 ielen = 2 + spos[1];
 
 		if (spos + ielen > ies2 + ies2_len)
 			break;
 		if (spos[0] == WLAN_EID_VENDOR_SPECIFIC &&
-		    !_wil_cfg80211_find_ie(ies1, ies1_len, spos, ielen)) {
+		    (!ies1 || !_wil_cfg80211_find_ie(ies1, ies1_len,
+						     spos, ielen))) {
 			memcpy(dpos, spos, ielen);
 			dpos += ielen;
 		}
-- 
2.19.1



