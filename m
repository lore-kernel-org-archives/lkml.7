Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C112C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1569206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9B12o/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfHOCeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:34:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39978 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfHOCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:34:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id e8so944260qtp.7;
        Wed, 14 Aug 2019 19:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UvlpKIEKzdLNWsDOs0SJoKEMJzb7R21bNGBtN9YQupI=;
        b=K9B12o/Yk2y89tU5fX97Xxbj7+PKroF6OTW+/7iukW5ZkrqtUIYRCDFTmKFWq0dA7J
         dBDrHA9PQQRdgHGrrc5K9BM102yHCRlWO2j7iMu5Z55fIQwhnDRCG5JqPFyBaJ7L2ftI
         ly52UtUychblOGnZZRfGlMCiXCrf0tW68i3ib8r8At5RfwPydwQLVRW+86Tx2WzjhwEU
         amZjwP3WM3ESFobEHCy6KnNd0QRt1IEhUTFydH5oFyQ8VYRAoRlsTZ81b2zpyMVtHEYc
         TTewAtBkkXRXg4VK1V7LIngtKpa4YX/Zcb04KTf961N6IHRlwf4BpfxDsa4u1XbIJVft
         FOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UvlpKIEKzdLNWsDOs0SJoKEMJzb7R21bNGBtN9YQupI=;
        b=ZOr7em0VxAXVDMoOOha01xQhVObGQR+owbas9ZvHI9KCy7TQtxzcX5Heg082t2jPmd
         YLG3sPB4YCZcf7GslkI1vDFFQBT0EaYJm/AEc/HI8LvAfmdg34k5UcSiwfsV/BazF3Yi
         X+iG9oGVOyyRm9mJfwfBTwy8WFeSSXhWzwrUHVt/wJgt8AjvktHK8FX/fDr3w+apl1xz
         ciwKE6gYCw5RakTNm1PdTlN8pdGFOUvhAjsnkDPIuTbXjN4JKDPYBKQIo2UFPpm+Hu77
         UVBWbwCHBcC1826T2Z/r9zusXB7Rk7ALDxJ6+TCg2GweL6fZpzfg5lqGDAon+C4ALWW1
         Glow==
X-Gm-Message-State: APjAAAXyt7Fo/h1eEdrKILsE/w/zLtYLy5fCJdwjs+41CAy4XYSzCIsf
        rpJVBQSTcPUPsd7uliPR9HvE6oIQoa2E/19i6Q==
X-Google-Smtp-Source: APXvYqyCgBZijuxiTiA6Ykjy5y3SBRER44fM5dusRcWlJHLBF8cB3s/O0u7LwJN6OQs5ElV+jL+J/Yy3PZiiMG4DeE4=
X-Received: by 2002:a0c:9782:: with SMTP id l2mr1911229qvd.72.1565836488982;
 Wed, 14 Aug 2019 19:34:48 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 14 Aug 2019 20:34:37 -0600
Message-ID: <CAL_JsqJRJp8a_sytr2C_18muxt4ehGQRdfu8n8J70HdRz-gFHw@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.3-rc, take 3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.3.

Rob

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.3-3

for you to fetch changes up to 83f82d7a42583e93d0f0dde3d61ed10f75c0f4d8:

  of: irq: fix a trivial typo in a doc comment (2019-08-14 20:12:16 -0600)

----------------------------------------------------------------
Devicetree fixes for 5.3:

- Fix building DT binding examples for in tree builds

- Correct some refcounting in adjust_local_phandle_references()

- Update FSL FEC binding with deprecated properties

- Schema fix in stm32 pinctrl

- Fix typo in of_irq_parse_one docbook comment

----------------------------------------------------------------
Lubomir Rintel (1):
      of: irq: fix a trivial typo in a doc comment

Nishka Dasgupta (1):
      of: resolver: Add of_node_put() before return and break

Rob Herring (2):
      dt-bindings: Fix generated example files getting added to schemas
      dt-bindings: pinctrl: stm32: Fix 'st,syscfg' schema

Sven Van Asbroeck (1):
      dt-bindings: fec: explicitly mark deprecated properties

 Documentation/devicetree/bindings/Makefile         |  4 ++-
 Documentation/devicetree/bindings/net/fsl-fec.txt  | 30 ++++++++++++----------
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  3 ++-
 drivers/of/irq.c                                   |  2 +-
 drivers/of/resolver.c                              | 12 ++++++---
 5 files changed, 32 insertions(+), 19 deletions(-)
