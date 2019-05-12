Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA45C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791192146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9Y0sCqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfELBZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50264 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfELBZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:28 -0400
Received: by mail-it1-f194.google.com with SMTP id i10so11318434ite.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIY61+72OuRAN3957lP5LhKCVDoCPp0jWpmduEMaRh4=;
        b=P9Y0sCqobkC+s9Spr0dR3Sw5WvbI4yjuscRMI7xoLIxWsnmLWZVFqzZj78yDJHQQb3
         BFBhe+mTZtyi16plFI46QZLZ24fd1nzCn2rk08nvuK0EXw1fnQXWmtUQEaskkvHOBPXi
         5e95fV/WUvrjNrCr8w8LJWS8lBN5H2Ey/pfv1r7ExkPNlDZBThux4b8y7bXmNztBmq40
         7zljySsIFelf5eUlYk94mcMNI0lkC6rUYv/e6AGfJ+dZLpRdLBuHR0o5Fw4lnqcAJk1Q
         I6c4hHMfppHv3IPrOxZ+ROnBurdotII7CwIXf9KkPrbceS7gzjfg1PAK2qdnoKj4Us31
         dfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIY61+72OuRAN3957lP5LhKCVDoCPp0jWpmduEMaRh4=;
        b=UdVOvNF/R9ZLrgg3kVxCwdHA8HMuEmHViNQq21TD7GMLcmnCeZIXrOTp4gJxVylLYs
         M0NFke1w9OA4VDrNv2LfUgzCO6qAmv2Ryk0C+N1ORlaTJj5iDlHqzbsiIcaRhDevprv8
         yPdbcXAFMZ8f7nEWrrIk8fYvMhv5jTyTGRTQ05or9bn+681oTvrxkCIK7Gwb4PMGSSJH
         LCuvcYRaVUQw1CbiV7SFI7tEYpgb3LNSCd46qJ7HZhKMTwXTL1sejB8ST0B/yn96AQBs
         Z/liULRd3F3EnjiPDhhf6bA48ut8LQ6/j4T5h7i9ppzsF+A92n8RdvATGMWnKaAOIO7L
         Xg1Q==
X-Gm-Message-State: APjAAAUuvNGBaACQfcjywfLwg/dOuZbb88XW+foiQILlPEA9/0nstycY
        1QFIV4D6qGtAYLrT+ghmyYyQ0g==
X-Google-Smtp-Source: APXvYqzlN7JnkgSHzaDmBu8FHBSjixDGHoVfzppcLe54cOuUt4TO+cKqeMiYd4qGNmP6I/EOu9OuyQ==
X-Received: by 2002:a24:1a07:: with SMTP id 7mr14461192iti.16.1557624327634;
        Sat, 11 May 2019 18:25:27 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:26 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 00/18] net: introduce Qualcomm IPA driver
Date:   Sat, 11 May 2019 20:24:50 -0500
Message-Id: <20190512012508.10608-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series presents the driver for the Qualcomm IP Accelerator (IPA).
The IPA is a component present in some Qualcomm SoCs that allows
network functions such as aggregation, filtering, routing, and NAT
to be performed without active involvement of the main application
processor (AP).

Initially, these advanced features are disabled; the IPA driver
simply provides a network interface that makes the modem's LTE
network available to the AP.  In addition, only support for the
IPA found in the Qualcomm SDM845 SoC is provided.

This code is derived from a driver developed internally by Qualcomm.
A version of the original source can be seen here:
  https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree
in the "drivers/platform/msm/ipa" directory.  Many were involved in
developing this, but the following individuals deserve explicit
acknowledgement for their substantial contributions:

    Abhishek Choubey
    Ady Abraham
    Chaitanya Pratapa
    David Arinzon
    Ghanim Fodi
    Gidon Studinski
    Ravi Gummadidala
    Shihuan Liu
    Skylar Chang

A version of this code was posted in November 2018 as an RFC.
  https://lore.kernel.org/lkml/20181107003250.5832-1-elder@linaro.org/
Fixes addressing all feedback received have been implemented.  It
has undergone considerable further rework since that time, and
most of the "future work" described then has now been completed.

This code (including its dependencies) is available in buildable
form here, based on kernel v5.1:
  remote: ssh://git@git.linaro.org/people/alex.elder/linux.git
  branch: ipa-v1_kernel-v5.1
    f5d4a676a981 arm64: defconfig: enable build of IPA code

					-Alex

Alex Elder (18):
  bitfield.h: add FIELD_MAX() and field_max()
  soc: qcom: create "include/soc/qcom/rmnet.h"
  dt-bindings: soc: qcom: add IPA bindings
  soc: qcom: ipa: main code
  soc: qcom: ipa: configuration data
  soc: qcom: ipa: clocking, interrupts, and memory
  soc: qcom: ipa: GSI headers
  soc: qcom: ipa: the generic software interface
  soc: qcom: ipa: GSI transactions
  soc: qcom: ipa: IPA interface to GSI
  soc: qcom: ipa: IPA endpoints
  soc: qcom: ipa: immediate commands
  soc: qcom: ipa: IPA network device and microcontroller
  soc: qcom: ipa: AP/modem communications
  soc: qcom: ipa: support build of IPA code
  MAINTAINERS: add entry for the Qualcomm IPA driver
  arm64: dts: sdm845: add IPA information
  arm64: defconfig: enable build of IPA code

 .../devicetree/bindings/net/qcom,ipa.txt      |  164 ++
 MAINTAINERS                                   |    6 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   51 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/net/Kconfig                           |    2 +
 drivers/net/Makefile                          |    1 +
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |    1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |   24 -
 .../qualcomm/rmnet/rmnet_map_command.c        |    1 +
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  |    1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |    1 +
 drivers/net/ipa/Kconfig                       |   16 +
 drivers/net/ipa/Makefile                      |    7 +
 drivers/net/ipa/gsi.c                         | 1741 +++++++++++++++++
 drivers/net/ipa/gsi.h                         |  241 +++
 drivers/net/ipa/gsi_private.h                 |  147 ++
 drivers/net/ipa/gsi_reg.h                     |  376 ++++
 drivers/net/ipa/gsi_trans.c                   |  604 ++++++
 drivers/net/ipa/gsi_trans.h                   |  106 +
 drivers/net/ipa/ipa.h                         |  131 ++
 drivers/net/ipa/ipa_clock.c                   |  291 +++
 drivers/net/ipa/ipa_clock.h                   |   52 +
 drivers/net/ipa/ipa_cmd.c                     |  372 ++++
 drivers/net/ipa/ipa_cmd.h                     |  116 ++
 drivers/net/ipa/ipa_data-sdm845.c             |  245 +++
 drivers/net/ipa/ipa_data.h                    |  267 +++
 drivers/net/ipa/ipa_endpoint.c                | 1253 ++++++++++++
 drivers/net/ipa/ipa_endpoint.h                |   96 +
 drivers/net/ipa/ipa_gsi.c                     |   48 +
 drivers/net/ipa/ipa_gsi.h                     |   49 +
 drivers/net/ipa/ipa_interrupt.c               |  279 +++
 drivers/net/ipa/ipa_interrupt.h               |   53 +
 drivers/net/ipa/ipa_main.c                    |  920 +++++++++
 drivers/net/ipa/ipa_mem.c                     |  237 +++
 drivers/net/ipa/ipa_mem.h                     |   82 +
 drivers/net/ipa/ipa_netdev.c                  |  250 +++
 drivers/net/ipa/ipa_netdev.h                  |   24 +
 drivers/net/ipa/ipa_qmi.c                     |  399 ++++
 drivers/net/ipa/ipa_qmi.h                     |   35 +
 drivers/net/ipa/ipa_qmi_msg.c                 |  583 ++++++
 drivers/net/ipa/ipa_qmi_msg.h                 |  238 +++
 drivers/net/ipa/ipa_reg.h                     |  279 +++
 drivers/net/ipa/ipa_smp2p.c                   |  304 +++
 drivers/net/ipa/ipa_smp2p.h                   |   47 +
 drivers/net/ipa/ipa_uc.c                      |  208 ++
 drivers/net/ipa/ipa_uc.h                      |   32 +
 include/linux/bitfield.h                      |   14 +
 include/soc/qcom/rmnet.h                      |   38 +
 48 files changed, 10409 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.txt
 create mode 100644 drivers/net/ipa/Kconfig
 create mode 100644 drivers/net/ipa/Makefile
 create mode 100644 drivers/net/ipa/gsi.c
 create mode 100644 drivers/net/ipa/gsi.h
 create mode 100644 drivers/net/ipa/gsi_private.h
 create mode 100644 drivers/net/ipa/gsi_reg.h
 create mode 100644 drivers/net/ipa/gsi_trans.c
 create mode 100644 drivers/net/ipa/gsi_trans.h
 create mode 100644 drivers/net/ipa/ipa.h
 create mode 100644 drivers/net/ipa/ipa_clock.c
 create mode 100644 drivers/net/ipa/ipa_clock.h
 create mode 100644 drivers/net/ipa/ipa_cmd.c
 create mode 100644 drivers/net/ipa/ipa_cmd.h
 create mode 100644 drivers/net/ipa/ipa_data-sdm845.c
 create mode 100644 drivers/net/ipa/ipa_data.h
 create mode 100644 drivers/net/ipa/ipa_endpoint.c
 create mode 100644 drivers/net/ipa/ipa_endpoint.h
 create mode 100644 drivers/net/ipa/ipa_gsi.c
 create mode 100644 drivers/net/ipa/ipa_gsi.h
 create mode 100644 drivers/net/ipa/ipa_interrupt.c
 create mode 100644 drivers/net/ipa/ipa_interrupt.h
 create mode 100644 drivers/net/ipa/ipa_main.c
 create mode 100644 drivers/net/ipa/ipa_mem.c
 create mode 100644 drivers/net/ipa/ipa_mem.h
 create mode 100644 drivers/net/ipa/ipa_netdev.c
 create mode 100644 drivers/net/ipa/ipa_netdev.h
 create mode 100644 drivers/net/ipa/ipa_qmi.c
 create mode 100644 drivers/net/ipa/ipa_qmi.h
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.c
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.h
 create mode 100644 drivers/net/ipa/ipa_reg.h
 create mode 100644 drivers/net/ipa/ipa_smp2p.c
 create mode 100644 drivers/net/ipa/ipa_smp2p.h
 create mode 100644 drivers/net/ipa/ipa_uc.c
 create mode 100644 drivers/net/ipa/ipa_uc.h
 create mode 100644 include/soc/qcom/rmnet.h

-- 
2.20.1

