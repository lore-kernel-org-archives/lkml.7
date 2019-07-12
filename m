Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C0C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097BF208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8hcH3V6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfGLUnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:43:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33721 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGLUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:43:23 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so23318034iog.0;
        Fri, 12 Jul 2019 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g31FrlFxuFM+xjFOCSjFHeI9OKsmJhFCkAkzNbx5Z+4=;
        b=X8hcH3V6OicPZyF+iBNl9yPFRYodLfeLabhL+gDENEtdOmHpWQQWe4jKCac6IbEqHv
         SnxWymnXOjRXXfhUZUBqZcfoUvFOBR6GoNp5IR9Gl9j7r+U9+0xdbn4I7Fx8XHOk6VGJ
         xiN7yncbQAeudz/U6f7RULTrnHlFEmofos+cV0FAdsWtn1UNEzNSWs2eE8w8v+KJ0oZH
         nG3MdR0F6HHV6Aw4LMrPplHeY7rUwYlbPAJtKovFIcbYUH7OE+oy89k0rBwf0i9z796O
         /i8Gz/HDdwkyZWjyAAIXr5eya1IKO4ue5S9UOEW2NGA3k/j31KZT2NLgraOp46zMH7um
         a9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g31FrlFxuFM+xjFOCSjFHeI9OKsmJhFCkAkzNbx5Z+4=;
        b=gFIVlIRT9zMFnAyT4y9PnJM4nisPBPEBrlWOz/Yz7tX64aC2X33dI2bf1KmQGDGXkv
         SH3p5iV3I90hyNSY6DqmsntBMunto+3WYPYaFYn5ZhV1BvEmHM0A9GRlcVVrLivfsdT9
         xhEVHrKrltKkWKE6li9ZxIBvzMoLupmxEhY+WdxlTFzdeEYvzaS+uadeA/AL0cArUURb
         XUqsEYhUusP8FI8KDd6g6aWHzK4tQQ5aKvW7/sUGlnA31/uH+qUld47J+Wnz6+ZchJIH
         jU3kUp6qdZ+QX5GAw5I30IC6Pjm6YypTraDgxV6/oYOU8eJUiIkBQN4E7OspGA5NRFoP
         PSwg==
X-Gm-Message-State: APjAAAXBCCYWKsG5VDC5NtuuA1UEW58aucxlmpo/9FAxVRSGEeSg60Wf
        7YNpwuZoGWeVU9mPEn7Xtx8=
X-Google-Smtp-Source: APXvYqxP2f2F9YZvE9gZj+i0IHuwbPUIDjLymCmzm8DfSmRxw+Mp7EzQ4drKtvZ8S8QQFWtaWNWzQw==
X-Received: by 2002:a6b:ed09:: with SMTP id n9mr12266556iog.153.1562964202986;
        Fri, 12 Jul 2019 13:43:22 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id l14sm9725013iob.1.2019.07.12.13.43.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 13:43:22 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] dt-bindings: bus: imx-weim: document optional burst clock mode
Date:   Fri, 12 Jul 2019 16:43:16 -0400
Message-Id: <20190712204316.16783-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712204316.16783-1-TheSven73@gmail.com>
References: <20190712204316.16783-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An optional devicetree property was added to the imx-weim driver,
which if present instructs it to operate in burst clock mode.
Update the dt-bindings to reflect this.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 Documentation/devicetree/bindings/bus/imx-weim.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
index dda7d6d66479..1b1d1c5c21ea 100644
--- a/Documentation/devicetree/bindings/bus/imx-weim.txt
+++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
@@ -44,6 +44,10 @@ Optional properties:
 			what bootloader sets up in IOMUXC_GPR1[11:0] will be
 			used.
 
+ - fsl,burst-clk-enable	For "fsl,imx50-weim" and "fsl,imx6q-weim" type of
+			devices, the presence of this property indicates that
+			the weim bus should operate in Burst Clock Mode.
+
 Timing property for child nodes. It is mandatory, not optional.
 
  - fsl,weim-cs-timing:	The timing array, contains timing values for the
-- 
2.17.1

