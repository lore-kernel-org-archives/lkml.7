Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB17AC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD628038
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pzYeMNuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfFCJrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:47:49 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50258 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfFCJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:47:49 -0400
Received: by mail-wm1-f43.google.com with SMTP id f204so6437716wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9Ixde2RaAqTQGdv+LA9dTohQTsUZNLap9qbImLLJdg=;
        b=pzYeMNujyAFxjYrDgexUSXvZNbCrKH4ON0S8GO6yhoEos7QDzrXvmiaDID9tfzEKyg
         sW+C6F5cEPQ/rk8fW7UCxjSvAEggstG/hdn4GThq0n1nMs4K/oyjnE0vqdKzWBf2MkUO
         t9UE+j3BJ4AthZlLyEv4+PbwuQtL0ZnvVBSIyQD1YjBS96WXsFK4qjaxcAco+7Fv//e4
         GkyNZ3jPOtU7lnGlESqER8ZzfdjuQgZ+a8fQ0huUdMNO4SiuGRrjLEk3+nnEBpn69Hem
         ujJeMrhWxL4SdxJTgLEWjBNLEVM0+PXZkeQxHFqFxVH5oWlt1bIAmpbbl6MXzA3/NxoX
         Kavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9Ixde2RaAqTQGdv+LA9dTohQTsUZNLap9qbImLLJdg=;
        b=jPwZjTj5L2UyMgAu1LlPM1iR6UWSPWRzY6qFJVhlm55/pK6M/PzEYeqXlXHkrl/4G2
         m7S0VDMDTjG8boNrFsIQeXQrEmTEJY5YwD7n7RSKF/+SLmLCCELfh1TQX2SmHkYdUop7
         hYQkHQxUv9YWHWQUh1ZqBE+c62vX0qvf9Z8xGFceWYm0Q0o+BciyBQcbTnmoj1ng4Mz8
         Fd29JzRBLLs3uAUN0U32sL4vWZBMw60xsxwSzEaFm1G1nUrOjmJC+W/sbYzroS8KvlJ2
         Ow30UXLyBaDTjy5YnSE6jdJmFxaqffHdcbqUK9BhdzoRm8laDYZ0m8zAxy5c1nTPh8Vv
         h7/w==
X-Gm-Message-State: APjAAAV60k9tO+wSLJ49njRnpu3EJgOxroCo+7dr5K2sCnFhL/s/2WJI
        WS9k7/4r8uBqDaRiQwUvKLqtoQ==
X-Google-Smtp-Source: APXvYqzbgRQEAG7CUDXFioI6Ii9i4e+8Al0EgocEvPQeRh42n3dvxouKvbj6QMVEBXoM/NPQwRWm/Q==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr14066558wmj.69.1559555267031;
        Mon, 03 Jun 2019 02:47:47 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm11235375wrh.86.2019.06.03.02.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:47:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] arm64: dts: meson-g12a: bluetooth fixups
Date:   Mon,  3 Jun 2019 11:47:36 +0200
Message-Id: <20190603094740.12255-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches :
- adds the 32khz low power clock to the bluetooth node, since this
  clock is needed for the bluetooth part of the module to initialize
- bumps the bus speed to 2Mbaud/s

Neil Armstrong (4):
  arm64: dts: meson-g12a-sei510: add 32k clock to bluetooth node
  arm64: dts: meson-g12a-x96-max: add 32k clock to bluetooth node
  arm64: dts: meson-g12a-sei510: bump bluetooth bus speed to 2Mbaud/s
  arm64: dts: meson-g12a-x96-max: bump bluetooth bus speed to 2Mbaud/s

 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  | 3 +++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.21.0

