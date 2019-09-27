Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1116EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FDB2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr1+Uv61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfI0I2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:28:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37772 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0I2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:28:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id u20so793804plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NbFqGjxE2PnbU6z1Ec7WUi7n4X/b/Z/rHpPihB2LfiE=;
        b=Nr1+Uv61tYBYR/gUeeunQBRJzDTbsfg0GWvMsad63gteY4RtQNSRpjeTGGNkFBUVd0
         eh4r8/Lw0VLOg1PBeJieR+OzvTouP0Le87sDd7coeFfMNGA/m4uRaKtHUrDnpCDJJvXs
         /r7TGahl1/9m5QxvOjdrjWlikA91e3ITT6tQ/3kE8LQa5pYBxZciKifLi4qH9xvMu3hz
         lpBf0lZ7wph5QmxBqpdso9gt2IexvuFiNBU2YInsUjY57uDWZMWNOh3OA7fCjLkR585v
         EgcvZXWKp777yZplzAiK7Vksf3N5viFUkOGC0LjBqfGPVZE7RrcAStM3v9FnrZ45OtYm
         bkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NbFqGjxE2PnbU6z1Ec7WUi7n4X/b/Z/rHpPihB2LfiE=;
        b=Ns+Pb6LBTV36N/kjhV6tWz3QTOx48UmXYwpuQiGrulZgzs8luXKHYmABmP1yULP2yB
         GJrkwGVKNsu5dUvpoC6HYLm3W6KXbxMSq2BlahzK4t9GSStKpLItMsMI46c29yRghG3S
         a7E8Iwqy1XZNMmYrEdZWgxQ2DJ0sx+Z649Q/PIbAZrBuM5sSEmeKPtC7DL0UtXUlLeuZ
         cIQFSr1m/GjGEBqwkwCT78o82zvIWtrt/cdecdxsoESrBP2i4wQ3g8T33RVPa2GBiA9t
         1vk2cR2JyUbJJkDk/NkJG16do8ma+aTISUFI87fENMrGHb8TBg3dnI54mvAFctl1NuO2
         CIIA==
X-Gm-Message-State: APjAAAVdYP8JSxRJYR3TsLOXzqTsZLbcGO6BQQ7hmSBJwyYo1UmTk/Ye
        OzGo8A01OoVaS7GsD+heSisbLg==
X-Google-Smtp-Source: APXvYqwBR2/4d/E5sZqWUkMQbkc18m5T+0zVPlzOpWrkai8yINxJ1zE85vRfNhXyjmTVdE4u1KlrzQ==
X-Received: by 2002:a17:902:d887:: with SMTP id b7mr3087377plz.297.1569572886073;
        Fri, 27 Sep 2019 01:28:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm2043521pfa.162.2019.09.27.01.28.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 01:28:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     baolin.wang@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Optimize the u8500_hsem hwlock driver
Date:   Fri, 27 Sep 2019 16:27:40 +0800
Message-Id: <cover.1569572448.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set did some Optimization with changing to use devm_xxx()
APIs to simplify the code and make code more readable.

Baolin Wang (3):
  hwspinlock: u8500_hsem: Change to use
    devm_platform_ioremap_resource()
  hwspinlock: u8500_hsem: Use devm_kzalloc() to allocate memory
  hwspinlock: u8500_hsem: Use devm_hwspin_lock_register() to register
    hwlock controller

 drivers/hwspinlock/u8500_hsem.c |   46 +++++++++++----------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

-- 
1.7.9.5

