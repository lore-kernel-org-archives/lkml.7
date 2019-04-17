Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB40C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6202173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QIgJrEdF";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ibfYq1L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbfDQQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:55:30 -0400
Received: from node.akkea.ca ([192.155.83.177]:45268 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbfDQQz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:55:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 420FF4E2056;
        Wed, 17 Apr 2019 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555520126; bh=kefJ10uT59admwoknv1hs5rk9yWioJDK7dziWO0gvdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QIgJrEdFxgOx6s9vpm775UDCobbGWGTDIyWrXccfAKfWs8GU2nupDD6DVFgwDYiqO
         nVob+6q7sdP7muY8HW1TxJxb0pfMPPRWI3iyP4GUYIPADDhfTvU1fWd6ky/UnAbIsE
         ZljVy74IUkuTIp0G2uLIRc9zL+D8thCZ2J4h+g9w=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MbzLa_ohFWT7; Wed, 17 Apr 2019 16:55:25 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id E03E34E204B;
        Wed, 17 Apr 2019 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555520125; bh=kefJ10uT59admwoknv1hs5rk9yWioJDK7dziWO0gvdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ibfYq1L9A3iISZGVT0wVMwNhjy740i/SlzgEEFzGY05klbo+/vyKOFPkSNRMPNjfc
         HpKjSr/KdcTsdYsEPBVq0t5sVi0ULQ42YmawyZDkexHBjwQ1YTE6tHfTtOMrziMoqF
         jnOecpPuII5LigKBiqQh+gJFQOZBVhEI4DLP89dQ=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     m.felsch@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 2/3] dt-bindings: Add an entry for Purism SPC
Date:   Wed, 17 Apr 2019 09:55:13 -0700
Message-Id: <20190417165514.18689-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417165514.18689-1-angus@akkea.ca>
References: <20190417165514.18689-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 40f632db7bc2..44ba42e48007 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -331,6 +331,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1

