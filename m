Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCF9205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o8SrkhJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFZJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:56:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57700 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:56:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190626095621euoutp023321bbccea6ec2c07f7d043754d3daca~rtxFc9Yhr0686106861euoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:56:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190626095621euoutp023321bbccea6ec2c07f7d043754d3daca~rtxFc9Yhr0686106861euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561542981;
        bh=Hk7za34B6PtC3S7miNX/a+oGyxVJXmwKHDbecortBKc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o8SrkhJl7F3EciyZZ8tAVTRp/vCSsciUyEUwNJkp0PIAWUdSZbmvtubfdWbA4cxQf
         dk3iqkM/quo23adh7MC8wN7iH02ejeP3rdwYUFbjXz3ejC7I/7HbyS/0faf8Oow6XZ
         YDKmE2SYxte1goj2aAqVCCY3WhxYQa/U1BhUwSzw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190626095620eucas1p14bfef993fc308e8e3cf36688cbac4b15~rtxE1lwZU0280502805eucas1p1l;
        Wed, 26 Jun 2019 09:56:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AE.AE.04325.441431D5; Wed, 26
        Jun 2019 10:56:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190626095619eucas1p2d17e9b495f3bdebf27b06c3fcec52ad8~rtxEHWQyy0312703127eucas1p2y;
        Wed, 26 Jun 2019 09:56:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190626095619eusmtrp2c277c1fcef3823b35811e8632b7e7722~rtxD4-cjB0511105111eusmtrp2j;
        Wed, 26 Jun 2019 09:56:19 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-47-5d13414449d4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.90.04140.341431D5; Wed, 26
        Jun 2019 10:56:19 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626095618eusmtip26d78c3c13eebcac38721956ffff22091~rtxDJsg3V2662626626eusmtip26;
        Wed, 26 Jun 2019 09:56:18 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Handle audio for
 more clock rates
To:     Doug Anderson <dianders@chromium.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Dylan Reid <dgreid@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <a94d9554-fc93-a2d0-9a30-9604db8c123e@samsung.com>
Date:   Wed, 26 Jun 2019 11:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WJBkYfRznh6aAyvgKgHb8-AG0hMORdKA0BXCL89wG_7w@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvXvOnk47bU6bpkdF2dGHomIY85LJrQ9njBkMH4w0LM5Uo032
        SBJakm6KiLTRGrNpU7mUShlkM11Qo6tc29xTTaM2ppmydves0bf/8zz/3/s8/5mXJmTJlAcd
        FXOQU8UoouWUhKxunGgLCF3jGr4oV0/hrLYWEc6qvivC5uocAmub31C49cYTCneNj1DY/HFQ
        jIc+PiVw9+8BArcMdZM4PUfngDvrrlB41GgmsHHgMcKG7DCsn6hC+P2dVrTahR3pTXFgC8sS
        2QJ1O8k+/HWNZAvS8sVs87kOEVvzyyhm+zKbRGylLonVXeqm2PqsCyRb01NIsGMVczdJt0tW
        7uWiow5xqqCQXZLI5gujROwHn8OfBjMoNeqcnYEcaWCWQvpkHZmBJLSM0SO4W9wpEgoTgu8d
        RWKhGLMUb1PRP2TwWY8dKUZQOfbD7hpGUHq1xMHqcmXCobXZRFj1LMYPvqoHCKuJYErF0Pjl
        PWkdUJbBVOVryqqlTAhc71fbYJLxhexLGhvsxmwDU20FEjwu0JL/2cY6MpvhTO2UzUMw3lAz
        fMWu3eHNZ60tBDDlNPQ/yLPfHQoF9WZC0K7wo+meg6C9wFxrBaw6Cfr0pwgBTkNQdafWDgRD
        Q1O7JSdt2eAHt+uChPYaeNFbZmsD4wy9wy7CDc5wvjqPENpSSDstE9zzoK+1yv6gOxS9HKfO
        IblmWjLNtDSaaWk0//deQ+RN5M7F8coIjl8Sw8UH8golHxcTEbhnv7ICWb7m8z9N4/fRo8nd
        BsTQSO4kVXvLwmVixSE+QWlAQBPyWdIiBRMuk+5VJBzhVPt3quKiOd6APGlS7i5NnGEMkzER
        ioPcPo6L5VT/piLa0UONQuO6jw7sfCd56zfiv2KVW9rS9am5bVt1Gwe3zK9Zuzu2XMtzntqL
        Z0+MpBSfNxybSc+/ZTS11C/fciAh7/LxMH1iw0+fdcG9Ev9lmU83vCg+kaNmk+4tV2oLS+gF
        u2YHJAelxneEdKkXxl8cdVrmvNoUcnLON02JV8MrXz6VT+/bESon+UjFYn9CxSv+AmQsCT6W
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xe7rOjsKxBpfnC1r0njvJZNG7bSOT
        xf9tE5kt5p+4xWZxdtlBNosrX9+zWfx/9JrV4s2jI8wWV7+/ZLY4+eYqi0XnxCXsFpd3zWGz
        +PTgP7PFg5f7GS0O9UVbrPi5ldHi7oazjA6CHu9vtLJ7zFtT7TG74SKLx95vC1g8ZnfMZPU4
        MeESk8f2bw9YPe53H2fy2Lyk3mPJtKtsHgd6J7N4bL82j9nj8ya5AN4oPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwTkz8xF9xTqHj8uoutgfGy
        ZBcjJ4eEgInE61PXWLoYuTiEBJYySnSdW8oOkRCX2D3/LTOELSzx51oXG0TRa0aJlXuPsYAk
        hAViJc6e+AJWJCKgKfGs4SUzSBGzwFpWicW9pxghOrqZJLYtncoEUsUGVPV38002EJtXwE5i
        0cMGsHUsAqoSfdNmgU0SFYiQmL2rgQWiRlDi5MwnYDanQKBEz86/YDXMAuoSf+ZdgrLlJba/
        nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsY
        gWli27GfW3Ywdr0LPsQowMGoxMPbIC8UK8SaWFZcmXuIUYKDWUmEd2miQKwQb0piZVVqUX58
        UWlOavEhRlOg5yYyS4km5wNTWF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQi
        mD4mDk4pYDTJdyVkpiQkme9fqbTggoPX7OnKSes2XYuUnP/p+i7ZDcneqS8XXzIuPbDmQO7P
        2eXncxZkW9lPEzPdLzb5UE2084Fsj5UvgnIsVVlnR38oWsH2k1u0jzuy6V/h/8zuXq1HPw+J
        R3s7/dU7dmSu3O4/v3d8YZflfx/2XdvwvlmJD3N1bmLQeSWW4oxEQy3mouJEAAnGQcIpAwAA
X-CMS-MailID: 20190626095619eucas1p2d17e9b495f3bdebf27b06c3fcec52ad8
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2019 18:26, Doug Anderson wrote:
> Hi,
>
>
> On Tue, Jun 25, 2019 at 9:07 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 19.06.2019 23:07, Douglas Anderson wrote:
>>> Let's add some better support for HDMI audio to dw_hdmi.
>>> Specifically:
>>>
>>> 1. For 44.1 kHz audio the old code made the assumption that an N of
>>> 6272 was right most of the time.  That wasn't true and the new table
>>> should pick a more ideal value.
>>
>> Why? I ask because it is against recommendation from HDMI specs.
> The place where it does matter (and why I originally did this work) is
> when you don't have auto-CTS.  In such a case you really need "N" and
> "CTS" to make the math work and both be integral.  This makes sure
> that you don't slowly accumulate offsets.  I'm hoping that this point
> should be non-controversial so I won't argue it more.
>
> I am an admitted non-expert, but I have a feeling that with Auto-CTS
> either the old number or the new numbers would produce pretty much the
> same experience.


Because Auto-CTS mechanism will alternate between two or more CTS values
every frame, thus it will compensate non-rational clock relationship.


>   AKA: anyone using auto-CTS won't notice any change
> at all.  I guess the question is: with Auto-CTS should you pick the
> "ideal" 6272 or a value that allows CTS to be the closest to integral
> as possible.  By reading between the lines of the spec, I decided that
> it was slightly more important to allow for an integral CTS.  If
> achieving an integral CTS wasn't a goal then the spec wouldn't even
> have listed special cases for any of the clock rates.  We would just
> be using the ideal N and Auto-CTS and be done with it.  The whole
> point of the tables they list is to make CTS integral.


Specification recommends many contradictory things without explicit
prioritization, at least I have not found it.

So we should relay on our intuition.

I guess that with auto-cts N we should follow recommendation - I guess
most sinks have been better tested with recommended values.

So what with non-auto-cts case:

1. How many devices do not have auto-cts? how many alternative TMDS
clocks we have? Maybe it is theoretical problem.

2. Alternating CTS in software is possible, but quite
complicated/annoying, but at least it will follow recommendation :)


Regards

Andrzej


>
>
>>> 2. The new table has values from the HDMI spec for 297 MHz and 594
>>> MHz.
>>>
>>> 3. There is now code to try to come up with a more idea N/CTS for
>>> clock rates that aren't in the table.  This code is a bit slow because
>>> it iterates over every possible value of N and picks the best one, but
>>> it should make a good fallback.
>>>
>>> NOTES:
>>> - The oddest part of this patch comes about because computing the
>>>   ideal N/CTS means knowing the _exact_ clock rate, not a rounded
>>>   version of it.  The drm framework makes this harder by rounding
>>>   rates to kHz, but even if it didn't there might be cases where the
>>>   ideal rate could only be calculated if we knew the real
>>>   (non-integral) rate.  This means that in cases where we know (or
>>>   believe) that the true rate is something other than the rate we are
>>>   told by drm.
>>> - This patch makes much less of a difference after the patch
>>>   ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when using
>>>   non-AHB audio"), at least if you're using I2S audio.  The main goal
>>>   of picking a good N is to make it possible to get a nice integral
>>>   CTS value, but if CTS is automatic then that's much less critical.
>>
>> As I said above HDMI recommendations are different from those from your
>> patch. Please elaborate why?
>>
>> Btw I've seen your old patches introducing recommended N/CTS calculation
>> helpers in HDMI framework, unfortunately abandoned due to lack of interest.
>>
>> Maybe resurrecting them would be a good idea, with assumption there will
>> be users :)
> I have old patches introducing this into the HDMI framework?  I don't
> remember them / can't find them.  Can you provide a pointer?
>
> -Doug
>
>

