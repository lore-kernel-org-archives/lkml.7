Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED3FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7472089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mX9KMI93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEBKfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:35:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38645 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEBKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:35:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so905910pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wZru5L4BwlMPJIzUrAzcCZvzKe2NTmlwt/CFToiy7Vs=;
        b=mX9KMI93SFhiHFZmRrSsQkw0yfoNOZT/f3xuRGJIUlEe4sgZGellOCd6jb7ZIfjpOF
         8ISyT58zUe1pShow8tMD1VF3snDw8geJ+PVIMjeF+do/3flqK42ioDxBE2Wlu6p5+eym
         19d4unsAjG54qqhfbbXfsikKv4gFLho8iMv+CaEO4tZE2GEqR4DO9xZtpJ+sh/+HC/5y
         /pQWz0ejLdonONRlEjWq4825blVVvGfGp6UU7XXuI8kx/gRovHn6Erb+CfdPjNGWCMf/
         NgNXUhNXwIgiBSuBre/hUSZBIX7rqdNFQWymugF9C9mXqOIIzg/UPED10GjBtc2/H9Ck
         N8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wZru5L4BwlMPJIzUrAzcCZvzKe2NTmlwt/CFToiy7Vs=;
        b=gH+Vy0hq+3cAjO0F5NGC9bsgE8rh16IfYzjHdpGi1hzUTx1mTg6RgUuyFpnfgau9pu
         +nHD2bjBRom9D6cN64MV+I4bIYKjVsaacCwlsIGpqTJDBzgSBfhhYLkwJ4EPS+23KwPk
         /QFo5o75aFdCa8AnN8WxCoyOL8/Hf21+ZrhrSSKOmytR6NvPYFORXMToN1T9WAzG+EJF
         h0FGfvdBnOp9SF+oC/tF0j4mtOL32xaKLaBNZ/KNwOxNuju/FX5F+s2Y4JH02adAq+Te
         uTij1bNAJHmM4zPyimV8fl6q01uIwBOrDuhGzZMi0AzC0TICcOWY/gB8KTuDym2MzPMI
         L9UA==
X-Gm-Message-State: APjAAAX1GifAU8suquig4JHukkqf6oMTXqRT4kFNMUEM0wzt3EL1wzXP
        1JTfj4kRw2p2e/ihjIlcongnsA==
X-Google-Smtp-Source: APXvYqwhlRnOQWCW7OXs/Fj/+cKri7DVuTQHAbVswxgM3+H54vt4x285HDiFeTDUBiPVFAJHrPZ9ZA==
X-Received: by 2002:a63:4c24:: with SMTP id z36mr1290196pga.130.1556793310922;
        Thu, 02 May 2019 03:35:10 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id h187sm69141133pfc.52.2019.05.02.03.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 03:35:09 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 0/2] L2 cache controller support for SiFive FU540
Date:   Thu,  2 May 2019 16:04:51 +0530
Message-Id: <1556793293-21019-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds an L2 cache controller driver with DT documentation
for SiFive FU540-C000.

These two patches were initially part of the patch series:
'L2 cache controller and EDAC support for SiFive SoCs'
https://lkml.org/lkml/2019/4/15/320
In order to merge L2 cache controller driver without any dependency on EDAC,
the L2 cache controller patches are re-posted separately in this series.

The patchset is based on Linux 5.1-rc2 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Change history:
v2
- Mention the valid values for cache properties in DT documentation
- Remove the unnecessary property 'reg-names'
- Add "cache" to supported compatible string property
- Remove conditional checks from debugfs functions in sifive_l2_cache.c

Yash Shah (2):
  RISC-V: Add DT documentation for SiFive L2 Cache Controller
  RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive
    SoCs

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  |  51 +++++
 arch/riscv/mm/Makefile                             |   1 +
 arch/riscv/mm/sifive_l2_cache.c                    | 221 +++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c

-- 
1.9.1

