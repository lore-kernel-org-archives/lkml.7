Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA8CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF60020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="T6fqjNs/";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="caJWXrR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCQPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:48:11 -0400
Received: from node.akkea.ca ([192.155.83.177]:34200 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfCQPsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:48:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 58F314E2050;
        Sun, 17 Mar 2019 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837690; bh=unGjJltg8u9g2EY98mxhLEZEt6mxzTeC2pwjMH5zOvg=;
        h=From:To:Cc:Subject:Date;
        b=T6fqjNs/o7KSb9Dk2iIzfCG/fd/rIa0k2d7BIwkNULf8wbqUpgYjCGOQ7hk65E2HU
         LqFmmGZq8/8JBEfxx0pSBBwWRNPIQyRV/DoTwPWkWLBknzip+XBBFIlXz/swpSDlz+
         FPIvPIa2YQKuEMY1eN6XrvO7r3FW4WT9XuCuoU38=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LHUApSl3AATF; Sun, 17 Mar 2019 15:48:09 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 7275B4E204B;
        Sun, 17 Mar 2019 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552837689; bh=unGjJltg8u9g2EY98mxhLEZEt6mxzTeC2pwjMH5zOvg=;
        h=From:To:Cc:Subject:Date;
        b=caJWXrR/23zXdrStR9xGz8ZQQAbgBVTPcWGyfaKfY+9uZ2Up0zDqvtFG144tauCb3
         HAH2a/ebz4QybTd3w6Q2wqPBP4/k00Wek2zCo0BLASE7ic+dPa57iFeF/WmdmKwYGP
         MB42eLJLeXGWd9BW8lyXdGQpYE8kF8Oz1YNJEI7E=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add a VCNL4040 light and proximity driver
Date:   Sun, 17 Mar 2019 08:47:57 -0700
Message-Id: <20190317154802.15174-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Vishay VCNL4000/4010/4020/4200 driver to work with the VCNL4040
chip.

Changes since V1:
    Separated byte vs word bug fix.
    Separated device tree hooks.
    Separated devicetree binding patches.

Angus Ainslie (Purism) (5):
  iio: light: vcnl4000 use word writes instead of byte writes
  iio: light: vcnl4000 add devicetree hooks
  dt-bindings: iio: light: add vcnl4000 devicetree bindings
  iio: light: vcnl4000 add support for the VCNL4040 proximity and light
    sensor
  dt-bindings: iio: light: add vcnl4040 devicetree bindings

 .../bindings/iio/light/vcnl4000.txt           | 24 ++++++
 drivers/iio/light/vcnl4000.c                  | 77 ++++++++++++++++---
 2 files changed, 91 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt

-- 
2.17.1

