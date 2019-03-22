Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A639C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB6221874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lAahNYuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCVT7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33640 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfCVT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so2249809pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7Trpx5JrofrLmP9LTA8EDeVXf0vpIlkzzne9nnJr20=;
        b=lAahNYuUfROlm/XhAjJhGNGbipyTKGKOa60koTC6ogMBQlePIg/nOxxHj/o93ZUalC
         geFqjWjwb5QtUwNBWZwG57XsHDyHfOLW9vxuxagWIMaetPjnktsaNX/SO8EuKdX867l/
         3p0SwYNdOufDo52JD3wbp7gmAD2yy52BSELGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7Trpx5JrofrLmP9LTA8EDeVXf0vpIlkzzne9nnJr20=;
        b=MalSOhlfMRTj+PGHQcTXkPRonJMacXuWaUqosDS/c/opujRjV03wW0DzECn6TqLT3P
         dWzgXTUgzd+9GnrF0FXqHHfN+NBr2tQfIubWpq93nInoQfvVHymlwAgNBbtJw7MenpDf
         xddj3ox0futhaDW/PlIbW0u5F6i9SbenZMgChgM9aWmidOf1FQ2uWVddTMofzDhNEHsC
         vfZBqiZ8JnvpMEXRXrrRQzvXLMxjrykBtO/UeXMurTAK/IL/i6LNn8uLs0odlx2EwYgM
         qGzWOj4vcFHHnRq+Arg0oYVQ1ticFnF/0C/GIJpBxGoSQh+IMuTxUINWOeeh2uaAHVdi
         flig==
X-Gm-Message-State: APjAAAUWsd2Y85Ft23SgmG453mSfuX980qikGbY+TasWW5EMfcRHWgTH
        UC0AtBtYgXYEvbE1OHAWJKu2Lw==
X-Google-Smtp-Source: APXvYqzpAWVxwbtM2UEORyyU76x/6aNJt+IxZOXemBfi/YqAiCaf6mVCEeoy5C3vQFWfmOr/GMQdjQ==
X-Received: by 2002:a17:902:20e8:: with SMTP id v37mr11239028plg.168.1553284772146;
        Fri, 22 Mar 2019 12:59:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n65sm27637990pfb.160.2019.03.22.12.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 12:59:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alexis Ballier <aballier@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: ARM: dts: rockchip: Add rk3288-veyron-jerry rev 10-15
Date:   Fri, 22 Mar 2019 12:59:23 -0700
Message-Id: <20190322195924.70448-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell/remember rev10 was originally created to support
making a SKU of jerry that had a different LCD.  rev11-rev15 were
added to give some wiggle room for future builds.  Downstream has a
separate device tree for rev10-rev15 (compared to rev3-rev7) with the
expectation that differences relating to the LCD would be accounted
for there but nothing was ever added to the rev10-rev15 making it
identical to the rev3-rev7 one.

It's likely nothing actually shipped with rev10-rev15 but they are
listed in the downstream kernel's device tree and it seems like it
should add a little safety if we match them here just in case
something actually shipped with one of these revisions and that device
will break if we don't claim support.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 0161b4a66586..864ee1fddcb0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -160,6 +160,12 @@ properties:
 
       - description: Google Jerry (Hisense Chromebook C11 and more)
         items:
+          - const: google,veyron-jerry-rev15
+          - const: google,veyron-jerry-rev14
+          - const: google,veyron-jerry-rev13
+          - const: google,veyron-jerry-rev12
+          - const: google,veyron-jerry-rev11
+          - const: google,veyron-jerry-rev10
           - const: google,veyron-jerry-rev7
           - const: google,veyron-jerry-rev6
           - const: google,veyron-jerry-rev5
-- 
2.21.0.392.gf8f6787159e-goog

