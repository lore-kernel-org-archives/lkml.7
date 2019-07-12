Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9CCC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD302084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934322;
	bh=foU8/SdRjmkg8g68VdEPgAvGDd0f6MXFPOujEykaolc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fKqxRlTVI1fJedbjZ38HnaqsIIcvfN7gBYhgsKzWPgW9L72zZiT5yjj02LDsFCuc6
	 teW/vCsIEfbA+CLRa8e1hyRQjuyGoTZd+JsEcBJJvfV2yAsYRj9yW0lflt0PDKm2fh
	 Xy7j8KCPBYfODsy1tHaAE58qH2nYGqp73a0qzFEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfGLMZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbfGLMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:25:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992AD2171F;
        Fri, 12 Jul 2019 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934314;
        bh=foU8/SdRjmkg8g68VdEPgAvGDd0f6MXFPOujEykaolc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=noCDBPPWXBkBB/ajvbAdlks9eXXuoeWRupleZHK2yMYqtpqo0snyM1wfnxdeqKFsH
         +GGuBhC18GgYKUTkyGBVZUVcdXo/18DNvnlv4hsLGVdQMmGSVwcKpThjMA0TLX+MWZ
         sWeV3jsjjM9SUB0AI7vhBFbQbL9XjdKMHz2+crXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 015/138] mac80211: fix rate reporting inside cfg80211_calculate_bitrate_he()
Date:   Fri, 12 Jul 2019 14:17:59 +0200
Message-Id: <20190712121629.308138963@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 25d16d124a5e249e947c0487678b61dcff25cf8b ]

The reported rate is not scaled down correctly. After applying this patch,
the function will behave just like the v/ht equivalents.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 75899b62bdc9..5a03f38788e7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1237,7 +1237,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	if (rate->he_dcm)
 		result /= 2;
 
-	return result;
+	return result / 10000;
 }
 
 u32 cfg80211_calculate_bitrate(struct rate_info *rate)
-- 
2.20.1



