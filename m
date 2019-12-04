Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2F9206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482687;
	bh=3QMdufV80+4d+hL2KT7BVZFNM0dt7I/JcvPcovucgcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWnvYi5GqHIXxv9K4YheWm5OSSYL2HTPCljpVOr8FQpPXMNAVKGCZHIR2ss37W6Gh
	 l/j6bCN8GTwAKYlvQpzYLgAy+LG6g4gQWhLvaSNK4JJdhYwShQ8ahAI+fhyDxUu8xX
	 eY/30QLPPyMJLrMdM9kgvMioDDjtdhJcLCFfZstY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfLDSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfLDSEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:04:42 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C60D206DF;
        Wed,  4 Dec 2019 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482681;
        bh=3QMdufV80+4d+hL2KT7BVZFNM0dt7I/JcvPcovucgcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APir3mACw7GzvowYUbgTtpkp/mceSVKKryyMgEi9U2w7lY5GmOkMm2M4iuJW/fSbr
         sFMPireU568r5m4V7HIMh8QOCMiRmGyACb1RBhp/KYEd/jcTBabgkREMS7Hx3Be5Ko
         NXTazFPqVH5ts37h1PfY2VfQaE2KlrMwhhiX1x1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyle Roeschley <kyle.roeschley@ni.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 091/209] ath6kl: Only use match sets when firmware supports it
Date:   Wed,  4 Dec 2019 18:55:03 +0100
Message-Id: <20191204175328.020098178@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Roeschley <kyle.roeschley@ni.com>

[ Upstream commit fb376a495fbdb886f38cfaf5a3805401b9e46f13 ]

Commit dd45b7598f1c ("ath6kl: Include match ssid list in scheduled scan")
merged the probed and matched SSID lists before sending them to the
firmware. In the process, it assumed match set support is always available
in ath6kl_set_probed_ssids, which breaks scans for hidden SSIDs. Now, check
that the firmware supports matching SSIDs in scheduled scans before setting
MATCH_SSID_FLAG.

Fixes: dd45b7598f1c ("ath6kl: Include match ssid list in scheduled scan")
Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 414b5b596efcd..f790d8021fa17 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -939,7 +939,7 @@ static int ath6kl_set_probed_ssids(struct ath6kl *ar,
 		else
 			ssid_list[i].flag = ANY_SSID_FLAG;
 
-		if (n_match_ssid == 0)
+		if (ar->wiphy->max_match_sets != 0 && n_match_ssid == 0)
 			ssid_list[i].flag |= MATCH_SSID_FLAG;
 	}
 
-- 
2.20.1



