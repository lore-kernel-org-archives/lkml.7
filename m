Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FAC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C520693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKdHoRuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfGVS7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:59:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41975 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGVS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:59:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so7757371pgg.8;
        Mon, 22 Jul 2019 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOXSDSa34NzMUxWJhg5oh1DkMb64LBwauGFB40L3Ik0=;
        b=WKdHoRuMoCZHlpdYo2hUSZmoejAPrpJT0y8zzvWqPA+gpst0zE8k6yZNXUrH6MUzj6
         i9zXgicSjUUanQv6XgDXPhw71laxjPPQplL7oE6sYEg5VG8ffq4hx1gzp5Uz7zOyol3p
         YaLJAIjaid/ZosCv+52St2290e0Zy0h1zHKzQ6m7LeqKZo5lErc85hugZaWC9aKN7zja
         3W8NIsmdruFY3g6V+snVUm8gjqONU4JxU1j1dm1ERa7znW7boX3gflaUbM7NH9qXZCjp
         cL1tRpcOHyEG/4EKSXBMxtgyHD5Yk8Xb/zaJW1GYpcdVYIdMtn0Ii8uhqJ9fjzhUWSLs
         v5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOXSDSa34NzMUxWJhg5oh1DkMb64LBwauGFB40L3Ik0=;
        b=WjV3VQfVQKLsdGDv7iEi9F8UMiUxkKNxuCRqFdLLmpAEFYm22uw/VeuhYFdrOK3iym
         pAajKKcpEs3wpTyPhAsOu3S5gywoNHLOrs0LjhP0XSK/2lIZCgnC22YhpESBmUXskPV5
         Xh0N9SnXydU7OOFZ7La5FrWqKVmEwmYWIP3yeaN4662nbv6I6dU9iThnMQ+wHQ6n9C5m
         0ZPIlMrmPwmsCHoy/HSlcNQTeoYwOiTaUCmKTt6Orm1yJ88CztyAKebWf4Gug6T0abzm
         O/fMg6USCSIWFKDEu3OJB9Oeaf0V2S4lWcT7z6VyLJI9zImEihw2Xpo3xXKn+5vEEZWH
         89mw==
X-Gm-Message-State: APjAAAWE3vZFm06oqeX2GsfUbDaiFxchwTe8/ZUHJpjBamnzy7y0vcXY
        F5RI33k30APCvRP3JnG9EykUhcNY/zI=
X-Google-Smtp-Source: APXvYqyhJmepX+Lgi3nmnuyfE7HPnX9Li95Ydpzq8d36xy2ABvZZpaIW4EMvgC41Uk59xg7pnqfydg==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr77270706pjt.16.1563821986436;
        Mon, 22 Jul 2019 11:59:46 -0700 (PDT)
Received: from localhost.localdomain ([103.51.73.174])
        by smtp.gmail.com with ESMTPSA id h1sm30777675pgv.93.2019.07.22.11.59.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:59:45 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC/RFT 0/5] Exynos USB 3.0 PHY tune setting
Date:   Tue, 23 Jul 2019 00:29:33 +0530
Message-Id: <20190722185938.9043-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Here are some patches which help tune USB 3.0 phy.
changes have been testing on Odroid XU3 / XU4 / HC1.
with suspend and resume working with usb hdd device connected.

These patches have been build on top on Marek Szyprowski
Fix USB3.0 DRD PHY calibration issues.

[0] https://patchwork.kernel.org/cover/11049823/

Anand Moon (5):
  phy: exynos5-usbdrd: read from correct offset of xhci linksystem
  phy: exynos5-usbdrd: add missing tuning of the phyutmi signal
  phy: exynos5-usbdrd: UTMI tune signal
  phy: exynos5-usbdrd: PIPE3 tune signal
  phy: exynos5-usbdrd: drop duplicate setting PIPE3 tune signal

 drivers/phy/samsung/phy-exynos5-usbdrd.c | 101 ++++++++++++++++++-----
 1 file changed, 82 insertions(+), 19 deletions(-)

-- 
2.22.0

