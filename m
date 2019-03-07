Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473F5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D4F20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MntE3LMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCGOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:14:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45604 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:14:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so17599110wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=102m7vigukY6b2r4HXlaV9za2FJR75yPTrUYx8MuDyg=;
        b=MntE3LMdL4WhEyeakqoEbbBDCZnuNWUqFQom72tuwIEjS8DppGHYQmct58TELWCtZT
         Y9OmEDJCTdEnb6M8bVpIsW1HNfbJNQwYBGrzpjzk5YMitJqAtQjg7MKwEfCtS9uANjvE
         oi+iaF15k8UY3mQ0vOlKYHEZAd7tKOr046UooTQdj0hHBuY7MlADQdoD1uNU2b1CwFgb
         VSVlstjyAp7uqIi5WaGWIX6q3nH8JdlZdtVbB4f5nplukWcHn6KL4UxJ2JEy+QA0d33J
         h55Aub59jR3p5VisbfBTG6QyExNutxND8gOKpiuD3qc22Gh12rqHbdug8j1JqRIvO7qK
         JrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=102m7vigukY6b2r4HXlaV9za2FJR75yPTrUYx8MuDyg=;
        b=jOO2HKY5clups69XvdB4mstlb5abpMKUeOnXhhdBUms4L8EJJp/iRGb6qQ5/xbUvFA
         lCuG/kIBJ+i/7g1gKSizsDKCie3aNSE5nTgYp98tpbCS4CyyqnhE6TuiMT23PY6h4uK3
         QikHqMAL4/vPeRE4qBhUHOED+bxNNXanKA3B9xuM2wiVPOVgQ6MFvxVOogUC3h3jVUF9
         LciPUrJPBn+u7TUP20KoHdn6SZ4j8JhdY/U2Sm658BtajFUEiLAQnfhLCVYndkwWHVjO
         OlcALKjQ9T9GKrBtYwh6sQ+ZfAswv/Ghtavdy3mO+MZ9WbgKXSCyiXaDhG5K7X+clMmm
         PNjg==
X-Gm-Message-State: APjAAAXHjrw7KEkd8NsYScvapL1wQgw+ppM31feKWLdut2D1qGbadClV
        gBB7kvvKOO35piwJ88rl9dYALg==
X-Google-Smtp-Source: APXvYqxFIGkuc2l23hZhsQeS86bnCNmzSmXwrXIRW2MPpe+DTrSSQZmfekPLccn6gHd1+XuMZzVL+g==
X-Received: by 2002:adf:f711:: with SMTP id r17mr6998984wrp.38.1551968096841;
        Thu, 07 Mar 2019 06:14:56 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm9679304wrv.11.2019.03.07.06.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 06:14:56 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: meson: add support for PCIE PLL
Date:   Thu,  7 Mar 2019 15:14:52 +0100
Message-Id: <20190307141455.23879-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds a dedicated PLL to feed the USB3+PCIE
Combo PHY. This PLL needs a very specific and strict register sequence
in order to correcly enable it and deliver the 100MHz reference clock
to the Analog PHY.

After lot of trials and errors, and since this PLL will ever feed 100MHz
with a static configuration, it is simpler to setup a dedicated ops
structure with a custom _enable() op applying the init register sequence.

The rate calculation ops are kept in order to keep the nominal read
ops as-in, but set_rate is removed.

With this setup, the PLL can be enabled and disable safely and always have
the recommended PLL setup to feed the USB3+PCIE Combo PHY.

Neil Armstrong (3):
  clk: meson-pll: add reduced specific clk_ops for G12A PCIe PLL
  dt-bindings: clk: g12a-clkc: add PCIE PLL clock ID
  clk: meson-g12a: add PCIE PLL clocks

 drivers/clk/meson/clk-pll.c           |  26 ++++++
 drivers/clk/meson/clk-pll.h           |   1 +
 drivers/clk/meson/g12a.c              | 118 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |   5 +-
 include/dt-bindings/clock/g12a-clkc.h |   1 +
 5 files changed, 150 insertions(+), 1 deletion(-)

-- 
2.20.1

