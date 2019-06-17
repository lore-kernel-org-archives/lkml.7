Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54792C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4F3208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CTQureyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfFQTAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:00:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25677 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQS77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560797999; x=1592333999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GED2GA9QcE13vUl5xR4mTzXTMt8Lm/cPPiiomsp+YVU=;
  b=CTQureynTTh6tI+Te55MGbsieRaBn+Pz3IJKzaVSXDaUPdz7d9rOGbXP
   7Fxg78oxBBUDnV3NhiKrWnzqcYBgXglALhjWYaPeCAXvfTcQ7p8xfu0cS
   9n7kSo0Zym/SIwjaclFs7GBlKwicl+0B5vhgZM7vxVETvFQk88WgBV376
   7FTGkI+t+u+xfHOtQNj2Nl0LfPDMf73nei8syufrUGwwt/TKDyphdspfW
   svaIYJYUc9nk2OASZRPXtg8HhbtZ7UK98o6iE4s9ned+CipNlTYZgiMBD
   UW727ykgoCdSchceDV92CZcsKwi8QYRA+KY11JEBKtR19vc/xLqK6Lj21
   A==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; 
   d="scan'208";a="112032235"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 02:59:59 +0800
IronPort-SDR: 6Hh3HAIXCsjyBHZroPvc+BoVZgprG7Nt32ljyu0uEZlXS2MQt/9UIYk6zGMZK+ngj3TQMr3bhk
 KbOuU3mt2EsNf2lvXuesjgxHJOstN/+giDL9jgJKpilQRsccSGIK8L/ZN6Qvk2agntWt1uFhB5
 PwtiM611zfjAhQEJLq/0unPxJIQID73Id+qBDxyI7/Bj06FxzRMaBwp/3Q0RbfgaviwpWIkuDE
 xwL3140C6K4JI0Jh3W49Ule+HWBpxBo4CHNxgIMfv6K3N8inFbaPnasuiXQLO1CDh0K4K2DrN6
 7sec2e5fY6pWliWTDTlqthmL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 11:59:29 -0700
IronPort-SDR: IwDlxCoeIEV9birPttBGRyAxGoo4PO9XDI2b6rv6So20SSp7gpuKqDYkVfcj/YgAbcIDEX5xrT
 zYriFHD9jzhIykf8rB1NYxOkxuLmX63honLpoHi1q20Jm3flrEUNsIYZSBUgfLLHB64iyw6FyK
 0waelF1QmvcpSgo00XeILtQHPXonfea34Z56vH/bd/QfZV64qpzowK9j4qXnHfDfiNg845p9sN
 fwrwNn3yuuI6f/dOANfN3s8Ud38GRQkHl1TlzmvYgjYWhQjjCutzZiUQghSMX/hNiQC2NfVp3N
 wk4=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 11:59:57 -0700
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v7 1/7] Documentation: DT: arm: add support for sockets defining package boundaries
Date:   Mon, 17 Jun 2019 11:59:14 -0700
Message-Id: <20190617185920.29581-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617185920.29581-1-atish.patra@wdc.com>
References: <20190617185920.29581-1-atish.patra@wdc.com>
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

