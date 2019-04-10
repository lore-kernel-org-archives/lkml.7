Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57998C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0073A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+9IJC6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDJA5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53471 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDJA5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so654657wmj.3;
        Tue, 09 Apr 2019 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4v9t6vcoyza3r/pFt2sqQWo2XWwXyRAA59qwj9zNqlQ=;
        b=F+9IJC6IQMB/y6HMXvo10wpTVIal65EYByQofyc5hFfrEhn+lVe4WifDbcIuaqTcIU
         fw9jn92vvDEiyY5VAzHMY3AvK/uecX+MilY8Og0HB19RwuP95v292sG6+OwgwmfLbO9T
         gyU7dXNbEqJlQ3wEbSOG4zu2P2tiT7R2o11yVsEmERMaD//0eVwocTjm5WsB60uXeXqG
         S0WvSQGrntJBlVYmeqqt51Dja/bzvsosKtKjSbFpjKXaAzC6qPodip633w6nWwFeS8NQ
         zNW/oH7Rs8HZfBWHbqWSyL1L5rXwQu0btmuFfwYCQwdZETPVJCF6y618qaI81kSSljT1
         KB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4v9t6vcoyza3r/pFt2sqQWo2XWwXyRAA59qwj9zNqlQ=;
        b=QwghFf4UGrO308SGZDudYjmL5WuOsx20J+CyRx75lo1r1sLHSA6Ts2uasOD//VYpgY
         Qfz0hfMOnPUGqecZs4SM3u9v+3wVNMh4TSRl9Y59eOUdDawbBnjI9oHuyL4/BFmK/0IP
         iUksUTwMJKtKvpjG/8B2xzTbB4mD+QUv0rW5gFKfD3pauCOLgtwsIfn8y7B9MlXyXwqV
         wjySKVNVG5P3wXaCa9e6SRzSSNaDFTFLEKYkyCx7FukEZqF1q96HJyVHsc562w61HoBc
         Yu54HesvGol/KHSGyYtELl+GDBmZZ9ihhvSpqX1Q0Jzg/zoq6LQmuvFQob5k+cbg1YeW
         N0bg==
X-Gm-Message-State: APjAAAXq8Nqxg53m3v/cUJFtCgLMvKKRJFSZmY7VToGfYjd1wedbKP7m
        7YW0GZgoJa5lo3wMBiySmZE=
X-Google-Smtp-Source: APXvYqx1QPm/O/0jS8Qmv/wZAd96vmCsOlzyo2aWbphokdHjXWk1PNwoiuEaRJ5H+P0imR6/P5OQ0Q==
X-Received: by 2002:a1c:6502:: with SMTP id z2mr641075wmb.119.1554857838993;
        Tue, 09 Apr 2019 17:57:18 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:18 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 00/22] NXP SJA1105 DSA driver
Date:   Wed, 10 Apr 2019 03:56:38 +0300
Message-Id: <20190410005700.31582-1-olteanv@gmail.com>
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
* Figure out how the tc-taprio hardware offload that was just proposed
  by Vinicius can be used to configure the switch's time-aware scheduler.
* Rework link state callbacks to use phylink once the SGMII port
  is supported.

Changes in v2:
1. Device ID is no longer auto-detected but enforced based on explicit DT
   compatible string. This helps with stricter checking of DT bindings.
2. Group all device-specific operations into a sja1105_info structure and
   avoid using the IS_ET() and IS_PQRS() macros at runtime as much as possible.
3. Added more verbiage to commit messages and documentation.
4. Treat the case where RGMII internal delays are requested through DT bindings
   and return error.
5. Miscellaneous cosmetic cleanup in sja1105_clocking.c
6. Not advertising link features that are not supported, such as pause frames
   and the half duplex modes.
7. Fixed a mistake in previous patchset where the switch tagging was not
   actually enabled (lost during a rebase). This brought up another uncaught
   issue where switching at runtime between tagging and no-tagging was not
   supported by DSA. Fixed up the mistake in "net: dsa: sja1105: Add support
   for traffic through standalone ports", and added the new patch "net: dsa:
   Allow drivers to modulate between presence and absence of tagging" to
   address the other issue.
8. Added a workaround for switch resets cutting a frame in the middle of
   transmission, which would throw off some link partners.
9. Changed the TPID from ETH_P_EDSA (0xDADA) to a newly introduced one:
   ETH_P_DSA_8021Q (0xDADB). Uncovered another mistake in the previous patchset
   with a missing ntohs(), which was not caught because 0xDADA is
   endian-agnostic.
10. Made NET_DSA_TAG_8021Q select VLAN_8021Q
11. Renamed __dsa_port_vlan_add to dsa_port_vid_add and not to
    dsa_port_vlan_add_trans, as suggested, because the corresponding _del function
    does not have a transactional phase and the naming is more uniform this way.

v1 patchset can be found at:
https://www.spinics.net/lists/netdev/msg561589.html

Changes from RFC:
1. Removed the packing code for the static configuration tables that were
   not currently used
2. Removed the code for unpacking a static configuration structure from
   a memory buffer (not used)
3. Completely removed the SGMII stubs, since the configuration is not
   complete anyway.
4. Moved some code from the SJA1105 introduction commit into the patch
   that used it.
5. Made the code for checking global VLAN filtering generic and made b53
   driver use it.
6. Made mt7530 driver use the new generic dp->vlan_filtering
7. Fixed check for stringset in .get_sset_count
8. Minor cleanup in sja1105_clocking.c
9. Fixed a confusing typo in DSA

RFC can be found at:
https://www.mail-archive.com/netdev@vger.kernel.org/msg291717.html

Vladimir Oltean (22):
  lib: Add support for generic packing operations
  net: dsa: Fix pharse -> phase typo
  net: dsa: Store vlan_filtering as a property of dsa_port
  net: dsa: mt7530: Use vlan_filtering property from dsa_port
  net: dsa: Add more convenient functions for installing port VLANs
  net: dsa: Call driver's setup callback after setting up its switchdev
    notifier
  ether: Add dedicated Ethertype for pseudo-802.1Q DSA tagging
  net: dsa: Optional VLAN-based port separation for switches without
    tagging
  net: dsa: Be aware of switches where VLAN filtering is a global
    setting
  net: dsa: b53: Let DSA handle mismatched VLAN filtering settings
  net: dsa: Allow drivers to modulate between presence and absence of
    tagging
  net: dsa: Introduce driver for NXP SJA1105 5-port L2 switch
  net: dsa: sja1105: Add support for FDB and MDB management
  net: dsa: sja1105: Add support for VLAN operations
  net: dsa: sja1105: Add support for ethtool port counters
  net: dsa: sja1105: Add support for traffic through standalone ports
  net: dsa: sja1105: Add support for Spanning Tree Protocol
  net: dsa: sja1105: Error out if RGMII delays are requested in DT
  net: dsa: sja1105: Prevent PHY jabbering during switch reset
  net: dsa: sja1105: Reject unsupported link modes for AN
  Documentation: networking: dsa: Add details about NXP SJA1105 driver
  dt-bindings: net: dsa: Add documentation for NXP SJA1105 driver

 .../devicetree/bindings/net/dsa/sja1105.txt   |  157 ++
 Documentation/networking/dsa/sja1105.txt      |  153 ++
 Documentation/packing.txt                     |  150 ++
 MAINTAINERS                                   |   14 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/b53/b53_common.c              |   25 +-
 drivers/net/dsa/mt7530.c                      |   14 +-
 drivers/net/dsa/mt7530.h                      |    1 -
 drivers/net/dsa/sja1105/Kconfig               |   17 +
 drivers/net/dsa/sja1105/Makefile              |   10 +
 drivers/net/dsa/sja1105/sja1105.h             |  164 ++
 drivers/net/dsa/sja1105/sja1105_clocking.c    |  612 ++++++
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |  504 +++++
 .../net/dsa/sja1105/sja1105_dynamic_config.h  |   43 +
 drivers/net/dsa/sja1105/sja1105_ethtool.c     |  414 ++++
 drivers/net/dsa/sja1105/sja1105_main.c        | 1667 +++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c         |  594 ++++++
 .../net/dsa/sja1105/sja1105_static_config.c   | 1042 +++++++++++
 .../net/dsa/sja1105/sja1105_static_config.h   |  305 +++
 include/linux/dsa/sja1105.h                   |   52 +
 include/linux/packing.h                       |   49 +
 include/net/dsa.h                             |   19 +-
 include/uapi/linux/if_ether.h                 |    1 +
 lib/Makefile                                  |    2 +-
 lib/packing.c                                 |  211 +++
 net/dsa/Kconfig                               |   13 +
 net/dsa/Makefile                              |    2 +
 net/dsa/dsa.c                                 |    6 +
 net/dsa/dsa2.c                                |   15 +-
 net/dsa/dsa_priv.h                            |   15 +
 net/dsa/legacy.c                              |    7 +
 net/dsa/port.c                                |   75 +-
 net/dsa/slave.c                               |   16 +-
 net/dsa/switch.c                              |    3 +-
 net/dsa/tag_8021q.c                           |  203 ++
 net/dsa/tag_sja1105.c                         |  148 ++
 37 files changed, 6673 insertions(+), 53 deletions(-)
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

