Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1094DC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91AB222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jNq5HnLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfIZTlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:41:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35736 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfIZTly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:41:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id a24so2113990pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCdvhJK5Y33A40LvwlOqP+c9oV7vBA4MZOHiplNr5PI=;
        b=jNq5HnLzdx9zDeXvjADUPS3hRpiC0NWfwCYgLSypfyj6AYhkTHrvoAV00tYwQ8uJGh
         nr8RCILo8J0q3uv+krJ/04dCt5OyVCcou0yvOJH7imD18oaypEtYZxZbYPzdiyTARz0b
         N+cOdPC0H/3TtVke352JCWaVl7LyJdyqMCVA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCdvhJK5Y33A40LvwlOqP+c9oV7vBA4MZOHiplNr5PI=;
        b=jSGy7jTgdQ8Ru35KjBJwAPAfJFpHcsgNzwz4stGhl0LxZ4raXFa1DN4J91rGDVbrtF
         RrJt5HY51EMgZClZn4ze0cNp0st57N8pUTUq59kfHzTphsOIRoOxM3IcDIBac+uvMa4/
         oZt0apcw2s4mMi8eWNXiYW6hc6u6oEqx9RPFpeIYhw3e2D6hHc3XUMSY05/Jr4foigNT
         ALDmJJZMoOiUjoQxFyONWNm33HT3C2Ft4K31+RG0lSXgZPoe4anl6ClUWCD/Hv10p5nV
         7PhToPfkuB/cM80jZ3MHhTr48MNovnpNyIPaIJi6S5RxEwPAz3Hq4LGRr4nyHuc7yxB1
         dCZQ==
X-Gm-Message-State: APjAAAXZ4o7YzeTrM8lVWRnJgHau+ABmQwPA1mNpmg5YDzI3ovoNWJaa
        4pH3SyotblN+r9ZJZwQ/OkO9Rw==
X-Google-Smtp-Source: APXvYqw7IM64AyswWgfGemWVQ/MeMyINgZpNzkZliB4f0D+or4raoPAglmEcQy3+09YYJ77Bb/tupw==
X-Received: by 2002:a17:90a:850c:: with SMTP id l12mr5561826pjn.9.1569526912255;
        Thu, 26 Sep 2019 12:41:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 8sm2986363pgd.87.2019.09.26.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:41:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        ckeepax@opensource.cirrus.com, zhang.chunyan@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] regulator: Document "regulator-boot-on" binding more thoroughly
Date:   Thu, 26 Sep 2019 12:41:18 -0700
Message-Id: <20190926124115.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of "regulator-boot-on" was a little unclear, at least
to me.  Did this property mean that we should turn the regulator on at
boot?  Or perhaps it was intended only to be used for regulators where
we couldn't read the state at bootup to indicate what state we should
assume?  The answer, it turns out, is both [1].

Let's document this.

[1] https://lore.kernel.org/r/20190923181431.GU2036@sirena.org.uk

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/regulator/regulator.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index 02c3043ce419..4e67fb41db6b 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -38,7 +38,12 @@ properties:
     type: boolean
 
   regulator-boot-on:
-    description: bootloader/firmware enabled regulator
+    description: bootloader/firmware enabled regulator.
+      It's expected that this regulator was left on by the bootloader.
+      If the bootloader didn't leave it on then OS should turn it on
+      at boot but shouldn't prevent it from being turned off later.
+      This property is intended to only be used for regulators where
+      Linux cannot read the state of the regulator at bootup.
     type: boolean
 
   regulator-allow-bypass:
-- 
2.23.0.444.g18eeb5a265-goog

