Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8115C2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VeyYF4Z8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VI0TTPkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfCTKtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:49:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTKtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:49:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25BFB60E59; Wed, 20 Mar 2019 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553078952;
        bh=HndniLRank9/R+U30rrKGdlktgQVhPF2solyl/13pxU=;
        h=From:To:Cc:Subject:Date:From;
        b=VeyYF4Z8a4QXan+03ms7Cbmz+TohRLKi/L04k4dvi5MOm0jZNSYtE82xUB+qd/pSL
         8mPhyVYatNIX0qFnrUub+s9wfj+aP2aHJg1Gs9paxeV7f2aU/tw+pdhAVbDNefvLN9
         CtvEtkgjvrYRkFWB3U5FcXWqopWz5fPlCIv73OoE=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6468860CF1;
        Wed, 20 Mar 2019 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553078951;
        bh=HndniLRank9/R+U30rrKGdlktgQVhPF2solyl/13pxU=;
        h=From:To:Cc:Subject:Date:From;
        b=VI0TTPkqfy1kECDDYbPEcN6rSnw0Jv6dGV+7bz8lo026RkoRKjLFlE9f5uR61M1k5
         BSwZ5HVRj9WtBF9Mbkbtof8CvAy9zGY85efApQNJQjxSuQcIOMl6W4uRf2KYAYVHlK
         kjav1SzYdExndKRuQnSwaAJBlgyshPzsg+5sIAOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6468860CF1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] of: Drop redundant check in linker section OF match table
Date:   Wed, 20 Mar 2019 16:19:00 +0530
Message-Id: <1553078940-9907-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing check of `fn` against NULL inside OF match table
is redundant. Remove the check.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: devicetree@vger.kernel.org
---
 include/linux/of.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index e240992..b86c00a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1283,13 +1283,13 @@ static inline int of_get_available_child_count(const struct device_node *np)
 	static const struct of_device_id __of_table_##name		\
 		__used __section(__##table##_of_table)			\
 		 = { .compatible = compat,				\
-		     .data = (fn == (fn_type)NULL) ? fn : fn  }
+		     .data = fn }
 #else
 #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
 	static const struct of_device_id __of_table_##name		\
 		__attribute__((unused))					\
 		 = { .compatible = compat,				\
-		     .data = (fn == (fn_type)NULL) ? fn : fn }
+		     .data = fn }
 #endif
 
 typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

