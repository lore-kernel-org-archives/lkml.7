Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D8C33C9C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D1124715
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cjQ0OZb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLMNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:30:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45937 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLMNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:30:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so6612742wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 05:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CcxRGFcCrtkq/Fa7c3EWJk3tVffr+ohpXoBBbiHwCUs=;
        b=cjQ0OZb/t830fsiw1m+88Q5m3W6dN8tb2EKys48brHEsYFriumeCBYH1gzs1T6XiNa
         KhtuxYzXEWvJPJ27bZlxSWvgp7VYtFnP2QlusXGZlXlPvJbKt2yi2FynYUxkpECpAjNm
         TG8sHRSnfxO2OIzRCaJjOpo0Puq/OiXDeuxQOxVouZaPxq1TPv8BC4HTqVZXsDFgTMVE
         gnT14QHP3ipUClIjCClxZu9mh6ubayg9egpQUtNgDdiDOctC5rkkQwl2TY0lewF4war9
         O5/PVU/RtFElEAoU45X82nuswfcKwyuaX0qqBIdLUPqb3f+GeNmBT6XkHKCD5RFxZOnw
         20Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CcxRGFcCrtkq/Fa7c3EWJk3tVffr+ohpXoBBbiHwCUs=;
        b=Zr9tTt6VGB+U2bKtDdBPmSmGimmLO+sTgumKvmDXSuHSmsk58+LFuVj1rVOSoeTUtL
         nu7nAiE0M8lwNsnYiGZo6eR1NjilaE5waWxpzoO0MhBsK3l6VmR+7FCuwIAPp/kkhqE7
         Xvf69SuUJkcmwkcAsrl4U9XIYCCtnrcQEOW0sKz9Q4/GNP+8c9U47URA+5xIvpoIUsui
         sEAz5aNQAQwYwQKTP85Ek/R5jTVkgSFiVwBmkWIPosRWvMSNTy2ksyoscJn3Cs2ntDtg
         RjxJ7WcrOIM8wYy4d1s7+V59rpm/D0B6z4FYqA1joz7hXcZd09mdmqwjhzZkrO+YakZx
         bVYQ==
X-Gm-Message-State: APjAAAUsPU4zM2kASXQiSISHPJNSLqnD3EVxWI+EcstQzDI3MQf0DkAO
        1o7MH6NVto1F/3/ei7THh6bg4Q==
X-Google-Smtp-Source: APXvYqz43qjGSJwCgT1Fuw9onIXmdIlL82ZNT9dug1PH1gM72NKtNtBBRiNR6mykRXSa3xxRxVS7Ig==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr13144184wrw.126.1576243798663;
        Fri, 13 Dec 2019 05:29:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id n3sm10540543wmc.27.2019.12.13.05.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 05:29:58 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support of CEC wakeup on Amlogic G12 and SM1 SoCs
Date:   Fri, 13 Dec 2019 14:29:53 +0100
Message-Id: <20191213132956.11074-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset add support of CEC wakeup.
We need to set logical address and activate some options in registers before going in suspend.
Registers address and options values come from amlogic driver.

Changes since v1:
- fix bad mask variable use to set logical address.
- use FIELD_PREP instead of shift value.

Guillaume La Roque (3):
  media: dt-bindings: media: meson-ao-cec: Add support of ao-sysctrl
    syscon
  arm64: dts: meson-g12g12: add syscon phandle in cec node
  media: platform: meson-ao-cec-g12a: add wakeup support

 .../media/amlogic,meson-gx-ao-cec.yaml        |  4 +++
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  1 +
 drivers/media/platform/meson/ao-cec-g12a.c    | 33 +++++++++++++++++++
 3 files changed, 38 insertions(+)

-- 
2.17.1

