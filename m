Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50CDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97ED206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782260;
	bh=PGBoSnLW4Rb1DhKStngull8p7dQLICcEIG8kZDgP+9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RdzqHOI1dJT1v9e/7UVM/KbKILuYfWyiOHJZ4p42EAuEir63qbQ7hrRFdgYEIYI0S
	 pbpXIgApcpzY6JbppY5muTcXTu2BqQ6Bf0KQ3BSrgx//2gChjGxtNIfiFHh2rNH502
	 wfsEBX6OHxK9YMW50PMdzvCLGqOOA/8Tpm+nitds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfLSSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfLSSrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:47:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0CC24672;
        Thu, 19 Dec 2019 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781235;
        bh=PGBoSnLW4Rb1DhKStngull8p7dQLICcEIG8kZDgP+9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFNysEBEDBEQ2eD8NaouLei9WZZU+UvELzaRqtQtU6fX+FJ4orvOPaNkFPPfl9OCZ
         +nLdR+gntLk6vMBb8pyqprz0GNEOLX/mhbMC5214oociR8VRDG2ukddmM7MCw3nS4M
         QUAZN2No7mhxT2S/MEaar5TgJdt/K6Jbq2nA867U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.9 139/199] pinctrl: samsung: Fix device node refcount leaks in init code
Date:   Thu, 19 Dec 2019 19:33:41 +0100
Message-Id: <20191219183222.838135508@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

commit a322b3377f4bac32aa25fb1acb9e7afbbbbd0137 upstream.

Several functions use for_each_child_of_node() loop with a break to find
a matching child node.  Although each iteration of
for_each_child_of_node puts the previous node, but early exit from loop
misses it.  This leads to leak of device node.

Cc: <stable@vger.kernel.org>
Fixes: 9a2c1c3b91aa ("pinctrl: samsung: Allow grouping multiple pinmux/pinconf nodes")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/samsung/pinctrl-samsung.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -281,6 +281,7 @@ static int samsung_dt_node_to_map(struct
 						&reserved_maps, num_maps);
 		if (ret < 0) {
 			samsung_dt_free_map(pctldev, *map, *num_maps);
+			of_node_put(np);
 			return ret;
 		}
 	}
@@ -770,8 +771,10 @@ static struct samsung_pmx_func *samsung_
 		if (!of_get_child_count(cfg_np)) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 							cfg_np, func);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(cfg_np);
 				return ERR_PTR(ret);
+			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
@@ -782,8 +785,11 @@ static struct samsung_pmx_func *samsung_
 		for_each_child_of_node(cfg_np, func_np) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 						func_np, func);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(func_np);
+				of_node_put(cfg_np);
 				return ERR_PTR(ret);
+			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;


