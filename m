Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F003C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83B12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CWsYS3aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZKA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:00:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59323 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:00:28 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190626100026euoutp027bdd2148ff6453199e1d8f8fd42e18ed~rt0qFEMh01032210322euoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:00:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190626100026euoutp027bdd2148ff6453199e1d8f8fd42e18ed~rt0qFEMh01032210322euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561543226;
        bh=NXk7oMxfNi8v62zBDMwYKSvviDEB9B4rrPkjTqeXUZw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CWsYS3aAPDeWoNyU7ZOeIvyjY4NqPOu/K+zES5OHlZ6iP/xJxOU9HmUkjObwzUfVk
         FtzktVrHHE5nhtugcV/RbVG5R/6oyauuLXXNBXNaVv4paLVB7TfDfbwhey0FnX+7St
         OolL3Q36fGNv8y2eSoO3NriUQsUxcQf5HNzSiMhg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190626100025eucas1p1a1f3de16455e64a44e48c23f0841ed7a~rt0pYMulO2493024930eucas1p1J;
        Wed, 26 Jun 2019 10:00:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 03.42.04298.932431D5; Wed, 26
        Jun 2019 11:00:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190626100025eucas1p1b18062e095d4bc44017721646d475d23~rt0or6Bkz1345913459eucas1p1h;
        Wed, 26 Jun 2019 10:00:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190626100024eusmtrp2ff0747e5e34d7789be0f9a3e80301a27~rt0odrHTJ0845208452eusmtrp23;
        Wed, 26 Jun 2019 10:00:24 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-77-5d134239b2b7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.31.04140.832431D5; Wed, 26
        Jun 2019 11:00:24 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190626100023eusmtip1e80c72d0809655698352fc2900193d45~rt0ncfrhv0183901839eusmtip1a;
        Wed, 26 Jun 2019 10:00:23 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Handle audio for
 more clock rates
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Dylan Reid <dgreid@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Message-ID: <fe8bb0f7-5ef1-4750-8b1a-f05c0f3469e0@samsung.com>
Date:   Wed, 26 Jun 2019 12:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a94d9554-fc93-a2d0-9a30-9604db8c123e@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH+z6/7nGcHkfddxJzq7WayNbWU0ll/fH80aota0rSlWeIQ/eg
        0OYyTOykVObH6I+TH2OJHG41OubHOB1iYkZSw9w07ghD7h6W/16f7/vz/n4/78++JCqew53J
        8KhYVhEli5QSQkzTvtJ7/LSfY9CJlNcHaVVvF0KrNB8QuqRzhKD1774Q9DfzPEHPTbah9ODy
        DEp3zQ1i9LMXagE9oC0i6IWJTZSemGkGtC47kC5fqQf0WI0eXNjLzA+nCZjiqiSmUNmHMYUZ
        +TjTmdOPMA1LEzgzntWBMHXqZEb9ZpBgWlS5GLNY63rN9pbQJ4SNDI9nFV6+d4Vh3XmTRMzn
        Q49XDKNACYwumcCGhNRJ2DXzCskEQlJMlQO41DCL84UJQLO2keCLRQD/KMvQTEBaLbnLpMUt
        psoALFvdz/cYAcx/Pk1YBEcqCOo7TaiFCeooXK/7bj132uLfyhnUYkCpIQyWtJoRiyCifGG6
        udrKGHUYatP7rIZ9VAA0NdUCvscBduVPYRa2oc7DXM2AwMIo5QYbjEUozxI4MlWC8NnySZg2
        6sfzJZj1VY3z7AhnOz4KeHaBm007/clwvDzVOhykMgCsr2lCeeEsbO3owy3p0a0E77Ve/PFF
        2DNchfNLsYfDRgd+BHv4UpO3vSsRzEgX893ucFxfv32hBJYazEQOkBbsClawK0zBrjAF/999
        C7BKIGHjOHkoy3lHsY88OZmci4sK9bwfLa8FW3+we6NjoRGY++/pAEUCqZ1I6SYOEuOyeC5B
        rgOQRKVOolIZFSQWhcgSEllFdLAiLpLldOAAiUkloqQ9E4FiKlQWy0awbAyr2FER0sZZCYLP
        rUr7Kk4ZdKF1xRU1DWvxt5+uxLa0f/p5Vc6MtkaMJpZm3+mJzHT8MZiuK5J4Ltnh1UcmbYVs
        TmBziNZdI/BY+1UdeOWJyuNGS8r1inZJpavwTOtfqZPBTq9ipzt95P5go+Vh25hpqNoVqX+Q
        d5PzXTIY/VNLA0zrXmZwWYpxYTLvY6iCk/0DvB5A1X8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4XV0LJ+FYg63b5S16z51ksujdtpHJ
        Yv6JW2wWZ5cdZLO48vU9m8WbR0eYLa5+f8lscfLNVRaLzolL2C0u75rDZvHpwX9miwcv9zNa
        HOqLtljxcyujxd0NZxkd+D3e32hl95i3ptpjdsNFFo/ZHTNZPU5MuMTksf3bA1aP+93HmTw2
        L6n3WDLtKpvHgd7JLB6fN8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZ
        Kunb2aSk5mSWpRbp2yXoZZye/oitYK9Kxc8LtxkbGN/KdDFycEgImEhM/s7RxcjFISSwlFHi
        R9dB9i5GTqC4uMTu+W+ZIWxhiT/XuthAbCGB14wSa3+og9jCArESZ098AathE9CU+Lv5JliN
        CJD9rOElM8hQZoEbLBLrJi1lg9hwgEniyO8+FpAqXgE7ibava5lAbBYBVYldbRfBukUFIiRm
        72qAqhGUODnzCZjNKWAvMXnbZbDrmAXUJf7Mu8QMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFp
        mYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3/bsZ9bdjB2vQs+xCjAwajE
        w9sgLxQrxJpYVlyZe4hRgoNZSYR3aaJArBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA9NS
        Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRoX1rseXcF3MWiX5
        gvu4yz/HYH5NO+cpv2dbLglvD2h+/ctsQtOKdV/mnxZ7d6FXj1fE+F9Al8vNFatb7lZuWX1r
        0vxE1+emcx6UuJo4/Gmcd7ZseVm7QvXKn573Jc5Lt8g915UX2dTxwMtoIZfeHM41aZ//MH96
        qV6+53HH/2uOG0UmKr7uXafEUpyRaKjFXFScCABrNH79EwMAAA==
X-CMS-MailID: 20190626100025eucas1p1b18062e095d4bc44017721646d475d23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1
References: <CGME20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1@epcas3p4.samsung.com>
        <20190619210718.134951-1-dianders@chromium.org>
        <bec87373-48cc-0c55-9662-a74a7d2a47a0@samsung.com>
        <CAD=FV=WJBkYfRznh6aAyvgKgHb8-AG0hMORdKA0BXCL89wG_7w@mail.gmail.com>
        <a94d9554-fc93-a2d0-9a30-9604db8c123e@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.2019 11:56, Andrzej Hajda wrote:
> On 25.06.2019 18:26, Doug Anderson wrote:
>> Hi,
>>
>>
>> On Tue, Jun 25, 2019 at 9:07 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>> On 19.06.2019 23:07, Douglas Anderson wrote:
>>>> Let's add some better support for HDMI audio to dw_hdmi.
>>>> Specifically:
>>>>
>>>> 1. For 44.1 kHz audio the old code made the assumption that an N of
>>>> 6272 was right most of the time.  That wasn't true and the new table
>>>> should pick a more ideal value.
>>> Why? I ask because it is against recommendation from HDMI specs.
>> The place where it does matter (and why I originally did this work) is
>> when you don't have auto-CTS.  In such a case you really need "N" and
>> "CTS" to make the math work and both be integral.  This makes sure
>> that you don't slowly accumulate offsets.  I'm hoping that this point
>> should be non-controversial so I won't argue it more.
>>
>> I am an admitted non-expert, but I have a feeling that with Auto-CTS
>> either the old number or the new numbers would produce pretty much the
>> same experience.
>
> Because Auto-CTS mechanism will alternate between two or more CTS values
> every frame, thus it will compensate non-rational clock relationship.
>
>
>>   AKA: anyone using auto-CTS won't notice any change
>> at all.  I guess the question is: with Auto-CTS should you pick the
>> "ideal" 6272 or a value that allows CTS to be the closest to integral
>> as possible.  By reading between the lines of the spec, I decided that
>> it was slightly more important to allow for an integral CTS.  If
>> achieving an integral CTS wasn't a goal then the spec wouldn't even
>> have listed special cases for any of the clock rates.  We would just
>> be using the ideal N and Auto-CTS and be done with it.  The whole
>> point of the tables they list is to make CTS integral.
>
> Specification recommends many contradictory things without explicit
> prioritization, at least I have not found it.
>
> So we should relay on our intuition.
>
> I guess that with auto-cts N we should follow recommendation - I guess
> most sinks have been better tested with recommended values.
>
> So what with non-auto-cts case:
>
> 1. How many devices do not have auto-cts? how many alternative TMDS
> clocks we have? Maybe it is theoretical problem.
>
> 2. Alternating CTS in software is possible, but quite
> complicated/annoying, but at least it will follow recommendation :)
>
>
> Regards
>
> Andrzej
>
>
>>
>>>> 2. The new table has values from the HDMI spec for 297 MHz and 594
>>>> MHz.
>>>>
>>>> 3. There is now code to try to come up with a more idea N/CTS for
>>>> clock rates that aren't in the table.  This code is a bit slow because
>>>> it iterates over every possible value of N and picks the best one, but
>>>> it should make a good fallback.
>>>>
>>>> NOTES:
>>>> - The oddest part of this patch comes about because computing the
>>>>   ideal N/CTS means knowing the _exact_ clock rate, not a rounded
>>>>   version of it.  The drm framework makes this harder by rounding
>>>>   rates to kHz, but even if it didn't there might be cases where the
>>>>   ideal rate could only be calculated if we knew the real
>>>>   (non-integral) rate.  This means that in cases where we know (or
>>>>   believe) that the true rate is something other than the rate we are
>>>>   told by drm.
>>>> - This patch makes much less of a difference after the patch
>>>>   ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when using
>>>>   non-AHB audio"), at least if you're using I2S audio.  The main goal
>>>>   of picking a good N is to make it possible to get a nice integral
>>>>   CTS value, but if CTS is automatic then that's much less critical.
>>> As I said above HDMI recommendations are different from those from your
>>> patch. Please elaborate why?
>>>
>>> Btw I've seen your old patches introducing recommended N/CTS calculation
>>> helpers in HDMI framework, unfortunately abandoned due to lack of interest.
>>>
>>> Maybe resurrecting them would be a good idea, with assumption there will
>>> be users :)
>> I have old patches introducing this into the HDMI framework?  I don't
>> remember them / can't find them.  Can you provide a pointer?


And forgot answer this:

My mistake the patches were by Arnaud Pouliquen[1].

[1]: https://patchwork.kernel.org/patch/8906791/


Regards

Andrzej



>>
>> -Doug
>>
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


