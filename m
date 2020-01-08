Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B700C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1593920656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5rGatZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgAHUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:54:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgAHUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so4975767wrr.1;
        Wed, 08 Jan 2020 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z9FpZJlsxfrtEhSFDySWhmw47lo8JbRtU9wLQFcCMME=;
        b=U5rGatZe//rnw7LVs9WeUyct2qy98AEqNUq+h00gKjRMmzUpzdKhHvMsn7GIEgXN7v
         d4ZvQYcSJjIvbv5jT6sso1Y/r+OjO7J9wyD2HSjInh2ZmHYUbsWNIDiky2JowA3yfLZZ
         LK2ZCes/u2fcKMGKO3BZw/fq/gI51a5LyGKcP83TIOENNnvKWwm824Gs++okVFTRDSPl
         GUpsSp9AfHziV5XY7P1fvMxzAilTc7NgBqHbH0lr3AQVjC/V6nNmwuH+E7KnAYmlZZka
         A0sxOEgo1F8MVyu5OhDr+lLjfZpb1gxbOu0YNEWGBRIwABrW+NuxPDU+PsyQkFHyeFhK
         wwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z9FpZJlsxfrtEhSFDySWhmw47lo8JbRtU9wLQFcCMME=;
        b=QMKdnB+1RIYV+L+CWpQjOkDhEbJAa97o4Lct7EAUyXh1rPwEilY2u/tmqYoZHMgjh1
         ZFgASehUbBtLGSGuWomUvMP+00SyuQsS9P14G8QBWvdpJyRIVsovpFPgTI71KvvnLWGZ
         bDu99GDP8YmcoNliHh6EOKyIxGiIViNHmN9q2syXDP4meO9e9E2a95xr0x/ysiT+1ag+
         H3z4nIR6HnFcaILkaSOUbfTSDw1aqrO2XmGHpo9+Ij9KFu4ME6C01+ugojjSiqZWYtJa
         AJPXz0IpB+T57TCIntx54wVJ59Ax/AMoP0vcMGPWefEaYgBhXNHNO4vv45o2mgGKtjDK
         Qogg==
X-Gm-Message-State: APjAAAUmJJTd0CtjJhaFLQlhuDMTViE8yXLBL/zJhqAfPzvPFipQT5Hq
        qOfUmEdNTo8HdUTozMzE6Ms=
X-Google-Smtp-Source: APXvYqwXzXwExy8tpSUlLOAGKe/8f/hfhE3ktWZZB/KjAShEe9kZZVaRqFTuXVzm07LUOTs/i9R4VQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr6734725wrp.1.1578516836849;
        Wed, 08 Jan 2020 12:53:56 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:56 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 10/10] ARM: dts: rockchip: rk3066a-mk808: enable nandc node
Date:   Wed,  8 Jan 2020 21:53:38 +0100
Message-Id: <20200108205338.11369-11-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the nandc node for a MK808 with rk3066 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 365eff621..8928c9345 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -133,6 +133,15 @@
 	status = "okay";
 };
 
+&nandc {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-is-boot-medium;
+	};
+};
+
 &pinctrl {
 	usb-host {
 		host_drv: host-drv {
-- 
2.11.0

