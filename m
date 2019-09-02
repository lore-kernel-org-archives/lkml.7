Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A143C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110E214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="CrK6yduX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfIBWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 18:10:15 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:2455 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfIBWKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 18:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567462214; x=1598998214;
  h=from:to:cc:subject:date:message-id;
  bh=5cjzoQ6j8LPRIgvYQs/hdB84XOxSvYfieFjVv+oztNE=;
  b=CrK6yduXstc2Pu+L2HjAJ+JlnWyvIpsUmQqJNURE/JPXcrJAeLGCsXcj
   /XgsNwgvn9PprPbpZqlhO3RewIXq2q2oguJt/QnWl5rj1lGClUFNIfRNZ
   IiPs0yjbDcIR4yrPyiOoX79L/+FDYkXgY/ScRo+EhVzVdZJuSow22QU+G
   5PkHdHH4CugfHXvCyq+919fIh2YH5dwycQDh6qCxkHskZ0eqz+EtkFq61
   TEyIr77ETZgw3PbDR4JdBG94UiPvNIgoRFfv/oZqrnGD011LvILqZsPQ8
   Kqz7ZrygTXaW+WNXCuo3cRH30z2t3Xih49JEJoJ9SUTeQ/zaSEzmQ6a6W
   w==;
IronPort-SDR: cavb9EizEnQ8gBH7VFRrgGHzajXHvdRMMdn+FgOaz+6OqbyCgXAdD+m6AEEN66JnQLAD+0b0W6
 XmokPnh7bpWm+y5cP2ms7c5WsUCQrd59Gp2y6cIl32L8RFxkj2gT8OL7Le17oDwtuQI1Q2WDSx
 d8LD28b4RFil8faegO6f0hzLhuRIgVc2N9cYAAkP4o2ACARMR5OmNJdw95J9B8K3YIQLaImoeK
 FYtVobxlF/yIBDz+gAw5GFfQN2Otc82i24jF9R2vicp5+PR6a5T5aXO66aJC5LYsbao3gYEgkV
 RYE=
IronPort-PHdr: =?us-ascii?q?9a23=3AS7wg1x2nj6pDPf8PsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0fLvad9pjvdHbS+e9qxAeQG9mCsbQd1LOd6/yocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmSSxbalvIBi0sAndudUajIR/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMXsNQVyxaGYO8bo0PD+UcNuhGtof2ulUOrRqgCgmoGezk1ztEi3Hq0aE/1e?=
 =?us-ascii?q?kqDAPI0xE6H98WsHrassj7OqkRX+6y16TE0SnPYulK1Trn9ITEbhYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGAHEjlSRqYzlIjSV3fkKvmmb7utgVfigi287pw1trDWi3doshZ?=
 =?us-ascii?q?XTho4P1F/L6Dh5zZ8zKNalS0B7ecapHIVMuyyeLYd7QcMvT3t2tConxbAKo4?=
 =?us-ascii?q?O3cSwJxZg/2hLSaviKf5KW7h/tVOudOyl0iXN/dL+9iBu/91WrxPfmWcmuyl?=
 =?us-ascii?q?lKqzJIktzLtn8QyRPe8tOHSv5h/ke53jaPyhzT5vlEIU8qkarbLIYswrsqmZ?=
 =?us-ascii?q?oStUTPBzf2mEHrgKOPeEUo5+yl5uf9brXpoZ+cMIB0igXgPag0hsO/BuE4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VPlTLhOlPE7kanUvIrEKcgGqaO1GRJZ34Ig5hqnCjepyt?=
 =?us-ascii?q?UYnX0JLFJffxKHipDkOlHPIfD4F/i/gkignCtlyv3dI73uHo/NImLdn7j8YL?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakMIPbyWk/3qdzZAQY1Mw+qzOb9DtVyyIceVHmRAq?=
 =?us-ascii?q?+WLqzSq0WE5uExLOmWYo8apjL9J+Ii5/70gn9q0XEHeqz87JoFaG2/VqB3MU?=
 =?us-ascii?q?WQYCK02f8cGn1MswYjGr+5wGaeWCJeMi7hF5k34Ss2Xcf5VYo=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G8AQDXkm1dgMbWVdFlHQEBBQEHBQG?=
 =?us-ascii?q?BVgUBCwGDV0wQjR2GXwEBAQaLOHGFeoMJhx8BCAEBAQwBAS0CAQGEP4JvIzc?=
 =?us-ascii?q?GDgIDCAEBBQEBAQEBBgQBAQIQAQEJDQkIJ4VDgjopgmALFhVSVj8BBQE1Ijm?=
 =?us-ascii?q?CRwGBdhQFnU6BAzyMIzOIbgEIDIFJCQEIgSIBhx6EWYEQgQeEYYQNg1aCRAS?=
 =?us-ascii?q?BLgEBAZRalg0BBgKCDRSBc5JcJ4QyiRuLGAEtphICCgcGDyGBRYF7TSWBbAq?=
 =?us-ascii?q?BRIJ6ji0gM4EIjCqCVAE?=
X-IPAS-Result: =?us-ascii?q?A2G8AQDXkm1dgMbWVdFlHQEBBQEHBQGBVgUBCwGDV0wQj?=
 =?us-ascii?q?R2GXwEBAQaLOHGFeoMJhx8BCAEBAQwBAS0CAQGEP4JvIzcGDgIDCAEBBQEBA?=
 =?us-ascii?q?QEBBgQBAQIQAQEJDQkIJ4VDgjopgmALFhVSVj8BBQE1IjmCRwGBdhQFnU6BA?=
 =?us-ascii?q?zyMIzOIbgEIDIFJCQEIgSIBhx6EWYEQgQeEYYQNg1aCRASBLgEBAZRalg0BB?=
 =?us-ascii?q?gKCDRSBc5JcJ4QyiRuLGAEtphICCgcGDyGBRYF7TSWBbAqBRIJ6ji0gM4EIj?=
 =?us-ascii?q?CqCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,460,1559545200"; 
   d="scan'208";a="74273994"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 15:10:13 -0700
Received: by mail-pl1-f198.google.com with SMTP id bj9so1167136plb.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 15:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7lAYw+WYXgGKa3GnnIrXLx3dmFJj4c1yM3CfWtIDfjw=;
        b=Tw3dbae80+6FSRxrjTRJL6sQfSi1g6Ke0H2VZL38xmkGvqamo87JkGIW1lJkJXcCFg
         ZVawpvf1QVcD5MZND1n/rs2DvLWI6zFnOtlmplyDla6U+sC4ALMs7du3sd5I47DTLrgk
         b51dlEbEqpaytXwWVaGRtWhcMz+TTxpn93BLrzGgDQgsn1xSS//02yLd5lEIl5izA4i9
         8NVnr1U1UVIk8+yZ6QcKlNO+knVxt4oARhAXw/R7UzVYN99U3hHvazb1QWmlQJsBFxDX
         0YApiKOzKmNmOH6+vGy88gStD4zKRiiHRbrpG2++qv2mEFe2nqx1760gwJlwqOesg1LP
         jhsA==
X-Gm-Message-State: APjAAAWGlCOTLqgDt8KseKTqVsgt/dkRFbGjtrwRur9kP18garaE1Jw7
        b8oVynzC6Ekteo8xpwhOsZMgaiCEwXpU5H1BWlDIs9gPs/r3Du2ejfgdwoFvsMTakYv/HhBUFe4
        RUYCQaaPsbdsjJmt6UlGFUCTtdg==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr27137028pgk.378.1567462213135;
        Mon, 02 Sep 2019 15:10:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNSTQVIp962Y65O4IgM35gCComdCD/HHeUpE1Ns7dzzsXcc/tCXj8aO8S7mliLuXw/MUENfQ==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr27137013pgk.378.1567462212862;
        Mon, 02 Sep 2019 15:10:12 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id q33sm12300791pgb.79.2019.09.02.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 15:10:11 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized
Date:   Mon,  2 Sep 2019 15:10:47 -0700
Message-Id: <20190902221047.20189-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function pfuze100_regulator_probe(), variable "val" could be
initialized if regmap_read() fails. However, "val" is used to
decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/regulator/pfuze100-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index df5df1c495ad..649e2bfcdffd 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -777,7 +777,7 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 	for (i = 0; i < regulator_num; i++) {
 		struct regulator_init_data *init_data;
 		struct regulator_desc *desc;
-		int val;
+		int val = 0;
 
 		desc = &pfuze_chip->regulator_descs[i].desc;
 
-- 
2.17.1

