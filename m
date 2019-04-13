Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627B020850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAl6asGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDMB2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:28:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32987 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDMB2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:28:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so14186982wrp.0;
        Fri, 12 Apr 2019 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XGYqBC+c8dhaUPgk8uGq6oTiSGFNVpjJBl1qlGLShfE=;
        b=iAl6asGsXb60LP0563CwNGiyg8JJ6UURUtRIFemlqTmBzZW7TDKLJpW5mZg4t1nErh
         EuNYqBcC5c/WWWlMdxE+sQIUoxSU3wwVp+PCKdVE2fuWrfVdTG14oonbAuu8cOYOUNih
         rqEoTa0lRPpezbJsCYXUpac58nkQUN5u13lnehwml6H3VJ9hPF1gHwICOT09jSMqhElW
         QZqXHA0p2X1BB8qaGRuiyL9/s3cx/C5iTOPmyAuNh4vkm+sB2pv3U6HeVzjBDoH521LJ
         dXLn/3pnYW+UqO95VmrNS4NiCWXV5YRUZ8Egp07utYAzTn8EYmy4OY/ncv/o5jYLLuBc
         tAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XGYqBC+c8dhaUPgk8uGq6oTiSGFNVpjJBl1qlGLShfE=;
        b=IQa9F1ToBO6Qe1Dev9iQuufYPbrFkTHQMqm5c40lpIyuHzK/jNIxs/3coQjRGO/V6V
         7551kgzmS+N8mtb25GsHfM/XfSfSpeaJ2xG1fuyEFaBORQUtYaU6gSaafblvbxS+alkQ
         2gWFHqYXFmOvAcGQOQQK/Z9FEkVt91UX+Xhaj4UGSnhqoFwns/qsEw6BuWTKeIZtrgCg
         l93QSvoRsFhaIYIWWROslapeRYhZJwOcnS8xa4+ll56LqvUtCwhj9JZMoYW6SdDGRIiE
         ZJGlWuT3Kl92KP1VPQ1uKgevL8/HQtw8HxTAB5yv+zuprggTb56mq1zeYmWWDFFrAK3Y
         vifw==
X-Gm-Message-State: APjAAAWsnIx+YmDeIF0ctY6r7T+sKskmT3TttvbQ+HJ8W7gb4e/a4Xsc
        7+MVL6y91xvazjLqxvlXeGg=
X-Google-Smtp-Source: APXvYqwfpsvsNUQs27YvpKKbith4NQVtxedpl9h/adIxrYR4/ZtDk8rcbIJCOcmz5R0XUQaQ2swd0A==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr37939689wrr.1.1555118909363;
        Fri, 12 Apr 2019 18:28:29 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:28 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 00/24] NXP SJA1105 DSA driver
Date:   Sat, 13 Apr 2019 04:27:58 +0300
Message-Id: <20190413012822.30931-1-olteanv@gmail.com>
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

Supporting a fully-featured (traffic-capable) driver for this switch
requires some rework in DSA and also leaves behind a more generic
infrastructure for other dumb switches that rely on 802.1Q pseudo-switch
tagging for port separation. Among the DSA changes required are:

* Permitting the .setup callback to invoke switchdev operations that
  will loop back into the driver through the switchdev notifier chain.
* Adding DSA awareness of switches where VLAN filtering is a global
  property and saving that setting in cpu_dp->vlan_filtering.
* Generic xmit and rcv functions for DSA interaction with 802.1Q tags on
  skb's. This is modeled as a tagging protocol of its own but must be
  customized by drivers to fit their own hardware possibilities.
* Intervention in the DSA receive hotpath, where a new filtering
  function called from eth_type_trans() is needed. This is because
  switches that employ 802.1Q tagging might actually have some limited
  means of source port decoding, such as only for management traffic.
  In order for the 802.1Q tagging protocol (which cannot be enabled
  under all conditions, unlike the management traffic decoding) to not
  be an all-or-nothing choice, the filtering function matches everything
  that can be decoded, and everything else is left to pass to the master
  netdevice.

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

Changes in v3:
1. Removed the patch for a dedicated Ethertype to use with 802.1Q DSA
   tagging
2. Changed the SJA1105 switch tagging protocol sysfs label from
   "sja1105" to "8021q" to denote to users such as tcpdump that the
   structure is more generic.
3. Respun previous patch "net: dsa: Allow drivers to modulate between
   presence and absence of tagging". Current equivalent patch is called
   "net: dsa: Allow drivers to filter packets they can decode source
   port from" and at least allows reception of management traffic during
   the time when switch tagging is not enabled.
4. Added DSA-level fixes for the bridge core not unsetting
   vlan_filtering when ports leave. The global VLAN filtering is treated
   as a special case. Made the mt7530 driver use this. This patch
   benefits the SJA1105 because otherwise traffic in standalone mode
   would no longer work after removing the ports from a vlan_filtering
   bridge, since the driver and the hardware would be in an inconsistent
   state.
5. Restructured the documentation as rst. This depends upon the recently
   submitted "[PATCH net-next] Documentation: net: dsa: transition to
   the rst format": https://patchwork.ozlabs.org/patch/1084658/.

v2 patchset can be found at:
https://www.spinics.net/lists/netdev/msg563454.html

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

Vladimir Oltean (24):
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
  net: dsa: Unset vlan_filtering when ports leave the bridge
  net: dsa: mt7530: Let DSA handle the unsetting of vlan_filtering
  net: dsa: Copy the vlan_filtering setting on the CPU port if it's
    global
  net: dsa: Allow drivers to filter packets they can decode source port
    from
  net: dsa: Introduce driver for NXP SJA1105 5-port L2 switch
  net: dsa: sja1105: Add support for FDB and MDB management
  net: dsa: sja1105: Add support for VLAN operations
  net: dsa: sja1105: Add support for ethtool port counters
  net: dsa: sja1105: Add support for traffic through standalone ports
  net: dsa: sja1105: Add support for Spanning Tree Protocol
  net: dsa: sja1105: Error out if RGMII delays are requested in DT
  net: dsa: sja1105: Prevent PHY jabbering during switch reset
  net: dsa: sja1105: Reject unsupported link modes for AN
  Documentation: net: dsa: Add details about NXP SJA1105 driver
  dt-bindings: net: dsa: Add documentation for NXP SJA1105 driver

 .../devicetree/bindings/net/dsa/sja1105.txt   |  157 ++
 Documentation/networking/dsa/index.rst        |    1 +
 Documentation/networking/dsa/sja1105.rst      |  216 +++
 Documentation/packing.txt                     |  150 ++
 MAINTAINERS                                   |   14 +
 drivers/net/dsa/Kconfig                       |    2 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/b53/b53_common.c              |   25 +-
 drivers/net/dsa/mt7530.c                      |   18 +-
 drivers/net/dsa/mt7530.h                      |    1 -
 drivers/net/dsa/sja1105/Kconfig               |   17 +
 drivers/net/dsa/sja1105/Makefile              |   10 +
 drivers/net/dsa/sja1105/sja1105.h             |  164 ++
 drivers/net/dsa/sja1105/sja1105_clocking.c    |  612 ++++++
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |  504 +++++
 .../net/dsa/sja1105/sja1105_dynamic_config.h  |   43 +
 drivers/net/dsa/sja1105/sja1105_ethtool.c     |  414 ++++
 drivers/net/dsa/sja1105/sja1105_main.c        | 1663 +++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c         |  594 ++++++
 .../net/dsa/sja1105/sja1105_static_config.c   | 1042 +++++++++++
 .../net/dsa/sja1105/sja1105_static_config.h   |  298 +++
 include/linux/dsa/sja1105.h                   |   52 +
 include/linux/packing.h                       |   49 +
 include/net/dsa.h                             |   26 +
 lib/Makefile                                  |    2 +-
 lib/packing.c                                 |  211 +++
 net/dsa/Kconfig                               |   13 +
 net/dsa/Makefile                              |    2 +
 net/dsa/dsa.c                                 |    6 +
 net/dsa/dsa2.c                                |    9 +-
 net/dsa/dsa_priv.h                            |   15 +
 net/dsa/legacy.c                              |    1 +
 net/dsa/port.c                                |   87 +-
 net/dsa/slave.c                               |   24 +-
 net/dsa/switch.c                              |   31 +-
 net/dsa/tag_8021q.c                           |  203 ++
 net/dsa/tag_sja1105.c                         |  148 ++
 net/ethernet/eth.c                            |    6 +-
 38 files changed, 6769 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/sja1105.txt
 create mode 100644 Documentation/networking/dsa/sja1105.rst
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

