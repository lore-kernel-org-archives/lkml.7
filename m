Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88599C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CE620674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKKJ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:29:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60560 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKKJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:29:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ECEF028EDBD
Subject: Re: [PATCH v4 05/17] platform: chrome: cros_ec: Do not attempt to
 register a non-positive IRQ number
To:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Enrico Granata <egranata@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-6-gwendal@chromium.org>
 <20191110121750.78f0824f@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <acc58053-bd09-e4f4-e598-aabe1d151f85@collabora.com>
Date:   Mon, 11 Nov 2019 10:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110121750.78f0824f@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/19 13:17, Jonathan Cameron wrote:
> On Tue,  5 Nov 2019 14:26:40 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
>> Add a layer of sanity checking to cros_ec_register against attempting to
>> register IRQ values that are not strictly greater than 0.
>>
>> Signed-off-by: Enrico Granata <egranata@chromium.org>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> 
> This strikes me as something that could be a potential fix to backport?
> Any known cases of a negative irq getting to here or is this a by
> inspection thing?
> 
> Otherwise seems obviously correct.
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Looks good to me:

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> Jonathan
> 
>> ---
>> No changes in v4, v3.
>> Changes in v2:
>>   Remove dual Enrico's signature.
>>
>>  drivers/platform/chrome/cros_ec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
>> index 925f84dbf621..d3dfa27171e6 100644
>> --- a/drivers/platform/chrome/cros_ec.c
>> +++ b/drivers/platform/chrome/cros_ec.c
>> @@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>  		return err;
>>  	}
>>  
>> -	if (ec_dev->irq) {
>> +	if (ec_dev->irq > 0) {
>>  		err = devm_request_threaded_irq(dev, ec_dev->irq,
>>  						ec_irq_handler,
>>  						ec_irq_thread,
> 
