Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01890C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ACC22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ILAbGWDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfIDK0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:26:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58309 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:26:11 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190904102609euoutp02dfb352fbfda83c3a838b85d381ef40ee~BNVGA7K5n2973829738euoutp02C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 10:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190904102609euoutp02dfb352fbfda83c3a838b85d381ef40ee~BNVGA7K5n2973829738euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567592769;
        bh=Coo8VjC8BbJP4Jab5IDQtcqQAThWSz0wl/NUTOmecc0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ILAbGWDA1nYrDgITbctBMbm85L5uvkp8KQsyWHX5ME58TgvDU7bAs1Cy4Mi2MtAav
         BACT9yPgkv7g8kj5KrTUeGGeC3KMP/eRHO0PowvyU6i7pube4s6Bgf8uBq+Z7KI4By
         WeifUFD6L4cZ/a3PAIO/bHn6sRQBInT2ePneBwGI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190904102608eucas1p26201f187c81e621bb239fdfc6975b740~BNVFMh-UM0216002160eucas1p2h;
        Wed,  4 Sep 2019 10:26:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 85.0A.04469.0419F6D5; Wed,  4
        Sep 2019 11:26:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190904102607eucas1p1f227d880687febaa347642cc7196083b~BNVEcd5fY1509215092eucas1p1J;
        Wed,  4 Sep 2019 10:26:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190904102607eusmtrp2de533ad9b5d54e6c7821d3f067d488c7~BNVEOQo6Z3178231782eusmtrp2d;
        Wed,  4 Sep 2019 10:26:07 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-12-5d6f9140dcab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.CF.04166.F319F6D5; Wed,  4
        Sep 2019 11:26:07 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190904102606eusmtip1eff3d45eba0d2fc67cb415a471045578~BNVDcPR-K1439914399eusmtip1Q;
        Wed,  4 Sep 2019 10:26:06 +0000 (GMT)
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     John Stultz <john.stultz@linaro.org>
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
        Matt Redfearn <matt.redfearn@thinci.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <9d31af23-8a65-d8e8-b73d-b2eb815fcd6f@samsung.com>
Date:   Wed, 4 Sep 2019 12:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLU5Ov+__b5gxnuMxQP1RLjndXkB4jAiGgmb-OMdaKePug@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtdx/b1Zpep+JHidlI0sAX9LhkhVHCLSIqMiKRXHlTy03bVXv4
        R/awLDMyw3S6fDRTisxpthyjxJEm2kPz1QtnamW1RpqVPVyb18j/znfO+X7nO/CjcOkEOZdK
        UKZwKqU8USZyJu40TzwODM9Nig65+cmDyXncijFd41YR0/19BGfafwUyrZ+6CeZMrlbMPDMU
        ixhDfynGNJ2PYt6V/cCZqol6xLyueYSYCcMVgqmzniCYNyOVZLgra+3LFLNFGR0E26B+LWYH
        NTr7mFVIsg8vdGLsqx6jiNV/M5Nsf3YLxmrzu0VsY04ewRblvSHZsVqfzZKdzitjucSENE4V
        vDrGOb4x/zJKrnI5pNFn4xmoYvZZ5EQBvQRsza0iB5bSVQjuF/ifRc52/BXB2HAbKQxjCLQ1
        GuzfRu2xYUIQKhFc1f0UC4MFgc7yFTlc7nQ4fNS/Jx3Yg/aHMm035jDhdBcB5zLLxQ5BRAfA
        n7rnU+ESejU0ltdPLRP0QmhUT07FedI7YNRsIgWPG7QWDhEO7ERvAaP5J+7AOD0f9JbiaewF
        L4ZKpsKArqDg7Y1eQrh7HVgGe6Y7uMOHlttiAXuDraFkmj8K/VUncWE5C0F9TQMuCGFgaumw
        X0HZEwLgliFYoNeArbJa7KCBdoE+i5twgwtcvHMZF2gJZJ2SCu4F0P+ofvpBL6h4Oi66gGTq
        Gc3UM9qoZ7RR/88tRcR15MWl8oo4jg9VcgeDeLmCT1XGBe1JUtQi+4dsm2wZvYvGO3c3IZpC
        sjmSu5uU0VJSnsYfVjQhoHCZhyTSmBgtlcTKDx/hVEm7VKmJHN+E5lGEzEuSPsscJaXj5Cnc
        fo5L5lT/VIxympuB/Hon222r7g3pJk9kSq55HjQr/FYs3cj2FFAas5Ve5rTehvl+9g5Zu24k
        99T7EusTb+PSrl0x6coOl8D8gXcxEb8HFvkc8N0wuu/W3m3pYabyzxpTpP/y079PvhRnI9et
        o2Fr2YjSave4OdgeXyUT++XBSPR45GJjyqWcM3m27fxxGcHHy0MX4ype/hegPJzGjAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42I5/e/4XV37ifmxBstmSln0njvJZHHl63s2
        i6vfXzJbnPmta3HyzVUWi86JS9gtLu+aw2ax6/4CJotDfdEWzxf+YLZY8XMro8XdDWcZLX7u
        msdisfl9M4vFo5fLWR34Pd7faGX3mN1wkcVj56y77B6P524EcjtmsnqcmHCJyePOtT1sHtu/
        PWD1uN99nMljybSrbB4HeiezeMye/IjV4/MmuQDeKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MA9OmMxas4KuYu72buYFxKXcXIyeHhICJxKbG
        pyxdjFwcQgJLGSW6lzWzQyTEJXbPf8sMYQtL/LnWxQZR9JpR4t23nYwgCWEBB4nX21+wgtgi
        AhoSC5dcZQIpYha4xiLxbfIcRoiOc8wSU7fuAqtiE9CU+Lv5JhuIzStgJ3Fg0VawSSwCKhIH
        Zv1jArFFBSIkDu+YxQhRIyhxcuYTFhCbUyBQYs+DX2AnMQuoS/yZdwnKlpfY/nYOlC0ucevJ
        fKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgQmhW3Hfm7e
        wXhpY/AhRgEORiUe3h1+ebFCrIllxZW5hxglOJiVRHhD9+TECvGmJFZWpRblxxeV5qQWH2I0
        BXpuIrOUaHI+MGHllcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg
        NPHifix/ii/T4arDq73RKucczrGG/4sKfqfoYWp/cUUVV0Gh7rX0qa+v8lf/dqq+mBwts/jg
        XYXquWmrDuW/5bBw4HwnLbJho6et1lbm4h4XXWXRFW4eDit3lOuJ8ez232jZdIPd4fDuXQ3m
        KTrvRdbcUmzhbGbrzfOSqNIR/+DcsG/ajO1KLMUZiYZazEXFiQDjsvijIAMAAA==
X-CMS-MailID: 20190904102607eucas1p1f227d880687febaa347642cc7196083b
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.2019 18:18, John Stultz wrote:
> On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 30.08.2019 19:00, Rob Clark wrote:
>>> On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> Of course it seems you have different opinion what is the right thing in
>>>> this case, so if you convince us that your approach is better one can
>>>> revert the patch.
>>> I guess my strongest / most immediate opinion is to not break other
>>> existing adv75xx bridge users.
>>
>> It is pity that breakage happened, and next time we should be more
>> strict about testing other platforms, before patch acceptance.
>>
>> But reverting it now will break also platform which depend on it.
> I'm really of no opinion of which approach is better here, but I will
> say that when a patch breaks previously working boards, that's a
> regression and justifying that some other board is now enabled that
> would be broken by the revert (of a patch that is not yet upstream)
> isn't really a strong argument.
>
> I'm happy to work with folks to try to fixup the kirin driver if this
> patch really is the right approach, but we need someone to do the same
> for the db410c, and I don't think its fair to just dump that work onto
> folks under the threat of the board breaking.


These drivers should be fixed anyway - assumption that
drm_bridge/drm_panel will be registered before the bus it is attached to
is just incorrect.

So instead of reverting, fixing and then re-applying the patch I have
gently proposed shorter path. If you prefer long path we can try to go
this way.

Matt, is the pure revert OK for you or is it possible to prepare some
workaround allowing cooperation with both approaches?


Regards

Andrzej


>
> thanks
> -john
>
>

