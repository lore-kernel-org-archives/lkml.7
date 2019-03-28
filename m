Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4C620700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jSL2WTLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfC1Lsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:48:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44271 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1Lsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:48:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190328114844euoutp02e7f54045bb4ea4b07c7eca25c3e969c1~QHPhlAgx03046030460euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:48:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190328114844euoutp02e7f54045bb4ea4b07c7eca25c3e969c1~QHPhlAgx03046030460euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553773724;
        bh=tp3m+q1epNtYfS/t5nFXhIWhJzSj5o8anq2dCYU5gYQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jSL2WTLtTvn5RoD5BfzM2NomeudeWapuIxJqiXWA17mVzEcIHUVztQPl5I1LNF3S0
         2YTqfZg0G33KuPPu+0wrYsQYvHY5vIVXIQEZMqjYVaxqq7i7eD4Dwpb1swK/CdZRmM
         Ln2eksHW8+K58xJ/klfl6n8i8qX3QmLBPkyQgecs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190328114843eucas1p1b5cc766859f6650ba2ee86b466baff8a~QHPg3DZ3L1961319613eucas1p1p;
        Thu, 28 Mar 2019 11:48:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.8C.04325.B94BC9C5; Thu, 28
        Mar 2019 11:48:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190328114843eucas1p20c9d870a68006ae9fc0f0699b867f896~QHPgLjH-z1606316063eucas1p2H;
        Thu, 28 Mar 2019 11:48:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190328114842eusmtrp168cb47d2f7020deefd091fbcb3b1d192~QHPf9c0EI1968119681eusmtrp1c;
        Thu, 28 Mar 2019 11:48:42 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-c8-5c9cb49bbdd5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.3A.04140.A94BC9C5; Thu, 28
        Mar 2019 11:48:42 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190328114842eusmtip2ef2abb7c43b589931d2b6dbbabc5c10c~QHPfX4ppd3139731397eusmtip2F;
        Thu, 28 Mar 2019 11:48:42 +0000 (GMT)
Subject: Re: Re: [PATCH v3 1/4] drm/bridge: sil_sii8620: depend on INPUT
 instead of selecting it.
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <35bf8a61-b84c-3aae-00de-14637d37547b@samsung.com>
Date:   Thu, 28 Mar 2019 12:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328000743.GB24753@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89tR9nkOI09rDCdFGSklYUHu6BRcaA+WJ+6GHXSg0o6ZUcr
        LcxKcrObWl6atsos5zAM22ZqGqh4yS5afshRTcjUhGE1JwUVbZ4ufvs9z/N//u/zh5fGlS5S
        TadpswWdlk/XUP6Evff7y9XV1prENS214eyls5UY2107hdgRzwzFPvX8pNhzd5ootsxZQrCj
        X+dI9nVbDcVOTS5hb8yW4+zUexfGdurHMLZ/rgJj77s/yOICOLdlmuRaje9kXGGnQ8ZdMwDX
        bDFQnGlgN/fkRqOMc17ow7jLVgviOt5bCc7dHMJVFdnJBPl+/03JQnraMUEXteWwf2rpRAuW
        VRly4kK/RVaAeqAY+dHArIfHd59ixcifVjJmBN1Vn5BUzCLo+TZNSIUbQaHZhP1bGXb9UdUj
        aC6toKTCheB7kwH3qYKYJNDXOeY5mNnoFY2QPsaZNgKKxjb7mGJWws+Ho5SPFcwWmDAa5jUE
        sxxeFduRjxcze2HmYzshaQJh4Pr4PPsx0XD5eQEmeS6Dc7ZqXGIVOMZvzgcCppwG85fPXiPa
        W2yDFuMOKUEQTPdZZRIvhcGrFwmJT4PTXIhLu3oEtgetuDTYCN19w6TPB/ce3dQWJbXjwVTX
        QEj2AfDGFSidEABl9kpcaitAf14pqcPA+dz2x1AFd4c8VAnSGBcEMy4IY1wQxvj/3VuIsCCV
        kCNmpAhitFY4HinyGWKONiUyKTOjGXk/4eCvPs8j1PnjSBdiaKSRK0IzqxOVJH9MzM3oQkDj
        mmCFo6EmUalI5nPzBF3mIV1OuiB2oSU0oVEpTi4aO6BkUvhs4aggZAm6v1OM9lMXoIgDjSgm
        9kqe8GLctoyNTR60800HR+s6do2F7un9rDbVz9lMI+3x34SR7a7dRH7Eu69Wh5pueHGEca/T
        5r1pT4iZdLzcHBay6nYFyQ/lX4zTyE9t0KcuwmNWhBelqbDls/LYZ9FnlPtUQ1uzo2ruMzsD
        tTasylPruIe/jfQc0hBiKr82AteJ/G+S3XzGgAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Pd1ZW+bEGHz9YWjR2zSdyeLwoheM
        Fle+vmezOPX1L5tF8+L1bBaT7k9gsbj56RurxeVdc9gsXjyXtpj7ZSqzxYt7b5ks9nU8YLI4
        8W0ak8Xaz4/ZHfg8Pq96xeqxc9Zddo+WfbfYPaZ0SnhsWtXJ5jHvZKDH/rlr2D3udx9n8ujb
        sorRY++9LSwenzfJecxo38YawBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
        qqRvZ5OSmpNZllqkb5eglzHx2XamgulyFd0nVrE3MB6R6GLk5JAQMJHYc/EtYxcjF4eQwFJG
        iRt3e5ghEuISu+e/hbKFJf5c62KDKHrNKHH35CJWkISwQLJEx5JbYEUiAtYSmyZeYQUpYhbY
        xyLR92ApC0THTCaJ2T8ng1WxCWhK/N18kw3E5hWwk3g2qxNsEouAqsSlrm2MILaoQITE3Ysv
        WCBqBCVOznwCZnMKGEv0nW1gArGZBdQl/sy7xAxhy0s0b50NZYtL3Hoyn2kCo9AsJO2zkLTM
        QtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHxv+3Yzy07GLveBR9iFOBgVOLh
        VcifHSPEmlhWXJl7iFGCg1lJhPfWyjkxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTE15
        JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoY+1dKb5VrvlB0yk/3
        2ZsWmSc2Gik1ek+Wctlq3dl1pF2Z2T1ksa1B99LY279M91b+uP+qwifZQ23Wp7t+e+ctal6d
        WnTp38flG790V2/6eWXbf7a0znx/M/ffDVyHwo8dZijr9W2MUkmbyjjj4uPjt3vrWT99+u90
        4q+EJ4/Q5+7nOmHTlvhpKbEUZyQaajEXFScCAJxqpUMVAwAA
X-CMS-MailID: 20190328114843eucas1p20c9d870a68006ae9fc0f0699b867f896
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190327014824epcas2p1f79a41c58f76150f7324169805f506f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190327014824epcas2p1f79a41c58f76150f7324169805f506f0
References: <20190327014807.7472-1-ronald@innovation.ch>
        <CGME20190327014824epcas2p1f79a41c58f76150f7324169805f506f0@epcas2p1.samsung.com>
        <20190327014807.7472-2-ronald@innovation.ch>
        <9fd8af5b-20ed-5dca-7d5c-98f2926b9b0c@samsung.com>
        <20190328000743.GB24753@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.03.2019 01:07, Life is hard, and then you die wrote:
>   Hi Andrzej,
>
> On Wed, Mar 27, 2019 at 03:13:37PM +0100, Andrzej Hajda wrote:
>> +cc: dri-devel
>>
>> On 27.03.2019 02:48, Ronald Tschalär wrote:
>>> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
>>> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
>>> INPUT. However, this causes problems with other drivers, in particular
>>> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
>>> future commit):
>>>
>>>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>>>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>>>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>>>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>>>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>>>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>>>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>>>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>>>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>>>
>>> According to the docs, select should only be used for non-visible
>>> symbols. Furthermore almost all other references to INPUT throughout the
>>> kernel config are depends, not selects. Hence this change.
>>>
>>> CC: Inki Dae <inki.dae@samsung.com>
>>> CC: Andrzej Hajda <a.hajda@samsung.com>
>>> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
>> This is drm bridge driver, next time please cc it to dri-devel ML also.
> Ok. Though as noted in the cover letter, the patch here is meant as a
> placeholder till the real thing being discussed on dri-devel is
> finalized. I was trying to avoid cross-posting too much, hence the
> separate submission on dri-devel.
>
>> Anyway this is not the solution we have agreed to.
>>
>> Why have you abandoned the patch [1]? It needed just some minor
>> polishing, as I wrote in response to this mail.
>>
>> [1]:
>> https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#mf620df0b1583096a214d8e2e690387078583472f
> It seems your mail client doesn't like me :-) I got neither of your
> responses. Sorry, I should've checked the archives when I didn't hear
> anything. In any case thank you for your review, and I will update
> that patch and send out a new version shortly.


I see where is the problem: Your mail client (mutt I suppose) sets
Mail-Followup-To header to all recipients (To and Cc) without the
sender. And my client (thunderbird) after pressing "Reply-All" checks
for Mail-Followup-To field, if present it uses only it to set
recipients, so in your case it does not response to the original author.

I do not know which mail client works incorrectly in this case, but for
sure it is not what we want :)

I do not know how to solve the issue in thunderbird, maybe mutt is more
configurable?


Regards

Andrzej


>
>
>   Cheers,
>
>   Ronald
>
>
>>> ---
>>>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 2fee47b0d50b..eabedc83f25c 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
>>>  config DRM_SIL_SII8620
>>>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>>>  	depends on OF
>>> +	depends on INPUT
>>>  	select DRM_KMS_HELPER
>>>  	imply EXTCON
>>> -	select INPUT
>>>  	select RC_CORE
>>>  	help
>>>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>>
>

