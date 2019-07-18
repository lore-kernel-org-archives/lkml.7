Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA9C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564A12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hTEl5gPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390658AbfGRO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:56:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60530 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:56:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718145558euoutp02b916395886e575e85e364e1700923690~yiC_bS8ZT1224712247euoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:55:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718145558euoutp02b916395886e575e85e364e1700923690~yiC_bS8ZT1224712247euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563461758;
        bh=BWVW0fKTFihsP0lM43tVLHndB+z6WqLVgsWkRd4FhEM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hTEl5gPJFS8KPlF28walMtHkRYMldjDqLXaC94OnkYQaKKNyeTlGxX5EADnRHCB3u
         bjUPOi4ePV6c15r/tSiLCmsa8b3nfipf7oA6NnNsZl04iIsiARR9lOYpavSgCzqVBD
         n3ATy9iHi2mNKWnwiRZMfA1andWJkHpH3Z7I9md0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718145557eucas1p110f12b7f20e86ba9ffa81dbf6ccb2f3b~yiC9vjnAF1109211092eucas1p1E;
        Thu, 18 Jul 2019 14:55:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AD.B8.04298.D78803D5; Thu, 18
        Jul 2019 15:55:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718145557eucas1p15a48800d76400fa564f5e153212c010d~yiC9IKDYm1366213662eucas1p1I;
        Thu, 18 Jul 2019 14:55:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718145557eusmtrp2f5d1c3349bcbf8d88cb3306d5f7c67fe~yiC86EM231858018580eusmtrp2k;
        Thu, 18 Jul 2019 14:55:57 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-66-5d30887d22fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.79.04140.C78803D5; Thu, 18
        Jul 2019 15:55:57 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718145556eusmtip29fbe69b16a5dbc623a31d5527f3093e7~yiC8cM-g63238732387eusmtip2A;
        Thu, 18 Jul 2019 14:55:56 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <7da08013-5ee0-1c39-e16b-8b6843a28381@samsung.com>
Date:   Thu, 18 Jul 2019 16:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87q1HQaxBhfOa1v0njvJZPF30jF2
        i//bJjJbHF70gtHiytf3bBadE5ewW1zeNYfN4sW9t0wWdycfYXTg9Pj9axKjx95vC1g8ds66
        y+4xu2Mmq8eUTgmP7d8esHrc7z7O5HF81y12j8+b5AI4o7hsUlJzMstSi/TtErgyfnxtZCtY
        yFPxa8Nv5gbGiVxdjBwcEgImEkdeyHYxcnEICaxglHj8bQ4jhPOFUeLp0RPsEM5nRonWgxtY
        YTqmnTeGiC9nlFg5q4kJwnnLKLHu9l6gdk4OYQFziV2zH7GC2CICihJTXzxjBiliFnjHJPFm
        UhcTSIJNQFPi7+abbCA2r4CdRPP332BxFgFViZU3P4HFRQXCJH4u6ISqEZQ4OfMJC4jNKRAo
        cevSerAFzALyEtvfzmGGsMUlbj2ZD3aRhMAjdompd+eBXSQh4CKx7fVhNghbWOLV8S3sELaM
        xP+d85kg7HqJ+ytamCGaOxgltm7YyQyRsJY4fPwi2P/MQFev36UPEXaUOHt3DQskWPgkbrwV
        hLiBT2LStunMEGFeiY42IYhqRYn7Z7dCDRSXWHrhK9sERqVZSD6bheSbWUi+mYWwdwEjyypG
        8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzA5HX63/FPOxi/Xko6xCjAwajEwxuQaxArxJpY
        VlyZe4hRgoNZSYT39kv9WCHelMTKqtSi/Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtS
        i2CyTBycUg2MojoPd2qdNHnNU9i/TvA9u3bl4/fb+/frLm3lN1p0mevc+pfTp32R074scuLB
        z4MlwvEigWf/n2m9dcRP9GqqnZOu/oR4K9OZe9KzOpcsTgqUObF6DUvyCqbJVlvYhKbIBgln
        aS+pb7k7NUI6YlXKsSm9ATdOf3edev6G3zf/oB3yNsq3Vlb8UGIpzkg01GIuKk4EABhnH5Za
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7q1HQaxBn0GFr3nTjJZ/J10jN3i
        /7aJzBaHF71gtLjy9T2bRefEJewWl3fNYbN4ce8tk8XdyUcYHTg9fv+axOix99sCFo+ds+6y
        e8zumMnqMaVTwmP7twesHve7jzN5HN91i93j8ya5AM4oPZui/NKSVIWM/OISW6VoQwsjPUNL
        Cz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwfXxvZChbyVPza8Ju5gXEiVxcjB4eEgInE
        tPPGXYxcHEICSxklDrxuYexi5ASKi0vsnv+WGcIWlvhzrYsNxBYSeM0ocXunKYgtLGAusWv2
        I1YQW0RAUWLqi2fMIIOYBd4xSZzcO50ZYmoLk8Shqe1gU9kENCX+br4JNolXwE6i+ftvJhCb
        RUBVYuXNT2wgF4kKhEkcPZEHUSIocXLmExYQm1MgUOLWpfVgy5gF1CX+zLvEDGHLS2x/OwfK
        Fpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN1
        27GfW3Ywdr0LPsQowMGoxMMbkGsQK8SaWFZcmXuIUYKDWUmE9/ZL/Vgh3pTEyqrUovz4otKc
        1OJDjKZAv01klhJNzgemkbySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1M
        HJxSDYwbpSptbmiq8VX9ed877+LmYJmZp3VfWurah++eVVn1//kzBsuO8z4nN+27839it17c
        /niDTc7ikR5R8qevl7A9OuM0PXzPnofWbQUTT8X9S14+N42fa0LfDq3l2e942jcnfyzlir82
        vfZjZVb0sV7d3iUGuz78qU6N3FrxPXD2/Hk/z8UcWThDiaU4I9FQi7moOBEAqD0GN+sCAAA=
X-CMS-MailID: 20190718145557eucas1p15a48800d76400fa564f5e153212c010d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
        <20190718134240.2265724-1-arnd@arndb.de>
        <ea59751e-7391-e3e9-bb46-00e86b25f1a8@samsung.com>
        <CAK8P3a0q5xmi+mCvb1ET4d1uQmbnw+J2VkjRCzjemCXGy+5OBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2019 16:21, Arnd Bergmann wrote:
> On Thu, Jul 18, 2019 at 4:16 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Hi Arnd,
>>
>> On 18.07.2019 15:42, Arnd Bergmann wrote:
>>> Using 'imply' causes a new problem, as it allows the case of
>>> CONFIG_INPUT=m with RC_CORE=y, which fails to link:
>>>
>>> drivers/media/rc/rc-main.o: In function `ir_do_keyup':
>>> rc-main.c:(.text+0x2b4): undefined reference to `input_event'
>>> drivers/media/rc/rc-main.o: In function `rc_repeat':
>>> rc-main.c:(.text+0x350): undefined reference to `input_event'
>>> drivers/media/rc/rc-main.o: In function `rc_allocate_device':
>>> rc-main.c:(.text+0x90c): undefined reference to `input_allocate_device'
>>>
>>> Add a 'depends on' that allows building both with and without
>>> CONFIG_RC_CORE, but disallows combinations that don't link.
>>>
>>> Fixes: 5023cf32210d ("drm/bridge: make remote control optional")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Proper solution has been already merged via input tree[1].
>>
>>
>> [1]:
>> https://lore.kernel.org/lkml/CAKdAkRTGXNbUsuKASNGLfwUwC7Asod9K5baYLPWPU7EX-42-yA@mail.gmail.com/
> At that link, I only see the patch that caused the regression, not
> the solution. Are you sure it's fixed?


Ups, you are right, I though you are fixing what this patch attempted to
fix :)

Anyway, we want to avoid dependency on RC_CORE - this driver does not
require it, but with RC_CORE it has additional features.

Maybe "imply INPUT" would help?


Regards

Andrzej


>
>       Arnd
>

