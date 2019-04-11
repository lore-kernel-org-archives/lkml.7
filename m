Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1E2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CWZrJl4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfDKWBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:01:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36895 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:01:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so8479069wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=USu0U08XtV62/FT9Y9Zw6NN9l+FpUxSZTLC2grbjDtk=;
        b=CWZrJl4Vr7VzKxx4cuNrkwzXvIhQIEfjKSZI99fOT5xoTTBPIFfNC4x1k2/Ehi5YGE
         cJLZz13nPJucNqWvqlx/Ol3o8Yb4yvARPRelZNiAjlxtQ2yylVm77DBAfzRqxd2G4D5k
         wKawDinP0rtC7FqirFT5TqwBU6HDUa6N6PlIVbIyinUCNoxUR9JpnYSEVHqsnYC2qC/n
         Blatm/jNmqQstPsj0SvkKwOS3/Mrd0AluYcEuvfosUAI6QgRvtPRbYvUzy+iSj4nS5Qe
         C+PRbgd/rM7XaApOmLpVVDYqj1v32bFm8lctgHhFP+dTpdpkORpQ/1jqDEAdt38WLTAU
         8/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=USu0U08XtV62/FT9Y9Zw6NN9l+FpUxSZTLC2grbjDtk=;
        b=VSusQMSnLBByKDMMVYf+dlr4F5KKFLE42wEw/X39zTIB9myPs8NFQv9ZWjpS3HlKE2
         dVNaD1cEE7sPQ11c7vtaQhBhlRBs4a6Nv7SHeIKYfOzymfUni/GZdhUNjyN2X+gE5RCa
         tlXTK6+4P4/kVU60/UMesrRYZvwpqLX73WM1payoEY+PXh4m0uvDPLzEujtzc2X6eJXK
         EtwZHRpAF1moAvkowR8gHH4z8PWOkI5fH1tE0JeLTBwdE2JsMGldooBN9Cf0tkyeI5oe
         A1swiQOvBH/IUbTH+RNzaBOlpZlnANdj6Hy5bQlDfX8DabWn1/tN4DA/O+K593lr6UPL
         JkRg==
X-Gm-Message-State: APjAAAWYkhHQyobXMvBe3AMtbZkVAm0L0BvBqZ9jAPyu2HUDUnLbKL9m
        Sp6EmSlBlJUQ0Ex44DKIkPI=
X-Google-Smtp-Source: APXvYqwrbxKve66ns57EPKWCyRVS1dNWITS6KhJEq0fgugMXjWKS9x4TQNLghNMdLAeaq01QCtsMTg==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr8237655wmf.118.1555020080027;
        Thu, 11 Apr 2019 15:01:20 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0009F15067C8D22C31.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:9f1:5067:c8d2:2c31])
        by smtp.googlemail.com with ESMTPSA id s189sm13266186wmf.45.2019.04.11.15.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:01:19 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     liang.yang@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        jianxin.pan@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] meson-nand: small code improvements
Date:   Fri, 12 Apr 2019 00:00:52 +0200
Message-Id: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series comes with four small improvements for the meson-nand
driver:
* the first patches are replacing open-coded logic with existing
  utilities / helpers
* the third patch drops some unnecessary casting after changing
  the type of the info buffer parameter from "u8 *" to "void *"
* the fourth patch adjusts the usage of init_completion with what the
  documentation suggests

I have tested these patches as best as I could on my Meson8m2 board
using experimental patches on top of this series which add support for
this older SoC to the meson-nand driver.

Liang, can you please test this series on GXL and/or AXG so I don't
break the NFC driver on these newer SoCs? All of my GXL/GXM boards
have eMMC instead of raw NAND, so I cannot test it on these newer SoCs
myself.

This series is meant to be applied to the nand/next tree.


Martin Blumenstingl (4):
  mtd: rawnand: meson: use struct_size macro
  mtd: rawnand: meson: use of_property_count_elems_of_size helper
  mtd: rawnand: meson: use a void pointer for meson_nfc_dma_buffer_setup
  mtd: rawnand: meson: only initialize the RB completion once

 drivers/mtd/nand/raw/meson_nand.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.21.0

