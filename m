Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582DBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3620718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419788;
	bh=j9Zcp3P2qjbCbgdGS8uBWmnp7vlhR4j9Ra7HKixGESQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08O3/1iAKqG62hYG4fn9ADanm3NT5zv6hutCpwhXNDUq9gfnT50ul2LiVkYwBGPf4
	 1DMeBGnqO6idnH1Z6qbRdYaBEIAdd4nqv9Fh4l/4pa82Y9KiaP4Q2cWaAQTG5fxnig
	 8oRzPl5bI+46GAQ1C/UchYFOW+fO9ux21kW4TXBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfKVKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbfKVKtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:49:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3767A20718;
        Fri, 22 Nov 2019 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419779;
        bh=j9Zcp3P2qjbCbgdGS8uBWmnp7vlhR4j9Ra7HKixGESQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKhc/FE2KSk/Jj5hn0eUq8CxDcHYbVggL8Jqwzr8uL/Gj0n1xsJ6Hpzje0BF0Zzf/
         TNtmBEkKPtqozN7M3/dqgXQaQfzCIPK99M+mrRjUFdr8eI4S9Is4x68ajkvpuZVyK1
         9mf9aaZZPQa5SJo43gJOO5zbCJk/G5fltUSy1OjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 219/222] mac80211: minstrel: fix CCK rate group streams value
Date:   Fri, 22 Nov 2019 11:29:19 +0100
Message-Id: <20191122100918.403586496@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 80df9be67c44cb636bbc92caeddad8caf334c53c ]

Fixes a harmless underflow issue when CCK rates are actively being used

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 30fbabf4bcbc1..593184d14b3ef 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -128,7 +128,7 @@
 
 #define CCK_GROUP					\
 	[MINSTREL_CCK_GROUP] = {			\
-		.streams = 0,				\
+		.streams = 1,				\
 		.flags = 0,				\
 		.duration = {				\
 			CCK_DURATION_LIST(false),	\
-- 
2.20.1



