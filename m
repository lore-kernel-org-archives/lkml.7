Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A75C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E8320692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143769;
	bh=UBcwiqcs+4h2OQNhYlEoP/ApOIVZSmpdBOgLMo93mcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZcUVw5YfNFkcRsEcHEb7FDlo8oeo7xXlDXxU9Hipveer8zwVml9aIH4qokAeoW6Ox
	 fAX3HYJBUjKFH9ebeeMe/jlORWQxNQs8mQvkL5pVdYpaJOH0BtgQmD/hpQCkf8MTvN
	 Ce/F79PS00nlWLg4ZvySy4MWwPGopeLsztM6dr3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfKSF2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfKSF2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:28:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC150208C3;
        Tue, 19 Nov 2019 05:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141316;
        bh=UBcwiqcs+4h2OQNhYlEoP/ApOIVZSmpdBOgLMo93mcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kp7hEZt5PO4JjBumdPIxYqXhCIn5JU59NnCv6KXWWAxoSodHeeR+uZ3YuYHj447fx
         ZGRmSwIj1aX7n/Xe2/12A7PvEo/Fz10A51UU0bRzekaDrUnlILv7iLTwvbMnf1G8zz
         O60ggGEv8sC3HWEAtnkTOufiJ/Gn7xhwz98fDSG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 119/422] cfg80211: validate wmm rule when setting
Date:   Tue, 19 Nov 2019 06:15:16 +0100
Message-Id: <20191119051406.766888842@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislaw Gruszka <sgruszka@redhat.com>

[ Upstream commit 014f5a250fc49fa8c6cd50093e725e71f3ae52da ]

Add validation check for wmm rule when copy rules from fwdb and print
error when rule is invalid.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 64 +++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 68ae97ef8bf0b..64841238df855 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -847,22 +847,36 @@ static bool valid_regdb(const u8 *data, unsigned int size)
 	return true;
 }
 
-static void set_wmm_rule(struct ieee80211_reg_rule *rrule,
-			 struct fwdb_wmm_rule *wmm)
-{
-	struct ieee80211_wmm_rule *rule = &rrule->wmm_rule;
-	unsigned int i;
+static void set_wmm_rule(const struct fwdb_header *db,
+			 const struct fwdb_country *country,
+			 const struct fwdb_rule *rule,
+			 struct ieee80211_reg_rule *rrule)
+{
+	struct ieee80211_wmm_rule *wmm_rule = &rrule->wmm_rule;
+	struct fwdb_wmm_rule *wmm;
+	unsigned int i, wmm_ptr;
+
+	wmm_ptr = be16_to_cpu(rule->wmm_ptr) << 2;
+	wmm = (void *)((u8 *)db + wmm_ptr);
+
+	if (!valid_wmm(wmm)) {
+		pr_err("Invalid regulatory WMM rule %u-%u in domain %c%c\n",
+		       be32_to_cpu(rule->start), be32_to_cpu(rule->end),
+		       country->alpha2[0], country->alpha2[1]);
+		return;
+	}
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		rule->client[i].cw_min =
+		wmm_rule->client[i].cw_min =
 			ecw2cw((wmm->client[i].ecw & 0xf0) >> 4);
-		rule->client[i].cw_max = ecw2cw(wmm->client[i].ecw & 0x0f);
-		rule->client[i].aifsn =  wmm->client[i].aifsn;
-		rule->client[i].cot = 1000 * be16_to_cpu(wmm->client[i].cot);
-		rule->ap[i].cw_min = ecw2cw((wmm->ap[i].ecw & 0xf0) >> 4);
-		rule->ap[i].cw_max = ecw2cw(wmm->ap[i].ecw & 0x0f);
-		rule->ap[i].aifsn = wmm->ap[i].aifsn;
-		rule->ap[i].cot = 1000 * be16_to_cpu(wmm->ap[i].cot);
+		wmm_rule->client[i].cw_max = ecw2cw(wmm->client[i].ecw & 0x0f);
+		wmm_rule->client[i].aifsn =  wmm->client[i].aifsn;
+		wmm_rule->client[i].cot =
+			1000 * be16_to_cpu(wmm->client[i].cot);
+		wmm_rule->ap[i].cw_min = ecw2cw((wmm->ap[i].ecw & 0xf0) >> 4);
+		wmm_rule->ap[i].cw_max = ecw2cw(wmm->ap[i].ecw & 0x0f);
+		wmm_rule->ap[i].aifsn = wmm->ap[i].aifsn;
+		wmm_rule->ap[i].cot = 1000 * be16_to_cpu(wmm->ap[i].cot);
 	}
 
 	rrule->has_wmm = true;
@@ -870,7 +884,7 @@ static void set_wmm_rule(struct ieee80211_reg_rule *rrule,
 
 static int __regdb_query_wmm(const struct fwdb_header *db,
 			     const struct fwdb_country *country, int freq,
-			     struct ieee80211_reg_rule *rule)
+			     struct ieee80211_reg_rule *rrule)
 {
 	unsigned int ptr = be16_to_cpu(country->coll_ptr) << 2;
 	struct fwdb_collection *coll = (void *)((u8 *)db + ptr);
@@ -879,18 +893,14 @@ static int __regdb_query_wmm(const struct fwdb_header *db,
 	for (i = 0; i < coll->n_rules; i++) {
 		__be16 *rules_ptr = (void *)((u8 *)coll + ALIGN(coll->len, 2));
 		unsigned int rule_ptr = be16_to_cpu(rules_ptr[i]) << 2;
-		struct fwdb_rule *rrule = (void *)((u8 *)db + rule_ptr);
-		struct fwdb_wmm_rule *wmm;
-		unsigned int wmm_ptr;
+		struct fwdb_rule *rule = (void *)((u8 *)db + rule_ptr);
 
-		if (rrule->len < offsetofend(struct fwdb_rule, wmm_ptr))
+		if (rule->len < offsetofend(struct fwdb_rule, wmm_ptr))
 			continue;
 
-		if (freq >= KHZ_TO_MHZ(be32_to_cpu(rrule->start)) &&
-		    freq <= KHZ_TO_MHZ(be32_to_cpu(rrule->end))) {
-			wmm_ptr = be16_to_cpu(rrule->wmm_ptr) << 2;
-			wmm = (void *)((u8 *)db + wmm_ptr);
-			set_wmm_rule(rule, wmm);
+		if (freq >= KHZ_TO_MHZ(be32_to_cpu(rule->start)) &&
+		    freq <= KHZ_TO_MHZ(be32_to_cpu(rule->end))) {
+			set_wmm_rule(db, country, rule, rrule);
 			return 0;
 		}
 	}
@@ -972,12 +982,8 @@ static int regdb_query_country(const struct fwdb_header *db,
 		if (rule->len >= offsetofend(struct fwdb_rule, cac_timeout))
 			rrule->dfs_cac_ms =
 				1000 * be16_to_cpu(rule->cac_timeout);
-		if (rule->len >= offsetofend(struct fwdb_rule, wmm_ptr)) {
-			u32 wmm_ptr = be16_to_cpu(rule->wmm_ptr) << 2;
-			struct fwdb_wmm_rule *wmm = (void *)((u8 *)db + wmm_ptr);
-
-			set_wmm_rule(rrule, wmm);
-		}
+		if (rule->len >= offsetofend(struct fwdb_rule, wmm_ptr))
+			set_wmm_rule(db, country, rule, rrule);
 	}
 
 	return reg_schedule_apply(regdom);
-- 
2.20.1



