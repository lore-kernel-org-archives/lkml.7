Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39169C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3420851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfFNNcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:32:43 -0400
Received: from foss.arm.com ([217.140.110.172]:33830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfFNNcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625AF367;
        Fri, 14 Jun 2019 06:32:42 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 460C93F718;
        Fri, 14 Jun 2019 06:32:41 -0700 (PDT)
Subject: Re: [RFC PATCH 01/57] drivers: s390/cio: Use driver_for_each_device
To:     linux-kernel@vger.kernel.org, sebott@linux.ibm.com,
        oberpar@linux.ibm.com, heiko.carstens@de.ibm.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-2-git-send-email-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2e71f1c3-9654-92a0-64e5-e7a2a1081fbb@arm.com>
Date:   Fri, 14 Jun 2019 14:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559577023-558-2-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko, Sebastian, Peter,

Please could you review the following patch ?


On 03/06/2019 16:49, Suzuki K Poulose wrote:
> The cio driver use driver_find_device() to find all devices
> to release them before the driver is unregistered. Instead,
> it could easily use a lighter driver_for_each_device() helper
> to iterate over all the devices.
> 
> Cc: Sebastian Ott <sebott@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/s390/cio/ccwgroup.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
> index 4ebf6d4..a006945 100644
> --- a/drivers/s390/cio/ccwgroup.c
> +++ b/drivers/s390/cio/ccwgroup.c
> @@ -581,9 +581,12 @@ int ccwgroup_driver_register(struct ccwgroup_driver *cdriver)
>   }
>   EXPORT_SYMBOL(ccwgroup_driver_register);
>   
> -static int __ccwgroup_match_all(struct device *dev, void *data)
> +static int ccwgroup_release_device(struct device *dev, void *unused)
>   {
> -	return 1;
> +	struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
> +
> +	ccwgroup_ungroup(gdev);
> +	return 0;
>   }
>   
>   /**
> @@ -594,16 +597,11 @@ static int __ccwgroup_match_all(struct device *dev, void *data)
>    */
>   void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
>   {
> -	struct device *dev;
> +	int ret;
>   
>   	/* We don't want ccwgroup devices to live longer than their driver. */
> -	while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
> -					 __ccwgroup_match_all))) {
> -		struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
> -
> -		ccwgroup_ungroup(gdev);
> -		put_device(dev);
> -	}
> +	ret = driver_for_each_device(&cdriver->driver, NULL, NULL,
> +				     ccwgroup_release_device);
>   	driver_unregister(&cdriver->driver);
>   }
>   EXPORT_SYMBOL(ccwgroup_driver_unregister);
> 


Thanks
Suzuki
