Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC02C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48EE208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Af5U4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEEPsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:48:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39372 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:48:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id z124so1312503lfd.6;
        Sun, 05 May 2019 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzDXzspUdpdj1Pdn5HzSktqe5RpeeWan097KS/U2Nos=;
        b=k2Af5U4Si/IpC5zFDjyuOkPKgNDvOQBhlEm00LSzX83W3oGDJd6vDMMul3u4++Kjll
         QAMZ5IFiRVBiFE5Q7F44kVEeE6S86q79C6fZz1t0TxbK2gouIghqhvX5rwvPxpQcdEo6
         dOnTVHZXATL1e3E/dU5J4BKWGW2xRQqzNYW6sNiXZY62Rr+nbp5+Lo7WNeNblqXC1JeL
         U9AKYPa5mpqyGeL07SNpLxdKh+oRMPopgvxhmna1hRP4hemo4KZfd5xlNAlCOPEgYShn
         nkrLm19etFXVngcWW/bZMCBof62f5bBeBnpcb+SUh39BGudGwDkTx0rYUFZaGkh7FUnN
         474Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzDXzspUdpdj1Pdn5HzSktqe5RpeeWan097KS/U2Nos=;
        b=naBdZGCtCMIA51RtMjWrjp1ZnTg+RIRlX+ouoIRogjCP4NxOW75UGExfoF+Ly3JZHh
         6ScdthpW/wV0z440+UDjqGOyxHRyAjUvbizbjxxDHBOFrq0zWrjcDHXzHLtZ896UN6Uc
         OE4U4tvvip6Xg6OQ/2JQdGs0UdP76hWmp5xIn8iTnxnn9b2rBgGT5/KUxvaRM5x0F5nc
         N+me/eSg+UvnR/UFNMvHf2Dt8ktveKvg2E/vnac9y3IdsXEGd8qxkNNdSekz1jDhG8gf
         XvQnbSEoMzVAHirHJi5VPNJWKhifgd0dT3/qnubwp7ZpMv0E1RiS1ELcWt6UdGXtBcs4
         qP5Q==
X-Gm-Message-State: APjAAAUD0jy/w1MWbD9O6pCzv0JMwlqegnFi1qpM6/YVVRewqmPJTWIh
        gDqYlmN4p3k5b8K8hvXdOjo=
X-Google-Smtp-Source: APXvYqxG0kVtFr9MyL5J3Ka4IysRDtGdvmYcXWglnPkFzFDhErzvzq7XRAFYLb1ceUDvFZHjIqhLwg==
X-Received: by 2002:ac2:4893:: with SMTP id x19mr10416172lfc.109.1557071314413;
        Sun, 05 May 2019 08:48:34 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d16sm1595278lfi.75.2019.05.05.08.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:48:33 -0700 (PDT)
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
Subject: [PATCH v4 2/6] dt-bindings: mfd: max77620: Add system-power-controller property
Date:   Sun,  5 May 2019 18:43:21 +0300
Message-Id: <20190505154325.30026-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505154325.30026-1-digetx@gmail.com>
References: <20190505154325.30026-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new generic property that designates the PMIC as the system's
power controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
index b75283787ba1..5a642a51d58e 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -18,6 +18,11 @@ Optional properties:
 			IRQ numbers for different interrupt source of MAX77620
 			are defined at dt-bindings/mfd/max77620.h.
 
+- system-power-controller: Indicates that this PMIC is controlling the
+			   system power, see [1] for more details.
+
+[1] Documentation/devicetree/bindings/power/power-controller.txt
+
 Optional subnodes and their properties:
 =======================================
 
-- 
2.21.0

