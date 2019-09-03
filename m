Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D32C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090D821881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfICBbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 21:31:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:40781 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfICBbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 21:31:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 18:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,461,1559545200"; 
   d="scan'208";a="381967332"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2019 18:31:04 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micha=c5=82_Wajdeczko?= <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
 hot re-plug
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
 <3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com>
 <ccb1434d-281c-abae-0726-7fd924041315@linux.intel.com>
 <1769080.0GM3UzqXcv@jkrzyszt-desk.ger.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <52fbfac9-c879-4b45-dd74-fafe62c2432b@linux.intel.com>
Date:   Tue, 3 Sep 2019 09:29:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1769080.0GM3UzqXcv@jkrzyszt-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 9/2/19 4:37 PM, Janusz Krzysztofik wrote:
>> I am not saying that keeping data is not acceptable. I just want to
>> check whether there are any other solutions.
> Then reverting 458b7c8e0dde and applying this patch still resolves the issue
> for me.  No errors appear when mappings are unmapped on device close after the
> device has been removed, and domain info preserved on device removal is
> successfully reused on device re-plug.

This patch doesn't look good to me although I agree that keeping data is
acceptable. It updates dev->archdata.iommu, but leaves the hardware
context/pasid table unchanged. This might cause problems somewhere.

> 
> Is there anything else I can do to help?

Can you please tell me how to reproduce the problem? Keeping the per
device domain info while device is unplugged is a bit dangerous because
info->dev might be a wild pointer. We need to work out a clean fix.

> 
> Thanks,
> Janusz
> 

Best regards,
Baolu
