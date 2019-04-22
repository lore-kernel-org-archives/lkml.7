Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34B3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8217120896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYHb2K8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfDVTTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:19:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46596 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfDVTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:18:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so11214303ljk.13;
        Mon, 22 Apr 2019 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgD/uImHb6NwkHJPZVMHXtBTkKsMvl+ZXd/c4dnETFU=;
        b=rYHb2K8iEd3lQ8zKFttTGCOneJAWHT1WTwhyx3WIVJ0BhbjWweozRbUACYEMyLFfQp
         aDgfeJ1t2wpo7kXOYrjVerNLZogItOuKG+ycotMBfQbUgltONAXnw4kOMrk1BmK9RXIL
         K1Jv+XnFMO27alqXVhw2eY5gh7jLUHh+3TgHYN4K+potbIFcZHvfnuy03u/Bmr3DDSEx
         tzEs3ErOmYwD+rzcOmcsb1/tlWwQtD3ZmU/NBri8Rc7oF6D6hipsRj0Z2qCcUTH2pfk1
         hsdjjPl1bydPYobWUvfZ38Dj3OQMmgK6Ex6ZMBjad5a12IT0rXkDou2CdNjtAOZmwwIZ
         zACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgD/uImHb6NwkHJPZVMHXtBTkKsMvl+ZXd/c4dnETFU=;
        b=FT/iO+LGggm3JEH5DvkAY9m8bQDOhQgQ/dGMK0d9DrBmvNTIT0j2yunWoFTmWI6XFy
         qjqiakuCtKXuGGlEOKPvcbRxumvghvF3sxpubhhujwznbIFQrISzp8w488qkGHze5aqQ
         ImR9Couupa1Hm30r6SCnNQEuoj0LHo0eF96HMWuAhVaSVteDgwZGFYlz53f+DaC1+fM1
         F5OPhjw02kKh3HGhXbxl0awHJ1MvRyIxGigdkcAdAKc0K1QnEPLcre62hjO7To0INtcY
         n3XVk4D/N+B1YGcDgtUlTmCZMQdONSKk84MQ1G3ex+DrRT9Bxk1H/NBgWlrVY+lF9QUh
         NTwA==
X-Gm-Message-State: APjAAAUK0no5VEnHoudMKcVw0pRlElHh/OlM03nHlNj0K7hxkvh0pd8S
        jbuea3nK9eP1EGYDqtq6/tY=
X-Google-Smtp-Source: APXvYqyQ4QQ0lnVzARVPt9wAqT6Do5arnX1LrulaM/w8jdqKLUnJAKKYRRGGFDy7tQ3MWXW+GWpmlQ==
X-Received: by 2002:a2e:8582:: with SMTP id b2mr10938851lji.24.1555960734653;
        Mon, 22 Apr 2019 12:18:54 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l13sm2848762lji.39.2019.04.22.12.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:18:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] dt-bindings: mfd: max77620: Add compatible for Maxim 77663
Date:   Mon, 22 Apr 2019 22:13:47 +0300
Message-Id: <20190422191350.27527-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422191350.27527-1-digetx@gmail.com>
References: <20190422191350.27527-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim 77663 has a few minor differences in regards to hardware interface
and available capabilities by comparing it with 77620 and 20024 models,
hence re-use 77620 device-tree binding for the 77663.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
index 9c16d51cc15b..9058499051e0 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -4,7 +4,8 @@ Required properties:
 -------------------
 - compatible: Must be one of
 		"maxim,max77620"
-		"maxim,max20024".
+		"maxim,max20024"
+		"maxim,max77663".
 - reg: I2C device address.
 
 Optional properties:
@@ -105,6 +106,7 @@ Optional properties:
 Here supported time periods by device in microseconds are as follows:
 MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
 MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
+MAX77663 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
 
 -maxim,power-ok-control: configure map power ok bit
 			1: Enables POK(Power OK) to control nRST_IO and GPIO1
-- 
2.21.0

