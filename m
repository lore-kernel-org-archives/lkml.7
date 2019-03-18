Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1753BC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB1B2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cly5J5GV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCRJ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:58:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:58:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so12262262wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nu4wz8X7eesuq9FeuUSWJQWjJaEoKZGjh4U1VvIO+mE=;
        b=cly5J5GV6va+MStGvubIKbR3YMVGk6tDL3MH03NDYJBA+wNqTUKuVnqo6yyeobgsKI
         XvMbcXd5CpmDSrvaQquSgxbkyGdfNAudXC3JLGeh4JVHcpXKqov2nDIdU8IcZYkf3blR
         ZgtsB76vvqWPqTlWz5uFIinGVfkeY9KluAqrCF3v0s1A7d0cdhMTr1mdK4KJRPxo31Mb
         vODEwsuoT/M7fyPzXt95Sjim3J+4d6XWcU5IpOJgXUbq1khK/P+VOPPRhuz3aWztj1SV
         4apDRGS/fl/08JakyleUU9CwOfVhptHYOFWnuv3HWGGlqP7IyNpAdtsGm20JxCdb6zhf
         8Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nu4wz8X7eesuq9FeuUSWJQWjJaEoKZGjh4U1VvIO+mE=;
        b=GAgGgmto9cHoUOuYCF5OVXapXzy2fvPMypRbNYF7MEy1mqwgOzl0Z1ami/byg0lh4M
         dVKMVYR7MQLuQAge1joBRe9fNYq/h9h3iecZ1pO99BYw/lP3SBC0OgKiRhntIrQQZd6K
         gIPhVbaEJMOt3pj/fok+dePY8g08m4pV7db/FAhJEDYwdwyY0sPHX3c5d11eY4N949dp
         qOm3sMZLcO9jHI8ribJQQBjfnXrFIlSeZDDdCyjn9NUSvoo+ILTuyCsYuBcKwys5DVtJ
         JOSYEvlB4t322dAcmgyVjn8D68Egh1ge9H1Ukl90Ep04TIZA8GN8aris97EKbrYPsgTy
         0LOw==
X-Gm-Message-State: APjAAAViE7pzmEj5yqGKq1ts1d6+5tb5Z0tjVtkBiQ9l5AWAZBbEn55H
        f5iSv9Pote7A/8UU8fqozUiAbw==
X-Google-Smtp-Source: APXvYqw61n1UVwTrZftVRkMR9MY26PpUenbqvt75pFnU6UY0mN1ZrA6SPV6bdZYLGZi+JZgKsyHG6Q==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr3161799wmb.110.1552903134285;
        Mon, 18 Mar 2019 02:58:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] arm64: dts: g12a: Add peripherals
Date:   Mon, 18 Mar 2019 10:58:43 +0100
Message-Id: <20190318095851.4062-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add following peripherals :
- AO Clock + Reset Controller
- Pinctrl
- UARTs
- SAR-ADC
- USB
- Mali GPU

USB depends on the PCIE clock and missing Reset bindings.

SARADC bindings is merged.

USB bindings has been reviewed, but not merged yet.

Mali GPU bindings are still in review.

Changes since v1 :
- dropped already applied "Add AO Secure node"
- dropped meson-g12a-u200.dts uart_AO change
- fixed includes overall to fix build for each patches
- removed disabled status in dwc2 node
- removed uart_ao_a_c pinctrl
- fixed uart pinctrl node name

Jerome Brunet (3):
  arm64: dts: meson: g12a: add pinctrl support controllers
  arm64: dts: meson: g12a: add uart_ao_a pinctrl
  arm64: dts: meson: g12a: add reset controller

Neil Armstrong (5):
  arm64: dts: meson: g12a: Add AO Clock + Reset Controller support
  arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
  arm64: dts: meson: g12a: Add SAR ADC node
  arm64: dts: meson: g12a: Add G12A USB nodes
  arm64: dts: meson: g12a: Add mali-g31 gpu node

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 274 ++++++++++++++++++++
 1 file changed, 274 insertions(+)

-- 
2.20.1

