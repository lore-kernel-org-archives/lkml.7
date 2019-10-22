Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C055DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6320700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgltDEjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbfJVPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:06:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35908 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVPGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:06:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so10840072pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IQrlgH9loWQR27iY8AmaRCSKR358bZ5kDUpR/+gPo88=;
        b=rgltDEjtrJM+H3tUeFN8nAqWX2kAMCK+ixb/hXDSjuPMm6hdtnUU26Np9ZDIq9obrD
         EzXTBttHOm1CeXR8RuKVxD2208EcO93+ZrmXWcS5yo5i7SnDZ0ilh6/ne6kQM9j64QgU
         /baidjqSQSDT4de63aID37SgMPW5Yi8tc830BBPbDuYGrUneN/AKTG+uggnRK9snKh2j
         wTo5vNmsd3AgeLSYVMh9Rn5V37Y6M62btHI9yWU35ecwbalTVFHKmRn5ii3mOviTWFeu
         Iv2CDRViz5lHVi1WSR/mMShKKaOZjutoZHEJ+Okf3vSjH9mbMlWkmPzc/qcsYeuolcha
         OxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IQrlgH9loWQR27iY8AmaRCSKR358bZ5kDUpR/+gPo88=;
        b=Id/sBUQ4BQP+97EO3w2wuenXx5G80cxFacfMVSFGgT8EPZ4L96lxTGzmyqb1TLwqDL
         CGOj2lCSztGPgDUUbnb82Yvt1CmsTThaGnmx3mRfbvbjLSGBy9in+g1p+ugni54FsMuI
         lSF252au6kCMQfYDOxYAhmb/kFpWwivtN8mpdiafbmgAehTUDMKwD83Y52Kjiw1xGoi7
         juxmiv3A7gQ6GjSsJsB/QHzBBDh4sW+5KnSPODGG30Vnqi/TomtNMaWpofOXOFaxzYLO
         T9tJNzHYl27fWq4Rz8ZcIuYxkCbaGWkTtscFYN/ddVBRXIMS9HEU4+DckWROWSiG88Eb
         CGcQ==
X-Gm-Message-State: APjAAAXSZxYGL99zkPnPMmtiPfUZXjfemIs832UkZeu0OpwkLKcpS69A
        LXR5ziNrBWJt+FxmHeA2tAo=
X-Google-Smtp-Source: APXvYqwjiNaBXnXOpx6sfoiwSQnl5ZJE+rvz3IL63kNQgF5sIwe31dDdMtaqznhJQg+GquPAND9OAA==
X-Received: by 2002:a62:6404:: with SMTP id y4mr3581119pfb.170.1571756781213;
        Tue, 22 Oct 2019 08:06:21 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id r30sm20688247pfl.42.2019.10.22.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:06:20 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:06:18 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, guro@fb.com, shakeelb@google.com,
        mhocko@kernel.org, chris@chrisdown.name,
        yang.shi@linux.alibaba.com, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] mm: fix comments based on per-node memcg
Message-ID: <20191022150618.GA15519@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These comments should be updated as memcg limit enforcement has been moved
from zones to nodes.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/memcontrol.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ae703ea3ef48..12c29f74c02a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -112,7 +112,7 @@ struct memcg_shrinker_map {
 };
 
 /*
- * per-zone information in memory controller.
+ * per-node information in memory controller.
  */
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
@@ -399,8 +399,7 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
  * @memcg: memcg of the wanted lruvec
  *
  * Returns the lru list vector holding pages for a given @node or a given
- * @memcg and @zone. This can be the node lruvec, if the memory controller
- * is disabled.
+ * @memcg. This can be the node lruvec, if the memory controller is disabled.
  */
 static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
 				struct mem_cgroup *memcg)
-- 
2.14.5

