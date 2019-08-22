Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF69C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B4620870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tYK2Nlmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfHVGVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:21:52 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:31747 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731615AbfHVGVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1566454911; x=1597990911;
  h=from:to:cc:subject:date:message-id;
  bh=te6sDAmETT+7Bh5fmhANTjsc/hBDg1ooMbPzRFeOAW8=;
  b=tYK2Nlmvx6g2jGM/kMmeH1TzqqfCKIxmoiKzLhR2sJIi747Gy6juJL73
   J2fDAoE+a/4Vds29381skKeXFu8CIf4Uy0FUSNIr+diqItkds4QkBMMAo
   VxPZliq7dN8/GTDmEAMPl3rmTDSsXePHamHqzOpyQl2j52a3RmlPVIBM0
   c2kuzDNezBlWCi09156th0cgmSd0ebL/rdymRlG/fl0ggFxFbEg5hxwRw
   gDG/1YBwDtfUZbVn+UCOoBpLdxwIZPIiV8e7VKZ/yAFxlM+eyvmLGMsr4
   RghjQeEposawxAraWb4xR3zcPLbQ3jwCk6jSSn3tI9o2AYKDGR07gLvYk
   A==;
IronPort-SDR: 4ZwvMUMfMv3qKFaihae0FSqGmxsR4I07nV6/HXz2ObZTpLUx+JgBhVzqpVld5jyUUB6SVptWoM
 2q+jBi78yphYR1m1lEAf2B/N1OR1cZsm9mGCbFhxrb57FVkWMAfQ4wmKEIAL0O+K3MM+zzyoES
 +PwvXgH4Vd4Q7DPquPyNuqzApdwOjRToFl6lpok4xkuVNKrG7Toi05Zg1ej1SN3faBA0zrcybc
 4irCd0JQev4z8NiCucP0GIyuIck3/4vVmVFbS3sJMJct4iTiCbSnRpS2sbfmpE0DAgM+FoLthT
 FwM=
IronPort-PHdr: =?us-ascii?q?9a23=3ABZOprBH8B7BEsU3UP2fdeJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78rsuwAkXT6L1XgUPTWs2DsrQY0rCQ6vy8EjVYsd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdu8YZjIdtN6o91h?=
 =?us-ascii?q?jEqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBIa8b4oUD+oaPOZYqYb9rEYQoxWnGAKsCuLvxSFMhnDrwKY21+?=
 =?us-ascii?q?osHR3D0AEmAtkAsmnbrM/tOakST+670afGwzbEYf5NxTvx9JLFfgw7rP2QQb?=
 =?us-ascii?q?59d9fax0k1FwPCi1WdsY7qPzKU1+QNrmib6PdrWOWvim8mqwF+uDmvytswho?=
 =?us-ascii?q?THnY8V10zL9T9jzIkrONK4VVd2bNi5G5VTryGXL5V6Tt8mTm1yuys3yqcKtY?=
 =?us-ascii?q?CmcCUF0pgr2hrSZv+ff4SV4x/uUPydLSl2iX9lYr6zmRe//VKix+DzUMS/zU?=
 =?us-ascii?q?xEoTBfktbWs3AAzxnT6s+aRfRj5kqhwjOP1xzL6uFDPEA0ibLXK54/zb40kZ?=
 =?us-ascii?q?oeqUHDETX3mEXylaOWbkEk9vWx5+Tpf7nropyRO5V7igH5NaQulci/DvoiPg?=
 =?us-ascii?q?cSWGib/Pyw1Lzl/ULnXLVHluM6nrXdvZzAJskWprS1DxFI3oss8RqzEjOr3d?=
 =?us-ascii?q?cAkXkCNl1FeRaHj4bzO1HJJfD1Ffe+glWskDhxxvDKIqHtD5vWI3jejLjhZ6?=
 =?us-ascii?q?xx5FBBxwou1dxf/Y5bCqkdIPLvXU/8rNjYDh4/MwypzOfrEdZ92Z0EWWKJHK?=
 =?us-ascii?q?CZNLjfsUGH5u0xOemAfowVtyjnK/gj+fHuiWU1mVgHfammjtM5cne9S8VnMU?=
 =?us-ascii?q?WEZjK4k8UBGGZS5lEWUefwzlCOTGgAND6JQ6sg62RjW8qdBoDZS9Xo3+SM?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GUAAAFNF5dh8bWVdFlHgEGBwaBVAg?=
 =?us-ascii?q?LAYNWTBCNHIZUAQEGix0YcYV4gwiFI4F7AQgBAQEMAQEtAgEBhD+CYCM1CA4?=
 =?us-ascii?q?CBQEBBQEBAQEBBgQBAQIQAQEBCA0JCCmFOoI6KYJgCxYVUoEVAQUBNSI5gkc?=
 =?us-ascii?q?BgXYUBZxhgQM8jCMziHgBCAyBSQkBCIEihxWEWYEQgQeBEYNQhA2DVoJEBIE?=
 =?us-ascii?q?uAQEBlDSVbwEGAgGCCxSBb5I+J4QsiRSLBwEtpTwCCgcGDyGBMQKCDU0lgWw?=
 =?us-ascii?q?KgUSCXB6OLR8zgQiJDoJSAQ?=
X-IPAS-Result: =?us-ascii?q?A2GUAAAFNF5dh8bWVdFlHgEGBwaBVAgLAYNWTBCNHIZUA?=
 =?us-ascii?q?QEGix0YcYV4gwiFI4F7AQgBAQEMAQEtAgEBhD+CYCM1CA4CBQEBBQEBAQEBB?=
 =?us-ascii?q?gQBAQIQAQEBCA0JCCmFOoI6KYJgCxYVUoEVAQUBNSI5gkcBgXYUBZxhgQM8j?=
 =?us-ascii?q?CMziHgBCAyBSQkBCIEihxWEWYEQgQeBEYNQhA2DVoJEBIEuAQEBlDSVbwEGA?=
 =?us-ascii?q?gGCCxSBb5I+J4QsiRSLBwEtpTwCCgcGDyGBMQKCDU0lgWwKgUSCXB6OLR8zg?=
 =?us-ascii?q?QiJDoJSAQ?=
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="71805031"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 23:21:51 -0700
Received: by mail-pl1-f198.google.com with SMTP id v4so3002518plp.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 23:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8jiYykEIKY+vErKJnS6hI8dD2/3tnco1PA9iNXuAOYk=;
        b=FBvEh7zDRsd14tFe6o32A+KZ2nRCbUoPufO5tx1c1T+3JlpoZMip+sMuK9363we08L
         QRWHodxdQICe8GvQyN87i+emvnQzO/00tnXGikjH9N/4XsQEhQ3Da7Evkbtogq2ia3Sb
         iket2xDB7qgQEWas4PsQQLWVt6fYBoP4SNfKwyJieIGl+3x0p+fn7ozo1B7AjuPWWPyD
         nHDaZL+DfzeKgDWAXRooq5ca2aHjPhG1sl+KCADQWvxpSrzuti+uLi6aZWwZwEvgdhsz
         vESszPg1VTLtMJ1uNqvVreSp7Ea73RhptEEnYc5SOY4vvMCprJsE/vQ7m+acAjIBKXww
         BJOw==
X-Gm-Message-State: APjAAAVOE7iVxNq+jK1IkwZAbWC808LElL2trYbCwSya8LcOpVJi+O3g
        Dps54F8xC0GA+XIpNAVEur5KCLmrstPu58R18axCsl29BQlaEGIjzw4u66fof9g/zRQfogdeskp
        C0VDr/nTKaSaZqUsJXxz5BKN+Bw==
X-Received: by 2002:a17:90a:4c:: with SMTP id 12mr3675056pjb.40.1566454910364;
        Wed, 21 Aug 2019 23:21:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPagb0bDHT1I4Z/sKRwM+ZNsKDqjx+3do3M12tj3N4RR0xguVlX5L/h68YeOUt+IBeLNfJ5g==
X-Received: by 2002:a17:90a:4c:: with SMTP id 12mr3675033pjb.40.1566454910065;
        Wed, 21 Aug 2019 23:21:50 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id b123sm44863606pfg.64.2019.08.21.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 23:21:49 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memcg: return value of the function mem_cgroup_from_css() is not checked
Date:   Wed, 21 Aug 2019 23:22:09 -0700
Message-Id: <20190822062210.18649-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function mem_cgroup_wb_domain(), the pointer memcg
could be NULL via mem_cgroup_from_css(). However, this pointer is
not checked and directly dereferenced in the if statement,
which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 661f046ad318..bd84bdaed3b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3665,7 +3665,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 
-	if (!memcg->css.parent)
+	if (!memcg || !memcg->css.parent)
 		return NULL;
 
 	return &memcg->cgwb_domain;
-- 
2.17.1

