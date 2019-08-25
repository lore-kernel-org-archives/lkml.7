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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C55C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1440C21744
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNtOikS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfHYECc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40319 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfHYECa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so12101209wrd.7;
        Sat, 24 Aug 2019 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zA4JW/hg+wx6CJsdzmqfZbE0PagO6sXNIEqF5lUUdjU=;
        b=NNtOikS18WU6T3gIKJEnRf8jbT7LMki9B8UG3870rXW0i05gDzzFcTZ+G7aKEZRrG4
         5Egd6B1CDenIiIjCYMQkL78+LgBx+A8ur0hNUS1EY2KA7o1P42lpk1t6hpz+S/ytCYzJ
         kW6fRvNd56jhbdBW9zTMktQKpk3JFfjFnnPeZIxPPwp5I202Ktj1lc9yMsi7OncHSlUq
         lvWhD6ydLALH3CxZb4+Y41F12Z6mXz/JRZUfDbLPA82fQiwzRwMKu2CiLRrX/UM2/Fb1
         26TmWcUvQAS3vNh7CsFggwVVLDzA6R+tRtUuT1h5gET5EbsyLhojyihgJgVr5ofgnkb+
         nb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zA4JW/hg+wx6CJsdzmqfZbE0PagO6sXNIEqF5lUUdjU=;
        b=aYLUNQaSZ44LP6g9m0rRZJBiv6lVlUUhuK3sfX0vlgI1QeOtgWLxJGMyGu4+CIw202
         X3nyeqsZI7QsIyTKHuXGecEkbz6PFQVntsgIc1qLM5B+YbdNMYtxif1YzVPQIx5Kh/Q2
         a2MxhsMKEZw1J7Gbb6F6Xym65QUQTAhUrWiZEC62gwuprUOcshnCT4yokyGid3mULlat
         mjZ0+UNdwwhBD4WSQkR40HIAmmiTfyJ50eBRY65Q2pnqBPkzraIERQD22e4jtqyYwcGo
         tafQUzJWcIMHd+Q6SXtg/d7BdQ56S8LoWrOy1adBZf0BvKwslVixy4Ei38E7IYL6S44c
         PuPQ==
X-Gm-Message-State: APjAAAX4WfndeOgupH4VrwVJQtk/mOGWzC1XEVkzn6PGt93kIXGUS4qv
        p3yUZXe3GmdgnNP9Gj5Ytho=
X-Google-Smtp-Source: APXvYqytpsaH+5s4MR9HODR+t+2siNqosgJSnzuzUa0mwtEnEkV1Q/JdbO8154er/EIwX3efOJM1dw==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr14714925wrn.142.1566705748885;
        Sat, 24 Aug 2019 21:02:28 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:28 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 4/7] arm64: dts: meson-gxbb-wetek-play2: add rc-wetek-play2 keymap
Date:   Sun, 25 Aug 2019 08:01:25 +0400
Message-Id: <1566705688-18442-5-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the rc-wetek-play2 keymap to the ir node

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 0038522..1d32d1f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -54,3 +54,7 @@
 &usb1 {
 	status = "okay";
 };
+
+&ir {
+	linux,rc-map-name = "rc-wetek-play2";
+};
-- 
2.7.4

