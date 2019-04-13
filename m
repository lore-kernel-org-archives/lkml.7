Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE78C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B08218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp/4y500"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfDMB3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:29:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfDMB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:29:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so14153267wro.5;
        Fri, 12 Apr 2019 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQT7bhemcqwqaoooaqVQt7QN9MmjgNUw2Sg/A4cispQ=;
        b=Tp/4y5002k1P4CHtyOg+FVPEF1cqY7aOe2kixa0xOOR2tstvO5PVf5bWiIDmOhtVGb
         RAC/NA083kDv+A/4lRYMnDZQuHsawa3L/gcjjyhYofAGb+RlruIm9wabAlanxqkyRsU2
         gxFnUvM0SUxYENKotKCKXh7Rwp1z1HMzRFwHVJ1j9JAQxzLTRyltVYLbT3tkxr+Gw9tP
         GBYSJI++XbVPSHLMqaaM+TJUQ0tLflLlu01gUI8QSS+Ry04WY7mFdlK4duQSGcyxKOH5
         Nf2Ngng59JnhkYe00/lEvIsXn/wBvSVVHMmaxs+kvIh8QDKmGTAL5JU1Mq1e7aT36+to
         wi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQT7bhemcqwqaoooaqVQt7QN9MmjgNUw2Sg/A4cispQ=;
        b=CO7qZdB7CpY0PJVLfRMWbqxNSbF7zP/Ii0yhIm9X36AQ1CHiLcWuzUbnTgXYmWTFCW
         9DKt9BYLwAys+l0zfFjMCL1ydppSlGg5K9JTjOJNOd2Ny1BJWA7ml4F9/gRGAEVEgTB6
         eHxmawwyabGXBsffCv7nswPxkXqwB35wVz/m94xgqc3ij9/SneqQh5mtoI+NdnAJjGeh
         FoSDrQ+/3S7kH0KRyOvsT6sKbUuiBBqSgWESYyVB4AmJyMq12B8SRH64k/JzTEJ8fAt6
         1jhPhxI1beBpnIwYS6TSOzier91cY7Z32grgaR35MCVC0nwWs1opmOVMV3fgrEjqeVs/
         1+HQ==
X-Gm-Message-State: APjAAAVC+P7heT/Qzb53UhHwQD8udH1blhppAqg4/aTAJ1MDGXeAxGpl
        2vFmSyGibhfXv1DlPARnA5E=
X-Google-Smtp-Source: APXvYqy+jZdZ2EwWZCGN7cwXBe9s6k5dzwlgvgYYxIBakfjgI+6bqVqiS2bpuEnfWa0hwJm73+kQog==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr25566968wru.125.1555118938081;
        Fri, 12 Apr 2019 18:28:58 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id r9sm8053141wmh.38.2019.04.12.18.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 18:28:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v3 net-next 23/24] Documentation: net: dsa: Add details about NXP SJA1105 driver
Date:   Sat, 13 Apr 2019 04:28:21 +0300
Message-Id: <20190413012822.30931-24-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190413012822.30931-1-olteanv@gmail.com>
References: <20190413012822.30931-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v3:
Reworked as rst, added a table for traffic support, added chapter for
switching features.

Changes in v2:
More verbiage at the end, regarding RGMII delays and potentially other
hardware-related caveats.

 Documentation/networking/dsa/index.rst   |   1 +
 Documentation/networking/dsa/sja1105.rst | 216 +++++++++++++++++++++++
 2 files changed, 217 insertions(+)
 create mode 100644 Documentation/networking/dsa/sja1105.rst

diff --git a/Documentation/networking/dsa/index.rst b/Documentation/networking/dsa/index.rst
index 5c488d345a1e..0e5b7a9be406 100644
--- a/Documentation/networking/dsa/index.rst
+++ b/Documentation/networking/dsa/index.rst
@@ -8,3 +8,4 @@ Distributed Switch Architecture
    dsa
    bcm_sf2
    lan9303
+   sja1105
diff --git a/Documentation/networking/dsa/sja1105.rst b/Documentation/networking/dsa/sja1105.rst
new file mode 100644
index 000000000000..9614d127da57
--- /dev/null
+++ b/Documentation/networking/dsa/sja1105.rst
@@ -0,0 +1,216 @@
+=========================
+NXP SJA1105 switch driver
+=========================
+
+Overview
+========
+
+The NXP SJA1105 is a family of 6 devices:
+
+- SJA1105E: First generation, no TTEthernet
+- SJA1105T: First generation, TTEthernet
+- SJA1105P: Second generation, no TTEthernet, no SGMII
+- SJA1105Q: Second generation, TTEthernet, no SGMII
+- SJA1105R: Second generation, no TTEthernet, SGMII
+- SJA1105S: Second generation, TTEthernet, SGMII
+
+These are SPI-managed automotive switches, with all ports being gigabit
+capable, and supporting MII/RMII/RGMII and optionally SGMII on one port.
+
+Being automotive parts, their configuration interface is geared towards
+set-and-forget use, with minimal dynamic interaction at runtime. They
+require a static configuration to be composed by software and packed
+with CRC and table headers, and sent over SPI.
+
+The static configuration is composed of several configuration tables. Each
+table takes a number of entries. Some configuration tables can be (partially)
+reconfigured at runtime, some not. Some tables are mandatory, some not:
+
+============================= ================== =============================
+Table                          Mandatory          Reconfigurable
+============================= ================== =============================
+Schedule                       no                 no
+Schedule entry points          if Scheduling      no
+VL Lookup                      no                 no
+VL Policing                    if VL Lookup       no
+VL Forwarding                  if VL Lookup       no
+L2 Lookup                      no                 no
+L2 Policing                    yes                no
+VLAN Lookup                    yes                yes
+L2 Forwarding                  yes                partially (fully on P/Q/R/S)
+MAC Config                     yes                partially (fully on P/Q/R/S)
+Schedule Params                if Scheduling      no
+Schedule Entry Points Params   if Scheduling      no
+VL Forwarding Params           if VL Forwarding   no
+L2 Lookup Params               no                 partially (fully on P/Q/R/S)
+L2 Forwarding Params           yes                no
+Clock Sync Params              no                 no
+AVB Params                     no                 no
+General Params                 yes                partially
+Retagging                      no                 yes
+xMII Params                    yes                no
+SGMII                          no                 yes
+============================= ================== =============================
+
+
+Also the configuration is write-only (software cannot read it back from the
+switch except for very few exceptions).
+
+The driver creates a static configuration at probe time, and keeps it at
+all times in memory, as a shadow for the hardware state. When required to
+change a hardware setting, the static configuration is also updated.
+If that changed setting can be transmitted to the switch through the dynamic
+reconfiguration interface, it is; otherwise the switch is reset and
+reprogrammed with the updated static configuration.
+
+Traffic support
+===============
+
+The switches do not support switch tagging in hardware. But they do support
+customizing the TPID by which VLAN traffic is identified as such. The switch
+driver is leveraging ``CONFIG_NET_DSA_TAG_8021Q`` by requesting that special
+VLANs (with a custom TPID of ``ETH_P_EDSA`` instead of ``ETH_P_8021Q``) are
+installed on its ports when not in ``vlan_filtering`` mode. This does not
+interfere with the reception and transmission of real 802.1Q-tagged traffic,
+because the switch does no longer parse those packets as VLAN after the TPID
+change.
+The TPID is restored when ``vlan_filtering`` is requested by the user through
+the bridge layer, and general IP termination becomes no longer possible through
+the switch netdevices in this mode.
+
+The switches have two programmable filters for link-local destination MACs.
+These are used to trap BPDUs and PTP traffic to the master netdevice, and are
+further used to support STP and 1588 ordinary clock/boundary clock
+functionality.
+
+The following traffic modes are supported over the switch netdevices:
+
++--------------------+------------+------------------+------------------+
+|                    | Standalone |   Bridged with   |   Bridged with   |
+|                    |    ports   | vlan_filtering 0 | vlan_filtering 1 |
++====================+============+==================+==================+
+| Regular traffic    |     Yes    |       Yes        |  No (use master) |
++--------------------+------------+------------------+------------------+
+| Management traffic |     Yes    |       Yes        |       Yes        |
+|    (BPDU, PTP)     |            |                  |                  |
++--------------------+------------+------------------+------------------+
+
+Switching features
+==================
+
+The driver supports the configuration of L2 forwarding rules in hardware for
+port bridging. The forwarding, broadcast and flooding domain between ports can
+be restricted through two methods: either at the L2 forwarding level (isolate
+one bridge's ports from another's) or at the VLAN port membership level
+(isolate ports within the same bridge). The final forwarding decision taken by
+the hardware is a logical AND of these two sets of rules.
+
+The hardware tags all traffic internally with a port-based VLAN (pvid), or it
+decodes the VLAN information from the 802.1Q tag. Advanced VLAN classification
+is not possible. Once attributed a VLAN tag, frames are checked against the
+port's membership rules and dropped at ingress if they don't match any VLAN.
+This behavior is available when switch ports are enslaved to a bridge with
+``vlan_filtering 1``.
+
+Normally the hardware is not configurable with respect to VLAN awareness, but
+by changing what TPID the switch searches 802.1Q tags for, the semantics of a
+bridge with ``vlan_filtering 0`` can be kept (accept all traffic, tagged or
+untagged), and therefore this mode is also supported.
+
+Segregating the switch ports in multiple bridges is supported (e.g. 2 + 2), but
+all bridges should have the same level of VLAN awareness (either both have
+``vlan_filtering`` 0, or both 1). Also an inevitable limitation of the fact
+that VLAN awareness is global at the switch level is that once a bridge with
+``vlan_filtering`` enslaves at least one switch port, the other un-bridged
+ports are no longer available for standalone traffic termination.
+
+Topology and loop detection through STP is supported.
+
+L2 FDB manipulation (add/delete/dump) is currently possible for the first
+generation devices. Aging time of FDB entries, as well as enabling fully static
+management (no address learning and no flooding of unknown traffic) is not yet
+configurable in the driver.
+
+Other notable features
+======================
+
+The switches have a PTP Hardware Clock that can be steered through SPI and used
+for timestamping management traffic on ingress and egress.
+Also, the T, Q and S devices support TTEthernet (an implementation of SAE
+AS6802 from TTTech), which is a set of Ethernet QoS enhancements somewhat
+similar in behavior to IEEE TSN (time-aware shaping, time-based policing).
+Configuring these features is currently not supported in the driver.
+
+Device Tree bindings and board design
+=====================================
+
+This section references ``Documentation/devicetree/bindings/net/dsa/sja1105.txt``
+and aims to showcase some potential switch caveats.
+
+RMII PHY role and out-of-band signaling
+---------------------------------------
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
+RGMII fixed-link and internal delays
+------------------------------------
+
+As mentioned in the bindings document, the second generation of devices has
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
+their driver inevitably needs to change the speed and clock frequency if it's
+required to work at gigabit.
+
+MDIO bus and PHY management
+---------------------------
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

