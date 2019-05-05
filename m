Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB2CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB26B206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba/H+rWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfEEPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:48:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37761 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfEEPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:48:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id 132so1305305ljj.4;
        Sun, 05 May 2019 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/oDDLfoDfhOy7WyChIuVkS7IKV9TMbU7wV4adCUitI=;
        b=ba/H+rWBrC18tHiXQYrajDMZMMGPeJb4pLyaiKprUqi1TD4zH8W4z+RAWNDjuaB6J0
         YnmETdEGdm3uHhpxgFVECrfnqLpxQf3hiwCMUkkubqG+9dxFFpiKs0YqRCmezhM7BA3s
         rF5eSj3w8GSQ2Y9VY3fMp0RPBBYDwbWYpAD7HRB1xuQ4vMEnbeAzxrSk/obZNrjb/Pka
         o7NiL5Rpt0OJ5ykYrWxTxiP9OMmNYIQrb62Ec7hK6PBq+G9i7+EI5TNazyPqu75m6jCz
         gmUTu7snuVy5xGHs1MLnKxdeMJvwVW/4QF2NrA+CJIlEHreZD8ajLnQcvLndaCZIGMfE
         lceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/oDDLfoDfhOy7WyChIuVkS7IKV9TMbU7wV4adCUitI=;
        b=e50jqGnDTXReoGVQGEpUI/sZsepXmCo1YCs6jLB4S6Ma+e9umDyNVx05ZHmueET8ix
         CQxuVfbwYtyyIR7dynHqU3A88lVgX9Ct3QhQCJgOn5D/KMnJfyHUcOl9WyHw6GAZ591T
         Wtk6WGzEf+TH77hhlpu9EMuDsjBzn/Srpn08TN3YVjX/GwxhED0aRN7yUiwhp8udTPZz
         SPbNqv3RRONUANCulUgcZT+fzeXplzEXmrnAXF7Yzcn+24rlPpPSpAUmlek58XPBGN1c
         btlXVkhiUPbaqoOC4D8QYiB8wydtKncn0wM0rYbvUYY+mAbmN/PlRfNPHA6WZVVbLbDl
         PAog==
X-Gm-Message-State: APjAAAVeWdK/GYm/xbNVsa6jDy5VzqQ36glML1ICa8HedGh4vs02V0z9
        oZSRAsvnXt3lDawu+u5s1jY=
X-Google-Smtp-Source: APXvYqy/jC22w3xG4JOm82UjunnBQ+qPoZTI7WGZxLQeKPk1HJ6uAeweoQplRcz7YkjRoAmSM9bcAw==
X-Received: by 2002:a2e:498:: with SMTP id a24mr11003675ljf.34.1557071313317;
        Sun, 05 May 2019 08:48:33 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d16sm1595278lfi.75.2019.05.05.08.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:48:31 -0700 (PDT)
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
Subject: [PATCH v4 1/6] dt-bindings: mfd: max77620: Add compatible for Maxim 77663
Date:   Sun,  5 May 2019 18:43:20 +0300
Message-Id: <20190505154325.30026-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505154325.30026-1-digetx@gmail.com>
References: <20190505154325.30026-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim 77663 has a few minor differences in regards to hardware interface
and available capabilities by comparing it with 77620 and 20024 models,
hence re-use 77620 device-tree binding for the 77663.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
index 9c16d51cc15b..b75283787ba1 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -4,7 +4,8 @@ Required properties:
 -------------------
 - compatible: Must be one of
 		"maxim,max77620"
-		"maxim,max20024".
+		"maxim,max20024"
+		"maxim,max77663"
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

