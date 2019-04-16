Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A2FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7922087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrZ3hyF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfDPPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:52:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36151 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:52:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so10550453pgc.3;
        Tue, 16 Apr 2019 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RNm5hn0ohiGFKX5GjGBSbT4h/9N8eRUXb5BNqJM2K28=;
        b=YrZ3hyF/xiGrw8soDfNUlf5v+tLqP7AWdtidhi/1g183Fw4ZRxLxJDgcaaDWKB1vKH
         /vrL46Oy9QCw5QF8svw9tff25FPVOO0IJTjI34z9tAu9Dc8EyuBE2ykTrKi6damXUltE
         lbzj6I5ufSAHsY0tsC4thVEif2y/h2efLgM3xJie7JqOQTa9Mdg8y4SlKMznseIsfbeD
         gwJlcDWCs72DtopR5I1uHqgRpqzF8y5VxTP/xzHmM/f24tekMeb/bAbEi7M5G8/VcuPI
         3xbUdvPTKrYipYOMlrq4Ot5txc9X3M4GDxuYYrt4O4KRHb8CDLo4B2Fg9d3tYCkxXFCm
         jdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RNm5hn0ohiGFKX5GjGBSbT4h/9N8eRUXb5BNqJM2K28=;
        b=OV59iuoRfHn3x1yCE9lBQKrdU5ZPPT6V+nOHMofWM0T0KbVZL/JtpikxkfAp3/Z+Ou
         3UMFO0Mk6Wm/i8xjHxnYZS3oGtesPuFPOd2vQreliqeu4+8IeZqaP+yulwRQi5/oZnsC
         dKtQ3z9XP1kLKkZEMAka/I+WE2FrcHS3TV2OO/5RtCC+WrKSOdlmuNKj55Ouamt+FvxE
         LRbkGoBgTs9l7ze12ZA7oblY8oxkgjtlOAZRT2jc6jHbYBFCaB9nVB+zQzqehGc33ZnF
         /NsnR3cwFEVGsdKC7h+aQKK7z7YSZL4W6A+XBXJNagUQQ0GXjkLX0myZ3Cek51/bmBTP
         L2KQ==
X-Gm-Message-State: APjAAAVjlR4BAHHFholilC0sNoHk56ZySWVGl4R3BMz9S6IiUunuvweJ
        /CpdGi8Wyc4FnMbArF9ZMSw=
X-Google-Smtp-Source: APXvYqxIMwgBNaB5CiejC/3ksrQa2jdGoqCDEA2N8rQ/WwGxOyBMgoKJAirovidm3fv5uB/049SBJw==
X-Received: by 2002:a63:6849:: with SMTP id d70mr76862039pgc.21.1555429934311;
        Tue, 16 Apr 2019 08:52:14 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a3sm81740695pfn.182.2019.04.16.08.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:52:13 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date:   Tue, 16 Apr 2019 11:52:07 -0400
Message-Id: <20190416155209.24216-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.

Yangtao Li (2):
  cpufreq: Add sunxi nvmem based CPU scaling driver
  dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points

 .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/cpufreq/Kconfig.arm                   |  12 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
 6 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
 create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c

---
v4:
-I removed this sunxi_cpufreq_soc_data structure for now.
-Convert to less generic name.
-Update soc_bin xlate.
v3:
-update changelog and title
-convert compatibles to allwinner,cpu-operating-points-v2
-document the valid names for opp-microvolt-<name>
v2:
-update changelog
-convert to dev_pm_opp_set_prop_name instead of
 dev_pm_opp_set_supported_hw
-some change in OPP Node  
---
2.17.0

