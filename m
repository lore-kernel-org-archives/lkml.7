Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC6E20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IXXSssla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENJQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:16:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52183 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfENJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:16:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so2030186wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3anIj92/L8NrlG9u2N2Y8IF5jQd43C2YjhwBflKNMM=;
        b=IXXSssla/+rsSsLeIQf7AF8zrXr53GrMS3dwAZ5bi8fbwce53xVHsstXJZQRkQnahB
         4G1giDmXV9ty/pmgqgwE0l5xv/yFpHLVKBLaANncHC/18mwC3Bw8m0fOpU+iJIOkocwI
         LQWTDGeDYO9kvMgFGwoNhw/u6X5Q9JN3cdzZSqCAwZA47amoJmr0iugoodMpw77SgoyH
         dEzoZWVgu3GNG3mm3si2VroGHSx/nr1k48HgzO6gszphhv8Cyn8PgS4qNmE784MZXv/1
         WaTBIyrR96OS1lwMHcRpf3dFR/IlRTo9paXSb9HzsVfVdptMTnAzBEDDe4GfADhMT6RI
         nlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3anIj92/L8NrlG9u2N2Y8IF5jQd43C2YjhwBflKNMM=;
        b=VTroCRr4OLJywf8887LcnOTMXPIByB30PToS0iN/xbiVTIWm6etK9Jc/fZVTRaRfE2
         /By06n9fSEcOOREtyZ5ILXXlBGvxsHwGiD5NJt1qdzRyzlxRxI77Slm79jHXS+/IJ4w3
         4DrXGkFWvw3RJvIIbyXAdFdCBY06CKlbyTtIJS5EZOrtB3onQil5LkVwhmAi7I6UOrN2
         DM81cTxPl7ANK5PuQm9FTV/SxVUovzW+uqcnSUpYkjAcVflaMwg/eCkw7w6VVOR1WAnd
         OBcK5qBVCB0E3E4V6BpQJjwiwN8HE7rb17V3CrQhWmNVjVssBbIYkKN3rkObFF6R/PLq
         jhCg==
X-Gm-Message-State: APjAAAVDyiQfR1VCcNF+ZhsDeVVK18JBAeaxmXyGE1F8fQfMws2UMuKx
        FFOV9ec/RgEMvriipXiAHQ6kyw==
X-Google-Smtp-Source: APXvYqwDWrDprnELvTySHIjnfYtG6C2tdrAZOARpxWykbzC0+OO4QdgMq6o9CfdvYnb7h0lLWx/6Nw==
X-Received: by 2002:a1c:ab0b:: with SMTP id u11mr18572373wme.26.1557825374721;
        Tue, 14 May 2019 02:16:14 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y40sm17737158wrd.96.2019.05.14.02.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:16:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson: g12a: add mmc B and C
Date:   Tue, 14 May 2019 11:16:08 +0200
Message-Id: <20190514091611.15278-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the MMC controller B and C to the g12a SoC as well
as the u200 and sei510 boards.

MMC controller A has been left out on purpose. This controller is
special on this SoC family and will be added later on.

Notice the use of the pinconf DT property 'drive-strength-microamp'.
Support for this property is not yet merged in meson pinctrl driver but
the DT part as been acked by the DT maintainer [0] so it should be safe
to use.

[0]: https://lkml.kernel.org/r/20190513152451.GA25690@bogus

Jerome Brunet (3):
  arm64: dts: meson: g12a: add mmc nodes
  arm64: dts: meson: u200: add sd and emmc
  arm64: dts: meson: sei510: add sd and emmc

 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  42 ++++++
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  42 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 124 ++++++++++++++++++
 3 files changed, 208 insertions(+)

-- 
2.20.1

