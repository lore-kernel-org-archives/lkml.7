Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9123C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AD020693
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaD1ffDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfDBOoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:44:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41316 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbfDBOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:43:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so6495731pfd.8;
        Tue, 02 Apr 2019 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=V8Wxerb8QVMUr4ZXeNBhHGdpEoEGh1gCyzHLGU+/dXU=;
        b=UaD1ffDJYnpHOW8iB9+5Es9z405COdYBBpKbD2UfnPnfEwsZQs/TDDZFb5rUPDc7pQ
         vs6V6LuSags9BOmALuIv21iKL108HerVaX7o9GEr4i7Ofw0ALIdrzi51wpYl+CCmuvP1
         dJd78S4mN/Qqzfiu5NPCqZ8p/7inpVEX2uGojopDKikvra6fU5zU9mZgQYZLIyCNWJf0
         VGp11tLL0+q2aLXr8jXWthY0mfXLX7yDSKGBhcqdQszW2A8US3/ypCfoiI+9qYKRgjeH
         u5EDdta8zeVGTFvnCJwebcfZHevUM5SweKvV8A4CMjWaQYsOmYKL0J4HQ+tVqzr7szP6
         hJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=V8Wxerb8QVMUr4ZXeNBhHGdpEoEGh1gCyzHLGU+/dXU=;
        b=NMTv8akPaFmup+OBhj6SYvF0ijXnVWGGlzW2wG+/N1faXpCmXvQsVveI7PfBHnZQaf
         SRN7JlTOpfLd3K85Ye3Oup1JIzfgx6uWQ70Vv1UjroCnG9E834nmc3IpkeNYf/G5pICT
         6vfF+9OI64b1aqp9G8ycrN1GVfWaa2QpiYcrWd3VzCnjMoszTDuW2L+p+Bcj4Y9DsFmc
         eWL4ueHErTYISgUC0HXshN+xNcof9im3V1IMWCYYYxQ1PPzqlwbS+q7DhKuwWYgcOHtj
         JICRL8l+PwiS7w94f7YK0S1y9yZ9EZ0WfFuHN6T+KSvlkiaB5stcpkly+XD3cj0M3MD7
         USzg==
X-Gm-Message-State: APjAAAUCOs6Aa5VL4L73UowVwes7vIE1BGFMdEF+2cecekC7knFVqHLS
        pt/hLrwyvvRKiAUp4cANMnAsWN3z
X-Google-Smtp-Source: APXvYqzTvj272Lm9Qe58pDb2GspngMFHKHvu0udFGpOpiENAxdclUyc2rSGDXwsMQ9hNRno7/arBcQ==
X-Received: by 2002:a65:6205:: with SMTP id d5mr11610002pgv.61.1554216239132;
        Tue, 02 Apr 2019 07:43:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16sm21208768pfz.106.2019.04.02.07.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:43:57 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for hwmon-for-v5.1-rc4
Date:   Tue,  2 Apr 2019 07:43:56 -0700
Message-Id: <1554216236-7074-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux hwmon-for-v5.1-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.1-rc4

Thanks,
Guenter
------

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.1-rc4

for you to fetch changes up to d3b018f757560ab5c2bce0e7f46e0c1510d7afd4:

  dt-bindings: hwmon: (adc128d818) Specify ti,mode property size (2019-03-29 09:52:00 -0700)

----------------------------------------------------------------
Couple of minor hwmon fixes

----------------------------------------------------------------
Axel Lin (1):
      hwmon: (w83773g) Select REGMAP_I2C to fix build error

Carlos Menin (1):
      dt-bindings: hwmon: (adc128d818) Specify ti,mode property size

Eddie James (1):
      hwmon: (occ) Fix power sensor indexing

Guenter Roeck (1):
      hwmon: (ntc_thermistor) Fix temperature type reporting

 Documentation/devicetree/bindings/hwmon/adc128d818.txt | 4 ++--
 drivers/hwmon/Kconfig                                  | 1 +
 drivers/hwmon/ntc_thermistor.c                         | 2 +-
 drivers/hwmon/occ/common.c                             | 6 ++++--
 4 files changed, 8 insertions(+), 5 deletions(-)
