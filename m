Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F01C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770BA2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qG4vPYt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDBGn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:43:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfDBGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:43:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so5847400pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RqCEVgmWB4DBAl2GVSfpMnJt/uaanoBEbafi8Msj4Hs=;
        b=qG4vPYt1k4iOj5W/+ZMPmXLnxByUkOjjDSWFm77PSLbaCzLFyTWyLJFfND/FG8hq4T
         +GIAoPisI7G65pwzgsSm9gvxQkN29NOAVmDia8mracWFcUlVIH5w2NMeKRPbrAiuYy+y
         Mf7umocjs9SFiZ/Ja+s9V6TCC9T3/NHm7IiAqjrZpv20kr6TCH//DskH+Dav+pNJIfWG
         V9dV4kdVg6Z88oCNd/4RLZ0nHaWstnNMVEbWIAIQ3OvJIxC+PMwRUtnxnbOG/vNdUqUO
         RG2Jr5lStp+Rvpmkye+7xA/QYqk/V1p42JGpKqdbQYeH/qU+yFQajRQPUWK7cyDTcFtp
         nuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RqCEVgmWB4DBAl2GVSfpMnJt/uaanoBEbafi8Msj4Hs=;
        b=isr/VuqYLFhILIlJSry0L9mZtu14GLlnXvpYxUJlOqFPd7bqiA3CFuDHKozoh50Wmc
         YE9+MabHMFxWT6D0kUXa4ulh5fNauRJEkNTH/MbvtomC5n1kNHR5gi70TUCENzcV7DKa
         vp5bgeKkGxDTxsMKlauaUspjyWlgDNtfqX3cGs8FT+8nDhp5tNvkt+jtulkYuchoJBnw
         k1gULehnHVXvhcgAMGXFXGVT9gZ09F7lUN3SXQ0SIP3c2WgobJ1aC3gARIs3Pofc272E
         BiIi22eFVRr4E6OOOhcn88wlasftI7uYTn/XORs3SHDhrXgexTNXKku3DwbPbJaUQODz
         8jxQ==
X-Gm-Message-State: APjAAAWll1htU/7WRYvUOWI5n8X4n7JFpx+5rUepRBzGN07sOqR+ZqoM
        WeSpc83CIZDm007YGNIxY8LldA==
X-Google-Smtp-Source: APXvYqw6Fcp/XqcEo3iTBKxbt2DKQ1of9+pzIZk/sKjVUBzAmu8uDd4sHsD40AZcGZBbjYMyF6o8Xw==
X-Received: by 2002:a62:70c6:: with SMTP id l189mr14796752pfc.139.1554187406329;
        Mon, 01 Apr 2019 23:43:26 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id p128sm25577996pfp.30.2019.04.01.23.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:43:25 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:43:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     thor.thayer@linux.intel.com
Cc:     arnd@arndb.de, dinguyen@kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, olof@lixom.net, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, mchehab+samsung@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, ARM and Net due for the 5.2
 merge window
Message-ID: <20190402064317.GA4187@dell>
References: <1552342688-6663-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552342688-6663-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-arm-net-5.2

for you to fetch changes up to 8f4ebe9b331ef3d39c8375ff38c623f26dbc1735:

  arm64: dts: stratix10: New System Manager compatible (2019-04-02 07:38:27 +0100)

----------------------------------------------------------------
Immutable branch between MFD, ARM and Net due for the 5.2 merge window

----------------------------------------------------------------
Thor Thayer (6):
      mfd: altera-sysmgr: Add SOCFPGA System Manager
      dt-bindings: arm: socfpga: Add S10 System Manager binding
      ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
      arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
      net: stmmac: socfpga: Use shared System Manager driver
      arm64: dts: stratix10: New System Manager compatible

 .../bindings/arm/altera/socfpga-system.txt         |  12 ++
 MAINTAINERS                                        |   6 +
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/altera-sysmgr.c                        | 211 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   5 +-
 include/linux/mfd/altera-sysmgr.h                  |  29 +++
 10 files changed, 275 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mfd/altera-sysmgr.c
 create mode 100644 include/linux/mfd/altera-sysmgr.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
