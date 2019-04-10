Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC2CC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA2218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNX6kn4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDJA5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38174 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfDJA5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so801386wro.5;
        Tue, 09 Apr 2019 17:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlb9kQYN7kSy11uCpgAfpplykpadbrYX9b3AWGBA/rw=;
        b=iNX6kn4Nyg1OuFOquW6bIVALa+yGduZRzG4GCD4vDgxj0mWPvyIM3+fwIDYwY8saiV
         LTRZANmO0m5G9rSzHaykoLtSAAJJd4RHhYaB4WjMm+AhwhUvWIQ9PYB3mJIALsImV5K0
         EGCJUjn4s+zdp/T4fBT4iG6uNeBnk9dY/L8DDQcKCFFDxuP0ujJS1fwgqlsH0ULhygRg
         UqkQWeWEedBVkB0pmCRQTY5KbKGUZc5+OmGBy09NG9gXWV29kYhdXDSM75f+OabkNb/C
         AX0ZkS28yW0kspG7fDDrGwziK8TbSnwjn5UrxS0SQx97HlcEEGNw2LPNV8lirIEb5+CN
         eoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dlb9kQYN7kSy11uCpgAfpplykpadbrYX9b3AWGBA/rw=;
        b=JnZh2NguhWLTKH+OW05bdM9LBvb6+EvOK48zmqT+b+IirxZpVqfCUS5XUF6lyb4xvC
         c9ipPXhbMBVds25CM3magIsmS52XnRIk2w0N2i5/TTF1H/cPhDtJpZzvlyaAXBmuGcTF
         XoybQEdN58h6cMrK7m2Wh6odweSC5Uo1lIxkXMGgZcj8n1BFPhpzSDSMlCJ5BeLe2iln
         3W77GIDUxlNZNMw8PVBwqpHvp7OUY6i+WRry/H7bw7qsnXarRb1MViFGsQLw0+jlOMd7
         uC61X+zKEAqDGEewBf8fRe7h0RP+oZCpatk9QLccyt/xCEkooL86aEmqdvbG9R9tCydn
         o30g==
X-Gm-Message-State: APjAAAUkEBJ+wdCJi96Wcn0nVjztQdRW/PWh6nPyWJ7YBjyeTInN7qc7
        cRRmbft8WbcvWkheM5ccfAk=
X-Google-Smtp-Source: APXvYqw6MNEt9J/GoKSJdcPe/Lun0zjuuGiE5sY7nuyZIfWSmIaaTCleCir75uoVbX5V2N1H32qnZg==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr25576356wrj.249.1554857865280;
        Tue, 09 Apr 2019 17:57:45 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:44 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 21/22] Documentation: networking: dsa: Add details about NXP SJA1105 driver
Date:   Wed, 10 Apr 2019 03:56:59 +0300
Message-Id: <20190410005700.31582-22-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
More verbiage at the end, regarding RGMII delays and potentially other
hardware-related caveats.

 Documentation/networking/dsa/sja1105.txt | 153 +++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/networking/dsa/sja1105.txt

diff --git a/Documentation/networking/dsa/sja1105.txt b/Documentation/networking/dsa/sja1105.txt
new file mode 100644
index 000000000000..bdc63061c3d6
--- /dev/null
+++ b/Documentation/networking/dsa/sja1105.txt
@@ -0,0 +1,153 @@
+NXP SJA1105 switch driver
+=========================
+
+The NXP SJA1105 is a family of 6 devices:
+* SJA1105E: First generation, no TTEthernet
+* SJA1105T: First generation, TTEthernet
+* SJA1105P: Second generation, no TTEthernet, no SGMII
+* SJA1105Q: Second generation, TTEthernet, no SGMII
+* SJA1105R: Second generation, no TTEthernet, SGMII
+* SJA1105S: Second generation, TTEthernet, SGMII
+
+These are SPI-managed automotive switches, with all ports being gigabit
+capable, and supporting MII/RMII/RGMII and optionally SGMII on one port.
+
+The switches do not have an MDIO bus of their own and do not support
+in-band autonegotiation, so for proper PHY management, the host's MDIO
+bus controller needs to be used.
+
+Being automotive parts, their configuration interface is geared towards
+set-and-forget use, with minimal dynamic interaction at runtime. They
+require a static configuration to be composed by software and packed
+with CRC and table headers, and sent over SPI.
+
+The static configuration is composed of several configuration tables. Each
+table takes a number of entries. Some configuration tables can be (partially)
+reconfigured at runtime, some not. Some tables are mandatory, some not.
+
+Table                        | Mandatory        | Reconfigurable
+-----------------------------+------------------+-----------------------------
+Schedule                     | no               | no
+Schedule entry points        | if Scheduling    | no
+VL Lookup                    | no               | no
+VL Policing                  | if VL Lookup     | no
+VL Forwarding                | if VL Lookup     | no
+L2 Lookup                    | no               | no
+L2 Policing                  | yes              | no
+VLAN Lookup                  | yes              | yes
+L2 Forwarding                | yes              | partially (fully on P/Q/R/S)
+MAC Config                   | yes              | partially (fully on P/Q/R/S)
+Schedule Params              | if Scheduling    | no
+Schedule Entry Points Params | if Scheduling    | no
+VL Forwarding Params         | if VL Forwarding | no
+L2 Lookup Params             | no               | partially (fully on P/Q/R/S)
+L2 Forwarding Params         | yes              | no
+Clock Sync Params            | no               | no
+AVB Params                   | no               | no
+General Params               | yes              | partially
+Retagging                    | no               | yes
+xMII Params                  | yes              | no
+SGMII                        | no               | yes
+
+Also the configuration is write-only (software cannot read it back from the
+switch except for very few exceptions).
+
+So the driver creates the static configuration at probe time, and keeps it at
+all times in memory, as a shadow for the hardware state. When required to
+change a hardware setting, the static configuration is also updated.
+If that changed setting can be transmitted to the switch through the dynamic
+reconfiguration interface, it is; otherwise the switch is reset and
+reprogrammed with the updated static configuration.
+
+The switches do not support switch tagging in hardware. But they do support
+customizing the TPID by which VLAN traffic is identified as such. The switch
+driver is leveraging CONFIG_NET_DSA_TAG_8021Q by requesting that special VLANs
+(with a custom TPID of ETH_P_EDSA instead of ETH_P_8021Q) are installed on its
+ports when not in vlan_filtering mode. This does not interfere with the
+reception and transmission of real 802.1Q-tagged traffic, because the switch
+does no longer parse those packets as VLAN after the TPID change.
+The TPID is restored when vlan_filtering is requested, and IP termination
+becomes no longer possible through the switch netdevices in this mode.
+
+The switches have two programmable filters for link-local destination MACs.
+These are used to trap BPDUs and PTP traffic to the master netdevice, and are
+further used to support STP and 1588 ordinary clock/boundary clock
+functionality.
+
+Among other notable features, the switches have a PTP Hardware Clock that can
+be steered through SPI and used for timestamping management traffic on ingress
+and egress.
+Also, the T, Q and S devices support TTEthernet (an implementation of SAE
+AS6802 from TTTech), which is a set of Ethernet QoS enhancements somewhat
+similar in behavior to IEEE TSN (time-aware shaping, time-based policing).
+Configuring these features is currently not supported in the driver.
+
+Heads up for board designers
+----------------------------
+
+This section references Documentation/devicetree/bindings/net/dsa/sja1105.txt
+and aims to show how some switch oddities relate to the DT bindings.
+
+1. RMII PHY role and out-of-band signaling
+
+In the RMII spec, the 50 MHz clock signals are either driven by the MAC or by
+an external oscillator (but not by the PHY).
+But the spec is rather loose and devices go outside it in several ways.
+Some PHYs go against the spec and may provide an output pin where they source
+the 50 MHz clock themselves, in an attempt to be helpful.
+On the other hand, the SJA1105 is only binary configurable - when in the RMII
+MAC role it will also attempt to drive the clock signal. To prevent this from
+happening it must be put in RMII PHY role.
+But doing so has some unintended consequences.
+In the RMII spec, the PHY can transmit extra out-of-band signals via RXD[1:0].
+These are practically some extra code words (/J/ and /K/) sent prior to the
+preamble of each frame. The MAC does not have this out-of-band signaling
+mechanism defined by the RMII spec.
+So when the SJA1105 port is put in PHY role to avoid having 2 drivers on the
+clock signal, inevitably an RMII PHY-to-PHY connection is created. The SJA1105
+emulates a PHY interface fully and generates the /J/ and /K/ symbols prior to
+frame preambles, which the real PHY is not expected to understand. So the PHY
+simply encodes the extra symbols received from the SJA1105-as-PHY onto the
+100Base-Tx wire.
+On the other side of the wire, some link partners might discard these extra
+symbols, while others might choke on them and discard the entire Ethernet
+frames that follow along. This looks like packet loss with some link partners
+but not with others.
+The take-away is that in RMII mode, the SJA1105 must be let to drive the
+reference clock if connected to a PHY.
+
+2. RGMII fixed-link and internal delays
+
+As already mentioned in this document, the second generation of devices has
+tunable delay lines as part of the MAC, which can be used to establish the
+correct RGMII timing budget.
+When powered up, these can shift the Rx and Tx clocks with a phase difference
+between 73.8 and 101.7 degrees.
+The catch is that the delay lines need to lock onto a clock signal with a
+stable frequency. This means that there must be at least 2 microseconds of
+silence between the clock at the old vs at the new frequency. Otherwise the
+lock is lost and the delay lines must be reset (powered down and back up).
+In RGMII the clock frequency changes with link speed (125 MHz at 1000 Mbps, 25
+MHz at 100 Mbps and 2.5 MHz at 10 Mbps), and link speed might change during the
+AN process.
+In the situation where the switch port is connected through an RGMII fixed-link
+to a link partner whose link state life cycle is outside the control of Linux
+(such as a different SoC), then the delay lines would remain unlocked (and
+inactive) until there is manual intervention (ifdown/ifup on the switch port).
+The take-away is that in RGMII mode, the switch's internal delays are only
+reliable if the link partner never changes link speeds, or if it does, it does
+so in a way that is coordinated with the switch port (practically, both ends of
+the fixed-link are under control of the same Linux system).
+As to why would a fixed-link interface ever change link speeds: there are
+Ethernet controllers out there which come out of reset in 100 Mbps mode, and
+their driver inevitably needs to change it if it's required to work at gigabit.
+
+3. MDIO bus and PHY management
+
+The SJA1105 does not have an MDIO bus and does not perform in-band AN either.
+Therefore there is no link state notification coming from the switch device.
+A board would need to hook up the PHYs connected to the switch to any other
+MDIO bus available to Linux within the system (e.g. to the DSA master's MDIO
+bus). Link state management then works by the driver manually keeping in sync
+(over SPI commands) the MAC link speed with the settings negotiated by the PHY.
+
-- 
2.17.1

