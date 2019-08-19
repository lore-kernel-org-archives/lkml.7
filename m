Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA77C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFF921773
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfHSBv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:51:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:17416 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfHSBvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:51:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 18:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="202096627"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2019 18:51:24 -0700
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
Date:   Mon, 19 Aug 2019 09:44:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190816063925.GB18980@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月16日 14:39, Borislav Petkov wrote:
> On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
>> The first three patches are the changes under x86/acrn, which adds the
>> required APIs for the driver and reports the X2APIC caps.
>> The remaining patches add the ACRN driver module, which accepts the ioctl
>> from user-space and then communicate with the low-level ACRN hypervisor
>> by using hypercall.
> 
> I have a problem with that: you're adding interfaces to arch/x86/ and
> its users go into staging. Why? Why not directly put the driver where
> it belongs, clean it up properly and submit it like everything else is
> submitted?

Thanks for your reply and the concern.

After taking a look at several driver examples(gma500, android), it 
seems that they are firstly added into drivers/staging/XXX and then 
moved to drivers/XXX after the driver becomes mature.
So we refer to this method to upstream ACRN driver part.

If the new driver can also be added by skipping the staging approach,
we will refine it and then submit it in normal process.
> 
> I don't want to have stuff in arch/x86/ which is used solely by code in
> staging and the latter is lingering there indefinitely because no one is
> cleaning it up...
> 

The ACRN driver will be the only user of the added APIs in x86/acrn. 
Without the APIs in x86/acrn, the driver can't add the driver-specifc 
upcall notification ISR or call the hypercall.

Not sure whether it can be sent in two patch sets?
The first is to add the required APIs for ACRN driver.
The second is to add the ACRN driver

Thanks
    Yakui
