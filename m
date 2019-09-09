Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BDDC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5906A218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2l6LxPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfIIPCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:02:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36629 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733015AbfIIPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so15135086wmh.1;
        Mon, 09 Sep 2019 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5xqEYreEBmZYyAfTC+RKgBu5G8ylv8O/lVjj/QJ6gcw=;
        b=F2l6LxPMIDzdfSFMzT+toWLV47+x4sa8AwBmE6Hzu0V7pxptBR1Ne0ukW3Og2JE9nO
         7lWiTWOUu4QihXaYX+K9E1qdXUdT6i27Ep+3kNlmyeqYW5z5Hiu3soyJGhD9gA3GKltL
         f+X4rrMXmhBM8e3PhA6Y4RS41qVCksT9xEUkVv4dtlVkQZ80rwbY3GPmZ0WAkLbnYjc0
         p/dNp2mvpP4h9eSFEef9fl0iXGxt7ARatCyF3h9i9Zt6HhSxZVldJ4Kro1lzGAF0swj0
         nH/vgwboS35iDkZn50CIqf8s+yAJQJaitlqHsKnXpfALCcNIz1tEFNI+vtYBMH7fw6Tx
         eYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5xqEYreEBmZYyAfTC+RKgBu5G8ylv8O/lVjj/QJ6gcw=;
        b=mDkQW11t+XJtlC9XS/goxWyq6FaLj1GQogaYw/nN/132/FEhaZHqlFFAvf2Tj7jtJM
         wCar1EsrkMhncnQ0LUqhRej3FCTs6TO1OXTI22+cqootg8GVZK9DUv+YHRNIN/0GQhVI
         nkX0pJCW7JSm5o+I+jUXksBWY5I7UcUMtQ4qyhqqkNNcTfLW6k++BTK0Bmu1/zgENf48
         96FMLYYrSRAcDjDtKwfoAeSNldlCJISRCwb2BIs2dWPMbrjVdOmHaHwfk1k3ynq4qEm0
         v+w5KEc3SvF+MfqWm+jIAWb9m9XGrwDpXStaoDLU7O9A6dyqihoXqOdxhAUtRjpKU1XH
         AvSA==
X-Gm-Message-State: APjAAAUU4Z8rmTfqkX12EKLQQtqfJp85tlEqACybUxz5NkBZ9vWTfraH
        wqxw9u0zapfJExtC4HljT4k=
X-Google-Smtp-Source: APXvYqxUDRLwK+SyWE8xuL/itq7LA23ccybuU7D+8c2JjcNssmx+4Hg3o49fxC7xXs89sGfOZc2KRQ==
X-Received: by 2002:a1c:c1cc:: with SMTP id r195mr20418891wmf.50.1568041345217;
        Mon, 09 Sep 2019 08:02:25 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:24 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/6] arm64: dts: meson-gxm-khadas-vim2: fix uart_A bluetooth node
Date:   Mon,  9 Sep 2019 19:01:24 +0400
Message-Id: <1568041287-7805-4-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 33344e2111a ("arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 989d33a..d392062 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -409,6 +409,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.7.4

