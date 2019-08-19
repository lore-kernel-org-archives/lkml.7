Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE4C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D823920651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfHSCqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:46:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:28880 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfHSCqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:46:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 19:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="261698076"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2019 19:46:31 -0700
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, devel@driverdev.osuosl.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic> <20190816070343.GA1368@kroah.com>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <30d31b78-7da6-5344-6f64-b7273b40f611@intel.com>
Date:   Mon, 19 Aug 2019 10:39:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190816070343.GA1368@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月16日 15:03, Greg KH wrote:
> On Fri, Aug 16, 2019 at 08:39:25AM +0200, Borislav Petkov wrote:
>> On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
>>> The first three patches are the changes under x86/acrn, which adds the
>>> required APIs for the driver and reports the X2APIC caps.
>>> The remaining patches add the ACRN driver module, which accepts the ioctl
>>> from user-space and then communicate with the low-level ACRN hypervisor
>>> by using hypercall.
>>
>> I have a problem with that: you're adding interfaces to arch/x86/ and
>> its users go into staging. Why? Why not directly put the driver where
>> it belongs, clean it up properly and submit it like everything else is
>> submitted?
>>
>> I don't want to have stuff in arch/x86/ which is used solely by code in
>> staging and the latter is lingering there indefinitely because no one is
>> cleaning it up...
> 
> I agree, stuff in drivers/staging/ must be self-contained, with no
> changes outside of the code's subdirectory needed in order for it to
> work.  That way it is trivial for us to delete it when it never gets
> cleaned up :)

Thanks for pointing out the rule of drivers/staging.
The acrn staging driver is one self-contained driver. But it has some 
dependency on arch/x86/acrn and need to call the APIs in arch/x86/acrn.

If there is no driver,  the API without user had better not be added.
If API is not added,  the driver can't be compiled correctly.
The ACRN driver is one new driver. Maybe it will have some bugs and not 
be mature. So we want to add the driver as the staging.

What is the better approach to handle such scenario?

> 
> You never say _why_ this should go into drivers/staging/, nor do you
> have a TODO file like all other staging code that explains exactly what
> needs to be done to get it out of there.

Ok. The TODO file will be added in next version.


> 
> thanks,
> 
> greg k-h
> 
