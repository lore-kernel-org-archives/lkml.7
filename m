Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F30C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDE0205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLMXZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:25:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:18076 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfLMXZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:25:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 15:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="239441460"
Received: from dmjacob-mobl2.amr.corp.intel.com (HELO [10.252.129.36]) ([10.252.129.36])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2019 15:25:24 -0800
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial definitions
 for sdw_master_device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
Date:   Fri, 13 Dec 2019 17:25:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213161046.GA2653074@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> No, I mean the new MODULE_NAMESPACE() support that is in the kernel.
> I'll move the greybus code to use it too, but when you are adding new
> apis, it just makes sense to use it then as well.

Greg, would the patch below be what you had in mind?
Thanks
-Pierre


diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 76a5c52b12b4..5bad8422887e 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -7,9 +7,11 @@ ccflags-y += -DDEBUG
  #Bus Objs
  soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o 
stream.o
  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
+ccflags-$(CONFIG_SOUNDWIRE) += -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE

  soundwire-generic-allocation-objs := generic_bandwidth_allocation.o
  obj-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) += 
soundwire-generic-allocation.o
+ccflags-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) += 
-DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE

  ifdef CONFIG_DEBUG_FS
  soundwire-bus-objs += debugfs.o
@@ -18,6 +20,7 @@ endif
  #Cadence Objs
  soundwire-cadence-objs := cadence_master.o
  obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
+ccflags-$(CONFIG_SOUNDWIRE_CADENCE) += 
-DDEFAULT_SYMBOL_NAMESPACE=SDW_CADENCE

  #Intel driver
  soundwire-intel-objs :=        intel.o
@@ -25,3 +28,4 @@ obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o

  soundwire-intel-init-objs := intel_init.o
  obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel-init.o
+ccflags-$(CONFIG_SOUNDWIRE_INTEL) += -DDEFAULT_SYMBOL_NAMESPACE=SDW_INTEL
diff --git a/drivers/soundwire/cadence_master.c 
b/drivers/soundwire/cadence_master.c
index cf96532b0a8e..89ed97e303b9 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1517,3 +1517,4 @@ EXPORT_SYMBOL(sdw_cdns_alloc_pdi);

  MODULE_LICENSE("Dual BSD/GPL");
  MODULE_DESCRIPTION("Cadence Soundwire Library");
+MODULE_IMPORT_NS(SDW_CORE);
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0b510e198928..2be9c365d342 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1823,3 +1823,5 @@ EXPORT_SYMBOL(intel_sdw_driver);
  MODULE_LICENSE("Dual BSD/GPL");
  MODULE_ALIAS("platform:int-sdw");
  MODULE_DESCRIPTION("Intel Soundwire Master Driver");
+MODULE_IMPORT_NS(SDW_CADENCE);
+MODULE_IMPORT_NS(SDW_CORE);
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 834a09bafdcc..0685be32012d 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -432,3 +432,5 @@ EXPORT_SYMBOL(sdw_intel_exit);

  MODULE_LICENSE("Dual BSD/GPL");
  MODULE_DESCRIPTION("Intel Soundwire Init Library");
+MODULE_IMPORT_NS(SDW_CADENCE);
+MODULE_IMPORT_NS(SDW_CORE);

