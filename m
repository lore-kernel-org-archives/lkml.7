Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D8C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B015218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KLn+NGOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGYVa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:30:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36605 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfGYVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:30:56 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so100489048iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=R34sE2QqEpGg+rOjPwslaDj/217UdV8AQ+/1Q6RrkTc=;
        b=KLn+NGOIueZ8ofrUSfHzFju02ajAJkkF2J8Q2OptIXHTJRh/RqWGa/B1iIT9/yd3LF
         14UOzf7MlJvZg0zZGEUYTLO2Bb3n01EPo5k4Q5W9dmFcg+/YM/KraPaLk3d3zhYCBPtE
         20dQoIBbfsEEpAtgOPFWksLy8ZODBrCDnc/vb8jr3lD1mKu/abGriNWaV/6QKlWmM7+v
         VUnDwSKeDtSNJJODGK2mt0EW5xpIm/9K3RCq0CV7XpCKw0pofYBRjKrFmsARi52b6Axf
         JM2XkL5qr3m3gZHe5jn36yfOe5dxDuO2I1fCNKy5eXpjshNf5zJr65zb9e/UjZQC++Jt
         f2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=R34sE2QqEpGg+rOjPwslaDj/217UdV8AQ+/1Q6RrkTc=;
        b=hXFiGv9ME/QF4QSuG8YbEi56/jaSaNCdM1jKXahev0+0uMfzFXrhBIPl7D9vdF76cV
         b9bcQ6ynOncHSlaY3UQ9v5KTeF8RsXQKtgFtrbjr40vuOR8UYaDjZa5UzYvDQzDOCtEU
         QviaMavDbFTVs91ZFMfgdnUELRX9+gvWo5S9XFVjIX3xWxCGan3Y/7+/0+L84FNni5gF
         b2WhE3+CT7qdIcgDzQvvlEZpK1HbqjYO0uanI/g5dEqbS82Nwn0r4iWRfAvcUzt8kS7O
         y3yJK15qhss422fZxEoQLFwKQa4xolzUU7N45LAj3lCipcmjXOO/d+d9aEIWhSRP1u7L
         rbJw==
X-Gm-Message-State: APjAAAVu0jUuM+XQ02Wr+kZxNJ97+NUQaN5dcCxWo/CUdTkSzUQdj/5t
        jbA1Yj7qFf6Xk7yle/uJmrXTAQ==
X-Google-Smtp-Source: APXvYqwVgEhvXkeqHfsRpK6JJQkcVYIip6G1SiuqcOLAHGGxZ9wHsmUDxl5+2sM2lJCAvov5rFgrGA==
X-Received: by 2002:a6b:f216:: with SMTP id q22mr44503183ioh.65.1564090255407;
        Thu, 25 Jul 2019 14:30:55 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id d25sm40703267iom.52.2019.07.25.14.30.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:30:54 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:30:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, palmer@sifive.com, devicetree@vger.kernel.org
Subject: [PATCH] riscv: dts: fu540-c000: drop "timebase-frequency"
Message-ID: <alpine.DEB.2.21.9999.1907251429420.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On FU540-based systems, the "timebase-frequency" (RTCCLK) is sourced
from an external crystal located on the PCB.  Thus the
timebase-frequency DT property should be defined by the board that
uses the SoC, not the SoC itself.  Drop the superfluous
timebase-frequency property from the SoC DT data.  (It's already
present in the board DT data.)

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 9bf63f0ab253..42b5ec223100 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -21,7 +21,6 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		timebase-frequency = <1000000>;
 		cpu0: cpu@0 {
 			compatible = "sifive,e51", "sifive,rocket0", "riscv";
 			device_type = "cpu";
-- 
2.22.0

