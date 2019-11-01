Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633ACA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6C720862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKlSmGu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKAObq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:31:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38556 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKAObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:31:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id j30so3121068pgn.5;
        Fri, 01 Nov 2019 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FrXDkN5ZNQ5+RGqx6Mrb8PAqmL7u63EHey24e7/ywQ=;
        b=oKlSmGu0l/QNsOmfcHoqvh5d2HYh7/VJfA3eELWS00z9HspCj6ziNT3qNtmtXxVKhG
         /vCFVTNxv+a7lZm6fQD+5HMGXDtNWu4ixskrHf/fxeAKHOos596BB/JiRvJ755+4vnGM
         nMb+cz/eWsPvmTC/FtInM60g+zC92ick5Q0KU5+4pkYcDA80pFrVBk31mqtWezAyU+7v
         O8oyQgfEzBDPa0Rv1Cd0SfY/do5hILcfNRMFbg+3UNg5pNTe191UC7s7l9QZjWRWFv3V
         rGKWYvmp9uaT0wQq/UmCj+HxrZRHN46GnjnLKx7uNHJbzXRjRQj1wvn7QSodQnbJhdNT
         lsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FrXDkN5ZNQ5+RGqx6Mrb8PAqmL7u63EHey24e7/ywQ=;
        b=JjXz426KuICcptjk1iIrF5q53usHBZFl5twsdqISZcUitlY41qCFiJ3wfBtQBdepIZ
         xzhFh3SWL5k0Q3x4tovasogxE+SacFMBWm9nls3JOpR5CFcbKPfx4vG7Q/pxhj/chv/2
         7brFywGM4RVep+/pCg2KKviCepqLcPyh4HChAgfC4IP8sBCSG6cf7PIO7iqLxxxrW27e
         wVXg0nQrGJ7Z9BTC7iztTIF6iQCMzL5ng2t921S+Za5wTtK3RMQxEzlRKCZlyQCvqqaf
         gWftpehqpFPBWjC3irUJQfbs+A8KGVMVKB6Qxz2uX4vcJfNkt3fYhCKNrACdasSsH1SK
         B8Hg==
X-Gm-Message-State: APjAAAV4vnaKnJC1eiyPJ2+zvZunuw3KO4Qzjpybx8B3YkvG3YgENMNc
        TOMfPYu6/v4hMgdBfH+HWA8=
X-Google-Smtp-Source: APXvYqwMma5R3MDVUeyvdrFzn/WU1yusLdcF5o5dfhV+xy+nI2ygjZLpe9NmzO0LZq+qPjbUw3w8YA==
X-Received: by 2002:a63:1c06:: with SMTP id c6mr13721047pgc.417.1572618705268;
        Fri, 01 Nov 2019 07:31:45 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.165])
        by smtp.gmail.com with ESMTPSA id x9sm9273061pje.27.2019.11.01.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:31:44 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC-next 1/1] arm64: dts: meson: odroid-c2: Enable SCPI DVFS for cpu
Date:   Fri,  1 Nov 2019 14:31:26 +0000
Message-Id: <20191101143126.2549-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101143126.2549-1-linux.amoon@gmail.com>
References: <20191101143126.2549-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable System Control and Power Interface, DVFS for cpu
with setting 1.54 GHz as max freq in the initial SCPI tables
loaded by the BL2, i.e. packed with U-Boot.

Fixes: f7bcd4b6f698 (ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
In discuss on other mailing list thread below.
[0] https://lkml.org/lkml/2019/8/30/186

Tested on mainline U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
on archlinux distro.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 6ded279c40c8..9678784aa1a9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -307,7 +307,7 @@
 };
 
 &scpi_clocks {
-	status = "disabled";
+	status = "okay";
 };
 
 /* SD */
-- 
2.23.0

