Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD25C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B7D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfD3MUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:20:11 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:58379 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3MUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:20:11 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3EF1744028D;
        Tue, 30 Apr 2019 15:20:09 +0300 (IDT)
References: <20190430093212.28425-1-alexandre.belloni@bootlin.com> <20190430093212.28425-2-alexandre.belloni@bootlin.com> <877ebbu3lz.fsf@tarshish> <20190430114702.GD11339@piout.net>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] rtc: digicolor: set range
In-reply-to: <20190430114702.GD11339@piout.net>
Date:   Tue, 30 Apr 2019 15:20:08 +0300
Message-ID: <875zqvu1l3.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Apr 30 2019, Alexandre Belloni wrote:
> On 30/04/2019 14:36:24+0300, Baruch Siach wrote:
>> Hi Alexandre,
>>
>> On Tue, Apr 30 2019, Alexandre Belloni wrote:
>>
>> > While the range of REFERENCE + TIME is actually 33 bits, the counter
>> > itself (TIME) is a 32-bits seconds counter.
>> >
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> > ---
>> >  drivers/rtc/rtc-digicolor.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
>> > index 5bb14c56bc9a..e6e16aaac254 100644
>> > --- a/drivers/rtc/rtc-digicolor.c
>> > +++ b/drivers/rtc/rtc-digicolor.c
>> > @@ -206,6 +206,7 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
>> >  	platform_set_drvdata(pdev, rtc);
>> >
>> >  	rtc->rtc_dev->ops = &dc_rtc_ops;
>> > +	rtc->rtc_dev->range_max = U32_MAX;
>>
>> Where can I find documentation on the meaning and usage of the range_max
>> value? I could not find anything in the kernel source.
>
> It should be set to the maximum UNIX timestamp the RTC can be set to
> while keeping range_min to range_max contiguous.
>
> In the digicolor case, you could go up to 8589934590 (Wed Mar 16
> 12:56:30 UTC 2242) but the driver only writes DC_RTC_REFERENCE and I'm
> not sure it can also update DC_RTC_TIME safely.

DC_RTC_TIME resets to zero whenever dc_rtc_write writes CMD_RESET to the
DC_RTC_CONTROL register. DC_RTC_REFERENCE keeps the value that
dc_rtc_write stores there. So the driver will return values larger than
U32_MAX if you happen to cross this point in time between dc_rtc_write
and dc_rtc_read. But you can't store a value larger than U32_MAX in
DC_RTC_REFERENCE.

Will the core RTC code handle the U32_MAX cross correctly?

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
