Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB83C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C9620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687814;
	bh=sId+74/EyAjDuEho0RaXf09XScz7tEbnioPhs/4zrAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWRqPPco4KfMruO/Uc0xiyLBR0Y8dwBhi4khouFqZwpXaRBpjoEJz0y/UtgsXeRJo
	 S+2IkvpuoQiQnTtm10EfnuSYk0Jp3zVak6XGXA597PGVMLRruqy2/Uc0gcYwlv8vO0
	 7hQj+pG6OF9LO6YQvr4HO00oaBxaLIBwRpcc2LyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfCDIXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfCDIX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C821D20863;
        Mon,  4 Mar 2019 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687807;
        bh=sId+74/EyAjDuEho0RaXf09XScz7tEbnioPhs/4zrAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pm1gRY/qvIxBbAVHSbynUTDyhsmFmmsSkQndDcSU0CrRMYhDvc/ufhOpTT0jYA67B
         AT4svfATRtWnKrLyUFnBbzj06s0P1rrlEgAajXhvStq57RIEBPnvjSPIBIRNZ1Bk+r
         vi3WiYL4z/PyWK+u+TVNjXR0OYyfLYFDCzg096kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Tata <Chaitanya.Tata@bluwireless.co.uk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/32] cfg80211: extend range deviation for DMG
Date:   Mon,  4 Mar 2019 09:22:14 +0100
Message-Id: <20190304081604.218613742@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 36d1d25082e32..7c19d0d2549b1 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -773,7 +773,7 @@ static bool reg_does_bw_fit(const struct ieee80211_freq_range *freq_range,
  * definitions (the "2.4 GHz band", the "5 GHz band" and the "60GHz band"),
  * however it is safe for now to assume that a frequency rule should not be
  * part of a frequency's band if the start freq or end freq are off by more
- * than 2 GHz for the 2.4 and 5 GHz bands, and by more than 10 GHz for the
+ * than 2 GHz for the 2.4 and 5 GHz bands, and by more than 20 GHz for the
  * 60 GHz band.
  * This resolution can be lowered and should be considered as we add
  * regulatory rule support for other "bands".
@@ -788,7 +788,7 @@ static bool freq_in_rule_band(const struct ieee80211_freq_range *freq_range,
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



