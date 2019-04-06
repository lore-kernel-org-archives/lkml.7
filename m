Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E44CC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242B42173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xr6BIecC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDFG0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:26:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45475 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfDFG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:26:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so4183722plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVzU6PP5F+SzOzpO6WtaAUoxTTsPMC1Ul+BiXwcB+sU=;
        b=Xr6BIecC0VTA+AkMq0Fd0wyp67AFq6aiZnX+pV0vheHuI7SaNlLv41VSgjo+/7Ex6f
         bXp546GqjmgdrydUmtGlD+5ob+bJYiySitT/ZSIIbUwtZJDM27MvYK30bX2zoetaiC1n
         ObqgWxB+S77xqYJnCiD/V0jMrIEl/6vzz1Nlrh0eCwfzbjwjlbz6X8GjcW44om7WeBnx
         sZO1UpyOTZpnncTjz53iT1HUvG6GDyQAWsjhM9gm/BkqRVpybiLt15Cn9IvBcoqdf/mH
         A7FjcyBgqn29Sv8vlTTB10W2S6YMeBPX9jFOUlTxjYuKDbxTQZyt15eUp87HzlAiTYcD
         7ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVzU6PP5F+SzOzpO6WtaAUoxTTsPMC1Ul+BiXwcB+sU=;
        b=qb33TPOhZp86p88CStIZb9P5cV/4BAEjHnrBw+9lgKkpb3aMCyWLkmHZmg7/lblTXV
         lf82jho9cZXq5n/GL026HxUxdWIXwt5hcjv1lDYVax5S6M/Si+kW23/5H1sAqvy4zNs0
         X60HDv4PcwM4Om3ZVDV6XfADxUMhRNA7n9pk1JrAaKtCNtSOIC4VPxa/mLLENGcInqn2
         nLPqHtfBmsTZlKoSHh8yxAEyHtjDgIsLQpWVsZWKJKIGjc1DXxXIgeBD/X7sK5bykEmM
         cJmpF7tN0aUoPlOcq5Fr+OwyYj3AyulqrA/u8h4TPSTyVt9vWeGP/4E60YZr/7wufCxu
         mUGQ==
X-Gm-Message-State: APjAAAVQlPaKvMwQ6TAmf0GYY4WjuZazh4GeI2m8qQ0QYeN97abZglSV
        nVQeMqB/xj95EniZBPlYP6hNzQ==
X-Google-Smtp-Source: APXvYqzj1J3fVFoxLOwhCA8mwLoMA4GAwIIB5VbJL9RH13qVDNdi6Viz5k286fZv8sj/3+lqHFCGPg==
X-Received: by 2002:a17:902:8c97:: with SMTP id t23mr17430492plo.110.1554531961340;
        Fri, 05 Apr 2019 23:26:01 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t12sm54444623pfl.59.2019.04.05.23.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 23:26:00 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: arm: fix YAML whitespace in cpus.yaml
Date:   Fri,  5 Apr 2019 23:25:39 -0700
Message-Id: <20190406062538.31325-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running 'make dt_binding_check' fails for
Documentation/devicetree/bindings/arm/cpus.yaml.  This is due to tabs
used for indentation:

$ dt-doc-validate Documentation/devicetree/bindings/arm/cpus.yaml
Documentation/devicetree/bindings/arm/cpus.yaml:  while scanning a plain scalar
  in "<unicode string>", line 230, column 19
found a tab character that violates indentation
  in "<unicode string>", line 231, column 1
$

Fixes: fd73403a4862842e89d7d2063cfe9e25bbe9c991 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 365dcf384d73..82dd7582e945 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -228,7 +228,7 @@ patternProperties:
                 - renesas,r9a06g032-smp
                 - rockchip,rk3036-smp
                 - rockchip,rk3066-smp
-		- socionext,milbeaut-m10v-smp
+                - socionext,milbeaut-m10v-smp
                 - ste,dbx500-smp
 
       cpu-release-addr:
-- 
2.20.1

