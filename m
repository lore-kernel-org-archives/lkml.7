Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA8DC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F8C215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRr/nzkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgAFBgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:36:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38508 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgAFBen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so35370216lfm.5;
        Sun, 05 Jan 2020 17:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXx8AiTiQfdwEaklBBCooH/CXMpEnuY2OdI9oQhNEoY=;
        b=eRr/nzkU2oFWoEEF/PKRz8Vx/Kqu/ABZyNema2H17iapZ+kax9iGpIJGSmHX9F8/Qn
         oVy3fNSI/OoGqffPJgwEZm2dubCuIGIIB1nuVkr3aqNyCFqDUgIwGc0oZM1KhEnoJOLf
         kzYF85Szg1u+cCilrmmQI0aC3P/V0udjNiOxAFKs9sazJpOM9qLgS1YK876ohQSqpIhd
         fC9r6WCGoSIqswSAMJbCkG33NfNkRpyCEUxZwJP01r+Zlj2lufdacWWYej0/RmOrnQWm
         itl88XOiiyvmO8XWyO8HAxnRlLeCXBIghMb0wEilGVBlW8ovF8taRGyRIqNu07I8DLMY
         lgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXx8AiTiQfdwEaklBBCooH/CXMpEnuY2OdI9oQhNEoY=;
        b=WpE16MNdQ01UdRF5mlStn4kVj4w/zbVC7bAzHrlliUVI1IrjXach6TSFDVkp1h00yS
         JW5p5mfx8BmYFoU7Nuw2Bt45ukyqU9liH711q2bJTTwAV598ldy7bYsWra3Xj6iBguJw
         A6bd5aEibGKnqMporjtbi8JusdAT0sP+JeFDCAQ7s+kcIQZueJ5cy40butPsAAzr09SR
         OZ9SiUBOtdJ0Jj0ooWrxvAr5RuIQMb62ftjO7FhojLdFG2qkVK0aLcXaUr2wMlcWg+AT
         k9XCYXI3I07Kks6CGe/eexvgQPA+Sl0hAhUwJBMvziIirQuXucUznPTGx7d8DzaN3EcQ
         Ogkg==
X-Gm-Message-State: APjAAAWO/gaBrQE6CD6z0x8yoaDaukDU6EielLgvfVv1AtqKSRiKRCBK
        8DtqpD52RPSYVAtpiHhdMT8=
X-Google-Smtp-Source: APXvYqyLNC7CfFJ5fYIaYrzTiJvJnDvbuLZna7+bIOX/WSAzztzloJnvs92To8krqE95BpYFL0bWDQ==
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr58574838lfk.76.1578274480972;
        Sun, 05 Jan 2020 17:34:40 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/20] NVIDIA Tegra USB2 drivers clean up
Date:   Mon,  6 Jan 2020 04:33:56 +0300
Message-Id: <20200106013416.9604-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series brings the NVIDIA Tegra USB2 PHY driver into a better
shape by refactoring code to match upstream standards, the ChipIdea/Tegra UDC
driver also gets a minor update. Please review and apply, thanks in advance!

Changelog:

v4: - Dropped the request_module() from "Add USB_TEGRA_PHY to driver's
      dependencies" because it resulted in a bit too many questions during
      review and since it won't be needed once Tegra EHCI driver will be
      squashed into the CI anyways.

    - Factored out clean up of ulpi_phy_power_off into a separate patch and
      improved it a bit move by disabling clock *after* asserting reset:

        usb: phy: tegra: Clean up ulpi_phy_power_off

    - Cleaned up ULPI reset-GPIO changes that were messed up a tad in v3,
      thanks to Michał Mirosław for reviewing it in v3.

    - Dropped the "Assert reset on ULPI close instead of deasserting it"
      patch because turned out that the problem was introduced by an earlier
      patch in this series, which is fixed now.

    - Added missed tegra_usb_phy_power_off to tegra_usb_phy_shutdown() in
      the "Hook up init/shutdown callbacks" patch.

    - I found out that PHY-enable refcount is broken after drivers reloading,
      added these new patches in a result:

        usb: phy: tegra: Keep track of power on-off state
        usb: host: ehci-tegra: Stop managing PHY's power

    - Added patch to clean up included headers in the PHY driver:

        usb: phy: tegra: Clean up included headers

v3: - The "Perform general clean up of the code" patch now cleans up couple
      more minor crumbs.

    - Added more "clean up" patches:

        usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
        usb: phy: tegra: Move utmip_pad_count checking under lock
        usb: phy: tegra: Keep CPU interrupts enabled
        usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd

    - I noticed that ULPI's reset is getting erroneously deasserted on
      PHY's shutdown, this is fixed in these new patches:

        usb: phy: tegra: Assert reset on ULPI close instead of deasserting it
        usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state

v2: - The "usb: phy: tegra: Hook up init/shutdown callbacks" patch was
      updated and now it does a better job in regards to checking whether
      PHY is initialized before it is started to be used and whether there
      is a double init/shutdown. This allows to factor out the ChipIdea's
      driver change into a separate patch, which was requested by Peter Chen
      in a review comment to v1. In a result there is this new patch:

        usb: chipidea: tegra: Stop managing PHY's power

    - Added few more new patches:

        usb: phy: tegra: Use generic stub for a missing VBUS regulator

      I noticed that VBUS regulator usage could be cleaned up a tad as well.

        usb: ulpi: Add resource-managed variant of otg_ulpi_create()
        usb: phy: tegra: Use devm_otg_ulpi_create()
        usb: phy: tegra: Use u32 for hardware register variables

      These patches are made in response to review comments that were made
      by Thierry Reding to v1.

      I also noticed that phy_tegra_usb isn't getting auto-loaded while it
      should be. This is fixed in this new patch:

        usb: chipidea: tegra: Add USB_TEGRA_PHY to driver's dependencies

Dmitry Osipenko (20):
  dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
  usb: host: ehci-tegra: Correct teardown order of driver's removal
  usb: phy: tegra: Clean up ulpi_phy_power_off
  usb: phy: tegra: Keep track of power on-off state
  usb: phy: tegra: Hook up init/shutdown callbacks
  usb: phy: tegra: Perform general clean up of the code
  usb: phy: tegra: Clean up included headers
  usb: phy: tegra: Use relaxed versions of readl/writel
  usb: phy: tegra: Use generic stub for a missing VBUS regulator
  usb: ulpi: Add resource-managed variant of otg_ulpi_create()
  usb: phy: tegra: Use devm_otg_ulpi_create()
  usb: phy: tegra: Use u32 for hardware register variables
  usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state
  usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
  usb: phy: tegra: Move utmip_pad_count checking under lock
  usb: phy: tegra: Keep CPU interrupts enabled
  usb: chipidea: tegra: Stop managing PHY's power
  usb: chipidea: tegra: Add USB_TEGRA_PHY to driver's dependencies
  usb: host: ehci-tegra: Stop managing PHY's power
  usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  |   4 +
 drivers/usb/chipidea/Kconfig                  |   1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c          |   9 -
 drivers/usb/host/ehci-tegra.c                 |  16 +-
 drivers/usb/phy/phy-tegra-usb.c               | 896 +++++++++---------
 drivers/usb/phy/phy-ulpi.c                    |  48 +-
 include/linux/usb/tegra_usb_phy.h             |   4 +-
 include/linux/usb/ulpi.h                      |  11 +
 8 files changed, 530 insertions(+), 459 deletions(-)

-- 
2.24.0

