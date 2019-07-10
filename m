Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69384C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5582064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljYnZWFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGJCFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:05:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33238 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfGJCFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:05:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so292708pfq.0;
        Tue, 09 Jul 2019 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YOtbLsy0wckrR7O54L5GemGbl9uTgq5jTL6vjGWdDYs=;
        b=ljYnZWFiRSRtcbu+p+TTU73sg8fIwBVMN1oE+To15K+eTEP0bMCmW0TT35uxXJ6Z5w
         JbJb+QepdZ5mHX2rO+pWfg1oE4b1gd6Fwh0/dVZgteMDTDPRq7bqr34N2Essu0ygjVX6
         J5kAFoAddMc3EIbfLPu4gyAy44BeF4QdNHEt9WiXKj5wtLLZmkH5vVE59Rai0qj+HLMG
         iOWxseFATT90gd8v95ZkWpvr9J0voWXZ7riKPo1vqMnK8kcXL8yRUVwuddyrWkeP/mWr
         OToRJ4VFd9cUjSYd1jW9zJRa4gWiO3/mlyO+7YPN1fRDfHd9FUFsW/ppJqwLD1mp2EbF
         SL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YOtbLsy0wckrR7O54L5GemGbl9uTgq5jTL6vjGWdDYs=;
        b=Cnr0o6mmbYYSM8bACWnQIUBvQ6a+M6rhB3axismO9bLPWw8CQF5EWo3/SDe0N6gC8t
         OLM3Tb+EOXk/XeTYzIJckqD1N4s3s5Tn4yTgPbPfldkTh1kwovsbEhBwRZlTBTV+EDM4
         3wz05q70lv3Isx9urR5bdhRVtRKOoMSzZ1w7eSkjTViX3Qi+UNzHBgQu5lFv3Qw1LTb4
         PzNDmrdvGSLI4d091Uoon9NxMvPggrEZIoh/ASWOG5F/yK1blQSNr5K20zQGNTzzipsh
         Uj7nU62WcYb/XqHA+bEp73s+5cmapojJLmBmqhdPYyARVl7rn2Lcw99N0+rAYDIv4VSh
         KAbg==
X-Gm-Message-State: APjAAAVoRmMfHdaQGzBp+SeEtPX9OuyZpn4nzCEonlJXpHVLgo6jTcwS
        iHKjnMtVz9LsPILZsWkpgzA=
X-Google-Smtp-Source: APXvYqyXPXHsq6jVl084kEF23MBAcRm9Hu9bbni/SWP/zZpIYwBF/C62luhj4aFtMcoi+KanOS9P1w==
X-Received: by 2002:a17:90a:a404:: with SMTP id y4mr3844308pjp.58.1562724341312;
        Tue, 09 Jul 2019 19:05:41 -0700 (PDT)
Received: from debian.net.fpt ([2405:4800:58f7:563b:d56c:af4b:a9fa:e854])
        by smtp.gmail.com with ESMTPSA id v8sm299426pgs.82.2019.07.09.19.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:05:40 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     corbet@lwn.net, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mchehab+samsung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        skhan@linuxfoundation.org, suzuki.poulose@arm.com,
        tranmanphong@gmail.com
Subject: [Patch V3] Documentation: coresight: covert txt to rst
Date:   Wed, 10 Jul 2019 09:05:30 +0700
Message-Id: <20190710020530.6262-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190705204512.15444-1-tranmanphong@gmail.com>
References: <20190705204512.15444-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as doc-guide of kernel documentation, use Sphinx tool to
generate the html/pdf... files.

This changes the plan text txt to rst format.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
ChangeLog:
V2: review points from Mathieu, Jonathan
  * Add coresight-cpu-debug
  * Update MAINTAINERS file
  * Avoid use markup as much as posible
V3: review points from Mauro
  * add the colon author, date
  * change to use ```` in the struct
  * add line for the acronyms
---
 ...sight-cpu-debug.txt => coresight-cpu-debug.rst} |  67 ++--
 .../trace/{coresight.txt => coresight.rst}         | 341 +++++++++++----------
 Documentation/trace/index.rst                      |   2 +
 MAINTAINERS                                        |   4 +-
 4 files changed, 219 insertions(+), 195 deletions(-)
 rename Documentation/trace/{coresight-cpu-debug.txt => coresight-cpu-debug.rst} (84%)
 rename Documentation/trace/{coresight.txt => coresight.rst} (55%)

diff --git a/Documentation/trace/coresight-cpu-debug.txt b/Documentation/trace/coresight-cpu-debug.rst
similarity index 84%
rename from Documentation/trace/coresight-cpu-debug.txt
rename to Documentation/trace/coresight-cpu-debug.rst
index f07e38094b40..8c6ecb4c1f54 100644
--- a/Documentation/trace/coresight-cpu-debug.txt
+++ b/Documentation/trace/coresight-cpu-debug.rst
@@ -1,8 +1,9 @@
-		Coresight CPU Debug Module
-		==========================
+==========================
+Coresight CPU Debug Module
+==========================
 
-   Author:   Leo Yan <leo.yan@linaro.org>
-   Date:     April 5th, 2017
+   :Author:   Leo Yan <leo.yan@linaro.org>
+   :Date:     April 5th, 2017
 
 Introduction
 ------------
@@ -69,6 +70,7 @@ Before accessing debug registers, we should ensure the clock and power domain
 have been enabled properly. In ARMv8-a ARM (ARM DDI 0487A.k) chapter 'H9.1
 Debug registers', the debug registers are spread into two domains: the debug
 domain and the CPU domain.
+::
 
                                 +---------------+
                                 |               |
@@ -125,18 +127,21 @@ If you want to enable debugging functionality at boot time, you can add
 "coresight_cpu_debug.enable=1" to the kernel command line parameter.
 
 The driver also can work as module, so can enable the debugging when insmod
-module:
-# insmod coresight_cpu_debug.ko debug=1
+module::
+
+  # insmod coresight_cpu_debug.ko debug=1
 
 When boot time or insmod module you have not enabled the debugging, the driver
 uses the debugfs file system to provide a knob to dynamically enable or disable
 debugging:
 
-To enable it, write a '1' into /sys/kernel/debug/coresight_cpu_debug/enable:
-# echo 1 > /sys/kernel/debug/coresight_cpu_debug/enable
+To enable it, write a '1' into /sys/kernel/debug/coresight_cpu_debug/enable::
+
+  # echo 1 > /sys/kernel/debug/coresight_cpu_debug/enable
+
+To disable it, write a '0' into /sys/kernel/debug/coresight_cpu_debug/enable::
 
-To disable it, write a '0' into /sys/kernel/debug/coresight_cpu_debug/enable:
-# echo 0 > /sys/kernel/debug/coresight_cpu_debug/enable
+  # echo 0 > /sys/kernel/debug/coresight_cpu_debug/enable
 
 As explained in chapter "Clock and power domain", if you are working on one
 platform which has idle states to power off debug logic and the power
@@ -154,34 +159,34 @@ subsystem, more specifically by using the "/dev/cpu_dma_latency"
 interface (see Documentation/power/pm_qos_interface.txt for more
 details).  As specified in the PM QoS documentation the requested
 parameter will stay in effect until the file descriptor is released.
-For example:
+For example::
 
-# exec 3<> /dev/cpu_dma_latency; echo 0 >&3
-...
-Do some work...
-...
-# exec 3<>-
+  # exec 3<> /dev/cpu_dma_latency; echo 0 >&3
+  ...
+  Do some work...
+  ...
+  # exec 3<>-
 
 The same can also be done from an application program.
 
 Disable specific CPU's specific idle state from cpuidle sysfs (see
-Documentation/admin-guide/pm/cpuidle.rst):
-# echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
+Documentation/admin-guide/pm/cpuidle.rst)::
 
+  # echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
 
 Output format
 -------------
 
-Here is an example of the debugging output format:
-
-ARM external debug module:
-coresight-cpu-debug 850000.debug: CPU[0]:
-coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
-coresight-cpu-debug 850000.debug:  EDPCSR:  handle_IPI+0x174/0x1d8
-coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
-coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
-coresight-cpu-debug 852000.debug: CPU[1]:
-coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
-coresight-cpu-debug 852000.debug:  EDPCSR:  debug_notifier_call+0x23c/0x358
-coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
-coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
+Here is an example of the debugging output format::
+
+  ARM external debug module:
+  coresight-cpu-debug 850000.debug: CPU[0]:
+  coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
+  coresight-cpu-debug 850000.debug:  EDPCSR:  handle_IPI+0x174/0x1d8
+  coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
+  coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
+  coresight-cpu-debug 852000.debug: CPU[1]:
+  coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
+  coresight-cpu-debug 852000.debug:  EDPCSR:  debug_notifier_call+0x23c/0x358
+  coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
+  coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.rst
similarity index 55%
rename from Documentation/trace/coresight.txt
rename to Documentation/trace/coresight.rst
index efbc832146e7..39b07115ff4d 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.rst
@@ -1,8 +1,9 @@
-		Coresight - HW Assisted Tracing on ARM
-		======================================
+======================================
+Coresight - HW Assisted Tracing on ARM
+======================================
 
-   Author:   Mathieu Poirier <mathieu.poirier@linaro.org>
-   Date:     September 11th, 2014
+   :Author:   Mathieu Poirier <mathieu.poirier@linaro.org>
+   :Date:     September 11th, 2014
 
 Introduction
 ------------
@@ -26,7 +27,7 @@ implementation, either storing the compressed stream in a memory buffer or
 creating an interface to the outside world where data can be transferred to a
 host without fear of filling up the onboard coresight memory buffer.
 
-At typical coresight system would look like this:
+At typical coresight system would look like this::
 
   *****************************************************************
  **************************** AMBA AXI  ****************************===||
@@ -95,15 +96,24 @@ Acronyms and Classification
 
 Acronyms:
 
-PTM:     Program Trace Macrocell
-ETM:     Embedded Trace Macrocell
-STM:     System trace Macrocell
-ETB:     Embedded Trace Buffer
-ITM:     Instrumentation Trace Macrocell
-TPIU:    Trace Port Interface Unit
-TMC-ETR: Trace Memory Controller, configured as Embedded Trace Router
-TMC-ETF: Trace Memory Controller, configured as Embedded Trace FIFO
-CTI:     Cross Trigger Interface
+PTM:
+    Program Trace Macrocell
+ETM:
+    Embedded Trace Macrocell
+STM:
+    System trace Macrocell
+ETB:
+    Embedded Trace Buffer
+ITM:
+    Instrumentation Trace Macrocell
+TPIU:
+     Trace Port Interface Unit
+TMC-ETR:
+        Trace Memory Controller, configured as Embedded Trace Router
+TMC-ETF:
+        Trace Memory Controller, configured as Embedded Trace FIFO
+CTI:
+    Cross Trigger Interface
 
 Classification:
 
@@ -118,7 +128,7 @@ Misc:
 
 
 Device Tree Bindings
-----------------------
+--------------------
 
 See Documentation/devicetree/bindings/arm/coresight.txt for details.
 
@@ -133,57 +143,57 @@ The coresight framework provides a central point to represent, configure and
 manage coresight devices on a platform.  Any coresight compliant device can
 register with the framework for as long as they use the right APIs:
 
-struct coresight_device *coresight_register(struct coresight_desc *desc);
-void coresight_unregister(struct coresight_device *csdev);
+.. c:function:: struct coresight_device *coresight_register(struct coresight_desc *desc);
+.. c:function:: void coresight_unregister(struct coresight_device *csdev);
 
-The registering function is taking a "struct coresight_device *csdev" and
-register the device with the core framework.  The unregister function takes
-a reference to a "struct coresight_device", obtained at registration time.
+The registering function is taking a ``struct coresight_desc *desc`` and
+register the device with the core framework. The unregister function takes
+a reference to a ``struct coresight_device *csdev`` obtained at registration time.
 
 If everything goes well during the registration process the new devices will
-show up under /sys/bus/coresight/devices, as showns here for a TC2 platform:
+show up under /sys/bus/coresight/devices, as showns here for a TC2 platform::
 
-root:~# ls /sys/bus/coresight/devices/
-replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
-root:~#
+    root:~# ls /sys/bus/coresight/devices/
+    replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
+    20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
+    root:~#
 
-The functions take a "struct coresight_device", which looks like this:
+The functions take a ``struct coresight_device``, which looks like this::
 
-struct coresight_desc {
-        enum coresight_dev_type type;
-        struct coresight_dev_subtype subtype;
-        const struct coresight_ops *ops;
-        struct coresight_platform_data *pdata;
-        struct device *dev;
-        const struct attribute_group **groups;
-};
+    struct coresight_desc {
+            enum coresight_dev_type type;
+            struct coresight_dev_subtype subtype;
+            const struct coresight_ops *ops;
+            struct coresight_platform_data *pdata;
+            struct device *dev;
+            const struct attribute_group **groups;
+    };
 
 
 The "coresight_dev_type" identifies what the device is, i.e, source link or
 sink while the "coresight_dev_subtype" will characterise that type further.
 
-The "struct coresight_ops" is mandatory and will tell the framework how to
+The ``struct coresight_ops`` is mandatory and will tell the framework how to
 perform base operations related to the components, each component having
-a different set of requirement.  For that "struct coresight_ops_sink",
-"struct coresight_ops_link" and "struct coresight_ops_source" have been
+a different set of requirement. For that ``struct coresight_ops_sink``,
+``struct coresight_ops_link`` and struct coresight_ops_source have been
 provided.
 
-The next field, "struct coresight_platform_data *pdata" is acquired by calling
-"of_get_coresight_platform_data()", as part of the driver's _probe routine and
-"struct device *dev" gets the device reference embedded in the "amba_device":
+The next field ``struct coresight_platform_data *pdata`` is acquired by calling
+``of_get_coresight_platform_data()``, as part of the driver's _probe routine and
+``struct device *dev`` gets the device reference embedded in the ``amba_device``::
 
-static int etm_probe(struct amba_device *adev, const struct amba_id *id)
-{
- ...
- ...
- drvdata->dev = &adev->dev;
- ...
-}
+    static int etm_probe(struct amba_device *adev, const struct amba_id *id)
+    {
+     ...
+     ...
+     drvdata->dev = &adev->dev;
+     ...
+    }
 
 Specific class of device (source, link, or sink) have generic operations
-that can be performed on them (see "struct coresight_ops").  The
-"**groups" is a list of sysfs entries pertaining to operations
+that can be performed on them (see struct coresight_ops). The ``**groups``
+is a list of sysfs entries pertaining to operations
 specific to that component only.  "Implementation defined" customisations are
 expected to be accessed and controlled using those entries.
 
@@ -191,9 +201,12 @@ expected to be accessed and controlled using those entries.
 How to use the tracer modules
 -----------------------------
 
-There are two ways to use the Coresight framework: 1) using the perf cmd line
-tools and 2) interacting directly with the Coresight devices using the sysFS
-interface.  Preference is given to the former as using the sysFS interface
+There are two ways to use the Coresight framework:
+
+1. using the perf cmd line tools.
+2. interacting directly with the Coresight devices using the sysFS interface.
+
+Preference is given to the former as using the sysFS interface
 requires a deep understanding of the Coresight HW.  The following sections
 provide details on using both methods.
 
@@ -202,107 +215,107 @@ provide details on using both methods.
 Before trace collection can start, a coresight sink needs to be identified.
 There is no limit on the amount of sinks (nor sources) that can be enabled at
 any given moment.  As a generic operation, all device pertaining to the sink
-class will have an "active" entry in sysfs:
-
-root:/sys/bus/coresight/devices# ls
-replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
-root:/sys/bus/coresight/devices# ls 20010000.etb
-enable_sink  status  trigger_cntr
-root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
-root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
-1
-root:/sys/bus/coresight/devices#
+class will have an "active" entry in sysfs::
+
+    root:/sys/bus/coresight/devices# ls
+    replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
+    20010000.etb         20040000.funnel  2201d000.ptm  2203d000.etm
+    root:/sys/bus/coresight/devices# ls 20010000.etb
+    enable_sink  status  trigger_cntr
+    root:/sys/bus/coresight/devices# echo 1 > 20010000.etb/enable_sink
+    root:/sys/bus/coresight/devices# cat 20010000.etb/enable_sink
+    1
+    root:/sys/bus/coresight/devices#
 
 At boot time the current etm3x driver will configure the first address
 comparator with "_stext" and "_etext", essentially tracing any instruction
 that falls within that range.  As such "enabling" a source will immediately
-trigger a trace capture:
-
-root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
-root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
-1
-root:/sys/bus/coresight/devices# cat 20010000.etb/status
-Depth:          0x2000
-Status:         0x1
-RAM read ptr:   0x0
-RAM wrt ptr:    0x19d3   <----- The write pointer is moving
-Trigger cnt:    0x0
-Control:        0x1
-Flush status:   0x0
-Flush ctrl:     0x2001
-root:/sys/bus/coresight/devices#
-
-Trace collection is stopped the same way:
-
-root:/sys/bus/coresight/devices# echo 0 > 2201c000.ptm/enable_source
-root:/sys/bus/coresight/devices#
-
-The content of the ETB buffer can be harvested directly from /dev:
-
-root:/sys/bus/coresight/devices# dd if=/dev/20010000.etb \
-of=~/cstrace.bin
-
-64+0 records in
-64+0 records out
-32768 bytes (33 kB) copied, 0.00125258 s, 26.2 MB/s
-root:/sys/bus/coresight/devices#
+trigger a trace capture::
+
+    root:/sys/bus/coresight/devices# echo 1 > 2201c000.ptm/enable_source
+    root:/sys/bus/coresight/devices# cat 2201c000.ptm/enable_source
+    1
+    root:/sys/bus/coresight/devices# cat 20010000.etb/status
+    Depth:          0x2000
+    Status:         0x1
+    RAM read ptr:   0x0
+    RAM wrt ptr:    0x19d3   <----- The write pointer is moving
+    Trigger cnt:    0x0
+    Control:        0x1
+    Flush status:   0x0
+    Flush ctrl:     0x2001
+    root:/sys/bus/coresight/devices#
+
+Trace collection is stopped the same way::
+
+    root:/sys/bus/coresight/devices# echo 0 > 2201c000.ptm/enable_source
+    root:/sys/bus/coresight/devices#
+
+The content of the ETB buffer can be harvested directly from /dev::
+
+    root:/sys/bus/coresight/devices# dd if=/dev/20010000.etb \
+    of=~/cstrace.bin
+    64+0 records in
+    64+0 records out
+    32768 bytes (33 kB) copied, 0.00125258 s, 26.2 MB/s
+    root:/sys/bus/coresight/devices#
 
 The file cstrace.bin can be decompressed using "ptm2human", DS-5 or Trace32.
 
 Following is a DS-5 output of an experimental loop that increments a variable up
 to a certain value.  The example is simple and yet provides a glimpse of the
 wealth of possibilities that coresight provides.
-
-Info                                    Tracing enabled
-Instruction     106378866       0x8026B53C      E52DE004        false   PUSH     {lr}
-Instruction     0       0x8026B540      E24DD00C        false   SUB      sp,sp,#0xc
-Instruction     0       0x8026B544      E3A03000        false   MOV      r3,#0
-Instruction     0       0x8026B548      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Timestamp                                       Timestamp: 17106715833
-Instruction     319     0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     9       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     10      0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
-Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
-Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
-Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
-Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
-Instruction     6       0x8026B560      EE1D3F30        false   MRC      p15,#0x0,r3,c13,c0,#1
-Instruction     0       0x8026B564      E1A0100D        false   MOV      r1,sp
-Instruction     0       0x8026B568      E3C12D7F        false   BIC      r2,r1,#0x1fc0
-Instruction     0       0x8026B56C      E3C2203F        false   BIC      r2,r2,#0x3f
-Instruction     0       0x8026B570      E59D1004        false   LDR      r1,[sp,#4]
-Instruction     0       0x8026B574      E59F0010        false   LDR      r0,[pc,#16] ; [0x8026B58C] = 0x80550368
-Instruction     0       0x8026B578      E592200C        false   LDR      r2,[r2,#0xc]
-Instruction     0       0x8026B57C      E59221D0        false   LDR      r2,[r2,#0x1d0]
-Instruction     0       0x8026B580      EB07A4CF        true    BL       {pc}+0x1e9344 ; 0x804548c4
-Info                                    Tracing enabled
-Instruction     13570831        0x8026B584      E28DD00C        false   ADD      sp,sp,#0xc
-Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
-Timestamp                                       Timestamp: 17107041535
+::
+
+    Info                                    Tracing enabled
+    Instruction     106378866       0x8026B53C      E52DE004        false   PUSH     {lr}
+    Instruction     0       0x8026B540      E24DD00C        false   SUB      sp,sp,#0xc
+    Instruction     0       0x8026B544      E3A03000        false   MOV      r3,#0
+    Instruction     0       0x8026B548      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+    Timestamp                                       Timestamp: 17106715833
+    Instruction     319     0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+    Instruction     9       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+    Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+    Instruction     7       0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+    Instruction     10      0x8026B54C      E59D3004        false   LDR      r3,[sp,#4]
+    Instruction     0       0x8026B550      E3530004        false   CMP      r3,#4
+    Instruction     0       0x8026B554      E2833001        false   ADD      r3,r3,#1
+    Instruction     0       0x8026B558      E58D3004        false   STR      r3,[sp,#4]
+    Instruction     0       0x8026B55C      DAFFFFFA        true    BLE      {pc}-0x10 ; 0x8026b54c
+    Instruction     6       0x8026B560      EE1D3F30        false   MRC      p15,#0x0,r3,c13,c0,#1
+    Instruction     0       0x8026B564      E1A0100D        false   MOV      r1,sp
+    Instruction     0       0x8026B568      E3C12D7F        false   BIC      r2,r1,#0x1fc0
+    Instruction     0       0x8026B56C      E3C2203F        false   BIC      r2,r2,#0x3f
+    Instruction     0       0x8026B570      E59D1004        false   LDR      r1,[sp,#4]
+    Instruction     0       0x8026B574      E59F0010        false   LDR      r0,[pc,#16] ; [0x8026B58C] = 0x80550368
+    Instruction     0       0x8026B578      E592200C        false   LDR      r2,[r2,#0xc]
+    Instruction     0       0x8026B57C      E59221D0        false   LDR      r2,[r2,#0x1d0]
+    Instruction     0       0x8026B580      EB07A4CF        true    BL       {pc}+0x1e9344 ; 0x804548c4
+    Info                                    Tracing enabled
+    Instruction     13570831        0x8026B584      E28DD00C        false   ADD      sp,sp,#0xc
+    Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
+    Timestamp                                       Timestamp: 17107041535
 
 2) Using perf framework:
 
@@ -327,7 +340,7 @@ A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
 listed along with configuration options within forward slashes '/'.  Since a
 Coresight system will typically have more than one sink, the name of the sink to
 work with needs to be specified as an event option.  Names for sink to choose
-from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
+from are listed in sysFS under ($SYSFS)/bus/coresight/devices::
 
 	root@linaro-nano:~# ls /sys/bus/coresight/devices/
 		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
@@ -343,14 +356,14 @@ to use for the trace session.
 
 More information on the above and other example on how to use Coresight with
 the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
-repository [3].
+repository [#third]_.
 
 2.1) AutoFDO analysis using the perf tools:
 
 perf can be used to record and analyze trace of programs.
 
 Execution can be recorded using 'perf record' with the cs_etm event,
-specifying the name of the sink to record to, e.g:
+specifying the name of the sink to record to, e.g::
 
     perf record -e cs_etm/@20070000.etr/u --per-thread
 
@@ -369,12 +382,14 @@ Generating coverage files for Feedback Directed Optimization: AutoFDO
 
 'perf inject' accepts the --itrace option in which case tracing data is
 removed and replaced with the synthesized events. e.g.
+::
 
 	perf inject --itrace --strip -i perf.data -o perf.data.new
 
 Below is an example of using ARM ETM for autoFDO.  It requires autofdo
 (https://github.com/google/autofdo) and gcc version 5.  The bubble
 sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tutorial).
+::
 
 	$ gcc-5 -O3 sort.c -o sort
 	$ taskset -c 2 ./sort
@@ -403,28 +418,30 @@ difference is that clients are driving the trace capture rather
 than the program flow through the code.
 
 As with any other CoreSight component, specifics about the STM tracer can be
-found in sysfs with more information on each entry being found in [1]:
+found in sysfs with more information on each entry being found in [#first]_::
 
-root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
-enable_source   hwevent_select  port_enable     subsystem       uevent
-hwevent_enable  mgmt            port_select     traceid
-root@genericarmv8:~#
+    root@genericarmv8:~# ls /sys/bus/coresight/devices/20100000.stm
+    enable_source   hwevent_select  port_enable     subsystem       uevent
+    hwevent_enable  mgmt            port_select     traceid
+    root@genericarmv8:~#
 
 Like any other source a sink needs to be identified and the STM enabled before
-being used:
+being used::
 
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
-root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
+    root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20010000.etf/enable_sink
+    root@genericarmv8:~# echo 1 > /sys/bus/coresight/devices/20100000.stm/enable_source
 
 From there user space applications can request and use channels using the devfs
-interface provided for that purpose by the generic STM API:
+interface provided for that purpose by the generic STM API::
+
+    root@genericarmv8:~# ls -l /dev/20100000.stm
+    crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
+    root@genericarmv8:~#
+
+Details on how to use the generic STM API can be found here [#second]_.
 
-root@genericarmv8:~# ls -l /dev/20100000.stm
-crw-------    1 root     root       10,  61 Jan  3 18:11 /dev/20100000.stm
-root@genericarmv8:~#
+.. [#first] Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
 
-Details on how to use the generic STM API can be found here [2].
+.. [#second] Documentation/trace/stm.rst
 
-[1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-[2]. Documentation/trace/stm.rst
-[3]. https://github.com/Linaro/perf-opencsd
+.. [#third] https://github.com/Linaro/perf-opencsd
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 6b4107cf4b98..b7891cb1ab4d 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -23,3 +23,5 @@ Linux Tracing Technologies
    intel_th
    stm
    sys-t
+   coresight
+   coresight-cpu-debug
diff --git a/MAINTAINERS b/MAINTAINERS
index 558acf24ea1e..04b006e5cc0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1549,8 +1549,8 @@ R:	Suzuki K Poulose <suzuki.poulose@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/hwtracing/coresight/*
-F:	Documentation/trace/coresight.txt
-F:	Documentation/trace/coresight-cpu-debug.txt
+F:	Documentation/trace/coresight.rst
+F:	Documentation/trace/coresight-cpu-debug.rst
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
-- 
2.11.0

