Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69672C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3874B206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2L4v7kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfKJA0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 19:26:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46661 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfKJA0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 19:26:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id e9so9968902ljp.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 16:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kNdZCj9DxVSyJ54jFBc2LZR95Z/ZrF07viZLOlvp5Oo=;
        b=B2L4v7kV4XR3aAFp2SwaJgfqWPhwTPGC+uzshrMX/vej+uxLd8WPOm5+A5M3P4GM+x
         WzkjBm1nLbaPI5JMlolB/vz76ZUR/XswHCNN323qePpp4sAYrWbD5RzQVeaq2CtEqVBx
         NiILr228Ny1GzAWhf8zSoOT9EDr305jVgTZCBYlOD2GuGhoWiX1eALyP10A9/cFBP8Dk
         WMQ6L0DWG6IcILnaaqqddLB7h3eZAsxJFiyiJ5X33v8+eaT1XjuXApUwE6dosJgqaQsS
         7ZZfwsf0zjglOK/gX4v0LKXE4gSeaG29HHxYuXyo7x/8BC211LMUY9dWp6DicutHhBvO
         VsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kNdZCj9DxVSyJ54jFBc2LZR95Z/ZrF07viZLOlvp5Oo=;
        b=EQFSjkG7TPGuJamueECi6fS68Ow/OJmLA8SdfS/6wY2qlznx78lQlUcDtenoDGFhnT
         6XJIQxpEXsVMYAIy1GQambyBHhVbXGDAQoPJagSUkfXAQmTmzkE2LUvSm08agCT+PDkg
         OSy0mO3fxMFUC6wXjYxvIRSdpxsyWlA9fbPBmiJ8rWfWtHA9R9umUzxbRyGWYh08LDEt
         vMlP4YBYl/vO9rRaKrrQVD8pte+pSQwKVL2hbS4zfmb4qIDUfTVjlabwJ+04HHo21Hbt
         h5Gw6F1hhs6c9DE5guuz4BDYc3SE2v6ZqIeieLgQ3T5xeG0Od+IF3RaAnercjZnBpcDD
         phfg==
X-Gm-Message-State: APjAAAWH4muMp+FjxRDw8RIdPIyAu+LsY7UIUx6kgKJ1tdrUN/ux9CaP
        wNFoDkTxvzPLJlItQxjHVUmV/G7VCDfUQNmYUvSO6w==
X-Google-Smtp-Source: APXvYqwwaWtPuF8fF5ikvLI1b9nFQd7zXD5T43bCvBvGUWGON/qsxJ1TDidLoXKq3/SN2x1D7qqx1ozVfJ5eB9hKBcI=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr11484420lji.191.1573345598170;
 Sat, 09 Nov 2019 16:26:38 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 10 Nov 2019 01:26:26 +0100
Message-ID: <CACRpkdaomX3PGdf9LPvi+S2yzTCs0f-G+TJkdfo=5HcoOJjehg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some late pin control fixes, mostly Intel stuff.

Details in the signed tag and the commits!

Please pull it in!

Yours,
Linus Walleij

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.4-3

for you to fetch changes up to 63e006c107ff4235d2a8fd52704f283d23642537:

  pinctrl: stmfx: fix valid_mask init sequence (2019-11-07 10:06:46 +0100)

----------------------------------------------------------------
Pin control fixes for v5.4:

- Fix glitch risks in the Intel GPIO

- Fix the Intel Cherryview valid irq mask calculation.

- Allocate the Intel Cherryview irqchip dynamically.

- Fix the valid mask init sequency on the ST STMFX driver.

----------------------------------------------------------------
Amelie Delaunay (1):
      pinctrl: stmfx: fix valid_mask init sequence

Andy Shevchenko (2):
      pinctrl: intel: Avoid potential glitches if pin is in GPIO mode
      pinctrl: cherryview: Allocate IRQ chip dynamic

Hans de Goede (1):
      pinctrl: cherryview: Fix irq_valid_mask calculation

Linus Walleij (1):
      Merge tag 'intel-pinctrl-fixes-v5.4-2' of
git://git.kernel.org/.../pinctrl/intel into fixes

 drivers/pinctrl/intel/pinctrl-cherryview.c | 26 +++++++++++++-------------
 drivers/pinctrl/intel/pinctrl-intel.c      | 21 ++++++++++++++++++++-
 drivers/pinctrl/pinctrl-stmfx.c            | 14 --------------
 3 files changed, 33 insertions(+), 28 deletions(-)
