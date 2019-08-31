Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689E723711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="C3WFmGxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfHaCAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:00:18 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:55880 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbfHaCAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567216891; x=1598752891;
  h=from:to:cc:subject:date:message-id;
  bh=9g/JKp5foaxieSnROfbCL0H+QjD7in4dyY/WHzgkS8M=;
  b=C3WFmGxrfxKUBM+iSR/+K4kgE91LeLXFUGiHfsJDFiDHyGU+hMhcINCE
   qPQE7zR+TiFIUEP8CR83Lw6gcKEbQMVZfDHOBAayF4rDitc9CN1WOAlYq
   5EfxOWM48cDeb3H8qm1uumt18jKXjnVIEqf8CxPXOOUfSIeGITcH5XFhI
   9DqAeWeCqK9IVmbLmVGyc3V+6/BgTBLCTpHsTTbWE8lgburChdauhgc2q
   f9eoAnZZZmJZcyZC/ZD8xxyET4KOvZ4cHsOC5b+gt5L3I1P2RyC2xBaK8
   xcLJI9o7u6NCnHDdVhwh9dl0mvcVXHuZL1j5AEPyke+jdAdJBeIcFfRLB
   g==;
IronPort-SDR: kpZj9UYsrRM173jeb4/SigkcW3nLh4OumUd01CUrAELV+gKIvvz3T+lNKK+XLxC7bqyOa58gE5
 jO5gzXGw0hkvYva8YPN2w/9iTeXAGCpJ9BJEH89AOa8DJ7yIb00rMSwDheTXIv7D8Zy90v8Zn0
 NpS1hSY6k3xEV4oM7Ct0vFAQ+51HwmDHbo8lUey480CIi0ovzDQNKvbbX/E9iqqsa7IYIjFG/J
 hbvghSOOBehfAbsKpKFsFsQf7Ci6P0ZnH+yPKr8t11FH+DZmxf5CK5IA+yQLAbUnSIjtXTA+6a
 6YQ=
IronPort-PHdr: =?us-ascii?q?9a23=3AOX1LQR+yywVC3/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B42u4cTK2v8tzYMVDF4r011RmVBN+dsqwZwLeN+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhWiDanfL9/LRW7oQrRu8QYnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?pEX8ZRTDdBAoK6b4sAEuEPI/9WpJTzp1sPsxS+ARSjD/7rxjJGmnP62Ks32P?=
 =?us-ascii?q?kjHw7bxgwtB9IAvmrJotv7N6kcVvu4wLXUwTjZc/9bwyvx5JTOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEYtFgPEj1WQqZHiPziI0ekMs2ma7+p6WuKul2Irtw98ryOyxsgwkI?=
 =?us-ascii?q?nFnJwaxU3Z9Shgxos+ON62SFZjbNK6DJddszuWOoh2T884XW1kpSk3xqcYtZ?=
 =?us-ascii?q?KnYCQG0Ikryh/bZvCdbYSF7BLuWPyPLTp5nn5oer2yihCv+ka60OL8TNO70F?=
 =?us-ascii?q?NSoypAldnDq24C2gTI6siCVvt95kCh2SuT1wzL6uFLP0Q0la3DJp4k2LEwl5?=
 =?us-ascii?q?4TvV3bHi/yhUn6laGWels49uS08ejnbbLmppiTN49wlA7yKLghmsu6AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH94UH0RK9Gg/42n6XDrpzWOMsWqrSnDwNJzoov8xO/AC2n0N?=
 =?us-ascii?q?Qck3kHNlVFeBefgonpOlDOIOr3Dfajj1iwnjpm3O3GMaH7ApnXMHfMjarhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB7EFIfLzXFLxtdPBAh86LQO02eDnB8t51o4FR2KPDb?=
 =?us-ascii?q?GWMLnIvV+L+O0vOe+Ma5ERuDrnLPgl/fHu3jcXg1gYKJioz5sKbzjsD+ZmKk?=
 =?us-ascii?q?TBOSHEn9wbV2oGo1xtH6TRlFSeXGsLND6JVKUm62R+V9qr?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FJAACqgmddgMjWVdFlHgEGBwaBUwk?=
 =?us-ascii?q?LAYNXTBCNHYYMUAEBAQaLHxhxhXmDCYUkgXsBCAEBAQwBAS0CAQGEP4JbIzQ?=
 =?us-ascii?q?JDgIDCAEBBQEBAQEBBgQBAQIQAQEJDQkIJ4VDgjopgmALFhVSVj8BBQE1Ijm?=
 =?us-ascii?q?CRwGBdhSdPIEDPIwjM4hpAQgMgUkJAQiBIgGHHYRZgRCBB4Nuc4QNg1aCRAS?=
 =?us-ascii?q?BLgEBAY0+hxCWBQEGAgGCDBSBcpJTJ4IygX6JGTmKWgEtpXcCCgcGDyGBL4I?=
 =?us-ascii?q?RTSWBbAqBRIJ6ji0fM4EIjAGCVAE?=
X-IPAS-Result: =?us-ascii?q?A2FJAACqgmddgMjWVdFlHgEGBwaBUwkLAYNXTBCNHYYMU?=
 =?us-ascii?q?AEBAQaLHxhxhXmDCYUkgXsBCAEBAQwBAS0CAQGEP4JbIzQJDgIDCAEBBQEBA?=
 =?us-ascii?q?QEBBgQBAQIQAQEJDQkIJ4VDgjopgmALFhVSVj8BBQE1IjmCRwGBdhSdPIEDP?=
 =?us-ascii?q?IwjM4hpAQgMgUkJAQiBIgGHHYRZgRCBB4Nuc4QNg1aCRASBLgEBAY0+hxCWB?=
 =?us-ascii?q?QEGAgGCDBSBcpJTJ4IygX6JGTmKWgEtpXcCCgcGDyGBL4IRTSWBbAqBRIJ6j?=
 =?us-ascii?q?i0fM4EIjAGCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="5139730"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 19:01:31 -0700
Received: by mail-pl1-f200.google.com with SMTP id b23so5178956pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DDyvegdKp6MmZvQoeqYKTe4rMUcvHNSrG5Su6nBLcf4=;
        b=qj9juewQOk1OfZTECMc0wUjtZ0xpZ5AHJ62YZoc6M2vut56Fh6K8XkdSuoN9+Rd382
         pZqi7NY+tVsUZPBUrt+Ux4QOz2pqYOZDl99/6aldWNddJcpQhsb4ppzxTZt6FvjeiSx6
         cU1uaVLunc4BSyiS1fHsJXZ3TdlCiJ2WwVQegGOZLc8bS4/zd/mFKcF962ufeGREc8K/
         TIdGZivRmL1nuGXXx3jkMqbV0Ho1V8gWjW31OtAipffqqNygvVyvcWq/u25/8KyliA9b
         RBEeOQ17dJgF3g9MxbahJRYhokPZmyhq0P8rHJqaGsnoQBnoU4j0/SVneTOkRy3+9N7n
         HHhA==
X-Gm-Message-State: APjAAAVO86UEGjRPiQR7TvkN0/jUfbs9optuTGWTf80GF6PLjQxr8Q82
        XkTpWY5OXEcMZsA2601TXdSLtDkvO0Je/tJSQDKjSnJo0hGx0i12OwtkN4WweiZNM+HkQLVJM4L
        GJwSaTcl/j5VHXz8bSoMP+X8YjQ==
X-Received: by 2002:aa7:9495:: with SMTP id z21mr21413557pfk.220.1567216815848;
        Fri, 30 Aug 2019 19:00:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2BLuGlLGxCSNkEHMBr+Frsk42bOM599GwK6aw54HDOsHA5LvdnFEX6NldgYdsc89eYIHNdQ==
X-Received: by 2002:aa7:9495:: with SMTP id z21mr21413519pfk.220.1567216815530;
        Fri, 30 Aug 2019 19:00:15 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id 127sm7549594pfy.56.2019.08.30.19.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 19:00:14 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: dwmac-sun8i:  Variable "val" in function sun8i_dwmac_set_syscon() could be uninitialized
Date:   Fri, 30 Aug 2019 19:00:48 -0700
Message-Id: <20190831020049.6516-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sun8i_dwmac_set_syscon(), local variable "val" could
be uninitialized if function regmap_field_read() returns -EINVAL.
However, it will be used directly in the if statement, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 4083019c547a..f97a4096f8fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -873,7 +873,12 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	int ret;
 	u32 reg, val;
 
-	regmap_field_read(gmac->regmap_field, &val);
+	ret = regmap_field_read(gmac->regmap_field, &val);
+	if (ret) {
+		dev_err(priv->device, "Fail to read from regmap field.\n");
+		return ret;
+	}
+
 	reg = gmac->variant->default_syscon_value;
 	if (reg != val)
 		dev_warn(priv->device,
-- 
2.17.1

