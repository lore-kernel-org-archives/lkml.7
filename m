Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB2C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04672206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oglEPlSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfDYTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:49:13 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34155 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbfDYTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:49:12 -0400
Received: by mail-pg1-f202.google.com with SMTP id z7so411224pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=I1Vs0ZSRMZjDsdASMFkMZlhVl8C0QGbmST5lDUWt2ew=;
        b=oglEPlSeAX9urBWfXYgouRdR1MFLbZpWIlMsU39Vnlq4bbZuw04+mfqmB/YCPgun8g
         se4hdoMGNBo7Yqm1G+Kk13aI5uWHnRF91S0W9dJ1P7bHL+WQZu13Rkp03XgHcJN2BWM5
         yU4DT2MKIx4A6hWWTQJjzrSJnS79Dgu2fdqz3Jt9+f4jcjfRCkplOHwWsFhi5UXoDpt5
         JaYjAvNJLddKvrgwVynBWH/YzPaOwhmjJoLe0gLSxA7GlIDlHPxKbXQ5PuBQIH4ZLA/t
         sWfmDcKi5dMGtQR0VyWegGgJmu2LJ2g8KdpiPBK2z+twRmTC2ZA8gsJ25uHIE+e5sK7s
         i3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=I1Vs0ZSRMZjDsdASMFkMZlhVl8C0QGbmST5lDUWt2ew=;
        b=YVnaEOFU5Nj0HAikCswYnwOcghvFckLt64qUMy6ZxgnjqVXLYlnlqRVJMdo2wE8Hqt
         U9AdO7RAAmLZ5rzIaGd3HcUGxbI70MJP1cvOSDavsplxSu754hLCh6rJY9cdrY+CLkKe
         jwRxSWOU6/8+esr+q5M+/wgjFeYXFuO0G/l3fUvWJpkSJwaAx8Rb9Mlo6IqmqF2KuWfY
         RaW65NwwAL9zn+cHzgkJBEL3GOlvZNj6mpusFLvoKoRFCoEK1MivquHI//cRitnCpsYn
         ykQT2tYdqPESfu9YUaNuRcgDnslq4Xb1L9dKAN0d9LEXC+QjMWaxxW96hTRI+zyljcs/
         AO+A==
X-Gm-Message-State: APjAAAXDnn97E2SFphxracHpJjP6tJe/Y8sfSHX+0NPU3wKvbkg0gorx
        1NkdvBt3HLKhWDog6wZG/Y54y2ZRfBNR
X-Google-Smtp-Source: APXvYqwwxi+eWcusnqq45pTCCNwbbLt8sPbjR930l9ckz9fDJdrJ3XYJsCqF1YypuOm6GIHhpxNiM29Q5GMp
X-Received: by 2002:a63:d816:: with SMTP id b22mr38533659pgh.349.1556221751817;
 Thu, 25 Apr 2019 12:49:11 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:49:03 -0700
Message-Id: <20190425194903.144569-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 2/2] ARM: dts: aspeed: quanta-q71: Enable p2a node
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the aspeed-p2a-ctrl node and configure with memory-region to
enable mmap access.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 0d7c6339da465..a68ff0675c28a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -112,6 +112,11 @@
 			&pinctrl_ddcclk_default &pinctrl_ddcdat_default>;
 };
 
+&p2a {
+	status = "okay";
+	memory-region = <&vga_memory>;
+};
+
 &ibt {
 	status = "okay";
 };
-- 
2.21.0.593.g511ec345e18-goog

