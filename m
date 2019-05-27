Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E3C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDD32133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aBkH5Udg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE0K7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:59:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36146 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0K7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:59:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190527105942euoutp01a25f95b4c070268330b1e9a4ff1306b4~ihR2DmVN72436824368euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 10:59:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190527105942euoutp01a25f95b4c070268330b1e9a4ff1306b4~ihR2DmVN72436824368euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558954782;
        bh=vmoddjQAdwfgajrjwjND/Fdm1rXcy9qvQd8vjTNxPS4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aBkH5UdgElHKDGMRk0CD0ZI+ILLNuxJNsZoFac21zBKRO5nVZFsQslA+XznbIsTtD
         rHJhEFU6wfx6MAFvfFK+ltS3oqIAlLa5m74JfQNlAITYxbRHFTLfaGTK0nR0fRi8no
         RoLqCeUl5cJtXTqiZKCgvLQ9QQBplhGItf9C2wuE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190527105941eucas1p1a7d6c4eee1b1a4bc0d209195ba7c3c68~ihR1PIMxF0679606796eucas1p1b;
        Mon, 27 May 2019 10:59:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.2D.04325.D13CBEC5; Mon, 27
        May 2019 11:59:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190527105941eucas1p12ed78aa5300b3c9275e33e67a4399fc7~ihR0d2C961963919639eucas1p1x;
        Mon, 27 May 2019 10:59:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190527105940eusmtrp1db8c587aca936b183bbeeab353dfbcd2~ihR0PsEKM2396923969eusmtrp1Q;
        Mon, 27 May 2019 10:59:40 +0000 (GMT)
X-AuditID: cbfec7f5-fbbf09c0000010e5-10-5cebc31db9f8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.96.04140.C13CBEC5; Mon, 27
        May 2019 11:59:40 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190527105940eusmtip23c0a8f60802c4d3b70ae41d6701100cb~ihRzvRTRR0654906549eusmtip2F;
        Mon, 27 May 2019 10:59:40 +0000 (GMT)
Subject: Re: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Richard Purdie <rpurdie@rpsys.net>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ee90a071-74b4-e9f0-03f9-2e959c333b1f@samsung.com>
Date:   Mon, 27 May 2019 12:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHWOY97FqyJ6FU1SYTgegKxm2A+R+X6Vjs0_zn1QGN3KQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7O45NjtPyzbJiUOC9i9JJQyqDTkFk/eoi1dKTipva5jXJ
        NCTNS2hS4pRcBGkK09TUzak40xlqlplIZFpamRdm6Cq7aLqj5L/ney7v+z7wkZhkkO9EhkfG
        sMpImVxKCPG6jvleD+e2yaCdjQYXuntqSEA/+DCE0aXdWozut5gJespUwKOLcmt4dNlcoYAe
        trQjuvP2DJ9+rS8m6Eb9Jz7dq5cdEDFN3zU4o8nuxRidekjAPDR85THvBgwEM5xl4jHm5jcE
        Yyj5yWdmq7cE2pwV7g9h5eFxrNLL/6Iw7H2ZGYt+aJegudHJS0F5tpnIhgTKG1rT27FMJCQl
        VBkC7XiTYFmQUHMIjAYfTphFUNt9V7CaKNK24pxQiqBuckTAPaYRGNp/WF321DF4MTONL2MH
        yhUyFtOsCYwax6A79Qm2LBCUL+Sll6NlLKb8oaXnvhXj1HYw32mw4vXUaRjuqOJzHjt4Xjhm
        HWpDnYS01ArrHIxyhLdjJTwOb4X66WJrIaAsAigdrcS5uw9Da4FupYM9TJhqV/Bm6MrPxrmA
        FsHfjPGVdD2C0vwFgnP5QZvp1dIZ5NIKF6jUe3H0QZjM+WKlgbKFwWk77ghbuFNXgHG0GDJu
        Sjj3Dqh6VEWsrs3UPcZykVS9ppp6TR31mjrq/3s1CC9HjmysShHKqvZEsvGeKplCFRsZ6hkc
        pahGS/+ta8FkaUDNfy4ZEUUiqUgc3TsRJOHL4lSJCiMCEpM6iH1qlyhxiCzxKquMuqCMlbMq
        I9pE4lJHcdK6kXMSKlQWw0awbDSrXFV5pI1TCpJMNTfmeZTNtfSYvEM+Bwj6Liuc5bxBd+Tk
        fEg3fMVTGbW4wW9gI3E054z5mpt+W/nHZwPZFgfb8wF7jyTo3LXKIEV8ya/dnX3NoorW0RMR
        j04Fh9XsC05+KXI77jhvvFdwhHna3u/le0xo/iZMrg2IdkmypGXZy/uv36oJFP3OkuKqMNku
        V0ypkv0DQyS7tmsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7oyh1/HGFy7bGJx5s1ddouFD+8y
        Wyw/s47Z4srX92wWb45PZ7KYPWEzk8WKLzPZLe5/PcpocaLvA6vF5V1z2Cx273rKanF+V6ID
        j8febwtYPBb0nGf22DnrLrvH4j0vmTzuXNvD5nG/+ziTx/t9V9k89sz/werxeZNcAGeUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsa9Fe+ZCxYL
        VixoOsHUwDiRr4uRk0NCwERi9rqDLF2MXBxCAksZJZa8PwLkcAAlZCSOry+DqBGW+HOtiw2i
        5jWjxM9DC1hBEsICXhLnPrxlAbFFBLQkOv63gA1iFnjBLPHv7FtWiI7tTBIHTl5nB6liE7CS
        mNi+ihHE5hWwk9h/dh6YzSKgKvF+0g4wW1QgQuLM+xUsEDWCEidnPgGzOQUCJVoaVzOD2MwC
        6hJ/5l2CssUlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrF
        ibnFpXnpesn5uZsYgfG87djPLUD3vQs+xCjAwajEw1tw/lWMEGtiWXFl7iFGCQ5mJRFe0y1A
        Id6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hppq8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC
        6YklqdmpqQWpRTB9TBycUg2MDC015/zLzv2cH+XnKbpsKdOuZ/+l18XcvCZyc4r5kuYZcWJh
        FUVSd2dqZq3ecIf3kXVsf0RpUfbF1QuM1rG92vYi6tMpkSWNs0Le8ln5zQotb4orF2QpLeae
        +LX3YXiV9HJ7pfkff/i6GTFM611qJt7CNnF60yIuz+fPvTaaG7523Ce4u4VJiaU4I9FQi7mo
        OBEAdCV2KP0CAAA=
X-CMS-MailID: 20190527105941eucas1p12ed78aa5300b3c9275e33e67a4399fc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190524152910epcas2p30be74545e6e0570ea42cef8e0b5b7da4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190524152910epcas2p30be74545e6e0570ea42cef8e0b5b7da4
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
        <20190524085354.27411-25-daniel.vetter@ffwll.ch>
        <20190524131453.e6mefygqyg46jeuf@holly.lan>
        <CGME20190524152910epcas2p30be74545e6e0570ea42cef8e0b5b7da4@epcas2p3.samsung.com>
        <CAKMK7uHWOY97FqyJ6FU1SYTgegKxm2A+R+X6Vjs0_zn1QGN3KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/19 5:28 PM, Daniel Vetter wrote:
> Hi Daniel,
> 
> On Fri, May 24, 2019 at 3:14 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>>
>> On Fri, May 24, 2019 at 10:53:45AM +0200, Daniel Vetter wrote:
>>> This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.
>>>
>>> The justification is that if hw blanking fails (i.e. fbops->fb_blank)
>>> fails, then we still want to shut down the backlight. Which is exactly
>>> _not_ what fb_blank() does and so rather inconsistent if we end up
>>> with different behaviour between fbcon and direct fbdev usage. Given
>>> that the entire notifier maze is getting in the way anyway I figured
>>> it's simplest to revert this not well justified commit.
>>>
>>> v2: Add static inline to the dummy version.
>>>
>>> Cc: Richard Purdie <rpurdie@rpsys.net>
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Yisheng Xie <ysxie@foxmail.com>
>>> Cc: linux-fbdev@vger.kernel.org
>>
>> Hi Daniel
>>
>> When this goes round again could you add me to the covering letter?
>>
>> I looked at all three of the patches and no objections on my side but
>> I'm reluctant to send out acks because I'm not sure I understood the
>> wider picture well enough.
> 
> It's one of these patch series with some many different subsystems and
> people you can't cc the cover to all of them or mailing lists start
> rejecting you because too many recipients. I tried to spam sufficient
> mailng lists, but I guess not enough.

BTW Not all relevant patches were posted to linux-fbdev and me (i.e.
"[PATCH 05/33] fbdev/sa1100fb: Remove dead code") - I found them on
other mailing lists but it requires some additional work from me to
find / process them. If possible please Cc: linux-fbdev & me on all
patches in the patchset. Thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
