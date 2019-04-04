Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE77C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D4D206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2K3ho6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfDDM1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:27:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55910 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfDDM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:27:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so2815175wmf.5;
        Thu, 04 Apr 2019 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwAOpYjNzXKsO8Sq287Ti3QPb3uJDsGdvAedp4I+PGE=;
        b=k2K3ho6N82j0FLhWLBurtHR2RsONMLliG6huSfwD2+ioyWj3ncpLhqsqFLzZEpJz5N
         G54pZQ0M5u1mFX+TKLVWwoMjQ/JO8XklBvU+pFH/pmrqcUcuFLQYwHo/YTO9iBkoF3lW
         MjLwsH242hhFFaJFso+Xf0VcIAfH6RkTinpXgN6gIBqnGR93iQEIWSyjVQAsC9MJ/0wo
         WIARPltQPFKPW6KwWJlZ59RcVnNi8+GVn14kPRUBAoVvIRS+/cucE0sm0tAh7vlmh30i
         wldPf8V1tpHxm1rAC8peotNlcejk1AMHnqiLm0RjH79XwQjLySBW9AEiUnun08ixB0yA
         gH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fwAOpYjNzXKsO8Sq287Ti3QPb3uJDsGdvAedp4I+PGE=;
        b=BST1pU+9qLSdr9CDZbb+qwr2J7TWIabY17ybwZU00xPO0PxCMYlnQ30hMzeHnmf3CW
         Ls2Ycy9gievATuYlc3v6ee1soPws6EiTD6CpGb4m9pDjO/PtCL4cb/G1bJ5oen8ggEg8
         pl7a11On8ikdz2vLggX/7FLkN9a1ilPMlFpsd59NGJHNyCwQmINg6KIIyZurw5ScTL+S
         ml0LQMQEXeooxuJnZlmR+jqOaJWiflf/phiG0NK7Y9S6XQQClXVXjw1FVwXWFecVYs5A
         AdaHkyZ2KUYEoaTKYhzR+ejQiukXvNesWjCbjWhP5jj1CgrvrhLqmmZzV9m+o42I7JqS
         /rRw==
X-Gm-Message-State: APjAAAUEGkEn8+G8AtwM1eLPSOfagHKk3RuCq15fw1sAdKHMP24RrJ/v
        VvzlbKIad23X7UApzdCmP8A=
X-Google-Smtp-Source: APXvYqxiIv0R/6z6mPh8DP1PyQAW6XIONCr1Lsw8Hq4BwNdt4viyn5Tu2swxtF6C7N8GdE9bCdtZqg==
X-Received: by 2002:a1c:e0c6:: with SMTP id x189mr3923674wmg.4.1554380858694;
        Thu, 04 Apr 2019 05:27:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id h2sm38031178wro.11.2019.04.04.05.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:27:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: add AZW
Date:   Thu,  4 Apr 2019 14:45:03 +0200
Message-Id: <20190404124504.11137-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen AZW Technology Co. Ltd. is a manufacturer specialized in Android
smart TV boxes, Intel mini PCs and home cloud TV boxes with NAS.

Add the vendor prefix for AZW.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8b4ae37629b2..8313edbaf52e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -54,6 +54,7 @@ avic	Shanghai AVIC Optoelectronics Co., Ltd.
 avnet	Avnet, Inc.
 axentia	Axentia Technologies AB
 axis	Axis Communications AB
+azw     Shenzhen AZW Technology Co., Ltd.
 bananapi BIPAI KEJI LIMITED
 bhf	Beckhoff Automation GmbH & Co. KG
 bitmain	Bitmain Technologies
-- 
2.17.1

