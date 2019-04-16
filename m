Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589AEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4AA20652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfDPJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:34:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:12912 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfDPJe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 02:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="165154947"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 16 Apr 2019 02:34:55 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 16 Apr 2019 12:34:54 +0300
Date:   Tue, 16 Apr 2019 12:34:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Gaurav Kohli <gkohli@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org, maxime.ripard@bootlin.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: add NVMEM_SYSFS Kconfig
Message-ID: <20190416093454.GN2654@lahna.fi.intel.com>
References: <20190415164011.2638-1-srinivas.kandagatla@linaro.org>
 <3a66797d-347d-2414-14e1-edbcd7c39ae8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a66797d-347d-2414-14e1-edbcd7c39ae8@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:49:22AM +0530, Gaurav Kohli wrote:
> Hi Srinivas,
> 
> Thanks for the patch,
> By default NVMEM_SYSFS should be set true, those whose don't want they can
> disable the same.
> 
> If we go with disable option, there are chances of eeprom may break in below
> case:
> 
> if (config->compat) {
>                 rval = nvmem_sysfs_setup_compat(nvmem, config); -> this will
> return error as config is disabled.
>                 if (rval)
>                         goto err_device_del;
>         }

I also think this may cause problems with Thunderbolt devices because
the upgradeable NVM is exposed to the userspace via these sysfs files
and those are being used by fwupd. If the files disappear it makes NVM
upgrade somewhat harder ;-)

At least it would be good to include following as part of this series if
you plan to disable the sysfs entries by default:

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index f4869c38c7e4..dd5facab0af2 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -7,6 +7,7 @@ menuconfig THUNDERBOLT
 	select CRYPTO
 	select CRYPTO_HASH
 	select NVMEM
+	select NVMEM_SYSFS
 	help
 	  Thunderbolt Controller driver. This driver is required if you
 	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
