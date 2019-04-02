Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4353208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDBCMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:12:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:36376 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDBCMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:12:36 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 02 Apr 2019 11:12:34 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 3E4CD6117D;
        Tue,  2 Apr 2019 11:12:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 2 Apr 2019 11:12:34 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id E4C341A04E0;
        Tue,  2 Apr 2019 11:12:33 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.234.213])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B50FC120499;
        Tue,  2 Apr 2019 11:12:33 +0900 (JST)
Subject: Re: [PATCH 0/2] Add Updown Counter support for Milbeaut M10V SoC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
References: <1553581954-13487-1-git-send-email-kanematsu.shinji@socionext.com>
 <20190330183603.55886d4f@archlinux>
From:   =?UTF-8?B?S2FuZW1hdHN1LCBTaGluamkv5YW85p2+IOS8uOasoQ==?= 
        <kanematsu.shinji@socionext.com>
Message-ID: <9522af01-1017-08d5-73c7-8b81b749c29a@socionext.com>
Date:   Tue, 2 Apr 2019 11:12:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190330183603.55886d4f@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 2019/03/31 3:36, Jonathan Cameron wrote:
> On Tue, 26 Mar 2019 15:32:34 +0900
> Shinji Kanematsu <kanematsu.shinji@socionext.com> wrote:
> 
>> This is a series of patch which adds Updown Counter support on
>> Milbeaut M10V SoC.
>>
>> The Updown Counter counts input pulse signal from external quadrature encoder.
>> It also has input pulse signal counter function.
> Hi Shinji,
> 
> Are you aware of the counter subsystem that has been proposed (and
> as far as I am concerned is ready to be merged)?
> 
> https://patchwork.kernel.org/project/linux-iio/list/?series=147
> (I think that's the latest version posted)..
> William, perhaps you could give an update?
> 
> (bad luck, you are getting popular ;)
> 
> I'll take a quick review as it stands, as some issues may carry over.
> I appreciate that it's always unfortunate to try to upstream stuff at the
> same time as a new framework is being developed / upstreamed, but I don't
> intend to take any additional counter drivers into IIO.  We just
> end up having to maintain old interfaces in more and more drivers.
> 

Thank you for your reply.
I just learned that upstream requires the counter subsystem.
Detailed information was given by William.

Thank you,
Kanematsu

> Thanks,
> 
> Jonathan
> 
>>
>> Shinji Kanematsu (2):
>>    dt-bindings: iio: counter: Add Milbeaut Updown Counter
>>    iio: counter: Add support for Milbeaut Updown Counter
>>
>>   .../bindings/iio/counter/milbeaut-updown_cnt.txt   |  22 ++
>>   drivers/iio/counter/Kconfig                        |  12 +
>>   drivers/iio/counter/Makefile                       |   1 +
>>   drivers/iio/counter/milbeaut-updown.h              |  38 ++
>>   drivers/iio/counter/milbeaut-updown_cnt.c          | 385 +++++++++++++++++++++
>>   5 files changed, 458 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
>>   create mode 100644 drivers/iio/counter/milbeaut-updown.h
>>   create mode 100644 drivers/iio/counter/milbeaut-updown_cnt.c
>>
> 

