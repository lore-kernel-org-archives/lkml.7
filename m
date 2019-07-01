Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A719C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B632089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGzO/KE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGALnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:43:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33087 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfGALnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:43:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so13514770wru.0;
        Mon, 01 Jul 2019 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=768bW+NBh3+M3cU3i7aWM2KWkFJQXIv+KDZnW0aUxDw=;
        b=fGzO/KE1PbbBO3YoNBTkiFv/0lPAPJa3G3huWilN2bh+A3xomDymBTf4zszJ+u0cZ0
         /S5oKrJuHTH6SakpJwUIWYQcbOtB7vEceOocdTcm2r/o7Kz4AxjT4UemrxQtpyy9JD+6
         FiUwDnLdoxK60gHOCvP2AkR0zaDZkgSdGO/16LODcKc/yQOPc1oR7ZSjJgGiB2R+tf5w
         k5YvWHfxNUbmrs0i+gQLcNUWpsVI0IZ7Uq+lDSLEGtSiq9liZZ/WWOjnDXztzrQT1TyR
         mzcJK6kvBKNS4KMQQVUase2Q3XiwXxWdkSLI25unSrJYj7tgAnUph5CaCvRL91G1qie3
         stug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=768bW+NBh3+M3cU3i7aWM2KWkFJQXIv+KDZnW0aUxDw=;
        b=mOq+mf1avmmFUubXBVOlY1UCvm7mJS3MM6MIJqTtR1zjHACijz9RhX8cB9plWiHYTE
         7vg9Fq17KBHjTp5SUaFIFysMqnrl1vTAnzbLrxwkutmZ1+vQb/kHHt3iE/jmLZcxw+pq
         Ll81JH4KEkcKkQiIVppdzBoFas/s2DOlv43aD/Bvxos8W2O47V405oanqm/8VIfLiEwE
         zEX/eJYVCNp1qlOwu4FCbvZsCMp9mqOt6Jr9Hh/SHbajU8B7A83/AzvysSSEPPYnZzq4
         0CWqudaAcP8HE0ANy20Ehps7T5w1cmj9FuEAo8yagKLoE6oT0VHr77L9jhCLdnXQpBnY
         J6pw==
X-Gm-Message-State: APjAAAXxuaX2rb34IluEwMkQKSHzAbjvCw+W1HTLX6iuc8bq3bX647FA
        sOVZpms8gj5w8FD32LsfCOo=
X-Google-Smtp-Source: APXvYqz97AjjKDd/aHt72illIwPvryzQx9js81DBV6FxfQtGr3jfKNEQRfUKkH6Iy5kVOpm/dxXJOA==
X-Received: by 2002:a5d:6449:: with SMTP id d9mr871439wrw.192.1561981377568;
        Mon, 01 Jul 2019 04:42:57 -0700 (PDT)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id f12sm23658907wrg.5.2019.07.01.04.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 04:42:56 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
To:     aisheng.dong@nxp.com
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 0/2] arm64: dts: add basic DTS for imx8qm-rom7720 board
Date:   Mon,  1 Jul 2019 13:42:44 +0200
Message-Id: <20190701114253.1538-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is ontop of Aisheng Dongs clock driver changes for the imx8qm

https://patchwork.kernel.org/cover/10824537/

This patchset is based on next-20190222

I need information about the status of the integration of the imx8qm clock
driver into mainline. Is this ongoing?

I need some hints why the imx8qm-rom7720 do NOT boot with the following
changes. It stops at "Starting kernel ..."

Oliver Graute (2):
  arm64: add gpio4 and gpio5 to basic DTS for i.MX8MQ
  arm64: dts: add basic DTS for imx8qm-rom7720-a1 board

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8qm-rom7720-a1.dts  | 221 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |  19 ++
 3 files changed, 241 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-rom7720-a1.dts

-- 
2.17.1

