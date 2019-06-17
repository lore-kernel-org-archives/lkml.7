Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE68C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8447208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bkgOc2/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfFQT34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:29:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35343 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfFQT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:29:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so11289409wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+faE7f2i5p9Exif1Tqt8gr1N97noY/QwTIkSkdvT3og=;
        b=bkgOc2/3ZUHCQSxFhp6RqNALsLKkn4tZVsorTRiDz7F3zc3bQNADsPmg82zVowvcZJ
         p42/8gSGuUzolct0ah3c6bnkOCgs+kXl9gnviB8mmoqexielke/sCZJ3utz7f7QpI9UM
         JrNWLHi8YsNpZFFs9zC7pApEVclq21iVyoY+QJhTnfNBHVbq72VDY8XbJ3ztLDXkQ1cq
         wuV5Dl6OA8QDybIHh193Gm0dea7yQrrKMTdQItwYgepNffLLuFpoxT284OYmKzeiWUY3
         c53hiU2XvpjpHLz2gQEvcNoGoGYlsvG4FCyYxZ9/GvD1Bfx8z9WgRBG3yNlwfKl9zoFB
         3ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+faE7f2i5p9Exif1Tqt8gr1N97noY/QwTIkSkdvT3og=;
        b=OacFLtMcSVHO00Sa0lXSgdBkg6tKedUJq3N0KvZ7PU+CDwgguJ1fnqVHzyzITMDS4n
         ClLYfbThvyN4hAWGDUwFJWcMvLT5QKN4900VTzSsUT5FptLAgdpPfbatFZ8v3zieqcWb
         tNmkawpvuHVGqEA2RoqyFAEZIWDaJdvR6wNk3d4I1mG91ygDxFKDLYNZfOQTIy5eL0RW
         1mN+6dMUuB7PmShn/cu9kCYojxPoFmk1o9cpeXsz3z+SQYPnVcS62528RK8fLzBcBySN
         A4Ga6xApz13K2IAlFGkyk0dk41JQZXZ8yeOR7XemQH0IgCUTqcSYAPRMwwOQpVsPOj0U
         Z0zA==
X-Gm-Message-State: APjAAAVPY+FOxtgQAHsPu2+6TekBfy4iHmK6D4rEN2YZ9CZsddfN7F5N
        f8BZ0rMH8zKB6jEqXojFzLtOoQ==
X-Google-Smtp-Source: APXvYqyH0bOBhea4+sw3VkCF82H7R+OQIXS9OUZ21Ftc6szY5AP5ukvB6GwAFBNv0VgCDCQyTYIy4w==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr25518129wrs.152.1560799794897;
        Mon, 17 Jun 2019 12:29:54 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com (cust-west-pareq2-46-193-13-130.wb.wifirst.net. [46.193.13.130])
        by smtp.googlemail.com with ESMTPSA id u18sm9412034wrr.11.2019.06.17.12.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 12:29:54 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/3] riscv: add SOC_SIFIVE config for SiFive specific resource
Date:   Mon, 17 Jun 2019 21:29:47 +0200
Message-Id: <1560799790-20287-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following is a patch series that adds a SOC_SIFIVE config.
The purpose of this config is to group all the code specific to the SiFive
architecture such as device tree and platform drivers.

The initial thought/discussion came from [0].

[0] https://lore.kernel.org/linux-riscv/20190602080500.31700-1-paul.walmsley@sifive.com/

Loys Ollivier (3):
  arch: riscv: add config option for building SiFive's SoC resource
  riscv: select SiFive platform drivers with SOC_SIFIVE
  riscv: defconfig: enable SOC_SIFIVE

 arch/riscv/Kconfig                  |  2 ++
 arch/riscv/Kconfig.socs             | 13 +++++++++++++
 arch/riscv/boot/dts/sifive/Makefile |  2 +-
 arch/riscv/configs/defconfig        |  6 +-----
 4 files changed, 17 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/Kconfig.socs

-- 
2.7.4

