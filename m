Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9036C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6374206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejBtaPnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfDPVyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:54:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36119 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbfDPVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:54:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so10985760pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWXcwUO99R4dLB/IuZUC9gJlZE5FQWRDL44srQDPsqk=;
        b=ejBtaPnR9q05b/fAPX24cAvnXMkUKl8dv74zXRQ/flOfxwW2g+52dgsY64NuNdME22
         uPRaVNQIDZwDLbenk3fXkr5sCpbUoQQx3iz6VI/N4wTVQq5I+lf9isXR5BnHdcl04m0i
         qMRY/ItYRRoO2Pj+l2mtAwkwcK8tNs2AKNPyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWXcwUO99R4dLB/IuZUC9gJlZE5FQWRDL44srQDPsqk=;
        b=l7Zs+kWEwk9VuElgdVqHC5nyQY0V4rpN1VgE29QvWBPwbT7aF0OlYW0QqhWXaan+Bf
         FVZxZBZJiKjolCLUUqiI6mfuqPbihwJ86td+akO26VG/dhslEF1H6BA+l4kv3FlsixT6
         jDg+vrbc4E4wUuwoefyi6kfKVahc1Z7ZU4ph5kYwhzb2zjNN8EJPReJb0Bhy85oZvJVn
         lfBvRaGFLh2GMW6PTaFnKQWyyo9Em4m3vo43OfI44l2Lu+kBPMfjKg4D6NqElN80fAAH
         2XN897B/ScRXLxciobACNmXI2fbb4x8+4/kFewn/7Nt5eoCN8kSj6sIG+D4KHoSi9Zzx
         66Rw==
X-Gm-Message-State: APjAAAWrd+CKr44RWpbnm5sH549oMuusg9k8Ce2dBjkjg/3Rhn+AY9w0
        W1hcXINakDnsk5Ga1/mNIyqpsg==
X-Google-Smtp-Source: APXvYqxxdYR0fLJUpsHaTgteMM1jkatPh1TgL1h1tZn2iyQSTF5t4CnY+DzCpefDu9PaKb6nKGydpA==
X-Received: by 2002:a63:af0a:: with SMTP id w10mr54056203pge.67.1555451656875;
        Tue, 16 Apr 2019 14:54:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b6sm8156770pgt.58.2019.04.16.14.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:54:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     amstan@chromium.org, linux-rockchip@lists.infradead.org,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        mka@chromium.org, ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Add quirk for resetting rk3288's dwc2 host on wakeup
Date:   Tue, 16 Apr 2019 14:53:51 -0700
Message-Id: <20190416215351.242246-5-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190416215351.242246-1-dianders@chromium.org>
References: <20190416215351.242246-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "host" USB port on rk3288 has a hardware errata where we've got to
assert a PHY reset whenever we see a remote wakeup.  Add that quirk
property to the device tree.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2: None

 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 7e70ecf2b95a..aa017abf4f42 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -621,6 +621,7 @@
 		dr_mode = "host";
 		phys = <&usbphy2>;
 		phy-names = "usb2-phy";
+		snps,reset-phy-on-wake;
 		status = "disabled";
 	};
 
-- 
2.21.0.593.g511ec345e18-goog

