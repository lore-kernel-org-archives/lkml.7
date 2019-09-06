Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB839C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57AD20693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwm8lWGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394476AbfIFOd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:33:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33510 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbfIFOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:33:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so6874568wrr.0;
        Fri, 06 Sep 2019 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YhOPiGQ/jKMfAKNMmBIBmilg3dwIp+IShaOpXqxWprg=;
        b=Dwm8lWGdUfC0GE7Rtw818ox0Io/TAtpAZBPZwpQUuPsDnSRSlrYN+jCD9mNWWFgdK4
         j4a0eB5omczZilSZ7ulLqflJcjHmKtm3/5FwVDYfDWUd2NWx+8VgQvQ+VvXgkQLc/w3Q
         TCO8DOlc9P3rYEoO+da2Fy6JtnNOP/DK8O+ny8ekeDW6ksFcpwWBOlzcWISQm0z/0kGi
         OmIBA8Ebfswojg9WcOK8TXLX2mqd0DknsH7t/Rw63q9erBbkT7BAs46SvDpBskdxrlCm
         SPeQPK1kDW8kCxfMZWH+k0/Iju1spAq8DuZm7ePQ34F4UdBA4gi+IL2hVZ44vpKM6BIw
         byBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YhOPiGQ/jKMfAKNMmBIBmilg3dwIp+IShaOpXqxWprg=;
        b=gWS2bpWZEStFgMeI0Z6j8ZAzPQZyiAFl7rOtOQj02FC8JSN9rkGSdPHneQ6LzyJpI3
         miYrcXUdihKesnFRRSRalhrKtEaA8zSgygVzlMRXjQ26UQGq+4g3kgKXkEsH1ki8Pm2b
         D020TKFdvKrCjTJZQOjbAZi1Td+Lkf3+XMhLaG1oKiYE5jQCjSFM0TWYRuBNQNgB8/LL
         DOeptgj2opfrhGyQPIGTCps60mC9uAd6yh+QAj/GpOuz6rPAFIbrD0TVaO7dcHDggm2C
         HwH34j43t0BZS8Y0Dd+WsA4D9AJ43BFrfmnUee33zKgL7K0BmiwXr69gndaJV94OQ477
         CvrA==
X-Gm-Message-State: APjAAAUEqFKde/5jzZXh3KgB69L0KdOIDddzrP6Ps2YuPvPyTTGsq42Q
        +kCD2yOaW4YFJkpkaPl5aP0FjWvkNxWuMyAc
X-Google-Smtp-Source: APXvYqw8wZl/LTWgg0Chrhk0TDYioBtuoFUHLvwZXVA3/hte6Kq+jsmDp9J3p5QcsrlFvFLn+mterA==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr7431909wrw.104.1567780404007;
        Fri, 06 Sep 2019 07:33:24 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s9sm9300198wme.36.2019.09.06.07.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 07:33:23 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [RESEND PATCH v3 0/3] arm64: meson-g12b: Add support for the Ugoos AM6
Date:   Fri,  6 Sep 2019 18:32:31 +0400
Message-Id: <1567780354-59472-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Ugoos AM6, an Android STB based on
the Amlogic W400 reference design with the S922X chipset.

v2: correction of minor nits

v3: address regulator and GPIO corrections from Neil Armstrong (using
schematic excerpts from Ugoos) and related v2 comments from Martin
Blumenstingle. Add acks on patches 1/2 from Rob Herring.

Christian Hewitt (3):
  dt-bindings: Add vendor prefix for Ugoos
  dt-bindings: arm: amlogic: Add support for the Ugoos AM6
  arm64: dts: meson-g12b-ugoos-am6: add initial device-tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      | 557 +++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts

-- 
2.7.4

