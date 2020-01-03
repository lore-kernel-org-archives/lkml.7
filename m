Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59569C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1586C222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AuceKUmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgACNHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:07:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40301 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgACNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:07:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103130718euoutp0256316ce3142f734f52e6af3d0dc6977e~mYlWAIQmf2102421024euoutp02V
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 13:07:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103130718euoutp0256316ce3142f734f52e6af3d0dc6977e~mYlWAIQmf2102421024euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578056838;
        bh=zDdH4NrkEQ5yIXja9XqlAOcAHDuIOVYWY5pN6f9uf1o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AuceKUmDHf97e4ESKeRAuy19z2IVSgtlq5pghCTR4tdXeecE0pm5D4Q35fAhlFrmJ
         RrZqjnP0RocevFmmhM/dtw4cfGwxDFC2oytILgg5D6fLeVz7bKRMpv8vcRe7w1i5ke
         IeJi6cP/WmSsEdUov+gsVbAE+Cay5ctoG3KVuQys=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200103130718eucas1p2cfef288ae36a773db4e0c9e9321dcbfd~mYlVcfDzl3117531175eucas1p2C;
        Fri,  3 Jan 2020 13:07:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.CA.60679.68C3F0E5; Fri,  3
        Jan 2020 13:07:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103130717eucas1p1707a5a61c3ae7df3233649d7e9e0abe3~mYlVNOJcZ0209102091eucas1p1K;
        Fri,  3 Jan 2020 13:07:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103130717eusmtrp133ec518ebccb9c2cf93b921f1882290a~mYlVMdYl32758327583eusmtrp14;
        Fri,  3 Jan 2020 13:07:17 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-52-5e0f3c869f26
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.87.07950.58C3F0E5; Fri,  3
        Jan 2020 13:07:17 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103130717eusmtip1131e069ace366b89333b9139649af04d~mYlUZSZFU0169601696eusmtip1g;
        Fri,  3 Jan 2020 13:07:17 +0000 (GMT)
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Peter Rosin <peda@axentia.se>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        security@kernel.org, Kees Cook <keescook@chromium.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
Date:   Fri, 3 Jan 2020 14:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhhjjryk.fsf@x220.int.ebiederm.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRz27X3vvbfL1bcru48YdszG8quMF80w5jUz+kOskV56lx/d1e7t
        B/0Vo3JupkJz1yjSj8NJVC6u2VlSmWZIjhRiRXH6Remi13tN/3z3fJ7P8+x5PtuXJlTHqCD6
        gC6R1+u4OA2lICsfDTUtSA/zi1qc5VIwX0dzSabgfSvBvBj4TjF/Ko/LGXPbR5Ipam9EzJNT
        WqbCOY357KwnmMenXTLmeXUexRT8qCAZu+MSYi4+fEUxJUMViHnpzkRrMHv+gVnOmtOekax9
        MJ9kbaZWOVtuOUmxF+vDWfudg2zbqTov9scnJ8n2W5oJtvD8S4r9XjP29JXPYM86MshtvpGK
        sBg+7kAyr1+0Olqx3+p8QyR0Bhy2Xe8g0tAvPwPypgEvhYbcbtKAFLQKlyA4mnFSLg39CGzZ
        5yhp6ENQ0DQoG7cMu8weSzGC0pYSj6UHgcn8B4mqALwRTl8u+ocD8TYYqj0hE0UEdhNgbSsm
        xQWFV0JWhuWfSIlXQ+lwn5eISTwHupvfUSKegndCb/tDmaTxh/oLHWNemvbGodCSvlykCawG
        Z8clLwnPhKqePELMAnyDhuHGBkqqvR5qu6VygAPgS90duYSnQ2OOkZQMVgTuzE6PuwpBcc6o
        x70K3j4dpsRkAs+Dm9WLJHotXLl7hhBpwL7Q0uMvlfCF7MpcD62EzHSVpJ4LZUVl1HiswVZK
        nEEa04TLTBPOMU04x/Q/Nx+RFqTmkwRtLC+E6PiUhQKnFZJ0sQv3xWvL0djPbByt67+Lqkf2
        OhCmkWayMnq2X5RKxiULR7QOBDShCVSmhCujVMoY7kgqr4/fo0+K4wUHmkaTGrUy9HLXbhWO
        5RL5QzyfwOvHt160d1AaygYfY6hb19N5zYduzYrJ+blAMRL0zB4c0duZuoM95t8VuSyYaxbu
        915dcb+pokE5YAxwb9jS9nPd0ggwRasTtqs3tu7aUmiPjSl8zf2+3f4icOqh4FTjra2bIi0z
        glzJVa+sHww1po+6c49sEfkHayfl9c/SLgkxfNtszL9X05upIYX93JL5hF7g/gJwGHZMlQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsVy+t/xu7qtNvxxBu3njS1e/5vOYrHw4V1m
        iytf37NZ/N/Wwm4x+/5jFotlD04zWpzpzrXYekva4tmtk8wWJ/o+sFpc3jWHzWLhx60sFnsP
        zWe0mHf4OpvFip9bGS2u/u1gdBDwmHZgNrvH7IaLLB57vy1g8dg56y67x6ZVnWwe804Geuzd
        kuVxv/s4k8fHp7dYPL6susbssWTaVTaP9/uAxOdNch5TDrWzBPBF6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWsu3WbueCFcMXONU+YGxh/8Hcx
        cnJICJhI/Powm6WLkYtDSGApo0TLholADgdQQkbi+PoyiBphiT/Xutggal4zSlxZdoUZJCEs
        4C7Rt2gZI4gtIuAncf7nYTCbWeA/s0Tz1nqIhhWMEl9Pv2IBSbAJWElMbF8FVsQrYCex8tdn
        JhCbRUBF4s21e2wgtqhAhMThHbOgagQlTs58AnYQp4CxxI02c4j56hJ/5l1ihrDFJW49mc8E
        YctLbH87h3kCo9AsJN2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHp
        Yduxn1t2MHa9Cz7EKMDBqMTDy6HIHyfEmlhWXJl7iFGCg1lJhLc8kDdOiDclsbIqtSg/vqg0
        J7X4EKMp0G8TmaVEk/OBqSuvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwf
        EwenVAOjLtO0LZfzOzr3fXka2XiWr/ZR/61Ur6xjDZs+RNv9S4qo3n5gsf0mIWmZTWtd9lQU
        FuQvsczKehojxf1o9cWKzQ9Zzz8+mbW4PfKA3EyZlIrnXK8iddKic89lKZy/dmA3Y2aBl92v
        y7HpovuVQ9LXxKSsvLpY+oyJDNdi85OP539w1LXXFDJSYinOSDTUYi4qTgQAauMwRSUDAAA=
X-CMS-MailID: 20200103130717eucas1p1707a5a61c3ae7df3233649d7e9e0abe3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e
References: <20191029182320.GA17569@mwanda>
        <CGME20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e@epcas3p4.samsung.com>
        <87zhhjjryk.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/29/19 8:02 PM, Eric W. Biederman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
>> The "fix" struct has a 2 byte hole after ->ywrapstep and the
>> "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
>> on the compiler.
>>
>> Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> I have 13 more similar places to patch...  I'm not totally sure I
>> understand all the issues involved.
> 
> What I have done in a similar situation with struct siginfo, is that
> where the structure first appears I have initialized it with memset,
> and then field by field.
> 
> Then when the structure is copied I copy the structure with memcpy.
> 
> That ensures all of the bytes in the original structure are initialized
> and that all of the bytes are copied.
> 
> The goal is to avoid memory that has values of the previous users of
> that memory region from leaking to userspace.  Which depending on who
> the previous user of that memory region is could tell userspace
> information about what the kernel is doing that it should not be allowed
> to find out.
> 
> I tried to trace through where "info" and thus presumably "info->fix" is
> coming from and only made it as far as  register_framebuffer.  Given

"info" (and thus "info->fix") comes from framebuffer_alloc() (which is
called by fbdev device drivers prior to registering "info" with
register_framebuffer()). framebuffer_alloc() does kzalloc() on "info".

Therefore shouldn't memcpy() (as suggested by Jeo Perches) be enough?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> that I suspect a local memset, and then a field by field copy right
> before copy_to_user might be a sound solution.  But ick.  That is a lot
> of fields to copy.
> 
> 
> Eric
> 
> 
> 
>>  drivers/video/fbdev/core/fbmem.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index 6f6fc785b545..b4ce6a28aed9 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1109,6 +1109,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>>  			ret = -EFAULT;
>>  		break;
>>  	case FBIOGET_FSCREENINFO:
>> +		memset(&fix, 0, sizeof(fix));
>>  		lock_fb_info(info);
>>  		fix = info->fix;
>>  		if (info->flags & FBINFO_HIDE_SMEM_START)
