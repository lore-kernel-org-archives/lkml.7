Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0875C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD97D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="A3QVNrpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfJDEqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:46:05 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:1049 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387855AbfJDEqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570164364; x=1601700364;
  h=from:to:cc:subject:date:message-id;
  bh=jWL5W27uUFoqE45P9aToaJkEZWCPur2rRlOPC00wtwM=;
  b=A3QVNrplGr+6cijH0FO52W+4BUux37p/127fb2vNPW4sKgwOhuxcqCx4
   4hWtqapYj5YoOQKCKyv7lPiroeVxrXXgRNW6I1YmSaJj4a2WEIx3luMBn
   NthNb0pW4VLH+CYe4AghD/qNhbLYRZcVbhEF4ix/8xjHG7YUtEahMR4RF
   twGtCNBgV+WBKnScYu7WueyO5/luEQAvoy2whZvJYFXG4DcatBviZFmq2
   9j5iod8U5vS8YUhof6IKPli7rmKJ2glG2qK7zavJdPN8VAZ+lM0DO4LXc
   CXyHcK6rUMGU3jKWt3ln94pjfRrjLEOej+RuST4z7zKCsW9oF3SjPodaH
   g==;
IronPort-SDR: t/oKGI0CU7nAByPo3gFH0JktfeIQN2vtUruIPvBS3RtKSEBFlXe5xFDmiqTsMu4BOEHC82Gk2d
 XvqxV6vpNYVybjCk9yqXBJOy7ycyzXP5EkYK1Bhb3VEWwlhy+Xmbn2hNmv2Ejd11ylpB+YV+kW
 MrX9ln4tT1NEYTuiPPM3konw2hLtBItvdYDwslaVgAOMhl9FWSzR01bdCUTIgpAvAl46OSIwY4
 NPkj7rm7oDsMhF4m3BZeEClY43PML1FxCK0diHOQeuApnjJEnjEdo5P9rVHFN5LJjZlLUmmb52
 e+4=
IronPort-PHdr: =?us-ascii?q?9a23=3A0xMbDh13ux3/JlDXsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIXI/ad9pjvdHbS+e9qxAeQG9mCsLQZ06GM6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7N/IAm5oQnPq8UdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cQG?=
 =?us-ascii?q?pBX91RVzdAAoO6YIsEEvQPM/9FpInzplsBsx++ChSxD+/rxDJEmnr60Ks93O?=
 =?us-ascii?q?k9HwzKwBEsE8sSvHjJsd75MLoeXOCwwKTO0D7Nbe5Z2S3l5YbIbB4vvP+CU7?=
 =?us-ascii?q?F3f8fK1UUjCxnIgkmKpID5Iz+Y0PkGvWiB7+pnUOKik2woqwBwoziv28csjZ?=
 =?us-ascii?q?TCi4UVy1HF9SV22oc1KcGkREN1etOkDYdftzuAO4RoX8wiXnhltSAnwbMFoZ?=
 =?us-ascii?q?62ZDYGxIgjyhLFaPGKc5KE7gz+WOuROzt0mm5pdK6nixqv8EWtzvfwWte63V?=
 =?us-ascii?q?tKtCZJjNjBumoP2hHc7MWMV+Fz8V272TmV0gDe8uREIUcpmqXFM5Mh2bswlo?=
 =?us-ascii?q?YLsUTEAy/2hF36jK+IeUUg/eil8+Hnba/npp+YLoN0kg7+Prk3lsyxH+g0Lh?=
 =?us-ascii?q?QCU3KU+eS7073j8kn5T6tQgvIqlanZtYjWJcUdpqGnHw9Yypgv5wq7Aju809?=
 =?us-ascii?q?kVnWMLIExYdB+HlYTlJU3CLOzgAfe6mVuskTNrx/7cPr3mB5XANnjCkbbhfb?=
 =?us-ascii?q?ln6k5Q1BY/wN5E6pJJFr4BOuj/VVHsu9zFFhM5KRC7w/77CNVh0YMTQWaPAq?=
 =?us-ascii?q?6fMKPPvl6E/+EvLPeWZI8Tpjn9L+Mo5+DhjXAng18RZ6qp0oUNaHC+APtmJ1?=
 =?us-ascii?q?+VYX32gtcOQi8kpA07Gd3rml2fVnYHdmSyVqNkvmoTFYm8S4rPW9b+0/S6wC?=
 =?us-ascii?q?6nE8gONSh9AVeWHCKtKtiJ?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FFIgDKzZZdgMjXVdFlHgEGEoFpg1x?=
 =?us-ascii?q?MEI0khV1QAQEBBosmGHGFeoMLhyMBCAEBAQwBAS0CAQGEQIJIIzgTAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQkNCQgnhUJCAQwBgWopgzULFhVSgRUBBQE1IjmCRwG?=
 =?us-ascii?q?BdhShXIEDPIwlM4hlAQkNgUgJAQiBIgGHNIRZgRCBB4NuB2yHZYJEBIE3AQE?=
 =?us-ascii?q?BjXaHNZZSAQYCghEUgXiTFCeEPIk/i0QBLacvAgoHBg8jgUaBe00lgWwKgUR?=
 =?us-ascii?q?QEBSBWxcVji4hM4EIgmmNWgE?=
X-IPAS-Result: =?us-ascii?q?A2FFIgDKzZZdgMjXVdFlHgEGEoFpg1xMEI0khV1QAQEBB?=
 =?us-ascii?q?osmGHGFeoMLhyMBCAEBAQwBAS0CAQGEQIJIIzgTAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhUJCAQwBgWopgzULFhVSgRUBBQE1IjmCRwGBdhShXIEDPIwlM?=
 =?us-ascii?q?4hlAQkNgUgJAQiBIgGHNIRZgRCBB4NuB2yHZYJEBIE3AQEBjXaHNZZSAQYCg?=
 =?us-ascii?q?hEUgXiTFCeEPIk/i0QBLacvAgoHBg8jgUaBe00lgWwKgURQEBSBWxcVji4hM?=
 =?us-ascii?q?4EIgmmNWgE?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="12059491"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:46:03 -0700
Received: by mail-pg1-f200.google.com with SMTP id z7so3512384pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 21:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=psYXa8mIT1FkAshfcFCubEkA00yN3VjYG8rNmfjs5/o=;
        b=sThgvPAtDkJoDfivtekfeZ5lINFSXUf8v/ADNLqrZWCBkq7NPPa8cZcccBhTCf+Acb
         LXBJkmvM47KHWpKjPEOBIsIxP1aS8NnrREpOk1xXTLaZtYgkIlyAJ0uff4hYHdKIr3Yq
         hr47NZaMUUPQjcvj9Qqtv9q+aBVzaKOwAjUiWo7L3ygxCmFaszUeg557LB7HatLh6zZb
         tmdDnDKCXRjVFPe2mWQsCsBHRDfqNRSlslFPCFpbavu4/3LIILc+tcPPLUzHwnsQjDIF
         UkIX/sVSIXWykCmPYPr7CKeaVGY9XiU48IXsvRvz968Nt2Cy9dS9BA8ykg6Lym66c2uq
         2SOA==
X-Gm-Message-State: APjAAAUo9Bd12YvxBmY4tgsvEE8uZ6RHqMql7ewGOUA6ZuGAdwjd4vi1
        4LsQ3NCuRG+oS0MfzwdKF/cWLmcaFEcpkuSPxsfYrTUamuVPBdOpGSZWRo3/VHOaXXCCb2FeLfl
        fGJj7JPC1gJ9VDXY3mGWSOB9wxg==
X-Received: by 2002:a17:90a:22b0:: with SMTP id s45mr14621628pjc.22.1570164362693;
        Thu, 03 Oct 2019 21:46:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGjRTgwnhlo2KZICWhErm2QBBJwJvYEziM2d39vj6xXurXwJPnB9wMG3PeWPQZzN2CBEQCIQ==
X-Received: by 2002:a17:90a:22b0:: with SMTP id s45mr14621596pjc.22.1570164362245;
        Thu, 03 Oct 2019 21:46:02 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p88sm3786036pjp.22.2019.10.03.21.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 21:46:01 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: stm32: Fix the usage of uninitialized variable in stm32_pwm_config()
Date:   Thu,  3 Oct 2019 21:46:49 -0700
Message-Id: <20191004044649.2405-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function stm32_pwm_config(), variable "psc" and " arr"
could be uninitialized if regmap_read() returns -EINVALs.
However, they are used later in the if statement to decide
the return value which is potentially unsafe.

The same case happens in function stm32_pwm_detect_channels()
with variable "ccer", but we cannot just return -EINVAL because
the error code is not acceptable by the caller. Aslo, the variable
"ccer" in functionstm32_pwm_detect_complementary() could also be
uninitialized, since stm32_pwm_detect_complementary() returns void,
the patch is not easy.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/pwm/pwm-stm32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 359b08596d9e..22c54df52977 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -346,9 +346,15 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	 */
 	if (active_channels(priv) & ~(1 << ch * 4)) {
 		u32 psc, arr;
+		int ret;
 
-		regmap_read(priv->regmap, TIM_PSC, &psc);
-		regmap_read(priv->regmap, TIM_ARR, &arr);
+		ret = regmap_read(priv->regmap, TIM_PSC, &psc);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(priv->regmap, TIM_ARR, &arr);
+		if (ret)
+			return ret;
 
 		if ((psc != prescaler) || (arr != prd - 1))
 			return -EBUSY;
-- 
2.17.1

