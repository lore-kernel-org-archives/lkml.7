Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4319220828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kUL71Qtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfF1WnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:43:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39142 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfF1WnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:43:11 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so15823890iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=5I9M9/u3BZ2aesCKkS5M8mcyM6rCFJYJd1iKO2yILd8=;
        b=kUL71QtdPQdVUccvQZfpc22DDxFcjvj4MJqwWMEN45l0h5nd4Pj0GSgrjTnkIyz0Ix
         RzolfhQ5j/LXeOnzLGyWbNjzjiW6UtSXANUDt62OPMMoxjWq2DY79v8LoNB2dXTpTFAl
         czqhVM2+90C7fWBWvcdN4JPr61JyORlKq+1DXsASDiDPHs+FgNh5kmkaTovHOXkE4eCF
         gcXDNIkUay78UEV5+O4v4sbCdRLhVSPlURd8TozlbPXoX2hChHkUP+VFUt3qGbKAl7Gq
         h7HnbZL6C54JVtstXoS+3hxdB3/TfM3Wofrc3hOLsvWGmsuVxQyYr/xYJ86BNzg98CH4
         n0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=5I9M9/u3BZ2aesCKkS5M8mcyM6rCFJYJd1iKO2yILd8=;
        b=ow6ZLFHHM3Ac8DWbPeB+U9lRbKvpIPgWQfMLc/wKN2tAIU6ooSI+uhmZvzolgzXkFX
         EJt8zV5+El28XPKOgNbec9AlEVD1ZCewxfXVIR3wtGPSkSKOzN0d8JrxYIeZvPwC+7Tu
         Xy9b77q+Fdty6Z2xYwyr522wpDediKKPE6dcsCsh4vliQAcwD7int4n59LYwqsglVGYI
         T7mLh5FvXTbheEpr92rDlw4cq+0/m21UIHoDAULUOXpayDsYLxPmkUk+ilZWCk4oqmkq
         6T/EhXxUjVTWcyl/38sKSwPjbzq+Y7dqikYDLIJU56ib+ik9ShfbHZG/i7ydLEHfZ6d6
         VEfg==
X-Gm-Message-State: APjAAAUF0ribLFS5k3GiNMmAnQ2FCcxylV5TkhkHGRWYi5tk5MMYh3bN
        GVG94iK1xsVoIJ9Lms1QqXxlptTWv8U=
X-Google-Smtp-Source: APXvYqxU0Cc0XVc9WLJLPycKfFcWuc14NaIqc8o3JqONLOWWJ571FTA0VjrpfrmdPbE5HwtVP8SC7A==
X-Received: by 2002:a05:6602:2252:: with SMTP id o18mr12827600ioo.63.1561761790935;
        Fri, 28 Jun 2019 15:43:10 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id i3sm3148925ion.9.2019.06.28.15.43.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 15:43:10 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:43:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V patches for v5.2-rc7
Message-ID: <alpine.DEB.2.21.9999.1906281541520.3867@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-v5.2/fixes-rc7

for you to fetch changes up to 0db7f5cd4aeba4cc63d0068598b3350eba8bb4cd:

  riscv: mm: Fix code comment (2019-06-26 15:10:30 -0700)

----------------------------------------------------------------
Minor RISC-V fixes and one defconfig update for the v5.2-rc series.

The fixes have no functional impact:

- Fix some comment text in the memory management vmalloc_fault path.

- Fix some warnings from the DT compiler in our newly-added DT files.

- Change the newly-added DT bindings such that SoC IP blocks with
  external I/O are marked as "disabled" by default, then enable them
  explicitly in board DT files when the devices are used on the board.
  This aligns the bindings with existing upstream practice.

- Add the MIT license as an option for a minor header file, at the
  request of one of the U-Boot maintainers.

The RISC-V defconfig update builds the SiFive SPI driver and the
MMC-SPI driver by default.  The intention here is to make v5.2 more
usable for testers and users with RISC-V hardware.

----------------------------------------------------------------
Atish Patra (1):
      RISC-V: defconfig: enable MMC & SPI for RISC-V

Paul Walmsley (2):
      dt-bindings: riscv: resolve 'make dt_binding_check' warnings
      dt-bindings: clock: sifive: add MIT license as an option for the header file

ShihPo Hung (1):
      riscv: mm: Fix code comment

Yash Shah (1):
      riscv: dts: Re-organize the DT nodes

 Documentation/devicetree/bindings/riscv/cpus.yaml  | 26 ++++++++++++----------
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |  6 +++++
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 13 +++++++++++
 arch/riscv/configs/defconfig                       |  5 +++++
 arch/riscv/mm/fault.c                              |  3 ---
 include/dt-bindings/clock/sifive-fu540-prci.h      |  2 +-
 6 files changed, 39 insertions(+), 16 deletions(-)
