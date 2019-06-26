Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AADBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C17C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFZWi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:38:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:10648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZWi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:38:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313574950"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:38:54 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 00/10] Intel(R) Speed Select Technology
Date:   Wed, 26 Jun 2019 15:38:41 -0700
Message-Id: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel® Speed Select Technology (Intel® SST) — A powerful new collection of
features giving more granular control over CPU performance for optimized total
cost of ownership and performance. With Intel® SST, one server can be configured 
for power and performance for variety of diverse workload requirements. In the 
Linux submission code. we are using ISST to specify Intel® SST to avoid confusion 
with existing use of SST for "Smart Sound Technology".

Refer to these links for overview of the technology released with some Intel® Xeon®
Scalable processor (5218N, 6230N, and 6252N):
https://www.intel.com/content/www/us/en/architecture-and-technology/speed-select-technology-article.html
https://builders.intel.com/docs/networkbuilders/intel-speed-select-technology-base-frequency-enhancing-performance.pdf

The next generation of Intel® Xeon® processors are adding more features to the
Intel® Speed Select Technology and allow dynamic configuration of these features
from OS-software level instead from BIOS. This submission is adding new features
and dynamic configuration capabilities .


Intel SST Features:

Intel® SST—Performance Profile (PP or perf-profile):
This feature allows one server to be configured for different workload requirements
instead of deploying different servers based on the workload requirement reducing total
cost of ownership. With a single server deployed, the same server can be reconfigured
dynamically to one of the supported profiles to suit the specific workload requirements.
This feature introduces a mechanism that allows multiple optimized performance profiles 
per system via static and/or dynamic adjustment of TDP level and other performance
parameters.

Intel® SST—Core power (CP or core-power):
An Interface that allows user to define per core priority. This defines a mechanism
to distribute power among cores when there is a power constrained scenario. This defines
a class of service configuration. Each CPU core can be tied to a class of service and hence
an associated priority.

Intel® SST—Base Frequency (BF or base-freq):
The Intel® SST-BF feature lets user control and direct base frequency. If some critical
workload threads demand constant high guaranteed performance, then this feature can be
used to execute the thread at higher base frequency on specific set of CPUs.

Intel® SST—Turbo frequency (TF or turbo-freq):
Enables the ability to set different all core turbo ratio limits to cores based on the priority.
Using this features some cores can be configured to get higher turbo frequency by designating
them as high priority at the cost of lower or no turbo frequency on the low priority cores.

Implementation

The Intel® SST features are implemented in the firmware executing in the the power
management unit (we are calling PUNIT here for short). The mechanism to control these
features are specific to firmware implementation for Intel® Xeon® CPUs and are not architectural
features. The interface mechanism and semantics of the messages can change in future Xeon 
CPUs. Hence there is minimal kernel implementation by offering direct communication
to PUNIT via set of IOCTLs. The actual messages which can be sent to PUNIT are specified
in the following document link:

https://github.com/intel/CommsPowerManagement/blob/master/intel_sst_os_interface/mailbox.md

The idea here is that user space software like cloud orchestration software based on their workload
requirement configure the system. There is a full featured "Intel Speed Select" utility
submitted to kernel power tools, which can be used to validate and exercise the features.

Types of PUNIT interfaces
There are two types of interfaces. One using Mail box communications, which is facilitated
by a PCI device or in some Xeon® CPUs using MSRs; and other using an MMIO interface, which is
used primarily for core prioritization. For hiding details a single character device is created
to handle IOCTLs. The following block diagram shows the implementation overview.


User		User Space tool(intel-speed-select)/Cloud Orchestration software
					   IOCTLs	
---------------------------------------character device------------------------------
kernel				Common driver handling IOCTLs
			Mail Box drivers(PCI & MSR)	PCI MMIO driver 
--------------------------------------------------------------------------
Hardware				    PUNIT



Srinivas Pandruvada (10):
  platform/x86: ISST: Update ioctl-number.txt for Intel Speed Select
    interface
  platform/x86: ISST: Add common API to register and handle ioctls
  platform/x86: ISST: Store per CPU information
  platform/x86: ISST: Add IOCTL to Translate Linux logical CPU to PUNIT
    CPU number
  platform/x86: ISST: Add Intel Speed Select mmio interface
  platform/x86: ISST: Add Intel Speed Select mailbox interface via PCI
  platform/x86: ISST: Add Intel Speed Select mailbox interface via MSRs
  platform/x86: ISST: Add Intel Speed Select PUNIT MSR interface
  platform/x86: ISST: Restore state on resume
  tools/power/x86: A tool to validate Intel Speed Select commands

 Documentation/ioctl/ioctl-number.txt          |    1 +
 drivers/platform/x86/Kconfig                  |    2 +
 drivers/platform/x86/Makefile                 |    1 +
 .../x86/intel_speed_select_if/Kconfig         |   17 +
 .../x86/intel_speed_select_if/Makefile        |   10 +
 .../intel_speed_select_if/isst_if_common.c    |  672 +++++++
 .../intel_speed_select_if/isst_if_common.h    |   69 +
 .../intel_speed_select_if/isst_if_mbox_msr.c  |  216 +++
 .../intel_speed_select_if/isst_if_mbox_pci.c  |  214 +++
 .../x86/intel_speed_select_if/isst_if_mmio.c  |  180 ++
 include/uapi/linux/isst_if.h                  |  172 ++
 tools/power/x86/intel_speed_select/Makefile   |   31 +
 tools/power/x86/intel_speed_select/isst.h     |  231 +++
 .../x86/intel_speed_select/isst_config.c      | 1607 +++++++++++++++++
 .../power/x86/intel_speed_select/isst_core.c  |  721 ++++++++
 .../x86/intel_speed_select/isst_display.c     |  479 +++++
 16 files changed, 4623 insertions(+)
 create mode 100644 drivers/platform/x86/intel_speed_select_if/Kconfig
 create mode 100644 drivers/platform/x86/intel_speed_select_if/Makefile
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_common.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_common.h
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
 create mode 100644 include/uapi/linux/isst_if.h
 create mode 100644 tools/power/x86/intel_speed_select/Makefile
 create mode 100644 tools/power/x86/intel_speed_select/isst.h
 create mode 100644 tools/power/x86/intel_speed_select/isst_config.c
 create mode 100644 tools/power/x86/intel_speed_select/isst_core.c
 create mode 100644 tools/power/x86/intel_speed_select/isst_display.c

-- 
2.17.2

