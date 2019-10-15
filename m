Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3135BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B912084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="VbW6x0M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfJOQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:57:27 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:26748 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJOQ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1571158647; x=1602694647;
  h=from:to:cc:subject:date:message-id;
  bh=tJT8udUe23SQ/yMvXD9JrhV+zdyow2x8Zk5qa/cM1lw=;
  b=VbW6x0M03Cs7mOz+EU+pUDdXKpVXDoNksCoRPuxMbWvQRIgADkWkq55D
   dB78/yUOMwykvpvgaYCbRpRxSKNWnLi6KjTBnUWZv3/ARw09smESp/xsD
   TFamwmZBkDPYBrhcIhg+357hgvXKhTQBONrbxYJC53T9lbH9s79dN0DpO
   alviJCv53qJWnJ9rrMpbEUK6Mv0E5ZNLGcVPW/XJEK1h1sf3zshdGPj/B
   uABm1OGvLbV9nxjXHuXQMulRRj+TZcs5WF1afWBgQy0AlGqowMYa3Y81+
   JawO86I2L0c/NbvO2Ze+ATGNv437FzOO9nEnt3URZKIa76HIcW3ojzhba
   A==;
IronPort-SDR: 3ePImYSncZep9v3pR30lroA5RXfe5pFyjBJFTmn0Cv9AMDg0zZ1qcixjdbC+cFpKLVuR6QnT/w
 iTFPeN0avoaYlabzVX/e9SsQKlk0Vvqi8+xak7s7LtsI+WNiscC5x5Zm4LVOyNLUde16sy6wr+
 DWjnfqKdsOPBnQ9a7TH0eoiE+b/bKNQr601SkkZT3+pc0e5Ci0jFlqbwiTKPyMJtz0/B4a5bJj
 IWOaahT4dkuN0rDudPp0B6wHsseNhdKumOmkEhZuVf4rLH+chibKJLr9D2Q+CB1gECizttNZz4
 u14=
IronPort-PHdr: =?us-ascii?q?9a23=3AqI1agxKpoMXm1jAfqtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRI/jxwZ3uMQTl6Ol3ixeRBMOHsqkC1LGd6vi9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLhi7owrdutQKjYZiN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8ZUVixBGZi8b4oJD+oOIO1WsZDzrEYArRu/GwasAP7gwSJMinL4waE21u?=
 =?us-ascii?q?IsGhzE0gM9BdIDqHTaosvoOqkcUu67y7LFwSnfY/5MxTvw8pTEfgwnrPqRXb?=
 =?us-ascii?q?xwa83RyUw3GgzHj1WRqIzlPy6S1u8QtGWa7+thVeK1hG4mtw19vjaiy9wxio?=
 =?us-ascii?q?bVnIIZ0E7L+jhkwIssI9CzVU11Yca8HZdOqy2XM5F6T8AiTm1ypio216EKtY?=
 =?us-ascii?q?SlcCQW1Jgr3wPTZv2DfoSS/B7uWuacLS1miH9kYr6yhRm//E69wePmTMa0yk?=
 =?us-ascii?q?xFri9dn9nJsXACygLc59CcSvt44kehwTGP1x3P6u1cIUA7i67bK5k5z741jJ?=
 =?us-ascii?q?UTsEDDEjbumEX4kaOab0sk9va05+j7eLnmqZicN4h7igH6LKsigNCwAeM9Mg?=
 =?us-ascii?q?QWXmib//qz1KH78EHnXLlHiuc6n6rZvZzAO8gXu7K1DxVL3oo/9xqzFzKm38?=
 =?us-ascii?q?4ZnXkDIlJFYhWHj43xNlDOIfH4De2wg1WwnDt3yf3LJaDhDYnXLnTZjrjuYK?=
 =?us-ascii?q?t951ZGyAUv1dBf+45UCrYZLfL3W0/xssHYDxAgPwy33ennEtN92Z0aWW+UHK?=
 =?us-ascii?q?+ZP73dsUWS6uIsPeaMfokVtyj5K/Q/4P7ul3A5yhczZ66siKoWenClGbwyMl?=
 =?us-ascii?q?eZaHu02owpDGwQ+AcyUbq52xW5TTdPaiPqDOoH7TYhBdfjUt/O?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EvEgAd+qVdgMjSVdFmHgELHIFwC4N?=
 =?us-ascii?q?gTBCNJ4YzBospGHGFe4owAQgBAQEMAQEtAgEBhECCcSQ3Bg4CAwkBAQUBAQE?=
 =?us-ascii?q?BAQUEAQECEAEBCQ0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBglIlBaIKgQM?=
 =?us-ascii?q?8jCUziGMBCQ2BSAkBCIEihzWEWYEQgQeDbgdshAMKG4M+gkoEgTkBAQGLQYl?=
 =?us-ascii?q?ycJVrAQYCghAUgXqTFSeCOoICiUA5iwwBLYwYmycCCgcGDyOBRYF8TSWBbAq?=
 =?us-ascii?q?BRFAQFIIHji4hM4EIjXuCVAE?=
X-IPAS-Result: =?us-ascii?q?A2EvEgAd+qVdgMjSVdFmHgELHIFwC4NgTBCNJ4YzBospG?=
 =?us-ascii?q?HGFe4owAQgBAQEMAQEtAgEBhECCcSQ3Bg4CAwkBAQUBAQEBAQUEAQECEAEBC?=
 =?us-ascii?q?Q0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBglIlBaIKgQM8jCUziGMBCQ2BS?=
 =?us-ascii?q?AkBCIEihzWEWYEQgQeDbgdshAMKG4M+gkoEgTkBAQGLQYlycJVrAQYCghAUg?=
 =?us-ascii?q?XqTFSeCOoICiUA5iwwBLYwYmycCCgcGDyOBRYF8TSWBbAqBRFAQFIIHji4hM?=
 =?us-ascii?q?4EIjXuCVAE?=
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="82381423"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2019 09:57:01 -0700
Received: by mail-pf1-f200.google.com with SMTP id z4so16415289pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oyyo8ueGcSv2C2YN7t5+4dy6tp5fxBoXld6XJLZPnpM=;
        b=fv9LbXnOpFWeOZlQ8yMk2r0N0a2/u3fSTFEY9kmLZB4hsJsYMrEpjKCmh4w4skBNaB
         x10XITlcwOKXSYxr1Cw3mWBg+UIkDZm6CQx1TAo/swNoo/LC3kAgyLFk9Izpa5EVz8td
         GlYe8uXTMPXYmy0kuStTLsbSujP+D9URxsAFOIGcFfwaQGOZ9kWhhmlLKjz7nnBQjhBx
         slCuvqbwxbKspHFWPY/ByXHNJ8WoKYQWmATOSWQj2Q8N/RiPQiN6+UPAhwV67vsLxKM/
         dPfxoiyA0WTqVedr1jZnCzO6nvT6yl+dj2R31xwkzS3N3CfL/DhNsxNehHjbv3nGZgCs
         ofLA==
X-Gm-Message-State: APjAAAXjBSyI7SNQwVH1cjWbzNLTQbSRc9sVai2L8MxHRgA71M+Qcb5z
        N5CM5BOBJE9H6lJnR7g/wz0I5By2AXiW1C83jvbz6cW+FAhOagHffpOK5p7pkl0zTXcKJeAGrwT
        Ov3nX4T1avFmlJ2WnUj3O2XhIkg==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr37063837plp.218.1571158620567;
        Tue, 15 Oct 2019 09:57:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYM/sGx2FnwldouLf984y/BIUzeFauhYwXc+v3vyUmkpZ29mvFBQoj0yMfftTqU12/tZAZ2w==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr37063822plp.218.1571158620267;
        Tue, 15 Oct 2019 09:57:00 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id v19sm21864641pff.46.2019.10.15.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:56:59 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     zhiyunq@cs.ucr.edu, csong@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: rt5033_battery: Fix the usage of potential uninitialized variable
Date:   Tue, 15 Oct 2019 09:57:37 -0700
Message-Id: <20191015165737.658-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rt5033_battery_get_present(), variable "val" could be
uninitialized if regmap_read() returns -EINVAL. However, "val" is
used to decide the return value, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/power/supply/rt5033_battery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index d8667a9fc49b..6a617531698c 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -26,8 +26,14 @@ static int rt5033_battery_get_present(struct i2c_client *client)
 {
 	struct rt5033_battery *battery = i2c_get_clientdata(client);
 	u32 val;
+	int ret;
 
-	regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
+	ret = regmap_read(battery->regmap, RT5033_FUEL_REG_CONFIG_L, &val);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to read RT5033_FUEL_REG_CONFIG_L.\n");
+		return false;
+	}
 
 	return (val & RT5033_FUEL_BAT_PRESENT) ? true : false;
 }
-- 
2.17.1

