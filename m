Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB39C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1DB20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfFJSCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:02:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbfFJSCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:02:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D30337;
        Mon, 10 Jun 2019 11:02:48 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 399E83F246;
        Mon, 10 Jun 2019 11:02:47 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] Documentation: coresight: Update the generic device names
Date:   Mon, 10 Jun 2019 19:02:42 +0100
Message-Id: <1560189762-5267-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to reflect the new naming scheme with
latest changes.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1
  - Add a section about the Device Naming scheme and add refer to
    it in the examples.
---
 Documentation/trace/coresight.txt | 82 ++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index efbc832..b027d61 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -188,6 +188,49 @@ specific to that component only.  "Implementation defined" customisations are
 expected to be accessed and controlled using those entries.
 
 
+Device Naming scheme
+------------------------
+The devices that appear on the "coresight" bus were named the same as their
+parent devices, i.e, the real devices that appears on AMBA bus or the platform bus.
+Thus the names were based on the Linux Open Firmware layer naming convention,
+which follows the base physical address of the device followed by the device
+type. e.g:
+
+root:~# ls /sys/bus/coresight/devices/
+ 20010000.etf  20040000.funnel      20100000.stm     22040000.etm
+ 22140000.etm  230c0000.funnel      23240000.etm     20030000.tpiu
+ 20070000.etr  20120000.replicator  220c0000.funnel
+ 23040000.etm  23140000.etm         23340000.etm
+
+However, with the introduction of ACPI support, the names of the real
+devices are a bit cryptic and non-obvious. Thus, a new naming scheme was
+introduced to use more generic names based on the type of the device. The
+following rules apply:
+
+  1) Devices that are bound to CPUs, are named based on the CPU logical
+     number.
+
+     e.g, ETM bound to CPU0 is named "etm0"
+
+  2) All other devices follow a pattern, "<device_type_prefix>N", where :
+
+	<device_type_prefix> 	- A prefix specific to the type of the device
+	N			- a sequential number assigned based on the order
+				  of probing.
+
+	e.g, tmc_etf0, tmc_etr0, funnel0, funnel1
+
+Thus, with the new scheme the devices could appear as :
+
+root:~# ls /sys/bus/coresight/devices/
+ etm0     etm1     etm2         etm3  etm4      etm5      funnel0
+ funnel1  funnel2  replicator0  stm0  tmc_etf0  tmc_etr0  tpiu0
+
+Some of the examples below might refer to old naming scheme and some
+to the newer scheme, to give a confirmation that what you see on your
+system is not unexpected. One must use the "names" as they appear on
+the system under specified locations.
+
 How to use the tracer modules
 -----------------------------
 
@@ -326,16 +369,25 @@ amount of processor cores), the "cs_etm" PMU will be listed only once.
 A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
 listed along with configuration options within forward slashes '/'.  Since a
 Coresight system will typically have more than one sink, the name of the sink to
-work with needs to be specified as an event option.  Names for sink to choose
-from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
+work with needs to be specified as an event option.
+On newer kernels the available sinks are listed in sysFS under:
+($SYSFS)/bus/event_source/devices/cs_etm/sinks/
 
-	root@linaro-nano:~# ls /sys/bus/coresight/devices/
-		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
-		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
-		20070000.etr     20120000.replicator  220c0000.funnel
-		23040000.etm  23140000.etm     23340000.etm
+	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
+	tmc_etf0  tmc_etr0  tpiu0
 
-	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
+On older kernels, this may need to be found from the list of coresight devices,
+available under ($SYSFS)/bus/coresight/devices/:
+
+	root:~# ls /sys/bus/coresight/devices/
+	 etm0     etm1     etm2         etm3  etm4      etm5      funnel0
+	 funnel1  funnel2  replicator0  stm0  tmc_etf0  tmc_etr0  tpiu0
+
+	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
+
+As mentioned above in section "Device Naming scheme", the names of the devices could
+look different from what is used in the example above. One must use the device names
+as it appears under the sysFS.
 
 The syntax within the forward slashes '/' is important.  The '@' character
 tells the parser that a sink is about to be specified and that this is the sink
@@ -352,7 +404,7 @@ perf can be used to record and analyze trace of programs.
 Execution can be recorded using 'perf record' with the cs_etm event,
 specifying the name of the sink to record to, e.g:
 
-    perf record -e cs_etm/@20070000.etr/u --per-thread
+    perf record -e cs_etm/@tmc_etr0/u --per-thread
 
 The 'perf report' and 'perf script' commands can be used to analyze execution,
 synthesizing instruction and branch events from the instruction trace.
@@ -381,7 +433,7 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
 	Bubble sorting array of 30000 elements
 	5910 ms
 
-	$ perf record -e cs_etm/@20070000.etr/u --per-thread taskset -c 2 ./sort
+	$ perf record -e cs_etm/@tmc_etr0/u --per-thread taskset -c 2 ./sort
 	Bubble sorting array of 30000 elements
 	12543 ms
 	[ perf record: Woken up 35 times to write data ]
@@ -405,7 +457,7 @@ than the program flow through the code.
 As with any other CoreSight component, specifics about the STM tracer can be
 found in sysfs with more information on each entry being found in [1]:
 
-root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
+root@genericarmv8:~# ls /sys/bus/coresight/devices/stm0
 enable_source   hwevent_select  port_enable     subsystem       uevent
 hwevent_enable  mgmt            port_select     traceid
 root@genericarmv8:~#
@@ -413,14 +465,14 @@ root@genericarmv8:~#
 Like any other source a sink needs to be identified and the STM enabled before
 being used:
 
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
+root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
+root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/stm0/enable_source
 
 From there user space applications can request and use channels using the devfs
 interface provided for that purpose by the generic STM API:
 
-root@genericarmv8:~# ls -l /dev/20100000.stm
-crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
+root@genericarmv8:~# ls -l /dev/stm0
+crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/stm0
 root@genericarmv8:~#
 
 Details on how to use the generic STM API can be found here [2].
-- 
2.7.4

