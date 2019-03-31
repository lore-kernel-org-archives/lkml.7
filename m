Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AAFC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A08E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEyk3mpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfCaRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36950 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfCaRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so8874389wrm.4;
        Sun, 31 Mar 2019 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CqmTfCF4w8icXJrHPaHYdiHwdbMqFe36GBb/xp+4jlw=;
        b=SEyk3mpxuN/d1ccaADmZ5o1fZhu5eALSJM6USXUsc3UnisEuS5NTPtw0yPOL0F7OtB
         7j8Gg2wc5DmvmWKMAQitojSpjGKseD7jTNzMIdao2XeakpqGkVlunfifYAoOfgZQYqOC
         BBtDbolMTOIO9ltVLdzBh8/ScOt+Td+6rpsHFLEnXLGZ9Ry176PQs8mJzFAK2LzwkRwe
         8cKUj7gZD9Xf+2YkKrUG2/l+pE5HbIP8HazCMtM2Wp6w5Qcv7AlfwZ9EeHcicBv5niE5
         wJT2iOfZGgPQ0jlhimTC3wOeBqTJ8ZzruR0UcVw1clk+x1kpM+lORdKznn8KSDiyctaK
         7How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CqmTfCF4w8icXJrHPaHYdiHwdbMqFe36GBb/xp+4jlw=;
        b=fSwaMl94r3+Hrg2M9d32gKyJxAkzaxinCd3LzCttT3v2BRIR7qYGlntNE5j/bG9kDD
         7sklDvJtzLjbbM08dGyvU34br9NRxG0OK41PQYMHYx2XuImN7VRbBeWz+GgykeeRxxWQ
         NtmAZjUU0gieC03wdZhDhbAUCt/KjngzwkShkhjTzw3euNvU2ivzjDJX9c2UnpOq3No/
         g4qmC+Iy7nz3cpYR1SVlnBXXd7o0O2Au4l5imlO3JrugPCJbZoQtqGOD0fvkHGiZonUX
         CI3HUtfdq8dHAu1FyDZKgA7Ek6XcYjdhIF8ImUQM4BZ7+vUiiyQkClLZwEAZHvIjniqp
         mjJQ==
X-Gm-Message-State: APjAAAX2crur+3JF5C474O5IL/DLhBShksSusnZsN/5h06OilvWa9/PU
        L5YUU7FhZt0yWU/Iv61V0D8=
X-Google-Smtp-Source: APXvYqzooV3dDaW4Ss9tr2zcsynUZEDQTzhaxMrd3Ok6Jn2AvDibYL0M60uRuDTpP5+WFHVPeoYHHQ==
X-Received: by 2002:a5d:53d0:: with SMTP id a16mr17211972wrw.309.1554054191442;
        Sun, 31 Mar 2019 10:43:11 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:10 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 16/17] Documentation: networking: dsa: Add details about NXP SJA1105 driver
Date:   Sun, 31 Mar 2019 20:42:31 +0300
Message-Id: <20190331174232.22060-17-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/dsa/sja1105.txt | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/networking/dsa/sja1105.txt

diff --git a/Documentation/networking/dsa/sja1105.txt b/Documentation/networking/dsa/sja1105.txt
new file mode 100644
index 000000000000..b6f2c1bedd02
--- /dev/null
+++ b/Documentation/networking/dsa/sja1105.txt
@@ -0,0 +1,83 @@
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
+be steered through SPI and used for timestamping on ingress and egress.
+Also, the T, Q and S devices support TTEthernet (an implementation of
+SAE AS6802 from TTTech), which is a set of Ethernet QoS enhancements similar in
+behavior to IEEE TSN. Configuring these features is currently not supported in
+the driver.
+
-- 
2.17.1

