Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B702C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8C02184B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adjbLfK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfHYECb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38323 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfHYEC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so12674227wmm.3;
        Sat, 24 Aug 2019 21:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zELEUgSsCN+8CRAOeDo9/h1leFLyd06lkasS5K9oq38=;
        b=adjbLfK8fidX/mMusGXjbEyvbhpLmfP04BYSiiwz0j3ALh42WU/gfYLDnik2D9ViPZ
         Z1601BUxrJD3wVL+8UTRUOcLekPV9VOFO8HA7Lqtixzkxki56TLAgkkcP+EcNytqvfXx
         jWYFLpe1evjM6sYocwV40uE5J6KZZ34WJ8Lz/IZZUUlIkmkb3gmIjNe7B50r9smKqqHs
         DA2TGBkKZIREM6sAZ6Bfb97Jvl8u3Y3PB6o45kjHWEZUoVVrLZ3M8PP+zYXDypq9RpL9
         HfT4NdfnSZMfV/6JGpSKzRFeFmLUXv2U9XjVkQcEUNAEM1wdjhJR4OrKBkIfWDs49D+E
         FZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zELEUgSsCN+8CRAOeDo9/h1leFLyd06lkasS5K9oq38=;
        b=MIN9F3g0fk41cH5eMbcVh596ubpmi1lWQhTGPKVrS92gtI3xsmbWs8TdMiby6+UzdJ
         kotGHfq3I4lZQPmKfcY8xm++5aLnx/bx8rmDT8Hc1325CgJHH2g+LcRXA5av3aaGsZVh
         /oWHx66MBbxHMH5oHq/WzJ9RmbmsOpm7LIeDVqIuGwuJISakOOn38pRwaT6u+o9xfK5u
         MTGDwvHcVvWfx9UBcH90mMOHjT5o9e5dEs70jvq7t800wRDre5IFOvAIT3r3bD7NWlB0
         RHpclal51huCy9Ne/JjwxGdtnpJY9wwQ4NHTfHtem/9ldhx/r/sQgoNBH8PxKOHVPSrf
         UuPA==
X-Gm-Message-State: APjAAAU5BA7g3o3j0SfnR/E6N8YGg852MZ2yP93aYu1cUHdlPQW5wJeB
        IPi3mJEr6Bop7TVXI0CQG+c=
X-Google-Smtp-Source: APXvYqx4cizF/w/NxjuQDhehIndoZo3vHd5SzkH1pDdj55nTy14mvcbc2b5y15qoEMJmPp4mbQ91iQ==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr13836550wme.152.1566705746188;
        Sat, 24 Aug 2019 21:02:26 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:25 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/7] arm64: dts: meson-gxbb-wetek-hub: add rc-wetek-hub keymap
Date:   Sun, 25 Aug 2019 08:01:24 +0400
Message-Id: <1566705688-18442-4-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the rc-wetek-hub keymap to the ir node

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 2bfe699..83b985b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -12,3 +12,7 @@
 	compatible = "wetek,hub", "amlogic,meson-gxbb";
 	model = "WeTek Hub";
 };
+
+&ir {
+	linux,rc-map-name = "rc-wetek-hub";
+};
-- 
2.7.4

