Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9191BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A5217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IoMj7wcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfIBQDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:03:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35035 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfIBQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:03:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so4480364wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9IqFz/rCcEzO9sp+80zoE9eGKQjzJcJCmdp79nsgKY=;
        b=IoMj7wcRG5nrP1XZaokIgDQnJyPnhAsLUVzLVD+Y8a8n/Got9Tn4fTRNNAJzAJb4ci
         byoY/In8Thaj/JTsbIo2F/izij0ckD+1KyFNX3wY8oWfSTBPd5Gqj9cUf7Lt5H3ol542
         zF1TAGtzpa/at4wONaXeiX8rsnq68UC7i1L/8167bMVgz3eIW16ogAVrL3PAz2lkb3bU
         JsqtrD4Ofl+CQFrU3p+7WyLY+ze5o84brxNX3Yfkulv0WB3GeuAGxguHff6ZiE224lHm
         +cTpR4N2jhxq9kMz2Z8/Bfd0jxDNQH1Jsq3avRw9Hdgm5QLOZ57HePqlFyDSNTOYb+du
         nKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9IqFz/rCcEzO9sp+80zoE9eGKQjzJcJCmdp79nsgKY=;
        b=LfiWGzrKo8TQsbVOzTTqLLQqNA7jdZI/4EiXyz4lfFkYkb544d/bqrtfVtSACQ13z3
         rtRzCBZ3BycpIA+fFsgS9t4r+SgoLWIexkOHNFigRoeLYZulOKGTvkt2gF9jmNDVBOoY
         /TCvxvOaJxqhbe84buE9XHdvB3iGj82vBBzR/WBFfL6GK3JRqTk9mjj4Ydp6jTKJXwhK
         KAxEwBhdtbL2QF7QIokioJzOcJtI0NKowpwGHDyYPI2UIG0ApfUvAW0Oo2MwBXXa0Hlo
         jHlk4hM3AZsGN/+qiy/NPSPIckXCCymH2+XRrxurllG/eN1Ey4nY4f1FkoxOI3YKYq77
         +hZg==
X-Gm-Message-State: APjAAAWZoBrcILVdJsGwFKYzYYrXufyJEk4ieyo0aemzbPUXjBhFEFvM
        wH8wdRWQxDH/ObJUAvqEF079ag==
X-Google-Smtp-Source: APXvYqzzmST/34EWEs+z7TaicJFBkWqMl5acy9cm3cF71CYOV64yFL+lf6O3kMjOc4sDbgGKLWB+PQ==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr36009973wmh.39.1567440229675;
        Mon, 02 Sep 2019 09:03:49 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id f15sm7507365wml.8.2019.09.02.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 09:03:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: sm1: set gpio interrupt controller compatible
Date:   Mon,  2 Sep 2019 18:03:34 +0200
Message-Id: <20190902160334.14321-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the appropriate gpio interrupt controller compatible for the
sm1 SoC family. This newer version of the controller can now
trig irq on both edge of the input signal

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 521573f3a5ba..6152e928aef2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -134,6 +134,11 @@
 	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
 };
 
+&gpio_intc {
+	compatible = "amlogic,meson-sm1-gpio-intc",
+		     "amlogic,meson-gpio-intc";
+};
+
 &pwrc {
 	compatible = "amlogic,meson-sm1-pwrc";
 };
-- 
2.21.0

