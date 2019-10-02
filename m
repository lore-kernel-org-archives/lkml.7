Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B7C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EF721920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="DXQLRpM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfJBPn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:43:26 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:45382 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfJBPnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570031004; x=1601567004;
  h=from:to:cc:subject:date:message-id;
  bh=Z+EVLw9fpQeyY0pHsne85bY8IJwYorDnDkYoPc67XmY=;
  b=DXQLRpM46eCMUjZ+Ah7QdtmlYmyjdNkFKiciIWOfrgYzJiYzZ9IeIMtI
   21IRbYBS91JAt0GdQeg3TGHuGtN/Ce2MJi+BSbM0ZFVUV8ySFeviDfoz6
   DFqXnQddYAs4u0ekAmb6emFw0ua53ciJcqLQ6WOiXMyq+ujWiYNXrwZBP
   BlBnNp+ROPVSaaEj84TQzhcfWb5WomKkzlsDXCy44hmGWj4K2EuSaYp9L
   pgEacRQnulg+iHeSrSJJ/NYYzN97psQ0rZDmg1lwF1qy/54LIobm5Y27d
   pXtD6tbM1bb5FdDg6lzZEPJsrwB/+z8mY7xmLg5DObApMnCVWzMKn98c2
   w==;
IronPort-SDR: AHMz0diXmTyHaUcN8WEw4F0Je/MtA4X9ReWqGmyM+avrBPKP6XXUwAADOqv93pHokd7fab0ww4
 me7wb05Tq+Tc3VqPTfT3Qs4x+AkOon0NusyRH/4RXtQs75f0RGrPrXR1xReMS9008iBDv0UfGn
 pYLPGiGm3SO3HHgNfrZ5JikNU5YfToKLw1nDsK4ecsANib36hXA30znOntCR/E+MXDM1NTf0ub
 OwDB0f1Q9rvFkvZV6zlftSY6PfDZ4gv2Wmk+cDgLcGNpgimoE3bvxEBwQaWDNI53qUUHRKCR8/
 Svs=
IronPort-PHdr: =?us-ascii?q?9a23=3APrN/IhWB+Yl3LN6R5a17Wx8C9hnV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYx2Gt8tkgFKBZ4jH8fUM07OQ7/m7HzBeqsfZ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLucQbgIRuJ6Itxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipEAoO9dIsPFOsBPeBXr4LguVUAtAa1BQetBOzxzj9Hm2L90ak03u?=
 =?us-ascii?q?g9FA3L2hErEdATv3TOtNj7NLkcX/27wqfLyjvOdO9a1Svn5YTUaB0tve2AUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02SpozkPjKV1vkNs2+G5OdnVeOuim4npBtwojSz2sshhJ?=
 =?us-ascii?q?LEhp8JxVDe7yl23ps6JcChRUN9fNWqE4NQujmEO4dqRs4uWWJltSYgxrEYpJ?=
 =?us-ascii?q?K2fDIGxIkjyhPdc/CLbomF7xb5WOqPLzp1hGhpdKy+ihqo80WtxevxXdSu3l?=
 =?us-ascii?q?lQtCpKiNzMu2gI1xzU98eIVONw/lyk2TaTzwDT7fxEIVwsmarbNZEhxrkwm4?=
 =?us-ascii?q?IWsUvZHy/2nFz6jLeZdkk54+So5fnrb7Hkq5OGOI90jQb+MqsqmsOhG+g3Lg?=
 =?us-ascii?q?8OX22D9eS90r3s41H5Ta1UgvEqlqTVqpPXKMQBqqKnHgNY0pwv5wu7AjqkyN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLej4DPa+g1SjijZry+zaMrDvGZjNM2TMkK37cb?=
 =?us-ascii?q?lj9kFc1RI/zcpD6JJMFrEBPPXzV1f1tNzZCB85LgO1z//kCNpjzIMeX3yAAq?=
 =?us-ascii?q?uCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcvrh84EQbSWJH+ZmPk?=
 =?us-ascii?q?LRNWv+gt4AST9Rlhc1VqrnhEDUAm0bXGq7Q69pvmJzM4mhF4qWA9/1jQ=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FAAADYxJRdh8XXVdFmHQEBBQEMBQG?=
 =?us-ascii?q?BVAcBCwGDXUwQjSCGKQaLPnGFeoMLhSeBewEIAQEBDAEBLQIBAYRAgkAjNQg?=
 =?us-ascii?q?OAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopgzULFmdWPwEFATUiOYJ?=
 =?us-ascii?q?HAYF2FAWjfYEDPIxYiGcBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEKIM9gkQEgTc?=
 =?us-ascii?q?BAQGVI5ZNAQYCghAUgXiTEieEOok9i0EBLYwNmxgCCgcGDyOBMQOCDU0lgWw?=
 =?us-ascii?q?KgURQEBSBWw4JFY4uITOBCJA8AQ?=
X-IPAS-Result: =?us-ascii?q?A2FAAADYxJRdh8XXVdFmHQEBBQEMBQGBVAcBCwGDXUwQj?=
 =?us-ascii?q?SCGKQaLPnGFeoMLhSeBewEIAQEBDAEBLQIBAYRAgkAjNQgOAgMJAQEFAQEBA?=
 =?us-ascii?q?QEFBAEBAhABAQEIDQkIKYVAgjopgzULFmdWPwEFATUiOYJHAYF2FAWjfYEDP?=
 =?us-ascii?q?IxYiGcBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEKIM9gkQEgTcBAQGVI5ZNAQYCg?=
 =?us-ascii?q?hAUgXiTEieEOok9i0EBLYwNmxgCCgcGDyOBMQOCDU0lgWwKgURQEBSBWw4JF?=
 =?us-ascii?q?Y4uITOBCJA8AQ?=
X-IronPort-AV: E=Sophos;i="5.67,574,1566889200"; 
   d="scan'208";a="80107053"
Received: from mail-pg1-f197.google.com ([209.85.215.197])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2019 08:43:21 -0700
Received: by mail-pg1-f197.google.com with SMTP id x31so13622639pgl.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N3wwXKf0R7CCR4EOyO31YNISlkUagx3YW+ubBEkjy90=;
        b=ZsXlrAVrecOeRH+/0yXMF4NA6IiyGRRXzS1zAmfqNTt192wQwre7FAF6takhZDWPuq
         XCPaV07mxgNlQZUpkohPzesyXfmFYKCZTp+moqIhs7BPp7R9wF11cOJzSW/YdXvXHOkB
         skifL+NM0AfiF8hwqn+4EqN1xnt/6S4JKZg3kA4MheJ9gLPTaN/J0UJpsUfi8XHGgXZT
         97zzEepuygFpGwU5Q4kNH8ttt0lQKmpBpwpw3pztCjHygzdhHhto0EDEwcBLgwZrE9bI
         SSeGZsnagBIQomfaweNg8D85svrOvD2ZReu8/DTG9X9K0tnZiDKzbbsz9VxdXj+3Huc+
         mmtg==
X-Gm-Message-State: APjAAAUKeg2EQ5Fd0ZiJh4iA41tXD+kNlJnOMVPAPppWbBR/h7PTqpo/
        icM2DXglgG8yCNdHegf09NGFmYiJxzgfzPSaaxgQYPjpQAZOPr+yOAehhi8UvBvh6f4Wg7IRR28
        v7UPtGhJUGmnYyYBZ7ilsnf0oYQ==
X-Received: by 2002:a17:90a:7181:: with SMTP id i1mr287703pjk.39.1570031001253;
        Wed, 02 Oct 2019 08:43:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5xvAvA3yzxjudCSvj/C3DRFOv+3OVFLDlbq510/C1VN0iXsuolwLESAlE9074I/ysViusjg==
X-Received: by 2002:a17:90a:7181:: with SMTP id i1mr287657pjk.39.1570031000821;
        Wed, 02 Oct 2019 08:43:20 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id a23sm13678588pgd.83.2019.10.02.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:43:20 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max17042_battery: fix the potential uninitialized use in max17042_write_verify_reg()
Date:   Wed,  2 Oct 2019 08:44:06 -0700
Message-Id: <20191002154406.8875-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function max17042_write_verify_reg(), variable "read_value"
could be uninitialized if regmap_read() fails. However,
"read_value" is used to decide the control flow later in the if
statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/power/supply/max17042_battery.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 0dfad2cf13fe..e6a2dacaa730 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -486,12 +486,15 @@ static void max17042_external_power_changed(struct power_supply *psy)
 static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
 {
 	int retries = 8;
-	int ret;
+	int ret, err;
 	u32 read_value;
 
 	do {
 		ret = regmap_write(map, reg, value);
-		regmap_read(map, reg, &read_value);
+		err = regmap_read(map, reg, &read_value);
+		if (err)
+			return err;
+
 		if (read_value != value) {
 			ret = -EIO;
 			retries--;
-- 
2.17.1

