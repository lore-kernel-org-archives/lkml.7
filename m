Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1A0205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfEGRfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:35:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:61243 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEGRfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:35:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 10:35:29 -0700
Received: from unknown (HELO [10.232.112.171]) ([10.232.112.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 07 May 2019 10:35:28 -0700
Subject: Re: [PATCH v2 3/7] devcoredump: allow to create several coredump
 files in one device
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <aced1953-4ea2-c8b1-9ee9-068e92ae1f8a@intel.com>
Date:   Tue, 7 May 2019 11:35:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> @@ -292,6 +309,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   	if (device_add(&devcd->devcd_dev))
>   		goto put_device;
>   
> +	for (i = 0; i < devcd->num_files; i++) {
> +		if (device_create_bin_file(&devcd->devcd_dev,
> +					   &devcd->files[i].bin_attr))
> +			/* nothing - some files will be missing */;

Is the conditional necessary if you aren't going to do anything?

> +	}
> +
>   	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
>   			      "failing_device"))
>   		/* nothing - symlink will be missing */;
