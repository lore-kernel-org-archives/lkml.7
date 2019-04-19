Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C8C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8F620663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/L5hdEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfDSTrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:47:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38425 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfDSTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:47:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so7366011wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aSruXCIf56eTUnwd91mFJWvgWo5ilLOW75OOPS8G/vQ=;
        b=b/L5hdEywCgjzZXewVEgNkwkRzSctvTyMAgjLLfQe/+d8De14q8WZX75J9BSDobTku
         YUBJKbF348WamlAnWAxLY8sGTZvvMi2yJIx2ug6l/zntb9dohxh0wh4tCkJGuI1d0z8L
         SrQZhZStVkUneIGq++IlAWsT2hX5/S0B8XP0NSNA4FAlnN04Ysw+Lv2b4MR89PMJOH2K
         R6rVoL0zmApHrx57+z8sXYHfjMS321lOzp1YwQ0P4p7s/xPwQ8gOC71JF4DxI7SHCf9F
         Ret9rCen/YzJXaWJ+lP/WFlhuEObKsdn5HpdKtYREmNd66KMY02IMnL2faRr9dUPQJhh
         RAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aSruXCIf56eTUnwd91mFJWvgWo5ilLOW75OOPS8G/vQ=;
        b=Zmo1lMVHDrz0KtX9AOI5CtKfM+58vMCR2ret3h6+KrqgWw17IXoqb2HC6dwqtkxMy1
         3ix13ExORrt+TpNXiwXqk7a/qxvdMoyOHsICID37V9KVHZTWJlFGQ16ECQo/R6mKBdAf
         GZa3IyxmFxzvAN5dcyxed6ht2WQvqkXDPeSaCVbfyqzmKNk2pFsNG7KgAreloxCA1UQh
         HXOV5rlR/Y076KvL+EaQTpdkw5qXtb13+nRfvvvX2cwCbsey6uy8zZDzl7zATVd8lwob
         tWREfp5ILQyRXrKljiGz0IoTdRJaL3nFAqeg99U7Mjrxd/kJ64XFT9YxwSOgzUDL+a3n
         SFjg==
X-Gm-Message-State: APjAAAV+aLDiDGdPDq+lZPhqHS1KkvDeSNsIAnX+3oegLP/T1m6Mojgv
        LqIkz/IhUinAuFAMwcah1hPUflRbCNo=
X-Google-Smtp-Source: APXvYqxfjCfRWxLbTWBnUcA/cu/fK391O64x79gXKonNAQ0gNZuh0zwpSSvj2c3lV75vHBq3aiErZQ==
X-Received: by 2002:a1c:e0c6:: with SMTP id x189mr1764732wmg.4.1555662903279;
        Fri, 19 Apr 2019 01:35:03 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id t76sm5700147wmt.8.2019.04.19.01.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:35:02 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        xuwei5@hisilicon.com, mturquette@baylibre.com, sboyd@kernel.org,
        yuq825@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org
Subject: [PATCH v2 0/6] Add HiKey / HI6220 SoC Mali-450 support
Date:   Fri, 19 Apr 2019 09:32:55 +0100
Message-Id: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series adds support for the Mali450 MP4 GPU found on the
hi6220 SoC from HiSilicon. It has been tested with the
lima drm/mesa driver hosted on freedesktop.org gitlab,
and validated using Weston and kmscube.

As lima drm driver has now been merged this v2 series includes
one extra patch to avoid Oops when all Mali ip blocks share the
same irq.

regards,

Peter.

Changes since v1:
* Additional drm/lima patch to avoid Oops in shared irq case (Peter Griffin)
* Squash clock and reset driver parts to avoid bisection hole (Stephen Boyd)
* Add comment as to what other driver is probing same dt node (Stephen Boyd)
* Check regmap_write error code and return individually (Philipp Zabel)
* Add Rob Herring Reviewed by tags

Peter Griffin (6):
  dt-bindings: gpu: mali-utgard: add hisilicon,hi6220-mali compatible
  dt-bindings: reset: hisilicon: Update compatible documentation
  arm64: dts: hisilicon: Add Mali-450 MP4 GPU DT entry
  reset: hi6220: Add support for AO reset controller
  dt-bindings: reset: hisilicon: Add ao reset controller
  drm/lima: handle shared irq case for lima_pp_bcast_irq_handler

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  5 ++
 .../bindings/reset/hisilicon,hi6220-reset.txt      |  1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 38 +++++++++++++
 drivers/clk/hisilicon/clk-hi6220.c                 |  3 +-
 drivers/gpu/drm/lima/lima_pp.c                     |  8 ++-
 drivers/reset/hisilicon/hi6220_reset.c             | 65 +++++++++++++++++++++-
 include/dt-bindings/reset/hisi,hi6220-resets.h     |  7 +++
 7 files changed, 124 insertions(+), 3 deletions(-)

-- 
2.7.4

