Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B0EFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013F7218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc5v9DBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfKGJm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:42:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39167 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfKGJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so2253370pfo.6;
        Thu, 07 Nov 2019 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itXp/vDqhHYMcsOhBE4Lb6epcLCaR4BGpG1zslxBhRk=;
        b=Cc5v9DBGGv59y4S5c7w3BAKGlgux8FvfqN7hYf4ErrnQ/We+woYIxx5te3ucWu4ZoF
         8q185rdwW1WrKPUnqYS5uY1Et35kDRkfXWNvHJ3KV1+PCM4Wnb09IuDnqiS7ejLJ4JoV
         2vFvRKGcV8wbe2AIehLT/qKg8b+ezul2JWl+eJNAOI3x1U9MsZPaM/rBFysw3h7SoSMg
         Sw+hLVcPw9jkCSN6F85LL/ZgZi4EeuNoHU3iOav8gK3XC66q7dHi1+On1UJe3jokRkuL
         Oed+oKFyi/ftKSfooSXTn870ExZNskTVnaRveBNVX8TKF7uWVbP9+utF2oabuUGl5d8P
         939w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=itXp/vDqhHYMcsOhBE4Lb6epcLCaR4BGpG1zslxBhRk=;
        b=IhIQsgclnR8SE/SmuoXiILwKQfZRdJAtW/IIgiAOWYdyK/92A3ujJrPKRpo7U2N7gl
         3uO1+aU5fCuZ5M4OhYJVcBwm36Z1Y8JU8Vpcw7VDOe101zM8DuSoA3YdPCdj+zkVbM+R
         jWaodWiKu1oxGPBOYDIKmXx695kWA07WKhLvO03RizvPlpxqv1CGCRg5hZt1POjHlkcW
         9VnKZV6+EAr7sPIah6IpyvSjzQZzYZK+ttXlD1ZqgmdSeeVblGBgjoUWu1/kZeLTLC4h
         whwc0r6eY9amU251Tr20uYNhE4imv/BBOz8lyBw7Un2bEttIzQ+qJ15JV8qhVp5eAEUT
         9Aqw==
X-Gm-Message-State: APjAAAXmkM7xp+xMPCZ9T8rBeZjZAXErRAAaX6KQMlFlkgV8BMHQSPji
        Eg24gP7Kk+66gAdHVAqKWrE=
X-Google-Smtp-Source: APXvYqx6i+XNW3wKSy1uugKeO5GmapHvlicFFeX4CGHx0TkPuZzVaw0mPNKdNljETG8kv/65+vgNfA==
X-Received: by 2002:a63:2506:: with SMTP id l6mr3355808pgl.131.1573119776554;
        Thu, 07 Nov 2019 01:42:56 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id 12sm1958195pfp.79.2019.11.07.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:42:55 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/4] dt-bindings: fttmr010: Add ast2600 compatible
Date:   Thu,  7 Nov 2019 20:12:18 +1030
Message-Id: <20191107094218.13210-5-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107094218.13210-1-joel@jms.id.au>
References: <20191107094218.13210-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ast2600 contains a fttmr010 derivative.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
index 195792270414..3cb2f4c98d64 100644
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
@@ -11,6 +11,7 @@ Required properties:
   "moxa,moxart-timer", "faraday,fttmr010"
   "aspeed,ast2400-timer"
   "aspeed,ast2500-timer"
+  "aspeed,ast2600-timer"
 
 - reg : Should contain registers location and length
 - interrupts : Should contain the three timer interrupts usually with
-- 
2.24.0.rc1

