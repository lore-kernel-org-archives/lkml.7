Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE562C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ECC218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfCVGMN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:12:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:45966 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbfCVGMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:12:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 23:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,255,1549958400"; 
   d="scan'208";a="144207660"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2019 23:12:12 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Mar 2019 23:12:12 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.192]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.249]) with mapi id 14.03.0415.000;
 Thu, 21 Mar 2019 23:12:11 -0700
From:   "Yang, Fei" <fei.yang@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        "plr.vincent@gmail.com" <plr.vincent@gmail.com>,
        "Shen, JingX" <jingx.shen@intel.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] usb: gadget: f_fs: don't free buffer prematurely
Thread-Topic: [PATCH v3] usb: gadget: f_fs: don't free buffer prematurely
Thread-Index: AQHU4C1+gBTRGRZXck6FOc9ySCJUE6YXl0MA//+UF+A=
Date:   Fri, 22 Mar 2019 06:12:11 +0000
Message-ID: <02E7334B1630744CBDC55DA8586225837F7FC660@ORSMSX102.amr.corp.intel.com>
References: <1553203874-130203-1-git-send-email-fei.yang@intel.com>
 <20190322053602.GA31708@kroah.com>
In-Reply-To: <20190322053602.GA31708@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTEwZGE3MDctNWM1ZC00OTJhLTg5MWQtZTdhZWZmM2Y5MjhjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicGlic210U1A5Qnl6b3hEYlNFMHdabXJrdFhITVErejZDTyt5dUxINjFcL3FEd1dWOHhVVWFqMGk0VVhvWXJ2disifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The following kernel panic happens due to the io_data buffer gets 
>> deallocated before the async io is completed. Add a check for the case 
>> where io_data buffer should be deallocated by ffs_user_copy_worker.
>> 
>> [   41.663334] BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
>> 
>> Fixes: 772a7a724f6 ("usb: gadget: f_fs: Allow scatter-gather buffers")
>> Signed-off-by: Fei Yang <fei.yang@intel.com>
>> Reviewed-by: Manu Gautam <mgautam@codeaurora.org>
>> Tested-by: John Stultz <john.stultz@linaro.org>
>> ---
>> v2: add tag: "Fixes: 772a7a724f6 ......", Reviewed-by and Tested-by.
>> v3: check data for NULL instead of "ret == -EIOCBQUEUED", which would be safer
>>     and keep the original logic intact.
> 
> If it "fixes" a problem in 5.0, we should add a:
> 	Cc: stable <stable@vger.kernel.org>
> to it as well.
Sent [PATCH v4] with Cc: stable

> thanks,
> 
> greg k-h
