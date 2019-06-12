Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA660C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867D92082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KJDjegjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbfFLKcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:32:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39208 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732254AbfFLKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:32:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190612103200euoutp018bcf3edb3c4f22c2d5d25f2d231c7d42~nbOOdXXIp0461404614euoutp01D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 10:32:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190612103200euoutp018bcf3edb3c4f22c2d5d25f2d231c7d42~nbOOdXXIp0461404614euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560335520;
        bh=RLAhzE8tpglT3XB2opIBLsyeo2pBXlzFYqMGzpKSjVc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KJDjegjKqjd/mEPB4bNP/Wx8sLQwvfzitwSbCGtgIzGMQleCgchTMBYwtQ26Rc2Es
         eEWBmzFQJlwuAk2wL2r3Rp1ZPq6nwxXtW4U11kGOvl0afYDaYgH2Fs6CFhmkxMQHxH
         SZfMi/ucXQI/MQVSGl5X7uqNo4b8Wph4YZBArWOQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190612103200eucas1p2008570be22801b55ab975f75ebc31218~nbONzu0Qs2779727797eucas1p2k;
        Wed, 12 Jun 2019 10:32:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.37.04377.F94D00D5; Wed, 12
        Jun 2019 11:31:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612103159eucas1p1a21761d840f8b37b4d7270f00148676c~nbONBi3Vx0761607616eucas1p1m;
        Wed, 12 Jun 2019 10:31:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190612103158eusmtrp12f47c31db12d6959a5aa4d554b6d4a8d~nbOMytBhi2572925729eusmtrp10;
        Wed, 12 Jun 2019 10:31:58 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-23-5d00d49f7f8c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.50.04140.E94D00D5; Wed, 12
        Jun 2019 11:31:58 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190612103158eusmtip1981e6b82da2355c493dd3e91d549d9a7~nbOMWrGB90171401714eusmtip1s;
        Wed, 12 Jun 2019 10:31:58 +0000 (GMT)
Subject: Re: [PATCH v5 00/15] tc358767 driver improvements
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <2017e112-2b58-8ba4-1176-9e9e6b212478@samsung.com>
Date:   Wed, 12 Jun 2019 12:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612083252.15321-1-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87rzrzDEGhzapGPR3GFr0XSogdXi
        x5XDLBYH9xxnsrjy9T2bxYO5N5ksOicuYbe4vGsOm8XdeydYLNbPv8XmwOXxYOp/Jo+ds+6y
        e8zumMnqcb/7OJNH/18Dj+M3tjN5fN4k53Fu6lmmAI4oLpuU1JzMstQifbsErowjW0+xFewV
        rzhwo52xgfGpUBcjJ4eEgInErQc3mbsYuTiEBFYwSlzYdYAJwvnCKHHnxwY2COczo8SNWWdY
        YVreTdjFCpFYzihxbcl2qP63jBKzj69kBKkSFrCS2NbZDtYhIhAg8alpJ9goZoHTTBLtu24z
        gyTYBDQl/m6+yQZi8wrYSTz7+g6sgUVAVeLF5vtgtqhAhMSXnZsYIWoEJU7OfMICYnMC1R9r
        XwAWZxaQl9j+dg4zhC0ucevJfLAnJARusUvsWA5yNweQ4yLR/zAD4gVhiVfHt7BD2DISpyf3
        sEDY9RL3V7QwQ/R2MEps3bCTGSJhLXH4+EWwOcxAR6/fpQ8RdpT4vug/E8R4PokbbwUhTuCT
        mLRtOjNEmFeiow0a1ooS989uhRooLrH0wle2CYxKs5A8NgvJM7OQPDMLYe8CRpZVjOKppcW5
        6anFRnmp5XrFibnFpXnpesn5uZsYgcnr9L/jX3Yw7vqTdIhRgINRiYf3wPT/MUKsiWXFlbmH
        GCU4mJVEeI2yGWKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJx
        cEo1MCaen5spH35ihkRmKMOxe2wCC9cZrJq9neOq0AMRTqefu3enbs0sW+R3ct2Bjx2vlzxL
        iq7P0Hz46XWIy80TZ3bY/L8kUukhddQi211RXjR4VshO9uj/c5epOhjvU7S+cyTivcrm524P
        3v7emft21tFvKW6Oh/hefuQ7pKZnanimJHztwoOi3PFKLMUZiYZazEXFiQCAse1bWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7rzrjDEGhy6Z2HR3GFr0XSogdXi
        x5XDLBYH9xxnsrjy9T2bxYO5N5ksOicuYbe4vGsOm8XdeydYLNbPv8XmwOXxYOp/Jo+ds+6y
        e8zumMnqcb/7OJNH/18Dj+M3tjN5fN4k53Fu6lmmAI4oPZui/NKSVIWM/OISW6VoQwsjPUNL
        Cz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwjW0+xFewVrzhwo52xgfGpUBcjJ4eEgInE
        uwm7WLsYuTiEBJYySqxaPosVIiEusXv+W2YIW1jiz7UuNoii14wSs1ctZAJJCAtYSWzrbAdr
        EBHwk+iad4AJpIhZ4CyTxO/dO6E6JjJKXO9cCVbFJqAp8XfzTTYQm1fATuLZ13dgcRYBVYkX
        m++D2aICERKzdzWwQNQISpyc+QTM5gSqP9a+gBHEZhZQl/gz7xIzhC0vsf3tHChbXOLWk/lM
        ExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNhtx35u2cHY
        9S74EKMAB6MSD++B6f9jhFgTy4orcw8xSnAwK4nwGmUzxArxpiRWVqUW5ccXleakFh9iNAV6
        biKzlGhyPjCZ5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYFxk
        0BSi+Uf/RNN6hVdXxfY9sTri3e947rAbs5DIst55nAe6Oq8qS0isbp1XOoXtI/v8236CGi1W
        TQt8e//fv6KiFBKz5eKazkVzudXCd4jVvxd/7Nw9I0PvSsMBw+cZN8yXP1y1L8j62MKdfWXF
        +f/4Gxw4TRi+7N71vEdp+hWH+QFMu8x371JiKc5INNRiLipOBAA2GGIG7gIAAA==
X-CMS-MailID: 20190612103159eucas1p1a21761d840f8b37b4d7270f00148676c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190612083307epcas1p457198b83aff94f588163cbef724ca0da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190612083307epcas1p457198b83aff94f588163cbef724ca0da
References: <CGME20190612083307epcas1p457198b83aff94f588163cbef724ca0da@epcas1p4.samsung.com>
        <20190612083252.15321-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2019 10:32, Andrey Smirnov wrote:
> Everyone:
>
> This series contains various improvements (at least in my mind) and
> fixes that I made to tc358767 while working with the code of the
> driver. Hopefuly each patch is self explanatory.
>
> Feedback is welcome!
>
> Thanks,
> Andrey Smirnov


Tomi, you can queue it to drm-misc-next.


Regards

Andrzej


>
> Changes since [v4]:
>
>     - tc_pllupdate_pllen() renamed to tc_pllupdate()
>
>     - Collected Reviewed-bys from Andrzej for the rest of the series
>
> Changes since [v3]:
>
>     - Collected Reviewed-bys from Andrzej
>     
>     - Dropped explicit check for -ETIMEDOUT in "drm/bridge: tc358767:
>       Simplify polling in tc_main_link_setup()" for consistency
>
>     - AUX transfer code converted to user regmap_raw_read(),
>       regmap_raw_write()
>
> Changes since [v2]:
>
>     - Patchset rebased on top of v4 of Tomi's series that recently
>       went in (https://patchwork.freedesktop.org/series/58176/#rev5)
>       
>     - AUX transfer code converted to user regmap_bulk_read(),
>       regmap_bulk_write()
>
> Changes since [v1]:
>
>     - Patchset rebased on top of
>       https://patchwork.freedesktop.org/series/58176/
>       
>     - Patches to remove both tc_write() and tc_read() helpers added
>
>     - Patches to rework AUX transfer code added
>
>     - Both "drm/bridge: tc358767: Simplify polling in
>       tc_main_link_setup()" and "drm/bridge: tc358767: Simplify
>       polling in tc_link_training()" changed to use tc_poll_timeout()
>       instead of regmap_read_poll_timeout()
>
> [v4] lkml.kernel.org/r/20190607044550.13361-1-andrew.smirnov@gmail.com
> [v3] lkml.kernel.org/r/20190605070507.11417-1-andrew.smirnov@gmail.com
> [v2] lkml.kernel.org/r/20190322032901.12045-1-andrew.smirnov@gmail.com
> [v1] lkml.kernel.org/r/20190226193609.9862-1-andrew.smirnov@gmail.com
>
> Andrey Smirnov (15):
>   drm/bridge: tc358767: Simplify tc_poll_timeout()
>   drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
>   drm/bridge: tc358767: Simplify polling in tc_link_training()
>   drm/bridge: tc358767: Simplify tc_set_video_mode()
>   drm/bridge: tc358767: Drop custom tc_write()/tc_read() accessors
>   drm/bridge: tc358767: Simplify AUX data read
>   drm/bridge: tc358767: Simplify AUX data write
>   drm/bridge: tc358767: Increase AUX transfer length limit
>   drm/bridge: tc358767: Use reported AUX transfer size
>   drm/bridge: tc358767: Add support for address-only I2C transfers
>   drm/bridge: tc358767: Introduce tc_set_syspllparam()
>   drm/bridge: tc358767: Introduce tc_pllupdate()
>   drm/bridge: tc358767: Simplify tc_aux_wait_busy()
>   drm/bridge: tc358767: Drop unnecessary 8 byte buffer
>   drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
>
>  drivers/gpu/drm/bridge/tc358767.c | 648 +++++++++++++++++-------------
>  1 file changed, 372 insertions(+), 276 deletions(-)
>

