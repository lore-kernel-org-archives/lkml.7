Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23879C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5AF2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689180;
	bh=2QEQiBsxvmwYnEK/ZwOWnDIb/XeDvwnsmbtHT0EM60o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTt6r0JKOTR+mUtZHGS2HTpwQZUqDQtKnKAMpSMKvJTcrc18liGbRXge/y29QKi+T
	 E2xjo1ZsEz/y2Q4+mULb2SPrHl3y1W6TGP+7EdILeiUYRQJcikGLBKbJ9/JIJVIfId
	 G7NLtOWwds3ul9tgfbbfoQ911LMAje5bYZf7OQ4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCDI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfCDI0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:26:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F5C20863;
        Mon,  4 Mar 2019 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688012;
        bh=2QEQiBsxvmwYnEK/ZwOWnDIb/XeDvwnsmbtHT0EM60o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQyWWKPRcsB5ihgb8k3V0tmu0Ygutz0iuFVtg2S1ahmTDeII3AMnBv82NyN7PcLWv
         ZAPBiVy9TFN6w13Ow/c7C/08ky5S6Wk20QjaVM8YwkuN0Yh72OGrgnNUbVUx/m4irG
         jURAblwgQU/STJIn6F/3xD6w2dLyz9VMPyHJyEP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Tata <Chaitanya.Tata@bluwireless.co.uk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 41/52] cfg80211: extend range deviation for DMG
Date:   Mon,  4 Mar 2019 09:22:39 +0100
Message-Id: <20190304081619.474825622@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

[ Upstream commit 93183bdbe73bbdd03e9566c8dc37c9d06b0d0db6 ]

Recently, DMG frequency bands have been extended till 71GHz, so extend
the range check till 20GHz (45-71GHZ), else some channels will be marked
as disabled.

Signed-off-by: Chaitanya Tata <Chaitanya.Tata@bluwireless.co.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index bd91de4160353..ebfbc3f1be428 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -759,7 +759,7 @@ static bool is_valid_rd(const struct ieee80211_regdomain *rd)
  * definitions (the "2.4 GHz band", the "5 GHz band" and the "60GHz band"),
  * however it is safe for now to assume that a frequency rule should not be
  * part of a frequency's band if the start freq or end freq are off by more
- * than 2 GHz for the 2.4 and 5 GHz bands, and by more than 10 GHz for the
+ * than 2 GHz for the 2.4 and 5 GHz bands, and by more than 20 GHz for the
  * 60 GHz band.
  * This resolution can be lowered and should be considered as we add
  * regulatory rule support for other "bands".
@@ -774,7 +774,7 @@ static bool freq_in_rule_band(const struct ieee80211_freq_range *freq_range,
 	 * with the Channel starting frequency above 45 GHz.
 	 */
 	u32 limit = freq_khz > 45 * ONE_GHZ_IN_KHZ ?
-			10 * ONE_GHZ_IN_KHZ : 2 * ONE_GHZ_IN_KHZ;
+			20 * ONE_GHZ_IN_KHZ : 2 * ONE_GHZ_IN_KHZ;
 	if (abs(freq_khz - freq_range->start_freq_khz) <= limit)
 		return true;
 	if (abs(freq_khz - freq_range->end_freq_khz) <= limit)
-- 
2.19.1



