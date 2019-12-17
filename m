Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F4F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IWrGd/se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfLQGGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:06:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46227 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLQGGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:06:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id z21so4064085pjq.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqq8EI8PetXDTX9SD5fPHS3ySd+6zzeipLGlfcg5Zxs=;
        b=IWrGd/seVhqfkyiDseJWo0Sbfx11NJtoTwyu5c4/nSABcXvEq+W+6nvn/9GQ7bwwq2
         85T22nRr5aeyzQcY4FH4w9g/ybLLtlaMva2KA1RsF/Hb5xiwliz19As+Hvv7xdotEXcC
         xssP5NVYgHtz30sK/ibkPM1V1ScT5WmL63b2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqq8EI8PetXDTX9SD5fPHS3ySd+6zzeipLGlfcg5Zxs=;
        b=YphHZkpfGtVQgE93YxZf4ECPd51sTboZ7UnuU5LbCmoT8EkfR8gf9Q6FOKXLQhWnvu
         hRza4z4ej5/6TJuBvrp4MXUmb2H8nKQijkCg7DhjwzjG6Z6XbLGx+uPAQzM6Iij1gYse
         ep2n/NjmQCFSjGnEAIyy6s884auncUbioMnsgpz6+kf7GVtInsX7H5By89JLGHPgK9ou
         0uOq6VvhLVBGo/p9yv8M8CZmf/Vdii6rLsQqpHsFwDAWDWPK42Jyfxw3DVwp5zkMM8Dw
         DoMrkk6F/GKOAbXUcc/WXyNCYyRcl1Kk0KQeZTajAvGJ+a+1y6KOf4u91m5B2vMtu+Xu
         D8kg==
X-Gm-Message-State: APjAAAUu1hEZnZeUV12n0UdZtu1y98qAZ1DYWL56Exl75phqz6O8g6Yy
        HuVJ+zERwyZHaN+6DfBYu+c1Xg==
X-Google-Smtp-Source: APXvYqy3ZSrRGG3wJsbsNsELq8FiXxGqWLLQkso+ZvvdJb7SNnlcTLsYAG9ULRHOPTO+a9QqGIJTJg==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr3969666pju.135.1576562775797;
        Mon, 16 Dec 2019 22:06:15 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u20sm24396721pgf.29.2019.12.16.22.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 22:06:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, mka@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] dt-bindings: timer: Use non-empty ranges in example
Date:   Mon, 16 Dec 2019 22:05:32 -0800
Message-Id: <20191216220512.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On many arm64 qcom device trees, running `make dtbs_check` yells:

  timer@17c20000: #size-cells:0:0: 1 was expected

It appears that someone was trying to assert the fact that sub-nodes
describing frames would never have a size that's more than 32-bits
big.  That does indeed appear to be true for all cases I could find.

Currently many arm64 qcom device tree files have a #address-cells and
about in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase
address and size cells for soc").  That means the only way we can
shrink them down is to use a non-empty ranges.

Since forever it has said in "writing-bindings.txt" to "DO use
non-empty 'ranges' to limit the size of child buses/devices".  I guess
we should start listening to it.

I believe (but am not certain) that this also means that we should use
"ranges" to simplify the "reg" of our sub devices by specifying an
offset.  Let's update the example in the bindings to make this
obvious.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
See:
  https://lore.kernel.org/r/20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid

...for the patch that sparked this change.

 .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
index b3f0fe96ff0d..d927b42ddeb8 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -99,22 +99,22 @@ examples:
       compatible = "arm,armv7-timer-mem";
       #address-cells = <1>;
       #size-cells = <1>;
-      ranges;
+      ranges = <0 0xf0000000 0x1000>;
       reg = <0xf0000000 0x1000>;
       clock-frequency = <50000000>;
 
-      frame@f0001000 {
+      frame@0 {
         frame-number = <0>;
         interrupts = <0 13 0x8>,
                <0 14 0x8>;
-        reg = <0xf0001000 0x1000>,
-              <0xf0002000 0x1000>;
+        reg = <0x0000 0x1000>,
+              <0x1000 0x1000>;
       };
 
       frame@f0003000 {
         frame-number = <1>;
         interrupts = <0 15 0x8>;
-        reg = <0xf0003000 0x1000>;
+        reg = <0x2000 0x1000>;
       };
     };
 
-- 
2.24.1.735.g03f4e72817-goog

