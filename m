Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4168C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78B820578
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAgSh8i9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfIWOOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:14:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40483 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfIWOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:14:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so14128915wru.7;
        Mon, 23 Sep 2019 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ipEvkTrDUAQZ6A9pj0LrEG9sqsJpRZyjqmkY4uDpwI=;
        b=aAgSh8i96OGbdM5LwzM1GgkU446nP7S236VaBnX9OkxS4QhsBI9a4qDoNc/if9ZPEK
         ElwXynkGa4OEfoOvhaZliPGOjQolMPhBPmjjhKYxYqm3fXjaqfKbeMDpvcO7MukVM63d
         n89B3qJHbaUV1VECag9lVca4gVrBSqhB6NktMa9cVHez0s6+0mMmLmWZaKTkQSewPFne
         wCUpH/RBNl6PPNt2mfVM+Eg4XwFt+YsQGZFei78N01wJRDREQW68K8pnzmDoHxybui4K
         IxU0DifKXjBCcickZHDaEQeS6ihiFew8iBdhtVcMsCKSzuJQk8IiqgAEy4k4rVGXqs/I
         It1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ipEvkTrDUAQZ6A9pj0LrEG9sqsJpRZyjqmkY4uDpwI=;
        b=GONvqzCMnkMvcK2quhHxyOZimfFBCYSnmFenCwBPBQ+hPbFS1DXkLEAPETRpaYJAq1
         3Ugp0+BAPI1jX4R6KRzZbWoSjp186JisFt4PFUNLiF2+E05Skylcrgsub2mh8qX+IQQI
         6D/mzbig9Hnmj0/a3qziCDx3FM+UuJ1dpcclrCZu+mi1FziP2lka5rAiyCYyc33v6pPL
         1aqwWFQ2ZRIhN0ioRMw/G23C9+bNiUtzBjkse3+ngpPe5K/aq+HdlwvWB4bw4sIfI3AX
         mXTw439o06D5JlLwdIJgnXs7FFJMQ5kOOrm0jfqg0vEtUr0HWoYnJ9HvC0FT+2aFFUbP
         /7hQ==
X-Gm-Message-State: APjAAAUdJpDwNhF9E4fjD114oG11Vxp1I23vI2HiooXl9aGLka6P4tSc
        Xnn1fHtj8NIU4YNx/mKlzbTBkp7zKKU=
X-Google-Smtp-Source: APXvYqw9HAjjnuXBdavuZ0SRshgnZYju0QLuOimouoUS/1DbePdxtej/ae9JRg50dT7Zh7zfycLseA==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr12325276wrq.139.1569248086133;
        Mon, 23 Sep 2019 07:14:46 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h17sm7001700wmb.33.2019.09.23.07.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 07:14:45 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Ivanov <balbes-150@yandex.ru>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v5 0/3] arm64: meson-g12b: Add support for the Ugoos AM6
Date:   Mon, 23 Sep 2019 18:13:53 +0400
Message-Id: <1569248036-6729-1-git-send-email-christianshewitt@gmail.com>
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

v4: address nits from Martin except for the vcc_3v3 node as it's not
known how to handle the vcc_3v3 regulator managed by ATF firmware, so
it remains untouched/undeclared like other g12a/g12b/sm1 boards.

v5: corrected some tabs v spaces issues introduced in v4.

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

