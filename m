Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCDC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B3208CB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jlD4TbfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfIBNWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:22:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39774 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbfIBNWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:22:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190902132204euoutp02fa9f7676b51b6a9d2e46c6b560b8c575~AocHsuwUO0677006770euoutp02J
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 13:22:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190902132204euoutp02fa9f7676b51b6a9d2e46c6b560b8c575~AocHsuwUO0677006770euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567430524;
        bh=ckI4sLttZQrjczcPGWL9kIdldY39B/NY6PxZzJD/dWk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jlD4TbfXpRjrJbbpCQV65Ictsv8CjYfXmrM12DWyFosiMdRasJV8u8mhhKStFxlJ8
         /BpvirSkQL4FI81nCBC0/8cv2RyhixEhrZfH2ktsrGd18ZviZ8t0PRiOMoYen/KVWN
         HxnK2xAwthFSKv43WtBcEG6Pjq/DPO4bKWC2D+mc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190902132203eucas1p2666f2a7e5e5c9bd5c7d4e5d833b8c40e~AocGnBMIj2049120491eucas1p2E;
        Mon,  2 Sep 2019 13:22:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9F.AE.04309.B771D6D5; Mon,  2
        Sep 2019 14:22:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190902132202eucas1p1dce911099833efa0666b0a0836f0b9b8~AocFp5sqR1404414044eucas1p1A;
        Mon,  2 Sep 2019 13:22:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190902132202eusmtrp249d8182ba91bbfb983e4a9a979cab0d0~AocFbtyLo1900819008eusmtrp2c;
        Mon,  2 Sep 2019 13:22:02 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-e8-5d6d177bb2c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.1E.04117.A771D6D5; Mon,  2
        Sep 2019 14:22:02 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190902132201eusmtip2a28906b560069b48e9ae1c5f6877ab51~AocEzw9Hf1984519845eusmtip22;
        Mon,  2 Sep 2019 13:22:01 +0000 (GMT)
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     Rob Clark <robdclark@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
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
        Matt Redfearn <matt.redfearn@thinci.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com>
Date:   Mon, 2 Sep 2019 15:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTt23nsKG6Oq7aXLMMtigKzJGLAsLJ+jBmRP4pIpLYcH+VustNW
        bkFmKZuhaYqP9RlpPop8ruZmDxR8UIZamoq1m+VjNRPKTCkrZ6fIf+fcc+7ccz6GwuRzxEoq
        SnOW02pU0UrSEa9vnX/pfVGhDt1Snk8yyS87JMzrb9Mk0/vdhjEvfngzHZ96ceZ6WrGUeWXO
        IxmzpUjCNKeEMGO35zCmbN6EmLdVnYiZNxfgTO30VZwZtpUSu5zZ6f4EKZsb142zjca3UvZD
        fvUiNeQQbHtqj4Qd6msi2YZZK8FabrRJ2OLMXpJ9lpyOs7npwwT7tcbzoOyo444wLjrqHKf1
        8T/uGJnWkI3FdK2/sPC+H49D/Z5JiKKA3gaZ1QeSkCMlp8sQJOa3S0Qyg6BrMEkqkq8IHhnf
        4UnIwb5hezeHRKEUQW7GCCmSKQRXFnowweVK74LJhnFCwG70WqgwPcUFE0YP4JD22EAKAklv
        hIXaATuW0f5QVZtgP4HT62DCXGnH7vQR+GJtIUSPC3TkfMSF4A50MNy/6yGMMXoNNEzlYSJW
        wODHQnsHoMspaP1cQoqx90Je39hf7AoTbXVSEa+C343CgoAvg6XsGiYuGxCYqhoxUfCDlrZu
        QjiMLYauNPuI493wu/SBVHzI5dA/5SJmWA636rMwcSwDQ6JcdHuBpdP094MKKOn6RqYipXFJ
        MeOSNsYlbYz/7xYhvAIpOB2vjuB4Xw13fjOvUvM6TcTmk2fUNWjxf3z+q23mITL/PNGMaAop
        nWTjSB0qJ1Tn+Fh1MwIKU7rJDjVFh8plYapYPac9c0yri+b4ZuRB4UqF7OIya4icjlCd5U5z
        XAyn/adKKIeVccgZCxmu6z0VmLJnb+1Od3z2nlegf8WTTqv/hN4hIOOw5lJAgNfo9upYqyU7
        K8bd1L0uqkU34qTn9Ho+Pv/aPm34nZu2hJRVSl8fbwQTwVzy8KshY1Du6oojbzak9gQGTI66
        FQe1zsUUFFaGv/dboeiWzxgO2Nzbn++n/XT18c5KnI9Ubd2EaXnVH32WMsGLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4Pd0q8dxYg6ubOSx6z51ksrjy9T2b
        xdXvL5ktzvzWtTj55iqLRefEJewWl3fNYbPYdX8Bk8WhvmiL5wt/MFus+LmV0eLuhrOMFj93
        zWOx2Py+mcXi0cvlrA78Hu9vtLJ7zG64yOKxc9Zddo/HczcCuR0zWT1OTLjE5HHn2h42j+3f
        HrB63O8+zuSxZNpVNo8DvZNZPGZPfsTq8XmTXABvlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GxO0zmAsuqFX8fXiDpYHxhlwXIyeHhICJxMt7
        Pxi7GLk4hASWMkps/DePBSIhLrF7/ltmCFtY4s+1LjaIoteMEnNOHGYESQgLOEi83v6CFcQW
        EVCWWLV1PwtIEbPAbRaJiW8PsoMkhAQuMUl8OyIMYrMJaEr83XyTDcTmFbCT2LC5FWwbi4CK
        xKtd68FsUYEIicM7ZjFC1AhKnJz5BCjOwcEpECixZpk0SJhZQF3iz7xLzBC2vMT2t3OgbHGJ
        W0/mM01gFJqFpHsWkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAhbDv2
        c8sOxq53wYcYBTgYlXh4XzDmxgqxJpYVV+YeYpTgYFYS4Q3dkxMrxJuSWFmVWpQfX1Sak1p8
        iNEU6LeJzFKiyfnAZJVXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNT
        qoExhIlrW/18/vPq3CqPnxr1TNvV1fqhwlroUnQpb2LcmtDOzRdCZq1it71eM+9pe6WVzROj
        wrmrbj5eGDplQeyuqEtX2eT4bfpfaM3aPsU49nKK144j3g1t4flTy71LDafzdGy0cSreuT9P
        Zf0miZ7HzX6R9fOD2CbN/xlWapmW8Xl2NuPhikIlluKMREMt5qLiRADWq2bPHgMAAA==
X-CMS-MailID: 20190902132202eucas1p1dce911099833efa0666b0a0836f0b9b8
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2019 19:00, Rob Clark wrote:
> On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 29.08.2019 19:39, Rob Clark wrote:
>>> On Wed, Aug 28, 2019 at 11:06 PM John Stultz <john.stultz@linaro.org> wrote:
>>>> Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
>>>> host at probe time") landed in -next the HiKey board would fail
>>>> to boot, looping:
>>> No, please revert 83f35bc3a852.. that is going in the *complete* wrong
>>> direction.  We actually should be moving panels to not require dsi
>>> host until attach time, similar to how bridges work, not the other way
>>> around.
>>
>> Devices of panels and bridges controlled via DSI will not appear at all
>> if DSI host is not created.
>>
>> So this is the only direction!!!
>>
> I disagree, there is really no harm in the bridge probing if there is no dsi.
>
> Furthermore, it seems that this change broke a few other drivers.


If the bridge/panel is controlled via dsi, it will not be probed at all
if DSI host/bus is not created, so it will not work at all. Upstream
device will wait forever for downstream drm_(panel|bridge).

So IMO we just do not have choice here.

If you know better alternative let us know, otherwise we should proceed
with "drm: kirin: Fix dsi probe/attach logic" patch.


>
>>> The problem is that, when dealing with bootloader enabled display, we
>>> need to be really careful not to touch the hardware until the display
>>> driver knows the bridge/panel is present.  If the bridge/panel probes
>>> after the display driver, we could end up killing scanout
>>> (efifb/simplefb).. if the bridge/panel is missing some dependency and
>>> never probes, it is rather unpleasant to be stuck trying to debug what
>>> went wrong with no display.
>>
>> It has nothing to do with touching hardware, you can always (I hope)
>> postpone it till all components are present.
> Unfortunately this is harder than it sounds, since we need to read hw
> revision registers for display and dsi blocks to know which hw
> revision we are dealing with.
>
> (Also, we need to avoid
> drm_fb_helper_remove_conflicting_framebuffers() until we know we are
> ready to go.)
>
> We could possibly put more information in dt.  But the less we depend
> on dt, the easier time we'll have adding support for ACPI boot on the
> windows arm laptops.
>
>> But it is just requirement of device/driver model in Linux Kernel.
> yes and no.. the way the existing bridges work with a bridge->attach()
> step seems fairly pragmatic to me.
>
>>> Sorry I didn't notice that adv7511 patch before it landed, but the
>>> right thing to do now is to revert it.
>>
>> The 1st version of the patch was posted at the end of April and final
>> version was queued 1st July, so it was quite long time for discussions
>> and tests.
> sorry I didn't notice the patch sooner, most of my bandwidth goes to mesa.
>
>> Reverting it now seems quite late, especially if the patch does right
>> thing and there is already proper fix for one encoder (kirin), moreover
>> revert will break another platforms.
> kirin isn't the only other user of adv75xx.. at least it is my
> understanding that this broke db410c as well.
>
>> Of course it seems you have different opinion what is the right thing in
>> this case, so if you convince us that your approach is better one can
>> revert the patch.
> I guess my strongest / most immediate opinion is to not break other
> existing adv75xx bridge users.


It is pity that breakage happened, and next time we should be more
strict about testing other platforms, before patch acceptance.

But reverting it now will break also platform which depend on it.

Anyway the old order was incorrect and prevented other users from adv*
driver usage, so it should be fixed anyway.


> Beyond that, I found doing mipi_dsi_attach() in bridge->attach() was
> quite convenient to get display handover from efifb work.  And that
> was (previously) the way most of the bridges worked.
>
> But maybe there is another way.. perhaps somehow the bridges/panels
> could be added as sub-components using the component framework, to
> prevent the toplevel drm device from probing until they are ready?


If you mean 'probe' as in initialization from component_master::bind
callback with this patch it still works, DSI-HOST calls component_add
after drm_bridge is found.


> We'd still have the problem that the dsi component wants to be able to
> read hw revision before registering dsi host.. but I suppose if CCF
> exported a way that we could query whether the interface clk was
> already enabled, we could have the clk enable/disable cycle that would
> break efifb.


I am not familiar with efifb, if you describe the issue you have in more
detail we can try to find some solution together.


Regards

Andrzej


>
> BR,
> -R
>
>

