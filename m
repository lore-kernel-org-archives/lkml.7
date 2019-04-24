Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA48C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42F6214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T/pp0xse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfDXWZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:25:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50688 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388081AbfDXWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:25:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOsbm107948;
        Wed, 24 Apr 2019 17:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556144694;
        bh=xZTafVjZLL57snPr5kMK6ARGfn8HBX0y6TPlwT/UIBE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T/pp0xseZhuEVNXx6NxHkWRzRp/1drRBbCDjqdas6Jtk1XHrmvmzIFd1sfknp1FUn
         zk1leDVaOOoYE2P53b+2GI3oaJwDwuZFbwasdUJk2wi/W5AW/4PnGKJQIGDwbKHba/
         a4IyoipiKbCGOs+VBwaQu1b9IMSvDEi08sWqS6mg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3OMOsKc087644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 17:24:54 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 17:24:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 17:24:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOqME050086;
        Wed, 24 Apr 2019 17:24:53 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 10/11] Documentation: networking: add cpsw switchdev based driver documentation
Date:   Thu, 25 Apr 2019 01:24:26 +0300
Message-ID: <1556144667-27997-11-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

A new cpsw dirver based on switchdev was added. Add documentation about
basic configuration and future features

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../device_drivers/ti/cpsw_switchdev.txt      | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ti/cpsw_switchdev.txt

diff --git a/Documentation/networking/device_drivers/ti/cpsw_switchdev.txt b/Documentation/networking/device_drivers/ti/cpsw_switchdev.txt
new file mode 100644
index 000000000000..471e831365f0
--- /dev/null
+++ b/Documentation/networking/device_drivers/ti/cpsw_switchdev.txt
@@ -0,0 +1,159 @@
+* Texas Instruments CPSW switchdev based ethernet driver
+
+- Port renaming
+On older udev versions renaming of ethX to swXpY will not be automatically
+supported
+In order to rename via udev:
+ip -d link show dev sw0p1 | grep switchid
+
+SUBSYSTEM=="net", ACTION=="add", ATTR{phys_switch_id}==<switchid>, \
+        ATTR{phys_port_name}!="", NAME="sw0$attr{phys_port_name}"
+
+- The new (cpsw_new.c) driver is operating in dual-emac mode by default, thus
+working as 2 individual network interfaces. When the both interfaces joined
+the bridge - CPSW driver will enter a switch mode and discard dual_mac
+configuration. All configuration is implemented via switchdev API.
+
+CPSW will be switched back to dual_mac mode if any port leaves the bridge.
+ALE table is completely cleared and then refilled while switching between modes
+and introduces some limitation to bridge setup sequence.
+
+====================
+# Bridge setup
+====================
+ip link add name br0 type bridge
+ip link set dev br0 type bridge ageing_time 1000
+[*]ip link set dev br0 type bridge vlan_filtering 0
+[*]echo 0 > /sys/class/net/br0/bridge/default_vlan
+ip link set dev sw0p1 up
+ip link set dev sw0p2 up
+ip link set dev sw0p1 master br0
+ip link set dev sw0p2 master br0
+...
+[*]echo 1 > /sys/class/net/br0/bridge/default_vlan
+[*]ip link set dev br0 type bridge vlan_filtering 1
+
+
+=================
+# On/off STP
+=================
+ip link set dev BRDEV type bridge stp_state 1/0
+
+Note. Steps [*] are mandatory.
+
+====================
+# VLAN configuration
+====================
+bridge vlan add dev br0 vid 1 pvid untagged self <---- add cpu port to VLAN 1
+
+Note. This step is mandatory for bridge/default_vlan.
+
+=================
+# Add extra VLANs
+=================
+ 1. untagged:
+    bridge vlan add dev sw0p1 vid 100 pvid untagged master
+    bridge vlan add dev sw0p2 vid 100 pvid untagged master
+    bridge vlan add dev br0 vid 100 pvid untagged self <---- Add cpu port to VLAN100
+
+ 2. tagged:
+    bridge vlan add dev sw0p1 vid 100 master
+    bridge vlan add dev sw0p2 vid 100 master
+    bridge vlan add dev br0 vid 100 pvid tagged self <---- Add cpu port to VLAN100
+
+====
+FDBs
+====
+FDBs are automatically added on the appropriate switch port uppon detection
+
+Manually adding FDBs:
+bridge fdb add aa:bb:cc:dd:ee:ff dev sw0p1 master vlan 100
+bridge fdb add aa:bb:cc:dd:ee:fe dev sw0p2 master <---- Add on all VLANs
+
+====
+MDBs
+====
+MDBs are automatically added on the appropriate switch port uppon detection
+
+Manually adding MDBs:
+bridge mdb add dev br0 port sw0p1 grp 239.1.1.1 permanent vid 100
+bridge mdb add dev br0 port sw0p1 grp 239.1.1.1 permanent <---- Add on all VLANs
+
+==================
+MUlticast flooding
+==================
+CPU port mcast_flooding is always on
+
+Turning flooding on/off on swithch ports:
+bridge link set dev sw0p1 mcast_flood on/off
+
+==================
+Access and Trunk port
+==================
+ bridge vlan add dev sw0p1 vid 101 pvid untagged master
+ bridge vlan add dev sw0p2 vid 100 master
+
+
+ bridge vlan add dev br0 vid 100 self
+ ip link add link br0 name br0.100 type vlan id 100
+ - or -
+ [TBD] bridge vlan add dev br0 vid 100 untagged self
+
+ Note. Setting PVID on Bridge device itself working only for default VLAN,
+ but CPSW Host P0 port allows to configure it - need evaluation.
+
+=====================
+ NFS
+=====================
+The only way for NFS to work is by chrooting to a minimal environment when
+switch configuration that will affect connectivity is needed.
+Assuming you are booting NFS with eth1 interface(the script is hacky and
+it's just there to prove NFS is doable).
+
+setup.sh:
+#!/bin/sh
+mkdir proc
+mount -t proc none /proc
+ifconfig br0  > /dev/null
+if [ $? -ne 0 ]; then
+        echo "Setting up bridge"
+        ip link add name br0 type bridge
+        ip link set dev br0 type bridge ageing_time 1000
+        ip link set dev br0 type bridge vlan_filtering 1
+
+        ip link set eth1 down
+        ip link set eth1 name sw0p1
+        ip link set dev sw0p1 up
+        ip link set dev sw0p2 up
+        ip link set dev sw0p2 master br0
+        ip link set dev sw0p1 master br0
+        bridge vlan add dev br0 vid 1 pvid untagged self
+        ifconfig sw0p1 0.0.0.0
+        udhchc -i br0
+fi
+umount /proc
+
+run_nfs.sh:
+#!/bin/sh
+mkdir /tmp/root/bin -p
+mkdir /tmp/root/lib -p
+
+cp -r /lib/ /tmp/root/
+cp -r /bin/ /tmp/root/
+cp /sbin/ip /tmp/root/bin
+cp /sbin/bridge /tmp/root/bin
+cp /sbin/ifconfig /tmp/root/bin
+cp /sbin/udhcpc /tmp/root/bin
+cp /path/to/setup.sh /tmp/root/bin
+chroot /tmp/root/ busybox sh /bin/setup.sh
+
+run ./run_nfs.sh
+
+=====================
+Currently unsupported
+=====================
+1. ageing configuration
+2. Multicast flooding on/off for the CPU port
+3. Discovered FDBs/MDBs do not appear on 'bridge fdb/mdb show'
+4. VLANs offloading
+5. STP
\ No newline at end of file
-- 
2.17.1

