Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890A2C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BF820663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Apq91SiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfFXHbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:31:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39720 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFXHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:31:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5O7U2mx055210;
        Mon, 24 Jun 2019 02:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561361402;
        bh=Nr11N80KudDTkBmA2h5dEMXRhA9/KJlHbyFJQ9rK1ac=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Apq91SiE6fuoCNrkBrsu2GdGAQZnDy9tWyWbwFr+Ps86ONgTmNm10mJdS1hueW/Ld
         KbeLqqlQLwhyZqcbKpYuPMm1suBxv4Qn+nUSafkbEj5nhrUb2RF4PN6wToyb5R/tP+
         B0pd71XKHKAUOO7JTn3qZY0MjSxcU0U6t7+IIWrI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5O7U1jL012828
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jun 2019 02:30:02 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 24
 Jun 2019 02:30:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 24 Jun 2019 02:30:01 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5O7TwPr072735;
        Mon, 24 Jun 2019 02:29:58 -0500
Subject: Re: [RFC v3 0/2] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190605083334.22383-1-brgl@bgdev.pl>
 <1ac8cfcf-1d77-9b6b-4aab-4171f6cf80fc@ti.com>
 <1a66e067-631c-c7a4-288b-3934737bee8c@linaro.org>
 <CAMRc=MecrpzwC0-8x=1dAipf+j7h+C54pHCfbZidFGXtAyv7Pg@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <234ab4c6-3b3d-6d6b-9bbc-6dc4ca9243b7@ti.com>
Date:   Mon, 24 Jun 2019 12:59:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MecrpzwC0-8x=1dAipf+j7h+C54pHCfbZidFGXtAyv7Pg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/19 12:51 PM, Bartosz Golaszewski wrote:
> pon., 24 cze 2019 o 07:40 Daniel Lezcano <daniel.lezcano@linaro.org> napisał(a):
>>
>>
>> Sekhar, Bartosz,
>>
>> if the sparse warning is not fixed, the driver won't hit this kernel
>> version. Please fix it before the two next days otherwise it won't make
>> it for v5.4.
>>
>> Thanks
>>
> 
> Hi Daniel,
> 
> will do, I just came back to the office.
> 
> Sekhar, how do we want to handle the rest of the platform code with
> this driver? Do you think it can make it for the next release?

It may have to wait till next release, I am afraid. Lets first try to
get the driver in though. I can try a late pull request with no guarantees.

Thanks,
Sekhar
