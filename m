Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67882C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409E720640
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3Ccp5m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfJJKbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:31:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37794 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfJJKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:31:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id u20so2575312plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkxBDeI13PS/unHL1Nr+Sh+9tXf4QbZkcMWKpQOyoZs=;
        b=A3Ccp5m0GI0vf9vINUCaNgrXVyXgcdJaG3xHrIHMVAavr6PGkGIk2Rnv8iPDi14niy
         DeIrUZ5K3Q1T7ubCWBcWkWX8JmKwbimhiuLo0lm4549GDL1CKjT06RlAALVfrRDR5u7n
         FJ+AGVq+D276MDy6CMC86mTU+GOmxPFdikGggsEMOufzYdp5kj2OID/tuyMnSKV8Iikj
         c4hhdJW6rUhKvSG89tn4nMcBIbT54aJbpI5/7GZeJCjtchMX7zI0INRAYVWCOtTBxQob
         ZScd8nGDewPTjXDz4bzQ9r8eT/lyHZ7WcKtDsJiRlvjMmq8NMc2aTO+NmaEbxMel79G1
         aycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkxBDeI13PS/unHL1Nr+Sh+9tXf4QbZkcMWKpQOyoZs=;
        b=es/npUCRInTcaRvFsb9ftGwTVTgSC3ujsGDsuVZsAhqkvf4qmMMucgwoFD4/yCYhwc
         SkK1tSMSiHAk7SfD3tRSXV56RNFoQT8iNF6ZLNBrKXvvhjwuy6crUB8mfuHLqEsQllDf
         EYjegn/IMsGMsK/sOOYLs8LhiKu1VngXGSxsNMrg9a4UsGylh14IZg4cx+3P4ptpVmJq
         ZmNyBxWLbULxEKwdMaFmFKwDXNivRjAeD9e2l17hpo5vJ3VnQLOAcDj367gYIZ2tLzPL
         5jP2LBfyKd6iEFJfYsoicCR8ImWD6usLMtDYewo6n7vBsyPgL6uo0OcY1Q+pcMZ+isYr
         +rEA==
X-Gm-Message-State: APjAAAWq/3wcB3ouCZpzycN3l8GGZ9vyGgHlHRDOgeibdo5RHBQN+dJi
        2q7o4MVIEYqivPrzJ06Bc5NTTw==
X-Google-Smtp-Source: APXvYqzGw7DVSkGCo0+oVtm1TNRkmmIhKzdkzTs6guJGLgP3WTdjGG4hUW7yUT6AdCBxVIDYb7hllQ==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr8899294plp.132.1570703461455;
        Thu, 10 Oct 2019 03:31:01 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id q13sm10056498pjq.0.2019.10.10.03.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:31:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "v5 . 0+" <stable@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: of: drop incorrect lockdep_assert_held()
Date:   Thu, 10 Oct 2019 16:00:52 +0530
Message-Id: <6306e18beab9deff6ee6b32f489390908495fe14.1570703431.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_find_opp_of_np() doesn't traverse the list of OPP tables but instead
just the entries within an OPP table and so only requires to lock the
OPP table itself.

The lockdep_assert_held() was added there by mistake and isn't really
required.

Fixes: 5d6d106fa455 ("OPP: Populate required opp tables from "required-opps" property")
Cc: v5.0+ <stable@vger.kernel.org> # v5.0+
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1813f5ad5fa2..6dc41faf74b5 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -77,8 +77,6 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 {
 	struct dev_pm_opp *opp;
 
-	lockdep_assert_held(&opp_table_lock);
-
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-- 
2.21.0.rc0.269.g1a574e7a288b

