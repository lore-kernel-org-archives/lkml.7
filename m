Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3E241F1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ptsY+8Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE2VOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:14:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60730 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559164509; x=1590700509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GED2GA9QcE13vUl5xR4mTzXTMt8Lm/cPPiiomsp+YVU=;
  b=ptsY+8Kh4E6vVXuCWnxpCf8S2yFK5CujPOwGLz71iaeL0oUQTHk10Y2V
   w7psIDK59FLEe2eLbSr/7DybmCM55vnNDZXhJ/rnHAMLPmZLSbsbNRy6j
   8BqiM0l+K9QsViNHCTwe6N3pxYOUBfeyFk6SaQkaYTqz7mi6ZVJbC65pC
   m1vqBaL8uS0/Bj52nGXAa6HShfTzuSmgpWz1+192tbTzSGOPMBXnjC8Cn
   Y9rNhRn69tYaIlnFj0PZ4q4xPaz3C/II9cz0O+7VTNTU3WA1D7iDKPQAu
   FNURi1NCc6+WOHxOj6Y1hTdm9JTp+cq/GmsH/CUmulYpQ66EfUcTjM3HW
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="208905638"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 05:15:08 +0800
IronPort-SDR: 53xN6LL2cl6JJ2aZQsGytbjKheyhFCUfo5RiwpFzA6phANlW6NCblA7B94nZiq3ZiMr6DNhSrk
 1U2z4GJaNZwffLXg2Bc2AyFfy/6QbiOxyGRuREqIT3/h3Pjxm4kNjwB0bdeYpDc8AfY4ozkKQm
 Sp30HEWY71AtxfCsiGbhXPpiIYneBxvAZ3xLpuxpxcYrAvia4O1W6yExm9OuCZyzVlAHjzl0f0
 bGY7nyH9NzsS7f5+Q65rYNXVxmKuMVLR89qsBYckWsCdZ37AZTaI/g3nlc0G3WzGPvP3xkarNb
 eY3omy2Qe6jqURjAD9KMEE+l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 May 2019 13:49:43 -0700
IronPort-SDR: LNieCBRCrRWkCPk/2wErF1qhbNOzx/mTCPMwP8pmln9eiSN2AhMLbpFEuptkyN49RfaKsID2/3
 1y43bDaShwmjq/4K71iziSi3fquIMoGmT23XcuPqgQPRv2KQbdWMOqojdGHnPB+BVWHdnobIsa
 30JadZk8qsdiL2Lw0vsVo06IwlqCQ2Fpk80AxBfwAXmvNyb26gwYjb/rJrWGSspeNI91OF+Z+6
 ShmyFdlaGp5oCLVoDmryBxj3/WQFv8Tg9UGcJqLeLpt7NKwtJ7gTFEXx4crY6PAXne2oVOb5Z8
 QwA=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 14:14:33 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets defining package boundaries
Date:   Wed, 29 May 2019 14:13:34 -0700
Message-Id: <20190529211340.17087-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529211340.17087-1-atish.patra@wdc.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

The current ARM DT topology description provides the operating system
with a topological view of the system that is based on leaf nodes
representing either cores or threads (in an SMT system) and a
hierarchical set of cluster nodes that creates a hierarchical topology
view of how those cores and threads are grouped.

However this hierarchical representation of clusters does not allow to
describe what topology level actually represents the physical package or
the socket boundary, which is a key piece of information to be used by
an operating system to optimize resource allocation and scheduling.

Lets add a new "socket" node type in the cpu-map node to describe the
same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/topology.txt      | 52 ++++++++++++++-----
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
index b0d80c0fb265..3b8febb46dad 100644
--- a/Documentation/devicetree/bindings/arm/topology.txt
+++ b/Documentation/devicetree/bindings/arm/topology.txt
@@ -9,6 +9,7 @@ ARM topology binding description
 In an ARM system, the hierarchy of CPUs is defined through three entities that
 are used to describe the layout of physical CPUs in the system:
 
+- socket
 - cluster
 - core
 - thread
@@ -63,21 +64,23 @@ nodes are listed.
 
 	The cpu-map node's child nodes can be:
 
-	- one or more cluster nodes
+	- one or more cluster nodes or
+	- one or more socket nodes in a multi-socket system
 
 	Any other configuration is considered invalid.
 
-The cpu-map node can only contain three types of child nodes:
+The cpu-map node can only contain 4 types of child nodes:
 
+- socket node
 - cluster node
 - core node
 - thread node
 
 whose bindings are described in paragraph 3.
 
-The nodes describing the CPU topology (cluster/core/thread) can only
-be defined within the cpu-map node and every core/thread in the system
-must be defined within the topology.  Any other configuration is
+The nodes describing the CPU topology (socket/cluster/core/thread) can
+only be defined within the cpu-map node and every core/thread in the
+system must be defined within the topology.  Any other configuration is
 invalid and therefore must be ignored.
 
 ===========================================
@@ -85,26 +88,44 @@ invalid and therefore must be ignored.
 ===========================================
 
 cpu-map child nodes must follow a naming convention where the node name
-must be "clusterN", "coreN", "threadN" depending on the node type (ie
-cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes which
-are siblings within a single common parent node must be given a unique and
+must be "socketN", "clusterN", "coreN", "threadN" depending on the node type
+(ie socket/cluster/core/thread) (where N = {0, 1, ...} is the node number; nodes
+which are siblings within a single common parent node must be given a unique and
 sequential N value, starting from 0).
 cpu-map child nodes which do not share a common parent node can have the same
 name (ie same number N as other cpu-map child nodes at different device tree
 levels) since name uniqueness will be guaranteed by the device tree hierarchy.
 
 ===========================================
-3 - cluster/core/thread node bindings
+3 - socket/cluster/core/thread node bindings
 ===========================================
 
-Bindings for cluster/cpu/thread nodes are defined as follows:
+Bindings for socket/cluster/cpu/thread nodes are defined as follows:
+
+- socket node
+
+	 Description: must be declared within a cpu-map node, one node
+		      per physical socket in the system. A system can
+		      contain single or multiple physical socket.
+		      The association of sockets and NUMA nodes is beyond
+		      the scope of this bindings, please refer [2] for
+		      NUMA bindings.
+
+	This node is optional for a single socket system.
+
+	The socket node name must be "socketN" as described in 2.1 above.
+	A socket node can not be a leaf node.
+
+	A socket node's child nodes must be one or more cluster nodes.
+
+	Any other configuration is considered invalid.
 
 - cluster node
 
 	 Description: must be declared within a cpu-map node, one node
 		      per cluster. A system can contain several layers of
-		      clustering and cluster nodes can be contained in parent
-		      cluster nodes.
+		      clustering within a single physical socket and cluster
+		      nodes can be contained in parent cluster nodes.
 
 	The cluster node name must be "clusterN" as described in 2.1 above.
 	A cluster node can not be a leaf node.
@@ -164,13 +185,15 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
 4 - Example dts
 ===========================================
 
-Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters):
+Example 1 (ARM 64-bit, 16-cpu system, two clusters of clusters in a single
+physical socket):
 
 cpus {
 	#size-cells = <0>;
 	#address-cells = <2>;
 
 	cpu-map {
+		socket0 {
 			cluster0 {
 				cluster0 {
 					core0 {
@@ -253,6 +276,7 @@ cpus {
 				};
 			};
 		};
+	};
 
 	CPU0: cpu@0 {
 		device_type = "cpu";
@@ -473,3 +497,5 @@ cpus {
 ===============================================================================
 [1] ARM Linux kernel documentation
     Documentation/devicetree/bindings/arm/cpus.yaml
+[2] Devicetree NUMA binding description
+    Documentation/devicetree/bindings/numa.txt
-- 
2.21.0

