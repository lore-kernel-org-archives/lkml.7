Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509BC20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEGWtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:49:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:6104 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfEGWtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:49:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 15:49:51 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 07 May 2019 15:49:51 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id 48EC2580105;
        Tue,  7 May 2019 15:49:50 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
To:     Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
 <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
 <20190507052732.GD16052@vkoul-mobl> <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl> <20190507111956.GB1092@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
Date:   Tue, 7 May 2019 17:49:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507111956.GB1092@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> The model here is that Master device is PCI or Platform device and then
>> creates a bus instance which has soundwire slave devices.
>>
>> So for any attribute on Master device (which has properties as well and
>> representation in sysfs), device specfic struct (PCI/platfrom doesn't
>> help). For slave that is not a problem as sdw_slave structure takes care
>> if that.
>>
>> So, the solution was to create the psedo sdw_master device for the
>> representation and have device-specific structure.
> 
> Ok, much like the "USB host controller" type device.  That's fine, make
> such a device, add it to your bus, and set the type correctly.  And keep
> a pointer to that structure in your device-specific structure if you
> really need to get to anything in it.

humm, you lost me on the last sentence. Did you mean using 
set_drv/platform_data during the init and retrieving the bus information 
with get_drv/platform_data as needed later? Or something else I badly 
need to learn?
