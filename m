Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C33ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F5D20820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409470AbfJQRc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:32:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:48465 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfJQRcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:32:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 10:32:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="279956391"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2019 10:32:12 -0700
Received: from mchancoc-mobl.amr.corp.intel.com (unknown [10.251.8.4])
        by linux.intel.com (Postfix) with ESMTP id 194685802F0;
        Thu, 17 Oct 2019 10:32:12 -0700 (PDT)
Subject: Re: [alsa-devel] linux-next: Tree for Oct 17 (soundwire)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191017152645.65892c78@canb.auug.org.au>
 <e8994e88-bdab-b3be-d62f-550ce9f2c76d@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0f8fa7fb-dd1d-c26d-7756-a525aa46cf71@linux.intel.com>
Date:   Thu, 17 Oct 2019 12:31:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e8994e88-bdab-b3be-d62f-550ce9f2c76d@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 10:22 AM, Randy Dunlap wrote:
> On 10/16/19 9:26 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20191016:
>>
> 
> on x86_64:
> 
> # CONFIG_BLOCK is not set
> 
>    CC [M]  drivers/soundwire/intel_init.o
> In file included from ../drivers/soundwire/intel_init.c:12:0:
> ../include/linux/iomap.h: In function ‘iomap_sector’:
> ../include/linux/iomap.h:76:48: error: ‘SECTOR_SHIFT’ undeclared (first use in this function); did you mean ‘SECTIONS_SHIFT’?
>    return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>                                                  ^~~~~~~~~~~~
>                                                  SECTIONS_SHIFT

Yes, looks like by fixing cross-compilation issues I added new ones.
We can either add an explicit dependency on CONFIG_BLOCK or remove the 
use of ioread32() and use readl() instead. I didn't write the initial 
code and I have no idea what the intent behind using ioread32 was.
