Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D4421874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EkoszOmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfH3Eed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:34:33 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:46228 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfH3Eec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567139706; x=1598675706;
  h=from:to:cc:subject:date:message-id;
  bh=XPfJegQ++l69vVm04ifZLNdv62gocxHQ8bqgeCGaYj0=;
  b=EkoszOmR/refO5SPAHZTn6cHSMiQj+1Z7CKq8J232swFnJTsdb/jEqTH
   6qbOHXPYdQnmFMsCKu3loddPPx3OFpQ9ESqt5hKZBcrFrt7QRC4Sfav+m
   I4iNzqh7qCX4Hrt93SATteVN7yXHEPMZhyrDoj+Ji/nBipUNHYjO99Rsj
   qmM8hOLeX+sr5TyLUMJuzEL4lP8s67Eoh3MuTfqN8wqqP6NMKFUfl2DEI
   UGS7/F4zh5W7mxGcoGQXT65FUO8OKXlaghwR3UCRriVy8ahNFQRMnq8Z2
   fMJeL+tvlDCujL+L7CbHZd5OC1ioXH34xZLq11+TS0Z8jLru5hNA5agde
   g==;
IronPort-SDR: b4ouB7Ow4Gn5yfmqbt4f1g+53HOgJwg5KD4Hr/J0YjX5azJFPytyBRSeLePu+wg99iKxW2/w6b
 jHd1pnXfCYi/WDSl1FWYStzX8E56ux3GP8m6ac3eJ6fAmRk1hvOIUxZ9uejNN+3glcKl38UwvB
 kedngjXsYoN/yVWXLZXHAoBQ/a+qSPnn1uq5zBDWfDFbuRfrvsO3KqEsFEZKMfFW9R8464cwqX
 0QMx+vowv96oRB2G2N0QxL2oBfSllsPb5GcJYN9MF+oNFq0Fc5H3l93sk5nCF8H3oc7ygb3FG3
 fU8=
IronPort-PHdr: =?us-ascii?q?9a23=3AMofmWhZUDb9se7lPNsHc2JL/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMW+bnLW6fgltlLVR4KTs6sC17OM9fm+AidQuN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdu8gYjIdtKas91w?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFBB4K8b5AUD+oAO+ZYoJT2qUUXoxCjCwmsBf3gyjtViXTr2aE33f?=
 =?us-ascii?q?gtHQTA0Qc9HdwBrW7Uoc31OqkMTO67wqrGwzLYYv9KxTvw8pTEfwo9rf2QW7?=
 =?us-ascii?q?97bMrfyVMoFwPAllifq43lPjKV1uQQtGiQ8u1tVOKuim4nsQ5xoySjytsih4?=
 =?us-ascii?q?TSm4Ia1krE+T9nz4koON21UUh2asOnHptIryyWKZd6T8c4T2xruCs20KMKtY?=
 =?us-ascii?q?OncCQQ1ZgqwxzSZ+Saf4WJ5h/vTvidLDl4iX5/Zr6yhgy+/Eqvx+D6S8K6yk?=
 =?us-ascii?q?xFrjBfndnJrn0N0hvT5dWZRfZl5Ueh3CqP1xjU6uFZPUA4jarbJIAlwr43jp?=
 =?us-ascii?q?cTtF7MHi7ymEnvlK+WeFgo9vGm6+j6ZrjrpIWQN4BzigH5PaQuntKwDf4kPQ?=
 =?us-ascii?q?gJWmiX4eW81Lv98k3lWLhGkOE6n63DvJ3ZJckXvLC1DxJJ3oo59hqyCzWr3M?=
 =?us-ascii?q?wdnXYdLVJFfByHj5LuO1HLOP35Dfa+g1S2nzdq2/zKIrPsD47QLnffirftZ6?=
 =?us-ascii?q?hy5FNByAYr19BQ+4pUCq0dIPL0QkLxsN3YDhkkMw272urnC8ty1pkYWW2RBq?=
 =?us-ascii?q?+UK73SsVCW6eI1OeWMZ5EauCz7K/c74/7il3g5mUUSffrh84EQbSWJH+ZmPk?=
 =?us-ascii?q?LRNWv+gt4AST9Rlhc1VqrnhEDUAm0bXGq7Q69pvmJzM4mhF4qWA9/1jQ=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EZAQCqgmddgMXSVdFlHgEGBwaBVgY?=
 =?us-ascii?q?LAYNXTBCNHYZcAQEBBosfGHGFeYooAQgBAQEMAQEtAgEBhD+CWyM3Bg4CAwg?=
 =?us-ascii?q?BAQUBAQEBAQYEAQECEAEBCQ0JCCeFQ4I6KYJgCxYVUoEVAQUBNSI5gkcBgXY?=
 =?us-ascii?q?UnTyBAzyMIzOIaQEIDIFJCQEIgSKHHoRZgRCBB4ERgmRsh2OCRASBLgEBAZR?=
 =?us-ascii?q?OlgUBBgIBggwUgXKSUyeEMIkZixMBpiQCCgcGDyGBRYF7TSWBbAqBRJEnHzO?=
 =?us-ascii?q?BCI5VAQ?=
X-IPAS-Result: =?us-ascii?q?A2EZAQCqgmddgMXSVdFlHgEGBwaBVgYLAYNXTBCNHYZcA?=
 =?us-ascii?q?QEBBosfGHGFeYooAQgBAQEMAQEtAgEBhD+CWyM3Bg4CAwgBAQUBAQEBAQYEA?=
 =?us-ascii?q?QECEAEBCQ0JCCeFQ4I6KYJgCxYVUoEVAQUBNSI5gkcBgXYUnTyBAzyMIzOIa?=
 =?us-ascii?q?QEIDIFJCQEIgSKHHoRZgRCBB4ERgmRsh2OCRASBLgEBAZROlgUBBgIBggwUg?=
 =?us-ascii?q?XKSUyeEMIkZixMBpiQCCgcGDyGBRYF7TSWBbAqBRJEnHzOBCI5VAQ?=
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="4951582"
Received: from mail-pf1-f197.google.com ([209.85.210.197])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 21:35:06 -0700
Received: by mail-pf1-f197.google.com with SMTP id i2so4339521pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 21:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=07dOxqCdQxKDoU2+68GM0KeX5KWpD+AWua+kX8OJRIA=;
        b=t7KcO6vpveacavTzju18yxR3Gu1XPumGtzEdn84qhdws7UIpK5Gwp4iewVfMaw70px
         tm479x862y6ICk2bCjXg8GuXzcEytxXCzZc8tiL0zBtrlOuMwQ/YmYFi24FvD7+ShDg1
         GvzBN/q0NRQtpqi6osOrV47AgRBehr2vviRSDeF00ASJz86OUDrGx/+oQAV5WLaRE8oc
         pOajNDRmJkYInFUAvwJ0cS7oIKjqmzGo5moxN+K4UjX1tBZ1yYunj057EnBDMVIVA1A0
         qYNL+fB4pyX9TldRLFyctBQW46hIIkyPOi0kJTEVSrPgHk3TVyOtLzdGVXnEAXMU9Fj5
         3Mzw==
X-Gm-Message-State: APjAAAUioyBYmhaCQkSU/NbCogJdZSqDr0Fs5WLFUaVjDzW6NGfAc0Ib
        HkvEDioYXvyFzEkR5ean4HdW8I3QXeXAeUUCdxLGZL8wN+hDieMh8mweE6AIRtZCDyK2xh7xru+
        e/li7iBf0aCiMQNRHHOPxz3YVgQ==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr13607510pln.37.1567139670465;
        Thu, 29 Aug 2019 21:34:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwyvmLToVZOecb3FxtZYyGbzvjpkmy+blWZgKh+cvqVJJgCWAhy1BthWVCA7K/ffjCHY7QWwA==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr13607482pln.37.1567139670076;
        Thu, 29 Aug 2019 21:34:30 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id 6sm5204331pfa.7.2019.08.29.21.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 21:34:29 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: Variable ps could be NULL when it get dereferenced
Date:   Thu, 29 Aug 2019 21:35:04 -0700
Message-Id: <20190830043504.23760-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function cz_get_performance_level(), pointer ps could be NULL via
cast_const_PhwCzPowerState(). However, this pointer is dereferenced
without any check, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
index bc839ff0bdd0..d2628e7b612d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -1799,6 +1799,9 @@ static int cz_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_p
 	data = (struct cz_hwmgr *)(hwmgr->backend);
 	ps = cast_const_PhwCzPowerState(state);
 
+	if (!ps)
+		return -EINVAL;
+
 	level_index = index > ps->level - 1 ? ps->level - 1 : index;
 	level->coreClock = ps->levels[level_index].engineClock;
 
-- 
2.17.1

