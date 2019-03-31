Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC495C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FF120872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeYPmOTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfCaRmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:42:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54898 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfCaRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:42:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so6627767wml.4;
        Sun, 31 Mar 2019 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lquHgCQVOo6EfI4luH1JpXJ3kcSO1lRumNt3diWTIL0=;
        b=WeYPmOTyPXKFpgwfoMLOq7lbo2se1VD30zDUMR739Rq3xRhXDnUxjCM/xH6/su8LZ1
         20gCURvX53pIXjEop8ttDEmRBpBYNAbo2EgSkOrtq8I4QeOO3WokiaAl07sgdHuvDhh8
         52+0xjoChpPwNqdv/oS4Np+qdR7P+yN/WJGDmjERYf9DuA4pcxt0Gy1N30gzWvtkPAoW
         gCSFzxyzPCDbVzMp3O+THH9h0xnE8V8dXuZBYAfBe+x7kKTs9Q8bPa41hUtoB/aEOyah
         zf/nnYtHCqvmlannyLky6URBV/isuzBrYIbYaHpM8aKLYMyMlqvZ0m7dPLP4OcoIsciz
         P42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lquHgCQVOo6EfI4luH1JpXJ3kcSO1lRumNt3diWTIL0=;
        b=cRlayTOMTP1DNVintljy0TINI7Q/C4ysLR8HwTUo8uqNkqBcoIjwLHGy/Y3mZ9sZJR
         sByP+I6XQJz/dBDaNAzuFj0q8QZ/wAmA9UBa+6bYQY2EAa5HGRTlIClMH7uhZnBOHC+2
         sFA8D0Xo0VmzvBXcT8DLNe2cFU9W5bDi/RlvTBrNlXVuzY3OMW6ypCd2DxYC6m7ll0DK
         FzCdVCWHWUHXxEIjYmlbCvs5g3NEqCycgIObBmowDNzruD9pP7BTSrVFDFs6OfNCQWDe
         s27fjd9Yir98RKuPWcPfk9YgLP4xOKGIuoFd2zoE+TCjA0v5fWIR1Ajz/TakRPYfqmDk
         tREg==
X-Gm-Message-State: APjAAAUOT5ZM54QK4Qo0sVousWnmf7wKkcC2fCY9hXw1kN/Ug08Z3l3L
        90TMFJlEDZpngBKfWCEm454=
X-Google-Smtp-Source: APXvYqy3B4bxMpNflCwBEC2ALf9p8lU6X2B0vxLmImRkuMtKU0VeDUCIxW06f27fnxRnv23D6FeoZw==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr9957948wme.24.1554054169050;
        Sun, 31 Mar 2019 10:42:49 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:42:47 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 00/17] NXP SJA1105 DSA driver
Date:   Sun, 31 Mar 2019 20:42:15 +0300
Message-Id: <20190331174232.22060-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a DSA driver for the SPI-managed NXP SJA1105 switch.
Due to the hardware's unfriendliness, most of its state needs to be
shadowed in kernel memory by the driver. To support this and keep a
decent amount of cleanliness in the code, a new generic API for
converting between CPU-accessible ("unpacked") structures and
hardware-accessible ("packed") structures is proposed and used.

Then several small modifications are done to the DSA core, like changing
the order of two calls during initialization, or permitting driver
access to the dp->vlan_filtering property.

These small modifications are done for the greater goal of adding
support for 802.1Q pseudo-switch tagging. The limitations of this type
of tagging are discussed in the commit that adds it, and in the code
comments.

The SJA1105 driver then proceeds to extend this 8021q switch tagging
protocol while adding its own (tag_sja1105). This is done because
SJA1105 needs SPI intervention during transmission of link-local
traffic, which cannot be done from the xmit handler but requires a
deferred worker thread.

The driver is GPL-2.0 licensed. The source code files which are licensed
as BSD-3-Clause are hardware support files and derivative of the
userspace NXP sja1105-tool program, which is BSD-3-Clause licensed.

TODO items:
* Add full support for the P/Q/R/S series. The patches were mostly
  tested on a first-generation T device.
* Add timestamping support and PTP clock manipulation.
* Figure out what the current state of tc-taprio hw offload is, and
  attempt to configure the switch's time-aware scheduler using that.
* Rework link state callbacks to use phylink once the SGMII port
  is supported.

Changes from RFC:
* Removed the packing code for the static configuration tables that were
  not currently used
* Removed the code for unpacking a static configuration structure from
  a memory buffer (not used)
* Completely removed the SGMII stubs, since the configuration is not
  complete anyway.
* Moved some code from the SJA1105 introduction commit into the patch
  that used it.
* Made the code for checking global VLAN filtering generic and made b53
  driver use it.
* Made mt7530 driver use the new generic dp->vlan_filtering
* Fixed check for stringset in .get_sset_count
* Minor cleanup in sja1105_clocking.c
* Fixed a confusing typo in DSA

RFC can be found at:
https://www.mail-archive.com/netdev@vger.kernel.org/msg291717.html

Vladimir Oltean (17):
  lib: Add support for generic packing operations
  net: dsa: Fix pharse -> phase typo
  net: dsa: Store vlan_filtering as a property of dsa_port
  net: dsa: mt7530: Use vlan_filtering property from dsa_port
  net: dsa: Add more convenient functions for installing port VLANs
  net: dsa: Call driver's setup callback after setting up its switchdev
    notifier
  net: dsa: Optional VLAN-based port separation for switches without
    tagging
  net: dsa: Be aware of switches where VLAN filtering is a global
    setting
  net: dsa: b53: Let DSA handle mismatched VLAN filtering settings
  net: dsa: Introduce driver for NXP SJA1105 5-port L2 switch
  net: dsa: sja1105: Add support for FDB and MDB management
  net: dsa: sja1105: Add support for VLAN operations
  net: dsa: sja1105: Add support for ethtool port counters
  net: dsa: sja1105: Add support for traffic through standalone ports
  net: dsa: sja1105: Add support for Spanning Tree Protocol
  Documentation: networking: dsa: Add details about NXP SJA1105 driver
  dt-bindings: net: dsa: Add documentation for NXP SJA1105 driver

 .../devicetree/bindings/net/dsa/sja1105.txt   |  123 ++
 Documentation/networking/dsa/sja1105.txt      |   83 +
 Documentation/packing.txt                     |  150 ++
 MAINTAINERS                                   |   14 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/b53/b53_common.c              |   25 +-
 drivers/net/dsa/mt7530.c                      |   14 +-
 drivers/net/dsa/mt7530.h                      |    1 -
 drivers/net/dsa/sja1105/Kconfig               |   17 +
 drivers/net/dsa/sja1105/Makefile              |   10 +
 drivers/net/dsa/sja1105/sja1105.h             |  150 ++
 drivers/net/dsa/sja1105/sja1105_clocking.c    |  643 +++++++
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |  518 ++++++
 .../net/dsa/sja1105/sja1105_dynamic_config.h  |   40 +
 drivers/net/dsa/sja1105/sja1105_ethtool.c     |  423 +++++
 drivers/net/dsa/sja1105/sja1105_main.c        | 1547 +++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c         |  665 +++++++
 .../net/dsa/sja1105/sja1105_static_config.c   | 1074 ++++++++++++
 .../net/dsa/sja1105/sja1105_static_config.h   |  311 ++++
 include/linux/dsa/sja1105.h                   |   52 +
 include/linux/packing.h                       |   49 +
 include/net/dsa.h                             |   11 +
 lib/Makefile                                  |    2 +-
 lib/packing.c                                 |  211 +++
 net/dsa/Kconfig                               |   12 +
 net/dsa/Makefile                              |    2 +
 net/dsa/dsa.c                                 |    6 +
 net/dsa/dsa2.c                                |    8 +-
 net/dsa/dsa_priv.h                            |   15 +
 net/dsa/port.c                                |   75 +-
 net/dsa/slave.c                               |   16 +-
 net/dsa/switch.c                              |    3 +-
 net/dsa/tag_8021q.c                           |  193 ++
 net/dsa/tag_sja1105.c                         |  142 ++
 35 files changed, 6556 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/sja1105.txt
 create mode 100644 Documentation/networking/dsa/sja1105.txt
 create mode 100644 Documentation/packing.txt
 create mode 100644 drivers/net/dsa/sja1105/Kconfig
 create mode 100644 drivers/net/dsa/sja1105/Makefile
 create mode 100644 drivers/net/dsa/sja1105/sja1105.h
 create mode 100644 drivers/net/dsa/sja1105/sja1105_clocking.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_dynamic_config.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_dynamic_config.h
 create mode 100644 drivers/net/dsa/sja1105/sja1105_ethtool.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_main.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_spi.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_static_config.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_static_config.h
 create mode 100644 include/linux/dsa/sja1105.h
 create mode 100644 include/linux/packing.h
 create mode 100644 lib/packing.c
 create mode 100644 net/dsa/tag_8021q.c
 create mode 100644 net/dsa/tag_sja1105.c

-- 
2.17.1

