Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B6C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C4820665
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZldXZqV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfFSLyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:54:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51152 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSLyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:54:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5JBrda1035621;
        Wed, 19 Jun 2019 06:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560945219;
        bh=3j+Hx7J6UIRaUMzrnC2olgBVhCErI1MY48NNqOIHyYY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZldXZqV2ajRvFOh5Xc3RmrMxeWp/jwvnvO7cE7c0S6Uz1xeynDttTxYllxLQqhrde
         RGnZPc76Ro6Yiaszg3BmIcsL3KSmslq64OUxJRS3GMGToJS067QdWws+xD2t3QlNgM
         5qqbQ/5czms25mb4+YvCQCuoQUxNgm09nmXE4Suc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5JBrdLw015952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jun 2019 06:53:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 19
 Jun 2019 06:53:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 19 Jun 2019 06:53:38 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5JBrZSd026049;
        Wed, 19 Jun 2019 06:53:36 -0500
Subject: Re: [RFC v3 0/2] clocksource: davinci-timer: new driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190605083334.22383-1-brgl@bgdev.pl>
 <1ac8cfcf-1d77-9b6b-4aab-4171f6cf80fc@ti.com>
 <67e4688a-09d5-61a3-7406-a91f55045004@linaro.org>
 <5250ca8e-81bf-6b93-1f00-8121605e9baf@linaro.org>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <92ed1030-db75-9da6-b990-0ff92c169fbe@ti.com>
Date:   Wed, 19 Jun 2019 17:23:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5250ca8e-81bf-6b93-1f00-8121605e9baf@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/19 11:33 PM, Daniel Lezcano wrote:
> On 14/06/2019 16:25, Daniel Lezcano wrote:
>> On 14/06/2019 12:39, Sekhar Nori wrote:
>>> Hi Daniel,
>>>
>>> On 05/06/19 2:03 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> This is another version of the new davinci clocksource driver. After much
>>>> discussion this contains many changes to simplify and improve the driver.
>>>
>>> Does this look good to you now? If yes, can you please merge and provide
>>> an immutable branch to me so I can merge dependent mach-davinci patches?
>>
>> Yes, I think it is fine.
>>
>> http://git@git.linaro.org/people/daniel.lezcano/linux.git
>> timers/drivers/davinci
>>
>> It is v5.2-rc4 + (2 x patches)
>>
>> It is merged in clockevents/next which is exported to linux-next and for
>> kernel-ci.
>>
>> AFAIU, the patch was compiled and tested. If not, please let me know.
>>
>> Please, wait a couple of days I confirm the tests passed and you can
>> consider the branch immutable.
> 
> lkp complained, please do not use the branch.
> 
> I'm waiting for Bartosz to fix the issue.

Alright, noted.

Thanks,
Sekhar
