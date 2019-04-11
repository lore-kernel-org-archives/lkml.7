Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A52217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoNxAH/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDKKrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:47:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDKKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so6665796wrq.8;
        Thu, 11 Apr 2019 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qACYbWibCn2NYEQtyoZ/KKRf3EQ91V9nFYFBIMWmRE=;
        b=OoNxAH/UfZWQ71k0iVbW+Nd4KZMUclCIEDuHnjYtLfggWsktEQj8t5eyskGK4f57o9
         rYDvKldzHFOtrFQSkXlXSHSFl4AP8Q6cHOgeLrzGESILvkJF6bF0KQtENGLoPxXpawwS
         ed82nuuJrmOgmtbDYT2vjKudiEGYDkXCfpUadAHZiKShGQtYZ6bfbSdIjTOZk3XebqIm
         xRONMSLQamIk6yBwYXV1iZxqIOWo2XzGpDxMdFpRbsvKEs13PPFOHBp/o/bSsFne2kjw
         uGNBpi1HUbATtdkZ+JNuaqQYT00evBBO4aEwIpbcXnKgNtmoWCkm+Klp8DEbjRcODQLS
         kr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qACYbWibCn2NYEQtyoZ/KKRf3EQ91V9nFYFBIMWmRE=;
        b=s08YPKEDC152uhU0quyv93R+Fd40FuD7OypGH96zuW6dxB5gpkoTVvhWLYdu275D5m
         pcwTBhYUPVoFwF4eKeb3YaA5EafeON+IhZMM+BNhAK9owYsxPlY9yEDkf/7xL0Lj7dKc
         JrrbrSC4EF5ZB8Ql+76VboYst7OjiMpUCdKtZ4p9n1i03l0w9u9VbZ0XT6sonvxB6JQW
         BMavLH6IuD27clhJ94gK6JTBLRucNqg86EZYPkMUkSlbimRQm43efrsMDGV68VCMJdNc
         6N8/X/DnfWl8WGAxJbTnteRlgr7u/yavIyjP34RDnvU7wihzihjJsVshDGedol18J3ug
         Ub/g==
X-Gm-Message-State: APjAAAUxcPBdpqJW5pZ7m6JY2sJt+KZsn5fFDaXlgyD93PsS6BQbqI0e
        5bt+WbXMmPc0faObvl9T+J0=
X-Google-Smtp-Source: APXvYqy9Ffo+bDiYwpkeZxK/eC2sbRafYMnlCEqnhKorcJATkTITXvDg3unrBdUlj+ef9w8kjCE75g==
X-Received: by 2002:adf:dc88:: with SMTP id r8mr8993988wrj.28.1554979658424;
        Thu, 11 Apr 2019 03:47:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/8] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Date:   Thu, 11 Apr 2019 12:57:14 +0200
Message-Id: <20190411105720.32357-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs adds a bus clock gate to the Mali Midgard GPU.

Add the binding for the bus clock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 1b1a74129141..2e8bbce35695 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -31,6 +31,12 @@ Optional properties:
 
 - clocks : Phandle to clock for the Mali Midgard device.
 
+- clock-names : Specify the names of the clocks specified in clocks
+  when multiple clocks are present.
+    * core: clock driving the GPU itself (When only one clock is present,
+      assume it's this clock.)
+    * bus: bus clock for the GPU
+
 - mali-supply : Phandle to regulator for the Mali device. Refer to
   Documentation/devicetree/bindings/regulator/regulator.txt for details.
 
-- 
2.17.1

