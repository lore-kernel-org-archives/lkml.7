Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E479420815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U4DhVvCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfETUIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:08:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39558 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:08:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so15997373wrl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzyK0hwlGllQwpUASaSXDvSJ4lCGjRcRs3B49LwTWQM=;
        b=U4DhVvCK8cGR4sjHiPqsoKZBv923R6m3+PqlKY6yM9WbcNPsiSGWSp0EiyVkyZQqNU
         QuyIQdQHOfB59b1bQmeTkp7KSzfQ5vZVmVyuHzJADG6uOlivsXM/JZ1gG42q+MhfLtbg
         KV5WlcCJjQaLzR1CX2K1bud2XDiA4mZtCsfZ7fzqx9GsiyTDNZWzC56Jv5AG4JysZrRE
         kFFqhJyIQ6qzMHcn38KuOn6OAr28Y33HQg3zN/qiRNrht0nCJPF4M/t1T0B0QJihgvMX
         11eZ+8WDcFIw3y8ELd8nApvIHH9kYRdPeQI25FszQntrjrxjlO+UZ6XUMIdpQQVb+bj3
         if/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzyK0hwlGllQwpUASaSXDvSJ4lCGjRcRs3B49LwTWQM=;
        b=uQhdMznjvYE/4EvO7UoFAmkwdu9F8BljQ2KGGMYCkDme9fHPmRhAETYF4N+kxEARWB
         fM4vcNi/8cvaTDmEWdNDL5jw80Es93/q8cOdMPFw+xhIVQSzEpSwKr8y+Q4EE/3c78w5
         jxhjQRbAYIGMUwcczILe3uhD0lhL9LwoynJFAi0PYIdsUF3YnrdwOBoE0BwE1WLGSaSP
         WrVbp6diYvpdWsEzA58gp7m/YBVx/T+Qq3gPbGDVAeQDro+ERw/avrbT4pkvlAysX8Ck
         CY+m1yNa9uakPmbBIDmgvPeXBxVdnbUQ4q4a5gnCdZ7sQj/p3JIjLffHlPo+Os1sIIX1
         sx5Q==
X-Gm-Message-State: APjAAAXg5eIMY/CiG1+wACtQb+vKuTZHzY7qLfKJ/cAwT6IQ0K0NVge+
        FBdg+580ze2TQHWSUGFImEM=
X-Google-Smtp-Source: APXvYqyKxze095fP1qavF8T4ed1d3zUmuovjiLWGUkszU48aPxDoxCWtwfyiPggxWuH+G4Upbd/zJQ==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr28290659wrv.254.1558382928917;
        Mon, 20 May 2019 13:08:48 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id i185sm918627wmg.32.2019.05.20.13.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:08:48 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     balbes-150@yandex.ru, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson8m2: mxiii-plus: add the supply for the Mali GPU
Date:   Mon, 20 May 2019 22:08:39 +0200
Message-Id: <20190520200839.22715-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520200839.22715-1-martin.blumenstingl@googlemail.com>
References: <20190520200839.22715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali GPU is supplied by VDD_EE which is provided by the DCDC2
regulator.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index c7d9cf035e22..59b07a55e461 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -190,6 +190,10 @@
 	};
 };
 
+&mali {
+	mali-supply = <&vddee>;
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao1v8>;
-- 
2.21.0

