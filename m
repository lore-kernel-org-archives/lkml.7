Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA533C282E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA17620675
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=babayev.com header.i=@babayev.com header.b="RPgmgTE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfE1DWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:22:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46694 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfE1DWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:22:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb3so94619plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 20:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txkPYx4kl/dbr2peXVzI1JFIF8M0v7UB6YuZExmYRSc=;
        b=RPgmgTE070YVO9U/nSaukvceq0z2LI7bXy7zOuS7TU8p0LInnNih5j7BECvhrURzaA
         mxTWhkNYa0Z3IJYe8lRswb0XVbKZ1NPbn9sPGi4X3Xyox5YK5GvS7Co/yvOtqoxfx/4h
         k+xL8PEz2ZonoAumksNuC7eI6sg2A3y13B01I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txkPYx4kl/dbr2peXVzI1JFIF8M0v7UB6YuZExmYRSc=;
        b=LgeguwuMRl0TnjwMIrGtK3CYJM+QrTv37a5tEyW3Z7tjOwO3n/IZZaLtki9555LlNo
         gCepKhD4F+Q9ziw3AVHP4eiDjv7IPr8jLF2UFpL9rhXWBImcAw3rX3D34uSqKA4khQ2z
         3hVnuEFnFvmkmaP/pSoZlG13QZZuoyoRQTtbA4jjjPc8SZBi1rgvVRsokYHrTOh8aB/W
         oSOHm5wo+bvGNecV8upwSVBAzuERVMZaxRg5NZFFXEDgZYW2cVGZ44qyYjPtNwSjnC26
         mEn3gyH179OYHstCcUyyhZAX3cmxYgM9L0Zfrcxauj3MT+cIpx+eZpOZkForxgnADF1s
         jIug==
X-Gm-Message-State: APjAAAWO8ajn8gXss4Ynk40KWQAlozweijoRZ+ThdI2eMbqh9YXGAWRO
        8mNes3gn9BQpZEe13oJ9CBqhjA==
X-Google-Smtp-Source: APXvYqxZ6q0wb4tst0o7iW9zQi1zpzrRqJ4aOJnY2Q1Qy1NYBL2UVXh9DmnyYdL6fagHbkPJ7Ew49w==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr2837278plb.314.1559013734376;
        Mon, 27 May 2019 20:22:14 -0700 (PDT)
Received: from p50.cisco.com ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id h71sm933042pje.11.2019.05.27.20.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 20:22:13 -0700 (PDT)
From:   Ruslan Babayev <ruslan@babayev.com>
To:     mika.westerberg@linux.intel.com, wsa@the-dreams.de,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [net-next,v3 0/2] Enable SFP on ACPI based systems
Date:   Mon, 27 May 2019 20:22:11 -0700
Message-Id: <20190528032213.19839-1-ruslan@babayev.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
v2: more descriptive commit body
v3: made 'i2c_acpi_find_adapter_by_handle' static inline

Ruslan Babayev (2):
  i2c: acpi: export i2c_acpi_find_adapter_by_handle
  net: phy: sfp: enable i2c-bus detection on ACPI based systems

 drivers/i2c/i2c-core-acpi.c |  3 ++-
 drivers/net/phy/sfp.c       | 33 +++++++++++++++++++++++++--------
 include/linux/i2c.h         |  6 ++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.19.2

