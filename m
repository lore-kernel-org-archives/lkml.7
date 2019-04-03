Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D436C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB65206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCQc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:32:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:6970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCQcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:32:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 09:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="146303470"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2019 09:32:53 -0700
Subject: Re: [PATCHv1] fpga: mgr: add FPGA configuration log
To:     Moritz Fischer <mdf@kernel.org>
Cc:     atull@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
References: <1554243943-25507-1-git-send-email-richard.gong@linux.intel.com>
 <20190403142022.GB5752@archbook>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <ee94981a-6562-9d26-ddc2-967596589599@linux.intel.com>
Date:   Wed, 3 Apr 2019 11:43:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403142022.GB5752@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,


On 4/3/19 9:20 AM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Tue, Apr 02, 2019 at 05:25:43PM -0500, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add a log for user to know FPGA configuration is successful
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   drivers/fpga/fpga-mgr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index c386681..559e046 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -151,6 +151,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
>>   	}
>>   	mgr->state = FPGA_MGR_STATE_OPERATING;
>>   
>> +	dev_info(&mgr->dev, "Successfully programming FPGA\n");
> 
> That info is available in FPGA manager's sysfs status entry, if at all
> I'd make this a dev_dbg().
> 
>  From my end I don't see how we need this really.

We got requests from the field and they want to see a log to get know if 
FPGA configuration is successfully completed. They don't want use any 
additional command to get status.

This log is useful for the user who performs FPGA configuration.

I think we need use dev_info, since dev_dbg is not enabled by fault for 
most build.

> 
> Thanks,
> Moritz
> 
