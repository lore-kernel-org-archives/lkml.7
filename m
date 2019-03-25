Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BA720870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Sab03Xgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfCYKO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:14:58 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35211 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfCYKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:14:57 -0400
Received: by mail-wm1-f53.google.com with SMTP id y197so8383075wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8o+LOU1T1ETU6b8hAChcmqvwxIICB9hO51bblD2L9U=;
        b=Sab03Xgv7Fjl6R5FlBon9XdX7SHnlouqsD+wv85qjeWYRzwH+KqMRt38uPCcn8Vdld
         mWxKgc6pmcRczSb3XKo3DZgl9eDoj56+AMUofjU2m1G3KKgukyzjvb4VYhFaFkKecb9/
         z/fAlsqeMBQG/StELz1L5nXArKb66KQ3rzPf5vL8scAJ1YNCxBe7qSilv+BLIo2SIHuW
         NsW7GF6dV6EcDs83+DdALzoJrS/eIsmQNXkzrwUD+Kd5ib53KYNp1LnzGoqL0R1tKKeH
         lr175Tbqm3Nt7dj1x4+sieO00lxjtVw5Apc3vuN6ve9Fph/tYEBHIORePhT7att/6+Y4
         YvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8o+LOU1T1ETU6b8hAChcmqvwxIICB9hO51bblD2L9U=;
        b=Uci56WMiydXcPS1clElhvTdhwtb1QpPpjo5oVszrmQFUECEDKBhFz/ZZ1Zj4iXUrgC
         I5gbK8djiZeBg53N6KbZFZKmQKo1g3TSQB2kAYDEMaVPYqVaqcU06zyFWBw1AtJH8Ghn
         KJEOcvAdWDYxxYfKOI+m4Mv6KQpgiHhwJIabOkbvz+9xExurrVBW5wzTlBmfQTDDQOyd
         W/RWGUpnSwV3kx6OaXXyDT8XpLWhjy4wX94arXzAsj5FK7IxLAZ/Uz/RppDobNX3CT68
         eUHeesllP018QuLAsgVuYql2xHf7n1ooqNuhuLDGuvcW6i0QhoJvNAkTlls+mvIzM2wX
         gJIw==
X-Gm-Message-State: APjAAAXb3aATsK6WOxyznqSKGAHEJuSmccVwF/tD5rHp8Vli0nnq7VFd
        5zujGeuoTv2CcFxQdDPJ7lxKMg==
X-Google-Smtp-Source: APXvYqxFXgCghasvdXR9NXeqm91C6VP9B+1+B8C875TVNExSHsoA58wXRlC3w3+NPQzhuj8uTvKCjA==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr7138333wmi.80.1553508895899;
        Mon, 25 Mar 2019 03:14:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:14:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] arm64: dts: g12a: Add boards peripherals
Date:   Mon, 25 Mar 2019 11:14:47 +0100
Message-Id: <20190325101453.3009-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following [1], add regulators, bluetooth and ADC keys on :
- meson-g12a-x96-max
- meson-g12a-u200
- meson-g12a-sei510

Dependencies :
- Patch 1, 2: None
- Patch 3: SAR ADC node at [2]
- Patches 4, 5, & 6: USB nodes at [3]

Changes since v2:
- Dropped already applied patches
- Collected martin's reviewed-bys
- Fixed x96 5v regulator polarity

Changes since v1:
- Collected martin's reviewed-bys
- Added missing regulators in commit logs
- fixed x96 dc_in regulator
- fixed includes overall
- removed dwc2 enable floowing disabled remove in [1]

[1] https://lkml.kernel.org/r/20190325100339.749-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190325100339.749-2-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190325100339.749-3-narmstrong@baylibre.com

Guillaume La Roque (1):
  arm64: dts: meson-g12a-x96-max: add regulators

Neil Armstrong (5):
  arm64: dts: meson-g12a-x96-max: Enable BT Module
  arm64: dts: meson-g12a-sei510: Add ADC Key and BT support
  arm64: dts: meson-g12a-sei510: Enable USB
  arm64: dts: meson-g12a-u200: Enable USB
  arm64: dts: meson-g12a-x96-max: Enable USB

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 35 ++++++++
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 12 +++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 84 +++++++++++++++++++
 3 files changed, 131 insertions(+)

-- 
2.21.0

