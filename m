Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB729217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Odq5GSjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfCONtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:49:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCONtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:49:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so9648656wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6dkimrea4AT1s+E1iMTXSF4jCCI3pHk/sEomO/wsiE=;
        b=Odq5GSjdCdv24A2JQH1SJUovV5jeyfw14Cw0Xl0yto2OdVZNVzjX7Up/HFAsW1a2TW
         cZsev3KQ5/6BsSSx/1zIW41fa6HnUjip1ByaRFRxqnhJLRQZylb4ukV70BTrrshwwI+S
         4ii36AkxQLA9BE0fmgtJNdA0KacbOZMebFw+go3aMcwJgEv1Q4168G5dcaWQZWH2oQeh
         3f7f+6BhmuovZroziorJvgiU3x+mF7YVadBjss9xAwHXxFTd8OrqFv4X5Qo4lsZ5gBVq
         IC7EZqCz9FUywj88J7jjzW/vAKbJQrH2QXXRfLYImHeCI28CU9yVOPibAAUrd4cGuevz
         f8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6dkimrea4AT1s+E1iMTXSF4jCCI3pHk/sEomO/wsiE=;
        b=FBzz0+0UildTcHWAYREOQutayoYoOF9KYuRnFusufaATmNK5TkeGK89RTQEPnj3Z1b
         hbucXD3m78PhvzRrRDQvRX6IO2vRnfk55ZDSODpE+XtirElR0A5VYfJ1dg/Xs5hXOYxi
         2aPaepckE9uvSDmTs4EalWHoc4nLhb8lKiPQORBblQGq6g4H0DywmYjCX2bTNf/BGk8I
         4wsDkpiPRmsREH4xyuZDVHCQdsDzITGA28OpbmqtcKD6HAIxYQ7ujRyin6Eg+tutFDnF
         ogkXHXmJde6GkgtMpHN+XOpgYp/8zWbg0/G68YKeQbrBoy0DTd88Fj4G88PycVX8ty4P
         t3Jw==
X-Gm-Message-State: APjAAAVFeU5szPrG+cGfg3Y56xozw67ZmDhN9IDTukDYMqn3t+/nvE1A
        do1Yge82qm2ENgKeSJLg0rNL8Q==
X-Google-Smtp-Source: APXvYqwLVrPlvJDRPQXhEzqYkuwMsZU7+fV+CXG/F+V/ner4sGg6/AUD7uvM7eoF/IHjWsH4PzQ6oA==
X-Received: by 2002:adf:f70c:: with SMTP id r12mr2734678wrp.54.1552657751176;
        Fri, 15 Mar 2019 06:49:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a2sm1630516wrr.60.2019.03.15.06.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 06:49:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-gxm-nexbox-a1: Enable USB
Date:   Fri, 15 Mar 2019 14:49:09 +0100
Message-Id: <20190315134909.26721-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB on the Nexbox A1 STB

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 8acfd40090d2..25f3b6b14043 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -178,3 +178,7 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb0 {
+	status = "okay";
+};
-- 
2.20.1

