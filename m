Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE1C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C587E21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ARPIhl8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfISKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:25:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33833 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbfISKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:25:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so2533243wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2A0oosZIpjBMenE6Tjm33BxMZdklQECEBVCtAhWMYQs=;
        b=ARPIhl8y30FO/F6oN6rrJzhE+e4JFkdGSwgjSFtfDZWZcWA/5EH5LBr4L6b0SKWglH
         UbVGQsTdPnHYSTM0FLHAvMtgmlZahzJaO25HwC8vbQ12W7cm3h9dFlL3FkstMUbU3S28
         4fm6Vth4wRpsGNZHNR6meJZD//S5QE3E6NFqQnYecq2YfXug/zatNdwqIm9lhAAKb9hY
         Mk7OrUEA6satXsZqIOlyBR39Nioo4KQgA4VYIhCnVz9Y91y2ppbs4ap7veYd6uCv2lOI
         pjhQdI9L7aOmQq/5zwbXHxCW9UhgyjR6TRmw74BMHQyWnyMsXrvAs6P17sdEuZdTqPji
         QWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2A0oosZIpjBMenE6Tjm33BxMZdklQECEBVCtAhWMYQs=;
        b=AfSEqB920KHUo8+XyQ/ghpM1YKYiUUoneMUxsF/F+oc5JfpRKiRNcrc8nHAFhEPq33
         p+r2PADunPo8rr1iUwyTDsCBoGEpwUam2oBx1MGSzP+On8f1QJSQYVRkAbbnwsEH8hPG
         +S6dhQmwsUZ4j+zHZf1Q8lKKGbw09BDAkFOr0FL6u0Fn3DIOGdneMxt3/CDFIW89yR5O
         xS/C+4nXjdqS21lBUKEqpd5l3G/t6llpWn8OJj+YfhNakFkO4XEE+D4FKLUXoT2tOWh8
         cMMl94bZV60xOV6xz/g9AcdFg4Q06i3CMi5IPSv97m8Q6+K0YL0mZtwhp2zKpaLwHEqE
         KGHw==
X-Gm-Message-State: APjAAAVipF2JaB7sHCoAOsvIUpBa3NSbMmg5n5O5uFvddl1fYlsGiRQV
        lHpIjJUNCcZooWry4+Kntyt9eg==
X-Google-Smtp-Source: APXvYqzpnu2phlLQMoNEuMIncosAx77n7gxWTvOlJbGfGU75RyLU3YIELaLuaI5zdmBNdg+SLbrCIA==
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr6471942wrh.195.1568888722613;
        Thu, 19 Sep 2019 03:25:22 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a18sm19542000wrh.25.2019.09.19.03.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 03:25:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     sboyd@kernel.org, jbrunet@baylibre.com, mturquette@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] clk: meson: g12a: handle clock hw changes while in suspend
Date:   Thu, 19 Sep 2019 12:25:16 +0200
Message-Id: <20190919102518.25126-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie aime to support when the suspend/resume firmware alters the
clock tree, leading to an incorrect representation of the clock tree
after a resume from suspend-to-mem.

For the Amlogic G12A/G12B/SM1 case, the SCPI firmware handling suspend
alters the CPU clock tree in various ways.

Since we know which part of the tree is possibly altered, we introduce here
the clk_invalidate_rate() function that will rebuild the tree from the
hardware registers in case parents and dividers have changed.

Finally we call clk_invalidate_rate() from a new resume callback to refresh
the CPU clock tree after a resume.

With the clock tree refreshed, CCF can now handle the new clock tree
configuration and avoid crashing the system on further DVFS set_rates.

Neil Armstrong (2):
  clk: introduce clk_invalidate_rate()
  clk: meson: g12a: add suspend-resume hooks

 drivers/clk/clk.c        | 70 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.c | 71 +++++++++++++++++++++++++++++++++++-----
 include/linux/clk.h      | 13 ++++++++
 3 files changed, 146 insertions(+), 8 deletions(-)

-- 
2.22.0

