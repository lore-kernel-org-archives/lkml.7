Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF6C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E64E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zV2sfJ5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfCYKZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:25:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43249 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbfCYKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:25:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so7270889lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcOI01Wr/+3DxH7WXfJEA8V1OyEeebKPMWO9OvVYzmQ=;
        b=zV2sfJ5OSOoelT6/jHfOWvo0LwWj7t+4JCuKx2tLrHjftzv/5+RIAXBhO4PfDZxV2J
         zIlBuQRsgMPCsGhf4aIJCmTRy9jRMQV/iS/A+G2PRERgw4LnHeQYzovXhV9vq/L1qw1o
         OCIEnK5YuxIXcWabWZ10aBozMoIlttSVf35rryYv3++dajdG4w3Ea675W3CCcl33hffT
         UYWbSBcbR5qHYiZ+82pSL5KkXKMpVU2cxLbgZIGf+9Em4AMGXyFt1U7p+/jgEnQJzRRm
         2SA+HA2yRvVze5SYagvkSlPXSbk7sVaB0CqWK4iPtP4wwjmU3gcyYhoCI3LNUnHLcbZd
         8Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcOI01Wr/+3DxH7WXfJEA8V1OyEeebKPMWO9OvVYzmQ=;
        b=U2yZzVcupcmDeYmEqXN8E+7ZZcnoOlnK6C8/05V4SAuatkKe5kt7gi/G7ctBpTJkJB
         mZ4Lc3WgwaHkOOayhV+muaMUN0hqcMWQn5Q2h/IWi8xSBDWsPk8vw3ra3bRv0sb9o7KY
         bVHLBQ/jGPmlryFZ7C+/x2K3UBBQLYKhd2GZECfRWHuUsd07LsJe8iUDpr47tdyNJjV8
         dGHlCRyMKUkcbuPCU0L4Ze5RyG+NZoPU3n18Sw4qR+4Fl+gfkoLd2Mm0EoRT9BTJR18J
         /fyDbcB+HKAvEVjhQGJSsSIkEi/HfEyjI17H7FuATeB1l6a+6s913cdUpYCBA+I8X175
         zR1g==
X-Gm-Message-State: APjAAAUNDJtTPsFzNN/CtRHlACHc2cd6OmpZLWGUKrhMC9HXyKwWAGDf
        N22tOBnv73EBXGC4K+FirnNsSw==
X-Google-Smtp-Source: APXvYqxcqBiPnY8+yX0CyOz6ed03aUetxiGJghuiH8kObnHSdu1k6zWJvTX0wsvWi8hdKpFn4AjOrw==
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr2129423ljc.172.1553509498786;
        Mon, 25 Mar 2019 03:24:58 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id r77sm2256964ljb.29.2019.03.25.03.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 03:24:58 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rtc: sh: fix unused variable warning
Date:   Mon, 25 Mar 2019 11:24:53 +0100
Message-Id: <20190325102453.8349-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the driver rtc/rtc-sh a warning about unused variable
shows up:

../drivers/rtc/rtc-sh.c: In function ‘sh_rtc_probe’:
../drivers/rtc/rtc-sh.c:472:18: warning: unused variable ‘r’ [-Wunused-variable]
  struct rtc_time r;
                  ^

Remove the declaration of the unused varable 'r'.

Fixes: 373f7f4bf4a5 ("rtc: sh: stop resetting time to epoch")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/rtc/rtc-sh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index d72ee3a841ea..579b3ff5c644 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -469,7 +469,6 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 {
 	struct sh_rtc *rtc;
 	struct resource *res;
-	struct rtc_time r;
 	char clk_name[6];
 	int clk_id, ret;
 
-- 
2.20.1

