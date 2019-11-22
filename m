Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AB920854
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420853;
	bh=GiRq6isUKqlw5ic9C6s8nWtJ3WvmPvXY0nX5Cv07Y+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/yk2LA0/d9w63xWI1CiccDSZt4aOx7chK2oVy3B0PY/zimkgpid7HMClQT5FTDYQ
	 lvo4VvPT7k2bgh79bc3Azqv1TFNcfBgQ13jOt18WFWZBBpjPR59RtkFR7H0Qy8ThWh
	 09O5mrWLpmfotbwBAoLcXZTAZgtdu3rVFepnjiLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfKVLHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbfKVLFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:05:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344962070E;
        Fri, 22 Nov 2019 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420744;
        bh=GiRq6isUKqlw5ic9C6s8nWtJ3WvmPvXY0nX5Cv07Y+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7BmO66QC/WMVtTMehG5QLstEjnJ32aCzmtibEjfeGPV7rK9WGHYOgXOMArX5LJSW
         ZckyYExczxSolAO+xvRrj1dnAJFsrGkGTgKSfmxcK1xJDxz43fdYga1FNUTn/JSuSg
         4rrSwRGMBbA6lGtMa0x2Fq9VJvrrkWFmDq62/M/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 209/220] mac80211: minstrel: fix CCK rate group streams value
Date:   Fri, 22 Nov 2019 11:29:34 +0100
Message-Id: <20191122100928.769259347@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
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
index ae1a180d2eee3..2ecca10f6c24a 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -129,7 +129,7 @@
 
 #define CCK_GROUP					\
 	[MINSTREL_CCK_GROUP] = {			\
-		.streams = 0,				\
+		.streams = 1,				\
 		.flags = 0,				\
 		.duration = {				\
 			CCK_DURATION_LIST(false),	\
-- 
2.20.1



