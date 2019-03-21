Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCCCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C681218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J/YsD8di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfCUIVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:21:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43693 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfCUIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:21:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so3812339pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMUNzEzuNv5+/G7LTk2UNMwsYgPjYrZ+abL8baBFG1I=;
        b=J/YsD8di/55xadaz8dvQEnlByFKXWpDWuyPthAKmZnRlx+9Nkxo8XX25M51UZnP3ZJ
         xjRB63poBciyqTWuhw41lz/GkHOVl7e22QDTaFWj9HiPmGLvwmd9+5ov5xZpoY735fWW
         xZE3z0vpB8Tq10rvjJ1ujaVT/NkweRSMnAMXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMUNzEzuNv5+/G7LTk2UNMwsYgPjYrZ+abL8baBFG1I=;
        b=QW/cHc+80Qq55+D3NWNis6C4sHsEldTcnB4luSg4a29YFyij2YWQE+pG/uJhDaxM08
         G/b4vvAQpTcNw7DnqX407T8En/Rnc8AdpAzD22HjcJ5up2agWrXMvdYfkDdpO0UWnR7H
         JR7IvJsSyNTM5VSamufCTDWBP9sU6VxrJuL/x9h6p94neE8ToLl3R910zqnv3W5Eqpv7
         Vtlm6CuJm4E7sGXbMzu2waqqNJGFNAn2bP8kfZwUmlWHOHcA4qPLR1AKl3fQQAzfef/m
         Ib/LO/9wOC0kcfDkn2mgzsQzOVkT4eh4mjrPh4fTadgpxSUeEStmAOr8/0mwS8nbdjK3
         E7Ig==
X-Gm-Message-State: APjAAAUPii14LVosKr3MmCVUm+LnWMB7H/TPNbCdUuBs7qGjiZMIKQQ8
        ALEeNsicpmOC3RfnfFFSlkw/SA==
X-Google-Smtp-Source: APXvYqw0vT4bnNimJrk86UnIp+C1drymPdpGuM6BqyJ7N3fxlEb8G+5phcT8jCw5YAydtbCQFd0LgA==
X-Received: by 2002:a17:902:a5c9:: with SMTP id t9mr2228455plq.196.1553156480222;
        Thu, 21 Mar 2019 01:21:20 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id b138sm6288681pfb.48.2019.03.21.01.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:21:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 1/4] dt-bindings: input: touchscreen: goodix: Document regulator properties
Date:   Thu, 21 Mar 2019 13:51:01 +0530
Message-Id: <20190321082104.2874-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Out of which AVDD28 and VDDIO regulators are required in few goodix CTP
chips during power-on sequence.

AVDD22, DVDD12 regulators have no relevant functionality described from
datasheet [1].

So, document both AVDD28, VDDIO regulators into optional properties since
few of the goodix chip do work without these regulator power-on sequence.

[1] GT5663 Datasheet_English_20151106_Rev.01

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8cf0b4d38a7e..255673250bbd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -19,6 +19,8 @@ Optional properties:
  - irq-gpios		: GPIO pin used for IRQ. The driver uses the
 			  interrupt gpio pin as output to reset the device.
  - reset-gpios		: GPIO pin used for reset
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
+ - VDDIO-supply		: GPIO power supply regulator on VDDIO pin
  - touchscreen-inverted-x
  - touchscreen-inverted-y
  - touchscreen-size-x
-- 
2.18.0.321.gffc6fa0e3

