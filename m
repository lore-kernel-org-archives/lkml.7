Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132FBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85FC208CA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SGuzD8+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGAL5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:57:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfGAL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:57:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id u18so5361869wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWBpEvn4nRZz1cmchO61KMpCxGabkWCJ3N6fsTIImxE=;
        b=SGuzD8+l7yIVTo4NJFrk5PQLhWUNIRIl+L2MIiLrNt2+dqP7uthb9y+UvZlfRDiShW
         W9SI2QjMio/nGjOHqcbJUrtYFWAYdaar70RuhUzDf9r6paqbgSGD8gdsYZlJYoWKJJye
         spj31of4THSKTqUlWnaUqUFe1Oi1R/mcK84Nes5jYXa16piAAdAAxckeWVeWVRfQU55u
         F3SiwkKDc1lKOO++wQwy9pM4QE7WV6NVWX3zRFpe6pSzHeC8xL/yZPwZr8D2frYayYRT
         gDFGy0aei38sRKxDcgPp/k1TdKS03J5XWlol9PzE0Q3G2sHwFFd8/8q1Ripa5qcoAj2/
         gFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWBpEvn4nRZz1cmchO61KMpCxGabkWCJ3N6fsTIImxE=;
        b=mNtWnKcg+Z+/jiR82+GYIL4jYWM4fWmkswB22TbTtthP8kmGEF6ms+5E5/qLNJgw5a
         u6l9E/rYwuKZblSg2qQeVGS+BslssSNetU8pfyVJajYHhVz1/e1KuccdgF/PMDMNUDjT
         8g+CL796M1ev4k0MjG5Hxhosd3/Zh/HKMf8IpdnDDOrNlwHKXH9hH1dQWQ1JQYgAzUED
         +MaV+7ihwjKMhRQCyMxXpkvwm40Z94BvejsrdwIe31YwypllfXYQWKPQageztzkrhmUY
         J0Ej+ViwP7HANbJDNNLQMKsx0TX1H8auLg7qFWBHupRq6N1CUmk3y5WhKkRZ9dsdcFpq
         jePQ==
X-Gm-Message-State: APjAAAUVcaExsQCbQqwM8+5LCIsWl8DeUxC1ATCF3UzpDj0yBj7d8Egh
        UMQhAutE6wZ0XysljUdFRLpqLA==
X-Google-Smtp-Source: APXvYqxYE/6Py43lG5VkCd6ZaToMDiKOWJY63MqNtt/xP+N1a4IkXdPwDaoToh3uN/qzhr9j4omYOg==
X-Received: by 2002:adf:fb8d:: with SMTP id a13mr18930522wrr.273.1561982248294;
        Mon, 01 Jul 2019 04:57:28 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id w25sm5660944wmk.18.2019.07.01.04.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 04:57:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH RESEND] arm64: dts: meson-g12a-sei510: enable IR controller
Date:   Mon,  1 Jul 2019 13:57:24 +0200
Message-Id: <20190701115724.15801-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the IR receiver controller on the SEI510 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c7a87368850b..12aa7eaeaf68 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -339,6 +339,12 @@
 	pinctrl-names = "default";
 };
 
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
 &pwm_ef {
 	status = "okay";
 	pinctrl-0 = <&pwm_e_pins>;
-- 
2.21.0

