Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183402087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vUJfOghB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfHENna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:43:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35525 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbfHENn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:43:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so73033396wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhUROw1HvhUxcOE9NaUVqqed4sa60oTqgrJfdf5Zd0w=;
        b=vUJfOghBWCqqLATCC18WkSf+axtMpfn3516CSlWGv8IM33ESEoYS7LgHT/JXThmFV+
         R50C/1ljsKosMRkum31NKzxE5GcDf1+cS4PqPboNZkOM842UqaJBkA6t+fVzr5B7cSw8
         XrDB8nUL6WKJ6Mv3ra5McwOCZvYWzVZDnZVLE8WfPFCysZiJfbQgJUiuCEnGzfFunNoe
         wyO7bkgzybB1vzbiu5vUMKJXNhS0d/6ZypXY2dk8Do5vE1HttC9naKxVdJJ53oPBMZlL
         3WC8lqxQs75xql5XaRGCWP6WetYgx47N/5VY5WQpugIwIDIdpTY4OBGqzyq6IPkpqlYQ
         MNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhUROw1HvhUxcOE9NaUVqqed4sa60oTqgrJfdf5Zd0w=;
        b=aUKuIKafJ39PkCawGX0z2RaAKWfMbFlXWeP+FJAep8x28wm7MXMQmtzE3cPYOLuJ50
         RfsEKY0FuBMfEEc3tY8caW1zES74AWpexvytwps2mQJEMVpI4TEOBDt8DT0AGw7BQ63V
         oiVMdLlPI6zcnD7qMIHhKoBIIEckZM+8Az2OdL2xybLxwuzpxMySEowcEKenimdBz9aD
         rKBHeZm5LJ30Zn1p7aICk3/sLatO+Y0E45NPLToGOYpPthZsl8ZkTJFJYfH1O8TpbZ8/
         HENYGhypht4VgrUMXlXSFIc+A6/Ddr0clKu5+gUX/eX4m4shXGoiHKeGtX3tWjWgQfuY
         t5ww==
X-Gm-Message-State: APjAAAXksKrYWyirnOU25Mcb5eQ/Fn6F7T1xnBhq0/l55iiqIdLtpv3o
        TPQuCQWhx3STjFSWVaz2A2U2kA==
X-Google-Smtp-Source: APXvYqwRQ8LTdh+aO2Wutd286Aw3WmG2Oy0ABsRw8fE9gC5QuZErdhrI3Sy/Vj9G8jN3TZSG3y4rYg==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr18523606wmk.92.1565012606039;
        Mon, 05 Aug 2019 06:43:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t3sm67835842wmi.6.2019.08.05.06.43.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:43:25 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/meson: convert bindings to YAML schemas
Date:   Mon,  5 Aug 2019 15:43:16 +0200
Message-Id: <20190805134319.737-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts the existing text bindings to YAML schemas.

Those bindings have a lot of texts, thus is interesting to convert.

All have been tested using :
$ make ARCH=arm64 dtbs_check

Issues with the amlogic arm64 DTs has already been identified thanks
to the validation scripts. The DT fixes will be pushed once these yaml
bindings are acked.

Neil Armstrong (3):
  dt-bindings: display: amlogic,meson-dw-hdmi: convert to yaml
  dt-bindings: display: amlogic,meson-vpu: convert to yaml
  MAINTAINERS: Update with Amlogic DRM bindings converted as YAML

 .../display/amlogic,meson-dw-hdmi.txt         | 119 -------------
 .../display/amlogic,meson-dw-hdmi.yaml        | 160 ++++++++++++++++++
 .../bindings/display/amlogic,meson-vpu.txt    | 121 -------------
 .../bindings/display/amlogic,meson-vpu.yaml   | 153 +++++++++++++++++
 MAINTAINERS                                   |   4 +-
 5 files changed, 315 insertions(+), 242 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml

-- 
2.22.0

