Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3370C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E16723711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PshT8Zyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfHaDEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 23:04:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42906 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfHaDEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:04:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id 26so3398741pfp.9;
        Fri, 30 Aug 2019 20:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYGiEbsiokKiZ5MvOpc0AKjBaUE0xFO3Aa5RPowPPwY=;
        b=PshT8ZytHxwcPCOM5tGaZycAo+7DMB9o6X2TuilJu8qmJuu+lDO5EThVnwX/fFyz02
         U2ZEbBmvDNLFkmvXpGG5XjZACUvpt5QFpAcP58QitjZNBbQRIobrE8lKH/k2Y0OwDOhX
         rfym6+ye7SMnGQp1YkF6TZJOxFPr/ciO8RREHtxTDFz8ZJtdTu+xER2AauuANEqyN/uK
         eZY1/Y9inZxd2lEiWwygFQN5mzHRwmWfIHXqjTbpd/kpw5qu+HRWZOW4prwgJ9pHHt0x
         SSvCWMOEHcPcCTK33W3xHcYYF6P1ac6/GWijr1HgQDgf84et4J7M0MvDxTW/HFTzG5fd
         0xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYGiEbsiokKiZ5MvOpc0AKjBaUE0xFO3Aa5RPowPPwY=;
        b=cIRYvUvnT9ilM68ioPsR/q/4fn69W2Hb4NHLQIuntISB8B0u3TthKbCnid1qTpt0Vw
         DQrBtFeWpYwZvLsb/RdbGm6jt+O2Vh7qpNQVszFLxNt4dTfS6pS+cAZD5RTQ/zb6DFOY
         P9MKY3vnFLjcQ7IkcgYH/wzDaOLXb7xWGNAuCkcF8eiK4cUlXrGyxcVtJrOEUPny7VAb
         tNLmxybWF3Oj6SQ2lTQ8+nj3YekisvHnkK9t2mNH12D+eI6PAYwkOvpCrn9yt0wfujln
         RvTkvQcdhRbwo+arGk+QIh5azURTvnNLZ4hn2SZJd3O0s/+kI9ieJMOfzuUTWMc4Ouyl
         QY1g==
X-Gm-Message-State: APjAAAVwTw9JtJVU+XYR2j9pRZmc8+V83O+0S4vL3H6tIfltLTUksX9C
        /FMuMLfojZv78e+zCIMjuqTqv6V4KN8=
X-Google-Smtp-Source: APXvYqw908NMPegI5hirfkJRriAJql5dmlJKaNWGJ3VRrMbz/82bw4TzQpwpgyUD4S41HAFgtSrnSw==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr15380450pgl.420.1567220660925;
        Fri, 30 Aug 2019 20:04:20 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
        by smtp.gmail.com with ESMTPSA id c13sm9423439pfi.17.2019.08.30.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 20:04:20 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        devicetree@vger.kernel.org, openrisc@lists.librecores.org
Subject: [PATCH 2/2] or1k: dts: Add ethoc device to SMP devicetree
Date:   Sat, 31 Aug 2019 12:03:48 +0900
Message-Id: <20190831030348.6920-3-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190831030348.6920-1-shorne@gmail.com>
References: <20190831030348.6920-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ethoc device configuration to the OpenRISC basic SMP
device tree config.  This was tested with qemu.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/simple_smp.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple_smp.dts
index defbb92714ec..71af0e117bfe 100644
--- a/arch/openrisc/boot/dts/simple_smp.dts
+++ b/arch/openrisc/boot/dts/simple_smp.dts
@@ -60,4 +60,10 @@
 		clock-frequency = <20000000>;
 	};
 
+	enet0: ethoc@92000000 {
+		compatible = "opencores,ethoc";
+		reg = <0x92000000 0x800>;
+		interrupts = <4>;
+		big-endian;
+	};
 };
-- 
2.21.0

