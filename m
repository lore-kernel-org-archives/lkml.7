Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F23C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96CF214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IQZ3Bhb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbfIMIrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:47:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47788 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbfIMIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:47:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190913084720euoutp029c29ecf574d0ab770cb0d41bdba12794~D8yYsCBRj0687906879euoutp02m
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:47:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190913084720euoutp029c29ecf574d0ab770cb0d41bdba12794~D8yYsCBRj0687906879euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568364440;
        bh=pHzQlbDo1C4cXmBS7A3CPSHtIvcSShpbfes0/svvBAk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IQZ3Bhb7LDMPNUMHIk2lfvY63nLiQDJln2N9hGBybTPIBWde9NjzU6YpQ0Op/ygi8
         c/fJq43NH5m6fF8+104+Sn1qlBuqYw8ZZnLTvITUu0O1AVsVb1js8mgUZ3evk0g86I
         G5Og1+b5SKTebiE50AvNsmaPTRgl9pHrkAdUzdTU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190913084719eucas1p13dd58e4dc9a40d174f07f71221dfcdce~D8yX10TT02512225122eucas1p1X;
        Fri, 13 Sep 2019 08:47:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.5A.04374.7975B7D5; Fri, 13
        Sep 2019 09:47:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190913084718eucas1p1ddebd180b28385b21873144dfdaccc57~D8yW_3pEY2930829308eucas1p1x;
        Fri, 13 Sep 2019 08:47:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190913084718eusmtrp1f4c3830eba1d66ec5047d67dfa572e37~D8yWwLvQY2570325703eusmtrp1d;
        Fri, 13 Sep 2019 08:47:18 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-90-5d7b579784a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.C4.04117.6975B7D5; Fri, 13
        Sep 2019 09:47:18 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190913084717eusmtip20eec82ae46ffc257da69575ea68a8e64~D8yWEbZkx1334313343eusmtip2x;
        Fri, 13 Sep 2019 08:47:17 +0000 (GMT)
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     Matt Redfearn <matt.redfearn@thinci.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Amit Pundir <amit.pundir@linaro.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <084ab580-8ba8-b018-bc7a-bd705027f200@samsung.com>
Date:   Fri, 13 Sep 2019 10:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00e4f553-a02c-6d98-a0e8-28c0183a3c8c@thinci.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3u+flnuLscZW+81Jzw+YlMWY/I6PZPH+0+MOWoXHxuKIu7lF6
        +cOZkJRdarUu9CLrZJTO9TZZLqSpSNIbLmlUSpZKt0ru8dT03+ft+/t+P9uPIZQT1CImRHuG
        12nVoSramSx5YX/tlR4QG7j+fLoLTmqoleGfplyE340M0rj5dy+B68a9cG1/M4mvJOfJcVPF
        DRpX2LJl2HrtIP6WM0Zgk92C8MeieoTtFbdIbB68QOKu3nxqB8sNtl6Uc5n6RpIrN36Uc19u
        PnTQ+AyKe2l4K+M+vH9Mc6WjnRRnu1oj4/LSmmmuKimF5DJTuijuV7HHXsUB523H+NCQSF7n
        vf2Ic3BGx8lTdSuj7rUMU3r03CMBOTHAboK+4Rw6ATkzStaEYOynRSaRYQTW8VYkkV8IEpsK
        qJkRU1wxJRn5CPqtX6fJAILHcVNITLmwO+B7aY/DYBhXdh80564XMwT7hoRno3ZCzNDsKpg0
        t9EiVrDboeplGRLzJLsC+n7MFWU3dj8MdVZTUmQB1GZ0kyJ2csTbC9PkIiZYT7hgySQk7A7t
        3Vn/KgB7nwFzvG366l1gGOuaxi7QV/NILuEl8ColkZTwObCZ4ghpOB6BpaickIytUF3T+K8M
        4Ti6sMJbknfCVP4DuSgDOx9aBxZIN8yH6yXphCQrIP6SUkovA1u9ZfpBd7jzZoQ2IJVxVjPj
        rDbGWW2M//dmI7IAufMRQpiGFzZq+bPrBHWYEKHVrDsaHlaMHH/y1Z+akTL0ZCLIilgGqeYp
        8NqYQCWljhSiw6wIGELlqvDrjw5UKo6po2N4XfhhXUQoL1jRYoZUuSti53QeVLIa9Rn+JM+f
        4nUzroxxWqRHS0/7MLoPvkUdoT3LnPSu5s8hR5PCTzQlxCgrrVnLKw8N4OTbZX/ycs43rqmT
        +0Jdakt9g5uNb+OFu0JVPmP03NNjCBqqrmp72rFtSsNvXv1Jm1puqEYL9ZsKQwIiorMrCY8t
        9ZfTT+/2Y1LGXcfmePofzymftEeaffwLoko1KlIIVm9YTegE9V+4sB/sjwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xe7rTwqtjDW7uFbPoPXeSyeLDikWM
        Fle+vmezuPr9JbPFmd+6FiffXGWx6Jy4hN3i8q45bBa77i9gsjjUF23xfOEPZosVP7cyWtzd
        cJbR4ueueSwWm983s1g8ermc1UHA4/2NVnaP2Q0XWTx2zrrL7vF47kYgt2Mmq8eJCZeYPO5c
        28Pmsf3bA1aP+93HmTyWTLvK5nGgdzKLx+zJj1g9Pm+SC+CN0rMpyi8tSVXIyC8usVWKNrQw
        0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYeTu74IxaxerrX1gbGI/KdTFyckgI
        mEisaNnE2sXIxSEksJRRYsfNu0wQCXGJ3fPfMkPYwhJ/rnWxQRS9ZpS4dGwbWJGwgIPE6+0v
        WEFsEYEQiRk9T8EmMQtcYpGY8fwpVMdmVomtS2aAjWIT0JT4u/kmG4jNK2AnceDEDsYuRg4O
        FgFViVfvuEHCogIREod3zGKEKBGUODnzCQuIzQlUfmv9NHYQm1lAXeLPvEvMELa8RPPW2VC2
        uMStJ/OZJjAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRmBq2
        Hfu5BejUd8GHGAU4GJV4eC10qmKFWBPLiitzDzFKcDArifD6vKmMFeJNSaysSi3Kjy8qzUkt
        PsRoCvTbRGYp0eR8YNrKK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TB
        KdXAyFI87+Gur7fLt06x1bWrWnji0dccxnLxl5cPl/hXrU68/K3l1DON9ZPlfqhM/3BkQ5R5
        LceSV+c6mHb2MjsK75z/9ybn9PvnLh9ctNVkgVWfD8OyC78us9zT5L50WHcHT5DxPh3GA3c9
        Sz9/Ul4X+bukLSv2hsrnEypXFNUlwx8unrQgPvu35CclluKMREMt5qLiRABEaVwuIwMAAA==
X-CMS-MailID: 20190913084718eucas1p1ddebd180b28385b21873144dfdaccc57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da
References: <20190829060550.62095-1-john.stultz@linaro.org>
        <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
        <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
        <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com>
        <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
        <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com>
        <CALAqxLU5Ov+__b5gxnuMxQP1RLjndXkB4jAiGgmb-OMdaKePug@mail.gmail.com>
        <9d31af23-8a65-d8e8-b73d-b2eb815fcd6f@samsung.com>
        <CALAqxLVP=x9+p9scGyfgFUMN2di+ngOz9-fWW=A1YCM4aN7JRA@mail.gmail.com>
        <16c9066b-091f-6d0e-23f1-2c1f83a7da1b@samsung.com>
        <00e4f553-a02c-6d98-a0e8-28c0183a3c8c@thinci.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2019 16:18, Matt Redfearn wrote:
>
> On 12/09/2019 14:21, Andrzej Hajda wrote:
>> On 12.09.2019 04:38, John Stultz wrote:
>>> On Wed, Sep 4, 2019 at 3:26 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 03.09.2019 18:18, John Stultz wrote:
>>>>> On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>> On 30.08.2019 19:00, Rob Clark wrote:
>>>>>>> On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>>>> Of course it seems you have different opinion what is the right thing in
>>>>>>>> this case, so if you convince us that your approach is better one can
>>>>>>>> revert the patch.
>>>>>>> I guess my strongest / most immediate opinion is to not break other
>>>>>>> existing adv75xx bridge users.
>>>>>> It is pity that breakage happened, and next time we should be more
>>>>>> strict about testing other platforms, before patch acceptance.
>>>>>>
>>>>>> But reverting it now will break also platform which depend on it.
>>>>> I'm really of no opinion of which approach is better here, but I will
>>>>> say that when a patch breaks previously working boards, that's a
>>>>> regression and justifying that some other board is now enabled that
>>>>> would be broken by the revert (of a patch that is not yet upstream)
>>>>> isn't really a strong argument.
>>>>>
>>>>> I'm happy to work with folks to try to fixup the kirin driver if this
>>>>> patch really is the right approach, but we need someone to do the same
>>>>> for the db410c, and I don't think its fair to just dump that work onto
>>>>> folks under the threat of the board breaking.
>>>> These drivers should be fixed anyway - assumption that
>>>> drm_bridge/drm_panel will be registered before the bus it is attached to
>>>> is just incorrect.
>>>>
>>>> So instead of reverting, fixing and then re-applying the patch I have
>>>> gently proposed shorter path. If you prefer long path we can try to go
>>>> this way.
>>>>
>>>> Matt, is the pure revert OK for you or is it possible to prepare some
>>>> workaround allowing cooperation with both approaches?
>>> Rob/Andrzej: What's the call here?
>>>
>>> Should I resubmit the kirin fix for the adv7511 regression here?
>>> Or do we revert the adv7511 patch? I believe db410c still needs a fix.
>>>
>>> I'd just like to keep the HiKey board from breaking, so let me know so
>>> I can get the fix submitted if needed.
>>
>> Since there is no response from Matt, we can perform revert, since there
>> are no other ideas. I will apply it tomorrow, if there are no objections.
> Hi,
>
> Sorry - yeah I think reverting is probably best at this point to avoid 
> breaking in-tree platforms.
> It's a shame though that there is a built-in incompatibility within the 
> tree between drivers.


Quite common in development - some issues becomes visible after some time.

> The way that the generic Synopsys DSI host driver 
> probes is currently incompatible with the ADV7533 (hence the patch), 
> other DSI host drivers are now compatible with the ADV7533 but break 
> when we change it to probe in a similar way to panel drivers.


1. The behavior should be consistent between all hosts/device drivers.

2. DSI controlled devices can expose drm objects (drm_bridge/drm_panel)
only when they can probe, ie DSI bus they sit on must be created 1st.

1 and 2 enforces policy that all host drivers should 1st create control
bus (DSI in this case) then look for higher level objects
(drm_bridge/drm_panel).

As a consequence all bridges and panels should 1st gather the resources
they depends on, and then they can expose higher level objects.


>
>> And for the future: I guess it is not possible to make adv work with old
>> and new approach, but simple workaround for adv could be added later:
>>
>> if (source is msm or kirin)
>>
>>      do_the_old_way
>>
>> else
>>
>>      do_correctly.
> Maybe this would work, but how do we know that the list "msm or kirin" 
> is exhaustive to cope with all platforms?


By checking dts/config files.


> It seems to me the built in 
> incompatibility between DSI hosts needs to be resolved really rather 
> than trying to work around it in the ADV7533 driver (and any other DSI 
> bus device that falls into this trap).


If you know how, please describe. Atm the only real solution I see is
explicit workaround to allow new adv7511, then fixing controllers,
together with workaround-removal.

OK, it could be possible to change msm, kirin and adv in one patch,
however I am not sure if this is the best solution.


Regards

Andrzej


>
> Anyway, my platform is out of tree so better to revert my patch and keep 
> the in-tree platforms working.
>
> Thanks everyone.
> Matt
>
>>
>> And remove it after fixing both dsi masters.
>>
>>
>> Regards
>>
>> Andrzej
>>
>>
>>> thanks
>>> -john
>>>
>>>

