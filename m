Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFA42070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258796;
	bh=t9EUwSKILR60IQ7F/N4zFbB7RulMvj2fxde1hAe8BOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0owHUt/5rdiQu/bsMK7f0TtE7Lm0kjhrJnWfFbZhEYnJsI9T86UmV69LpC4OOgJZ7
	 dr+EhvLgdIZs4uBtevhU0za7/YcxLhtL1xTIPKzO3Op4icMCj2DaMXx+9cVITlJ7nD
	 Gq6m4FwXxBlTlr4qhOKFy8Nm5h0q36erLTOjVGFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbfCVMqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733270AbfCVL7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148C02192B;
        Fri, 22 Mar 2019 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255957;
        bh=t9EUwSKILR60IQ7F/N4zFbB7RulMvj2fxde1hAe8BOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zijDUBmAljTNxoQ3oK0kPoPVuOm/5ZfCgd4aDYdj5arFCTF+YcOJSqSN9EF9xFDIv
         vQIVXriahkzEkChgu/nCP0D3Zns4s0FDrDIcffi0W8kO6wNWnfLzyyalWAsKeTHA64
         uBhWqwkW9OJzlw/kQEfXFGy+WrPvCtqq6jtUJ2Qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/280] mac80211: call drv_ibss_join() on restart
Date:   Fri, 22 Mar 2019 12:13:21 +0100
Message-Id: <20190322111309.015555750@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4926b51bfaa6d36bd6f398fb7698679d3962e19d ]

If a driver does any significant activity in its ibss_join method,
then it will very well expect that to be called during restart,
before any stations are added. Do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 716cd6442d86..3deaa01ebee4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018-2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -2020,6 +2020,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 			break;
+		case NL80211_IFTYPE_ADHOC:
+			if (sdata->vif.bss_conf.ibss_joined)
+				WARN_ON(drv_join_ibss(local, sdata));
+			/* fall through */
 		default:
 			ieee80211_reconfig_stations(sdata);
 			/* fall through */
-- 
2.19.1



