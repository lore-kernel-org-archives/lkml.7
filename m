Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E5E2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 20:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tdJXA/ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJAUX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 16:23:59 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:15996 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfJAUX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 16:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569961439; x=1601497439;
  h=from:to:cc:subject:date:message-id;
  bh=6Std4kNv6rcCi3H8DqYign72h7owKlGXXMq3UQl1GHY=;
  b=tdJXA/ezagi+PcqSH/cQ48M0ASWvSE/5gevefaAvVMlynZkGtladt6ip
   dquas8FcYKS8SoRqTZOittQprt7kOvvREg3Ia2JWowpmlbSvSFI8vJtje
   nOVqLO8pwBXGdo2NMD+NjsrWwvJJHe1DPYQ19sOquKe/aydeRrG2vVpLM
   K1I1DfWm8BM3L/CBV5fiPzzbyAMwxJrNlQfGsEP9kXmGDFlEa1Gr0No4N
   0NYzoTIPaJkC0+bbzgy4gomm0EcTw6ZuSMlfUWt/lBAyC0Hx309+I8tak
   fx33uO0BoNmTnNNMKiIi7nvgNzJhbwTjEEKFvTVvhfXhReMpgX7gklBUA
   w==;
IronPort-SDR: oU3uxq+Q0zh3MOwqsKCYTtRrnjkqUIFh+9jn4V8SETPxqCb0jbezC6tO5yoCeWAoa3qz5mSwiz
 zQ05HDpGUDRjFIPUioIAOvoLsUBrA7lc2B/3wCxfyTClzagiEFMseQ2sgGLY1DeNXT3EPqLba/
 760OI8DLrlmk94C/RHacxY12gnaqtb4DCrpnKRHy7YfUV83SHt3SHBCVWmRxVnTrxxnN1HygVe
 T4Nzb2jqcE23xRiVMDr2tgK3anFYjhvgI9PnT01Boow2G6373M/ZV67FExe6/yGDDrvUibRj6v
 SOw=
IronPort-PHdr: =?us-ascii?q?9a23=3AxCCGmxbp6+u9DWvmniFQdn//LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMW+bnLW6fgltlLVR4KTs6sC17ON9fy8EjVcv96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twrcu8YZjYd/Jas8yw?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFBB4K8b5AUD+oAO+ZYoJT2qUUXoxCjCwmsBf3gyjtViXTr2aE33f?=
 =?us-ascii?q?gtHQTA0Qc9HdwBrW7Uoc31OqkMTO67wqrGwzLYYv9KxTvw8pTEfwo9rf2QW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllifq43lPjKV1uQQtGiQ8u1tVOKuim4nsQ5xoySjytsih4?=
 =?us-ascii?q?TSm4Ia1krE+T9nz4koON21UUh2asOnHptIryyWKZd6T8c4T2xruCs20KMKtY?=
 =?us-ascii?q?O7cSQQ1ZgqwxrSZ+Saf4WJ5h/vTvidLDl4iX5/Zr6yhgy+/Eqvx+D6S8K6yk?=
 =?us-ascii?q?xFrjBfndnJrn0N0hvT5dWZRfZl5Ueh3CqP1xjU6uFZPUA4jarbJIAlwr43jp?=
 =?us-ascii?q?cTtF7MHi7ymEnvlK+WeVgo9vGm6+j6ZrjrooWQN4BzigH5PaQuntKwDf4kPQ?=
 =?us-ascii?q?gJWmiX4eW81Lv98k3lWLhGkOE6n63DvJ3ZJckXvLC1DxJV34o59hqyCzOr3M?=
 =?us-ascii?q?wdnXYdLVJFfByHj5LuO1HLOP35Dfa+g1S2nzdq2/zKIrPsD47QLnffirftZ6?=
 =?us-ascii?q?hy5FNByAYr19BQ+4pUCq0dIPL0QkLxsN3YDhkkMw272urnC8ty1pkYWW2RBq?=
 =?us-ascii?q?+UK73SsVCW6eI1OeWMZ5EauCz7K/c74/7il3g5mUUSffrh84EQbSWJH+ZmPk?=
 =?us-ascii?q?LRNWv+gt4AST9Rlhc1VqrnhEDUAm0bXGq7Q69pvmJzM4mhF4qWA9/1jQ=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HNAgA6tZNdgMfXVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNH4ZNBosmGHGFeoMLhSeBewEIAQEBDAEBLQIBAYRAgjIjNAkOAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAW?=
 =?us-ascii?q?jSIEDPIwlM4hiAQkNgUgJAQiBIoc1hFmBEIEHg3VshA2DWIJEBIE3AQEBlR+?=
 =?us-ascii?q?WSwEGAoIQFIF4kw0nhDqJPYtBAS2nHwIKBwYPI4EvghJNJYFsCoFEUBAUgge?=
 =?us-ascii?q?OLiEzgQiOH4JUAQ?=
X-IPAS-Result: =?us-ascii?q?A2HNAgA6tZNdgMfXVdFmHgEGEoFcC4NeTBCNH4ZNBosmG?=
 =?us-ascii?q?HGFeoMLhSeBewEIAQEBDAEBLQIBAYRAgjIjNAkOAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWjSIEDPIwlM4hiA?=
 =?us-ascii?q?QkNgUgJAQiBIoc1hFmBEIEHg3VshA2DWIJEBIE3AQEBlR+WSwEGAoIQFIF4k?=
 =?us-ascii?q?w0nhDqJPYtBAS2nHwIKBwYPI4EvghJNJYFsCoFEUBAUggeOLiEzgQiOH4JUA?=
 =?us-ascii?q?Q?=
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="79955259"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2019 13:23:58 -0700
Received: by mail-pg1-f199.google.com with SMTP id a31so11899886pgm.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 13:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q599bl3zDqjBXqyRyPM4QuCbcNSe6pusjy0ki6fkKJs=;
        b=hKVJqoOfIgHOOap/j0YVXQ2IueuNTI4lp+RtTF8WNPvQBLo6ML5H3my1UmhA+4gKyC
         esY3CaiEMp+HC73zzFBMHVqUfFg3Y9tzptchPDASP8SIS5YJQOY/gw6L70K5PKHKjQFt
         O7tK+rQzXY7dmIYFszVLaODpXqsQChrICOjxNdJmDSa/ixRAfN+yHP2zClAPCaGdu1Bc
         CZiES/npZRuDmRMlWGK7H55dM8qgl2e9ad4wPVuhuGPw56t/rtUkH2Jg8ctoFkQxbN/N
         AipWjeE+WiExQbAtido0mJqqmHamo8onDstnHr/QD1GnucwR9PNVMS3ZOgDMF337kas1
         Lqgg==
X-Gm-Message-State: APjAAAWf9n6tAFcLVOwfiMhhDCarHC0uCu8f0Wf8e9ici/UjHBBhyNLQ
        aPIP73Fq2SDuWX97BK+J/BiGQoUvmejheB9o1HDA3pptwguG+sQSymT8SwCWohanJsBozhFIUp5
        +qJv9M/3OV7gZFWf8Rn64XsQWzQ==
X-Received: by 2002:a62:4e0f:: with SMTP id c15mr182632pfb.42.1569961437719;
        Tue, 01 Oct 2019 13:23:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHo3trZ/iZ+zj7Hc4tRao5vzbmDEDx6LB2tg/EDz+Vg7EKgDtl7xl6KNPl7o4NL6RoTM55oA==
X-Received: by 2002:a62:4e0f:: with SMTP id c15mr182595pfb.42.1569961437238;
        Tue, 01 Oct 2019 13:23:57 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id 202sm18779898pfu.161.2019.10.01.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 13:23:56 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hisilicon: Fix usage of uninitialized variable in function mdio_sc_cfg_reg_write()
Date:   Tue,  1 Oct 2019 13:24:39 -0700
Message-Id: <20191001202439.15766-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mdio_sc_cfg_reg_write(), variable "reg_value" could be
uninitialized if regmap_read() fails. However, "reg_value" is used
to decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 3e863a71c513..7df5d7d211d4 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -148,11 +148,15 @@ static int mdio_sc_cfg_reg_write(struct hns_mdio_device *mdio_dev,
 {
 	u32 time_cnt;
 	u32 reg_value;
+	int ret;
 
 	regmap_write(mdio_dev->subctrl_vbase, cfg_reg, set_val);
 
 	for (time_cnt = MDIO_TIMEOUT; time_cnt; time_cnt--) {
-		regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
+		ret = regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
+		if (ret)
+			return ret;
+
 		reg_value &= st_msk;
 		if ((!!check_st) == (!!reg_value))
 			break;
-- 
2.17.1

