Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83645C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A48B20828
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCTFil convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:38:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:2079 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfCTFil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:38:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 22:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,247,1549958400"; 
   d="scan'208";a="153323950"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2019 22:38:40 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Mar 2019 22:38:39 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.192]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.233]) with mapi id 14.03.0415.000;
 Tue, 19 Mar 2019 22:38:38 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     "mgautam@codeaurora.org" <mgautam@codeaurora.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangjerry@google.com" <zhangjerry@google.com>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        "plr.vincent@gmail.com" <plr.vincent@gmail.com>,
        "Shen, JingX" <jingx.shen@intel.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb-owner@vger.kernel.org" <linux-usb-owner@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: f_fs: don't free buffer prematurely
Thread-Topic: [PATCH] usb: gadget: f_fs: don't free buffer prematurely
Thread-Index: AQHU3qsSI6LKjKQGEU+fpZKqH+DdLqYUUrWA//+twSA=
Date:   Wed, 20 Mar 2019 05:38:38 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F7FB244@ORSMSX102.amr.corp.intel.com>
References: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
 <f382765c6d30972ab84224a1b3982f62@codeaurora.org>
In-Reply-To: <f382765c6d30972ab84224a1b3982f62@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmRhYWU2ODYtZDhjZS00YmVmLTlhNzAtMjM2OGU2ZjEwNzczIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTHpDZkF0a2NydmNNSEZWcEZcL2N1Ym9nN2YzbjhiMkZkdTVXMlwvVUxMamhaK1J6WU5IMXI4VjVwQ0NJR1ZQcWlSIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: Fei Yang <fei.yang@intel.com>
>> 
>> The following kernel panic happens due to the io_data buffer gets 
>> deallocated before the async io is completed. Add a check for the case 
>> where io_data buffer should be deallocated by ffs_user_copy_worker.
> 
> [snip]
>
> Please add tag - 'Fixes: 772a7a724f6 ("usb: gadget: f_fs: Allow scatter-gather buffers")
Sent [PATCH V2]

>> ---
>>  drivers/usb/gadget/function/f_fs.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/gadget/function/f_fs.c
>> b/drivers/usb/gadget/function/f_fs.c
>> index 20413c2..47be961 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -1133,7 +1133,8 @@ static ssize_t ffs_epfile_io(struct file *file,
>> struct ffs_io_data *io_data)
>>  error_mutex:
>>  	mutex_unlock(&epfile->mutex);
>>  error:
>> -	ffs_free_buffer(io_data);
>> +	if (ret != -EIOCBQUEUED) /* don't free if there is iocb queued */
>> +		ffs_free_buffer(io_data);
>>  	return ret;
>>  }
