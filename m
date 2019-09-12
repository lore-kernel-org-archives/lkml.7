Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8353FC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AACA20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="slhQrT9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbfILNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:21:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46133 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfILNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:21:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190912132127euoutp01aa4f3e9ccf202715bb72969112ce3e5a~Ds4cR1dnf0257302573euoutp01K
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 13:21:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190912132127euoutp01aa4f3e9ccf202715bb72969112ce3e5a~Ds4cR1dnf0257302573euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568294487;
        bh=tlEvquuIuW9HkzSFCWtP6aVz/Llz1jttyGDq549d7xE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=slhQrT9JoQ5IpckP1TdazKArL5nidnqsqTegr/1bsitNGcXxl8wvZSfbIIUBsHkCp
         w1kz+w0wQmnfCYuJLNRkLc1kMNErDPEOQnrKNW8erCRXPbql3HnG5y6w9T1nWAB3NO
         OvIimBz5AXCS4pISGN0SYKH2tLoTnhATA/Ll1bps=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190912132126eucas1p19f372230cf5576d5286ddbaabc1bcb08~Ds4bVrYfa1903319033eucas1p1Y;
        Thu, 12 Sep 2019 13:21:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.D6.04469.6564A7D5; Thu, 12
        Sep 2019 14:21:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190912132126eucas1p1232a3be470d783e7676d22f462a252b4~Ds4aqa3mh1903319033eucas1p1X;
        Thu, 12 Sep 2019 13:21:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190912132126eusmtrp1be40c8b867e017da7064c56436d3967f~Ds4apTRSl1907619076eusmtrp19;
        Thu, 12 Sep 2019 13:21:26 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-8f-5d7a46561230
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.7F.04166.6564A7D5; Thu, 12
        Sep 2019 14:21:26 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190912132125eusmtip21addbf3b29cb6ac44ac21c0141b81adf~Ds4Z92MFT0734107341eusmtip2Z;
        Thu, 12 Sep 2019 13:21:25 +0000 (GMT)
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
        Matt Redfearn <matt.redfearn@thinci.com>,
        Amit Pundir <amit.pundir@linaro.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <16c9066b-091f-6d0e-23f1-2c1f83a7da1b@samsung.com>
Date:   Thu, 12 Sep 2019 15:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVP=x9+p9scGyfgFUMN2di+ngOz9-fWW=A1YCM4aN7JRA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut/vY1Zz9nBNPGoUjMSu16MEPCjGSukVQQUloYisvGumqTSsN
        cqWGPSxrlbRVmila2HPOVxYysym9rUWFsWUPe2JoVtOydr1J/vd93/nOd86Bw1HKASaI26jN
        EHRaTZqa9aZrb7sfRMQtyk6cUVEXTgrvt8vI16oyRJ7097DE8eMDRe4ORpD2zw6a7DtSLieP
        G0+xpNFZKiO2Qwmk++xPilS5rYi8vHIPEXfjGZpYenJp0vWhkonBfM+zfDlvNjyi+QbTSzn/
        +vRVDy04yfBtRR0yvvNpE8vXfXcxvPOAXcaXn3CwfHOhkebNxi6G77s2cYUi3nt+spC2cZug
        i4pe5516w90k29IesKO5xsEaUJ7ffsRxgGdD9Vu8H3lzSlyF4JblDC2Rbwh6a4tlEulDUGMz
        0yMdN9tiJL0SQYnF5DF5ecgXBGVfKRH74xj4VPeeEbEKT4Gz5Y7hIAr/osF6rhWJBRaHw2/L
        c1bEChwNpqa7cnEAjUPBdpsW5QC8BnpdLYxk8YP2k2+GdS+8Egp/F8lFTOFJkGs1UxIOhBdv
        SoZnAb7Iwa8nhn9Lx4KpZKnoAewPH+01cglPgDvGg7SEc8BZlUdJvQUIrFcaKKkwD1rsjxgx
        h/LsfLkxSpIXwJ/KS3Ip3heeffGTVvCFo7XFlCQroGCvUnKHgPOe9V9gIFQ87GeLkNo06jDT
        qGNMo44x/Z9biugLKFDI1KenCPqZWmF7pF6Trs/UpkRu2Jx+DXk+8s6Qvbce9XestyHMIbWP
        gkzPTlQymm36rHQbAo5SqxTLPmclKhXJmqxsQbc5SZeZJuhtKJij1YGKnWNcCUqcoskQNgnC
        FkE3UpVxXkEGlLQEvYqzupe5jK3Ls1tClo+lu8Pi57f2Fy9pG+taOC+g2hz/LqwtwJCvPKKa
        tqp0bblPpm980gu479LuORxsG1/avTVnddb1VRlB4y6dV8fiTp/644tvptY6V1jmHns7J6Zi
        luqYGu0ebO6crKpPHeoqWWsPH9NqHAg9FeUXGdKxS03rUzUzp1I6veYv1p68CY0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd0wt6pYg2U7OCx6z51ksviwYhGj
        xZWv79ksrn5/yWxx5reuxck3V1ksOicuYbe4vGsOm8Wu+wuYLA71RVs8X/iD2WLFz62MFnc3
        nGW0+LlrHovF5vfNLBaPXi5ndRDweH+jld1jdsNFFo+ds+6yezyeuxHI7ZjJ6nFiwiUmjzvX
        9rB5bP/2gNXjfvdxJo8l066yeRzoncziMXvyI1aPz5vkAnij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL2/tzDVHBStOLAlqtsDYwtgl2MHBwS
        AiYS+044dDFycQgJLGWUOH95AXMXIydQXFxi9/y3ULawxJ9rXWwQRa8ZJW48WskCkhAWcJB4
        vf0FK4gtIqAhsXDJVSaQImaBfywS01vmgHULCZxikdi+JwjEZhPQlPi7+SYbiM0rYCcxa88Z
        dpArWARUJQ4dA5spKhAhcXjHLEaIEkGJkzOfgMU5BQIlev9OYAexmQXUJf7Mu8QMYctLNG+d
        DWWLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiB
        iWHbsZ+bdzBe2hh8iFGAg1GJh9dCpypWiDWxrLgy9xCjBAezkgivz5vKWCHelMTKqtSi/Pii
        0pzU4kOMpkC/TWSWEk3OByatvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUw
        fUwcnFINjIxm5lPdq68xPLdSrKq3PX7cuOOPbkPJiTNJs7VZQhzei2Xm6ti3HCk49JZTwWXR
        di/edBEHBqkdG6b8mFv0dHGUpdfH4Mccb3li/JY2X4l2dJnTbv58zsalWQyJfk/89f1U3nyN
        3f3mNbPhnU/Nt2OYFI5s33nx8K0Hq3rX9skf9cuf2eMjoMRSnJFoqMVcVJwIAC2247giAwAA
X-CMS-MailID: 20190912132126eucas1p1232a3be470d783e7676d22f462a252b4
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2019 04:38, John Stultz wrote:
> On Wed, Sep 4, 2019 at 3:26 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 03.09.2019 18:18, John Stultz wrote:
>>> On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 30.08.2019 19:00, Rob Clark wrote:
>>>>> On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>>> Of course it seems you have different opinion what is the right thing in
>>>>>> this case, so if you convince us that your approach is better one can
>>>>>> revert the patch.
>>>>> I guess my strongest / most immediate opinion is to not break other
>>>>> existing adv75xx bridge users.
>>>> It is pity that breakage happened, and next time we should be more
>>>> strict about testing other platforms, before patch acceptance.
>>>>
>>>> But reverting it now will break also platform which depend on it.
>>> I'm really of no opinion of which approach is better here, but I will
>>> say that when a patch breaks previously working boards, that's a
>>> regression and justifying that some other board is now enabled that
>>> would be broken by the revert (of a patch that is not yet upstream)
>>> isn't really a strong argument.
>>>
>>> I'm happy to work with folks to try to fixup the kirin driver if this
>>> patch really is the right approach, but we need someone to do the same
>>> for the db410c, and I don't think its fair to just dump that work onto
>>> folks under the threat of the board breaking.
>>
>> These drivers should be fixed anyway - assumption that
>> drm_bridge/drm_panel will be registered before the bus it is attached to
>> is just incorrect.
>>
>> So instead of reverting, fixing and then re-applying the patch I have
>> gently proposed shorter path. If you prefer long path we can try to go
>> this way.
>>
>> Matt, is the pure revert OK for you or is it possible to prepare some
>> workaround allowing cooperation with both approaches?
> Rob/Andrzej: What's the call here?
>
> Should I resubmit the kirin fix for the adv7511 regression here?
> Or do we revert the adv7511 patch? I believe db410c still needs a fix.
>
> I'd just like to keep the HiKey board from breaking, so let me know so
> I can get the fix submitted if needed.


Since there is no response from Matt, we can perform revert, since there
are no other ideas. I will apply it tomorrow, if there are no objections.

And for the future: I guess it is not possible to make adv work with old
and new approach, but simple workaround for adv could be added later:

if (source is msm or kirin)

    do_the_old_way

else

    do_correctly.


And remove it after fixing both dsi masters.


Regards

Andrzej


>
> thanks
> -john
>
>

