Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF20C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA138217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 23:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="OhnTr0ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfIBXOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:14:38 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:5684 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfIBXOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567466279; x=1599002279;
  h=from:to:cc:subject:date:message-id;
  bh=wrJn6aBHz0Uw1eGhnnd+uYHpG8nT9vsMJN2vUur/bWQ=;
  b=OhnTr0ldt5Mv8QIOqfKoGO5jKzVcBnhz2phCnjp8HMy3Z4zhSBlPlWZP
   EdYsMgKQVGFjDTBARnjzO1+p3Zcad2mYHadNlnF8bnxE92fv/WzQFlQcb
   vEZTyFZO1KJo4TYmIOza7DNBfwApnSU2GF4L1symoGL47trASjQk/1JEn
   TjcyO48I5Hn3HOcQZetzNqa1uoOTmBSqSgD/ZzFZYdOQHzrR8iCXIdcX9
   tHV1HJFyz8kl6wRNrcIXtc24rqWC47WNjpsvWfosz8Q8RG2kFodhLA1pS
   8xHaERd8BlS1ilkFzBCGFHz5hAhSg9dCh13yw9eq0ANketdiJ9aYsHetA
   Q==;
IronPort-SDR: n3qv3njVNkvFqgrYURstPTaJYfKTX+0kFQzwrBIl5oikQH+n9lM/IpDaYc0C6X3JgyT3cvLI4N
 crtX15mBwqzhPmnnEiQDAkVKF1pPxDyHGuOJY62W1FuK2v7tHy5Ismibq8ais2jdRoTaGswlMf
 1crDir4KF4d/qaZzm227ggSVMS7uv2ckN1fPN1jPdwnMoUqNtC/RY6rm2aCzUa1jfFNRiL62Gh
 PvW93woJhy4Hftz5oYcZIBkhPpvGEHSPP54tkHRGsJ+XJVgfTFZ38CKRHwGd4Nua7yheqX6YvC
 VNg=
IronPort-PHdr: =?us-ascii?q?9a23=3Arvp1WhLny5rMXwg389mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRI/jxwZ3uMQTl6Ol3ixeRBMOHsqgC0rWP+Pm/EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rxjdusYLjYZgN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8ZUVixBGZi8b4oJD+oOIO1WsZDzrEYArRu/GwasAP7gwSJMinL4waE21u?=
 =?us-ascii?q?IsGhzE0gM9BdIDqHTaosvoOqkcUu67y7LFwSnfY/5MxTvw8pTEfgwnrPqRXb?=
 =?us-ascii?q?xwa83RyUw3GgzHj1WRqIzlPy6S1u8QtGWa7+thVeK1hG4mtw19vjaiy9wxio?=
 =?us-ascii?q?bVnIIZ0E7L+jhkwIssI9CzVU11Yca8HZdOqy2XM5F6T8AiTm1ypio216EKtY?=
 =?us-ascii?q?SmcCUOy5kr3wPTZv2DfoSS/B7uWuacLS1miH9kYr6yhRm//E69wePmTMa0yk?=
 =?us-ascii?q?xFri9dn9nJsXACygLc59CcSvt44kehwTGP1x3P6u1cIUA7i67bK5k5z741jJ?=
 =?us-ascii?q?UTsEDDEjbumEX4kaOab0sk9vWs5unkeLnmqZicN4h7igH6LKsigNCwAeM9Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHnXLlHiuc6n6rZvZzAO8gXu7K1DxVI3osn6BuzFzKm38?=
 =?us-ascii?q?4ZnXkDIlJFYhWHj43xNlDOIfH4De2wg1WwnDt3yf3LJaDhDYnXLnTZjrjuYK?=
 =?us-ascii?q?t951ZGyAUv1dBf+45UCrYZLfL3W0/xssHYDxAgPwy33ennEtN92Z0aWW+UHK?=
 =?us-ascii?q?+ZP73dsUWS6uIsPeaMfokVtyj5K/Q/4P7ul3A5yhczZ66siKoWenClGbwyMl?=
 =?us-ascii?q?eZaHu02owpDGwQ+AcyUbq52xW5TTdPaiPqDOoH7TYhBdfjUt/O?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E8AACqgmddh8bSVdFlHgEGBwaBUwk?=
 =?us-ascii?q?LAYNXTBCNHYZdAQEGix8YcYV5gwmFJIF7AQgBAQEMAQEtAgEBhD+CWyM0CQ4?=
 =?us-ascii?q?CAwgBAQUBAQEBAQYEAQECEAEBAQgNCQgphUGCOimCYAsWFVJWPwEFATUiOYJ?=
 =?us-ascii?q?HAYF2FJ08gQM8jCMziGkBCAyBSQkBCIEiAYcdhFmBEIEHhGGEDYNWgkQEgS4?=
 =?us-ascii?q?BAQGUTpYFAQYCAYIMFIFyklMngjKBfokZOYpaAS2ldwIKBwYPIYEvghFNJYF?=
 =?us-ascii?q?sCoFEglweji0fM4EIjAGCVAE?=
X-IPAS-Result: =?us-ascii?q?A2E8AACqgmddh8bSVdFlHgEGBwaBUwkLAYNXTBCNHYZdA?=
 =?us-ascii?q?QEGix8YcYV5gwmFJIF7AQgBAQEMAQEtAgEBhD+CWyM0CQ4CAwgBAQUBAQEBA?=
 =?us-ascii?q?QYEAQECEAEBAQgNCQgphUGCOimCYAsWFVJWPwEFATUiOYJHAYF2FJ08gQM8j?=
 =?us-ascii?q?CMziGkBCAyBSQkBCIEiAYcdhFmBEIEHhGGEDYNWgkQEgS4BAQGUTpYFAQYCA?=
 =?us-ascii?q?YIMFIFyklMngjKBfokZOYpaAS2ldwIKBwYPIYEvghFNJYFsCoFEglweji0fM?=
 =?us-ascii?q?4EIjAGCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="5470477"
Received: from mail-pf1-f198.google.com ([209.85.210.198])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 16:17:58 -0700
Received: by mail-pf1-f198.google.com with SMTP id z13so9609232pfr.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 16:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbPcGIvjek55/mukFc57PQHYy7743OrNG7Y4v0Ab2d0=;
        b=akB6V87MIelXqA69qufz3gN9sCMwdUL6nhU9fXTVasTV/neN4XsUBINreyiIdcggeh
         u4nAuKdQM5mIT/wed9aaXSHy2VvFtkkzSjdQ0UA1hBj+b8tjuOc8d0dSAMGaKDRoziM7
         QjbwAOwoT3ExCZ8C1WugNdx8SxrQB/bc9xThG4Syrxzdow5xBecJuEgeIsPC4bDC9bh0
         p7tK1ZrbRQN/QzDKjkiKLA0NbBVQkWV+qtzjLXCO9BK50/CPeG8d6y2smnRH4cjhau7m
         OLYUER2ifY4EkLQoAip09ppoT8N3LsR/FWeDeI95Qa1jOP4GNfjnTO+8fHBjFylut+zl
         z0eg==
X-Gm-Message-State: APjAAAUNRhtWhCjqKJ+LYiwJM3d71VxQvD0akpvfvKolGnuJ/bVPDXBt
        ztBLMcHwLl3KrxxQniH+Ot67aamYK5sPDBHbpmXDcTB7TB0b43nlr+YLnxN5Tii/rrMyk28TcQf
        KKw3V1gf5FaYI+rqk3tZ2aYTyCA==
X-Received: by 2002:a17:902:9f97:: with SMTP id g23mr25566848plq.248.1567466076389;
        Mon, 02 Sep 2019 16:14:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyG1mxoH7h9PwFtEKTdqe361X81McE/StIlugJILQyx3cKKtm08UaQvwZnUk/+e7cNgptjUmQ==
X-Received: by 2002:a17:902:9f97:: with SMTP id g23mr25566835plq.248.1567466076169;
        Mon, 02 Sep 2019 16:14:36 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id 138sm18270374pfw.78.2019.09.02.16.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 16:14:35 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hisilicon: Variable "reg_value" in function mdio_sc_cfg_reg_write() could be uninitialized
Date:   Mon,  2 Sep 2019 16:15:10 -0700
Message-Id: <20190902231510.21374-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mdio_sc_cfg_reg_write(), variable reg_value could be
uninitialized if regmap_read() fails. However, this variable is
used later in the if statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 3e863a71c513..f5b64cb2d0f6 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -148,11 +148,17 @@ static int mdio_sc_cfg_reg_write(struct hns_mdio_device *mdio_dev,
 {
 	u32 time_cnt;
 	u32 reg_value;
+	int ret;
 
 	regmap_write(mdio_dev->subctrl_vbase, cfg_reg, set_val);
 
 	for (time_cnt = MDIO_TIMEOUT; time_cnt; time_cnt--) {
-		regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
+		ret = regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
+		if (ret) {
+			dev_err(mdio_dev->regmap->dev, "Fail to read from the register\n");
+			return ret;
+		}
+
 		reg_value &= st_msk;
 		if ((!!check_st) == (!!reg_value))
 			break;
-- 
2.17.1

