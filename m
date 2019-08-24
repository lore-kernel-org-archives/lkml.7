Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6783821670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/jXSBzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfHXIFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 04:05:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39688 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfHXIFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 04:05:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id i63so11148751wmg.4;
        Sat, 24 Aug 2019 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+60LdlbCqtJ4syN92vvJCUvdUjv+hUfRrAAbnZIgK8=;
        b=Z/jXSBzzIBPfUtpD4JBH8pFN8MtUbg/4iBP50Ys4wRovpm0EmEJs8CQX0rhqf3FvI0
         suE5+eOnJ/SEnzSAQNI0W5CEFY0mcsbt+0uVBgyKJiQTB0GnUDqiCFeqixeMJVdOwEhX
         GXv/HV7a0meXqKCUCy8KKoKtAQTo+nvZSCfRtX3ImVX+pWuNd69H1MXJ7n+AzUz/K5R6
         b9kQjTA+A+58A+MHLlt+QoDS8FWYfXl6cPY0lWHENJxPQYhT8uDu/2kT6AXq+1WI98L9
         SzrNeuXXy7Hgfi99DULmb6qxNGn1ruM9sVVtoV54kKwNYnb7UiUXEmVGOmZEN/v6YFOy
         CbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+60LdlbCqtJ4syN92vvJCUvdUjv+hUfRrAAbnZIgK8=;
        b=knxjH+P5tQ+S3BH0C9nNmUKJ/UDG2R5hiiKAXT4kgVPz9l6fsEf2ICCsWeNyujzUOw
         S/qJy1EHJpvhoUKQBcMOYzeMw4SiHLwSUkuOgo7SmhwivrbfK3mbbxQGniP3s4VB6ISQ
         0QDCHaZF2d4CPh2NBp5CHYPK8u3M89jYNUmNkP6fTcLSQFkRTSsHeG3f+Aqo09Gs8h1O
         AzGeXRKN79vyvqGSJ0UM2IBTW8LXV4fyx8DnBiBS0NwFbzLXR5/Z2neXa1oHQLfiNE3b
         t6jXrmHQ4cQeFfMqVXkOUBzc3CoeS8ocgNZtIzb5ZMW5VAMLH9mqW4CrrClc+EAligp3
         K2cA==
X-Gm-Message-State: APjAAAWuibZmBFKH6YXV1lWlig8TEa9eQ2ps/CnLi4TFpXaicGl9ebJB
        S0F8/7+9YN5rjcoUoZ7NSwQ=
X-Google-Smtp-Source: APXvYqwtfEgzay9VkCqtIBWQdafyJCktisSy5n/2gTrK3Jp2Nunb1lIPkWrquChZMkOnteVH4OLQKQ==
X-Received: by 2002:a05:600c:254e:: with SMTP id e14mr10259290wma.150.1566633905944;
        Sat, 24 Aug 2019 01:05:05 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id w8sm16615656wmc.1.2019.08.24.01.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 01:05:05 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH v2,2/3] dt-bindings: arm: amlogic: Add support for the Ugoos AM6
Date:   Sat, 24 Aug 2019 12:04:09 +0400
Message-Id: <1566633850-9421-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com>
References: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
S922X chipset.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..2ded61d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - ugoos,am6
           - const: amlogic,g12b
 
 ...
-- 
2.7.4

