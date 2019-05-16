Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5FCC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F8A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MkJydfFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEPQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:29:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40620 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfEPQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:29:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so2113586pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5tBSaJenAAl2/2/E0QKr9xsfgAq0TAexbm1VudYCYY=;
        b=MkJydfFNb8Zarh1j8X6Nl7cZR1+cKqVxQrYZ0p/8MRxz06Xrun/tupqmE6v8jCMnpb
         jbSSanskoXF6x0hoBAhAGR48KDIIxgbxfZ+7kJhS/gAzPjro3h1FdLMLJkTx4WY/mXoq
         sfTF/JOBJPhgwL5NJWHhaVbxr+nH8ynJAG1LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5tBSaJenAAl2/2/E0QKr9xsfgAq0TAexbm1VudYCYY=;
        b=eMXx78hPFl/0/qVu/S6zl7vW6EB/SIYk8Xsku1gSRLOBu9rcGSKrZ+w7b2L/6hnPmQ
         BUDJkDzKudW0J46R52abJ6rmPg/5warbjd+D7rQTDFbG0rcTwsHoj3qYV2+xZI5n9t7z
         Wea560UJTj3LaAv+fXgulI6/kJuU7NPZuammxvf7CZT0Z2JaOZir1ksqnnTRyFf+ICyQ
         +7mjlczmNoRS2Q44xwrAJQ0m8Np5So05lcq55InHnfbqhJx9QFPSGeKWRvp7SR1gtoKe
         EpYq8/qamNWfq6QtLVGkcJY7WpICV2u+gOVFAZxyAulDMhw9j1swYv7BIRB1G0Vc9L4x
         EppA==
X-Gm-Message-State: APjAAAWGc0FCQbPfK22yvzmETIKN2vhgmrngoWCscGBv90gpupOG6IcH
        v31XYLxY3qWwO7KKVNSATameSg==
X-Google-Smtp-Source: APXvYqw+BIh+offSQSSziALymyeAhxhq1O7ckJ1x3tzKL9gNG55hDnHX76jw+v/G285jFXE5k2ohHA==
X-Received: by 2002:a62:2b43:: with SMTP id r64mr54971169pfr.210.1558024190331;
        Thu, 16 May 2019 09:29:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s198sm8644416pfs.34.2019.05.16.09.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:29:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/3] ARM: dts: raise GPU trip point temperature for speedy to 80 degC
Date:   Thu, 16 May 2019 09:29:42 -0700
Message-Id: <20190516162942.154823-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190516162942.154823-1-mka@chromium.org>
References: <20190516162942.154823-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raise the temperature of the GPU thermal trip point for speedy
to 80°C. This is the value used by the downstream Chrome OS 3.14
kernel, the 'official' kernel for speedy.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- add entry at position in alphabetical order
---
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index 3d2769f1bef2..6f870d89866b 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -75,6 +75,10 @@
 	force-hpd;
 };
 
+&gpu_alert0 {
+	temperature = <80000>;
+};
+
 &gpu_crit {
 	temperature = <90000>;
 };
-- 
2.21.0.1020.gf2820cf01a-goog

