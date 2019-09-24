Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CC8217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngYhG1/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfIXQUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:20:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45351 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfIXQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:20:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33so2358876edh.12;
        Tue, 24 Sep 2019 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jGaYIvx5eMd2C8W/Ntjb7BFiKQ1bZogo0tZfXc3/zIc=;
        b=ngYhG1/r7NA2i5Q2IKHFn1PWl4b7ZDF2BiFZbaJGQB6cTzVzvh5BNmQKxxrKrj8naF
         cVwVen+dZXMaQfupoRu3+ffJ4UJ+HEo+ZfQoijKa3jh6hS9eydyI+gNiDBh5xDo/iB/k
         1quZQnW0va2qcmqMBjsABDHprwEeTgGhly9EiBsh8gWvjpAXkjzmojioarPBSR7QoQF6
         A5Dp1TGM7GggNWD9CuDIoSS658uU+4wQAFJQ6iTOgdrsa0okbUVEnyjSfzi1+cz2HTyh
         sD7BYxLLY7jL3zfKAs1r8GP8istN1ATWzJcFz6Lwp9PVtdZ4FYKXJwep4UrLfOJkgUfr
         +x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jGaYIvx5eMd2C8W/Ntjb7BFiKQ1bZogo0tZfXc3/zIc=;
        b=kEkvMfKhpt0WHx7/tC4+k6IZKs/f0hPGyV+mOl8TFxH+RVCpElgE0L3pA/jEZITZ7Z
         TyfnnkSqE2ycf/hyXk/Hb2Ppg2DdYKpZeec7ESgXuZt56RHR+tY4nilgoCEfCzEeYAy8
         CyDQRyfwuBE2EJ3KyT07MyCbzjd67tzZOkqnF52yaEaeTp33GTmN/fPf2MseOrZeTjiP
         lef0g1DBIDOr19298t5CQ3ebEEHtMNK0AZW5LiCKXDuG3xGMWgeicHdxVOVny61r82WK
         MD1S0659KF1b7LMG9bq7zO1XVAyEwYzEdjqMJVMm1yPhFX8OHS7s40Hmnp0d2tVGeSQM
         /eSg==
X-Gm-Message-State: APjAAAV13o7bkdkvnYuR7PmkwKseneNPyqJzAfZw+nJl1PHa83R2caGA
        BT0LqwPEmN2H990pjbHREQg=
X-Google-Smtp-Source: APXvYqy1z09jDJqczIuE4DqBONcKoRnAnyHD+uSGkuKv3lqECLD/pZ/WdZJV5iYePeFfBfQWUbI1vw==
X-Received: by 2002:a17:906:d8c8:: with SMTP id re8mr3325112ejb.130.1569342035905;
        Tue, 24 Sep 2019 09:20:35 -0700 (PDT)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id g19sm253301eje.0.2019.09.24.09.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 09:20:34 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, m.felsch@pengutronix.de,
        narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv6 0/2] Variscite DART-6UL SoM support
Date:   Tue, 24 Sep 2019 18:20:19 +0200
Message-Id: <1569342022-15901-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need feedback to the following patches which adds support for a DART-6UL Board

Need feedback if the division between customboard and SoM is done right

Need some feedback why ethernet RX is not working the right way. RX is deaf.

Need feedback howto document propertys and compatible the right way


Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (2):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 445 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 196 +++++++++
 3 files changed, 642 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

