Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD41B2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc6/+a7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDCEBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:01:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCEBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so7459413pfr.4;
        Tue, 02 Apr 2019 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxLrLCbVFtIy/2ubbj8Qeap60NlW6HHL3ONFbuGto3Y=;
        b=Xc6/+a7ewMlXoahd2w2kgGP7noBDg1B9iHlHEESf0VmW+YukMNx7AaElYP5em/g99G
         /g5KqlKZ3ndcEhOQjuy19sSea7bwnDFEZDV7P7VEy2vUEbEHdqRKJbosLwosPyPKn9io
         FiYeWfAuKdCpsdwwreQ/dtnLvMSCl5AMnQb0/qw71kvUBITWmFlo8Pu3qc3k9K8h4lFo
         5i9Eg3URjXmgjE6FWr0MIjaTJCv5ORLVR0KfKPLjhRqYrfSJB6NiO4rOO+eckKamSiOd
         KD5wF8Q120D6Frb6tIMFh810s0BoTqQEDJKnpRdkqkurHwaMWks9T6w8w8r7BJiSbaCq
         otpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lxLrLCbVFtIy/2ubbj8Qeap60NlW6HHL3ONFbuGto3Y=;
        b=qtQBmvhQLPsQxrnLM8lIZygi9jUnZjy97DRaO3Q26BlMKIbKyUClsLGExcZBpr57W0
         QvTaX3c4loRHMzUPnqpd93EWXKedJIDBAUrQZCmkbXZBad/6jP6P2D5EtxegLSLCVh2H
         ji+rcZZOazUkZNxhy7+cZuam09Cv/dOSn2mX0Zvx2bBHOxLE+a47S7ManxU6Ik4a7XXz
         mtIZH5j7CyGqfshKyMg8CCZJ1y8QS2nr8IC6J3Mfof8qVLALVLQipjW+9qK3NRqlx1NV
         SGnXKSPL9wv3+ZCUCI/FPzqwaLhiFku6EnccqdxVgL0Imk9yhco9CK/akFa98M3X51wb
         luOg==
X-Gm-Message-State: APjAAAXx4MXIQ+sYrCjJ2Eu/TWfv1oEgKKxODIEUku6bg65RPA+k+3eA
        Gy9dNSPbiaOyxhEpeIE7J7xlj9Aq
X-Google-Smtp-Source: APXvYqwswxkqLTa43qq9uT8QDHLUEggiP/JlvjaeuISf1CqJBWxGQhJf9aQM2QUIYtia7DCSrN1KpQ==
X-Received: by 2002:a63:d302:: with SMTP id b2mr9881105pgg.13.1554264110191;
        Tue, 02 Apr 2019 21:01:50 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] SPI GPIO improvements
Date:   Tue,  2 Apr 2019 21:01:21 -0700
Message-Id: <20190403040133.1459-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains a fix ("spi: Don't call spi_get_gpio_descs()
before device name is set) and improvements for SPI GPIO and driver I
made while looking at that code recently. Hopefully each patch is
self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (12):
  spi: gpio: Drop unused spi_to_pdata()
  spi: gpio: Add local struct device pointer in spi_gpio_probe()
  spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()
  spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()
  spi: gpio: Drop unused pdata copy in struct spi_gpio
  spi: gpio: Don't request CS GPIO in DT use-case
  spi: Don't call spi_get_gpio_descs() before device name is set
  spi: gpio: Drop mflags argument from spi_gpio_request()
  spi: gpio: Drop unused pdev field in struct spi_gpio
  spi: gpio: Make sure spi_master_put() is called in every error path
  spi: bitbang: Introduce spi_bitbang_init()
  spi: gpio: Use devm_spi_register_master()

 drivers/spi/spi-bitbang.c       |  66 ++++++----
 drivers/spi/spi-gpio.c          | 226 ++++++++++++++------------------
 drivers/spi/spi.c               |  37 +++---
 include/linux/spi/spi_bitbang.h |   1 +
 4 files changed, 154 insertions(+), 176 deletions(-)

-- 
2.20.1

