Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAB0C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A2620645
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FAoXo7J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfEVKEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:04:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59702 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfEVKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:04:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190522100437euoutp0223bcbfe26fc7541136c75ef406655ddd~g_TT7o4ab2768627686euoutp02m
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 10:04:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190522100437euoutp0223bcbfe26fc7541136c75ef406655ddd~g_TT7o4ab2768627686euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558519477;
        bh=fha/Fx6x2WdnhswPE74xM2jkxqehQxZKcmhjFF3aSc4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FAoXo7J6mzVj4rICwz1WoBjzCATt0V5WgdZx+N6MPR1ApK8syDcjaQ5a5hFtRZZgB
         C93OxcReeMn+UxIGDLPhD5jpI4dZqyRyTeUKYs0+CLPyxN1nz2WJVWGpx8gTQTz9GQ
         1UWgyI9bUIYx12jGuIEdUJBqFPIqn6U4oFNLnAvU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190522100436eucas1p1fc6e02a3132020cad281edb2f7c5c061~g_TTJEG0D2378323783eucas1p1g;
        Wed, 22 May 2019 10:04:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.57.04298.3BE15EC5; Wed, 22
        May 2019 11:04:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190522100435eucas1p24398c029079c7a58e526299687bd1e61~g_TSa7tUX3161031610eucas1p2X;
        Wed, 22 May 2019 10:04:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190522100435eusmtrp1f7461ef5592a01ba9ed0e1569e61ffa0~g_TSMwqlk0941609416eusmtrp1r;
        Wed, 22 May 2019 10:04:35 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-22-5ce51eb3e78f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.EE.04140.3BE15EC5; Wed, 22
        May 2019 11:04:35 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190522100434eusmtip184c651f0e350b704d5486e7c496a33cf~g_TRpjFZY1044210442eusmtip1P;
        Wed, 22 May 2019 10:04:34 +0000 (GMT)
Subject: Re: [PATCH] fbcon: Remove fbcon_has_exited
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Kees Cook <keescook@chromium.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6b9747cf-8845-0eb9-878e-f2953665fcec@samsung.com>
Date:   Wed, 22 May 2019 12:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521142304.9652-1-daniel.vetter@ffwll.ch>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87qb5Z7GGLTvMbdY+PAus8XyM+uY
        La58fc9m8eb4dCaL2RM2M1mc6c61eLzzJavF5V1z2CwWftzKYjH11Dt2i3c/etktzu9KdODx
        mN1wkcVj77cFLB4Les4zeyze85LJY97JQI/73ceZPN7vu8rmsb7nCKPH501yHq/3H2IM4Iri
        sklJzcksSy3St0vgyrhy7x9LQYN4xfFFM9gaGK8LdTFyckgImEhcvf6YCcQWEljBKNH8Rr+L
        kQvI/sIo0f33EQuE85lR4sq54ywwHd2b/zNDJJYzSsz4M5cdwnnLKLH42AdGkCphAWOJ3ndf
        2EFsEQEtiY7/LWCjmAV+MEvcv/ARbCGbgJXExPZVYA28AnYSe77tYgaxWQRUJQ58mgRWIyoQ
        IXH/2AZWiBpBiZMzn4CdwSlgLfHu9TqwemYBcYlbT+YzQdjyEs1bZzNDnPqXXWL3pkwI20Xi
        b/92NghbWOLV8S3sELaMxOnJPWDHSQisY5T42/GCGcLZziixfPI/qA5ricPHLwJdwQG0QVNi
        /S59iLCjxMNtp5lAwhICfBI33gpC3MAnMWnbdGaIMK9ERxs0rNUkNizbwAaztmvnSuYJjEqz
        kHw2C8k3s5B8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKe70v+OfdjB+
        vZR0iFGAg1GJh9fi4eMYIdbEsuLK3EOMEhzMSiK8p089ihHiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAaMorlh8uOsvbXvAjO29LxwzTPXe/GGce3Wr2
        IFR20itl3e9zFleUdjeW7NV70CHT7x2Tnn/y1YyczfaiP09OkknyWzI7x2tP/rU3Xmp6Ylt/
        m6TGla+ITb1SoC/9+3+WNo9Y7v8j/seE45a0bRR8fkJmnevPVI2wvWFn58Ymz9tevsOhIfin
        EktxRqKhFnNRcSIAoM++qW0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7qb5Z7GGNw6x2qx8OFdZovlZ9Yx
        W1z5+p7N4s3x6UwWsydsZrI4051r8XjnS1aLy7vmsFks/LiVxWLqqXfsFu9+9LJbnN+V6MDj
        MbvhIovH3m8LWDwW9Jxn9li85yWTx7yTgR73u48zebzfd5XNY33PEUaPz5vkPF7vP8QYwBWl
        Z1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Hl3j+W
        ggbxiuOLZrA1MF4X6mLk5JAQMJHo3vyfGcQWEljKKNG0IKaLkQMoLiNxfH0ZRImwxJ9rXWxd
        jFxAJa8ZJT7ea2AFSQgLGEv0vvvCDmKLCGhJdPxvYQEpYhb4xSyx6d8nZoiOg4wSHzofM4FU
        sQlYSUxsX8UIYvMK2Ens+bYLbDOLgKrEgU+TwGpEBSIkzrxfwQJRIyhxcuYTMJtTwFri3et1
        YPXMAuoSf+ZdgrLFJW49mc8EYctLNG+dzTyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTc
        YiO94sTc4tK8dL3k/NxNjMCY3nbs55YdjF3vgg8xCnAwKvHwPrj3OEaINbGsuDL3EKMEB7OS
        CO/pU49ihHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmG7ySuINTQ3NLSwNzY3Njc0slMR5
        OwQOxggJpCeWpGanphakFsH0MXFwSjUwqtZ6SfElSM4Q81ZicTc89UtZZKeA4Vn3f1feH7jX
        /9Y9R3HNiytf8m7WnJDcnnrv/KX21tt7X7DUbQmddMlCtEuqo0zvd/LPiglr+cw6H4T6MYf9
        M75mcMJhn35qafCDGYa3vxn5rDDqEZz3fd3SYPfi/Y0ZFpMb1kjGe/Ybhv6ZXb/qgpCAEktx
        RqKhFnNRcSIAS5uLHf8CAAA=
X-CMS-MailID: 20190522100435eucas1p24398c029079c7a58e526299687bd1e61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190521142317epcas2p44d184ead3ec7d514a8fa6784abf30747
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190521142317epcas2p44d184ead3ec7d514a8fa6784abf30747
References: <20190520082216.26273-10-daniel.vetter@ffwll.ch>
        <CGME20190521142317epcas2p44d184ead3ec7d514a8fa6784abf30747@epcas2p4.samsung.com>
        <20190521142304.9652-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel,

On 5/21/19 4:23 PM, Daniel Vetter wrote:
> This is unused code since
> 
> commit 6104c37094e729f3d4ce65797002112735d49cd1
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Tue Aug 1 17:32:07 2017 +0200
> 
>     fbcon: Make fbcon a built-time depency for fbdev
> 
> when fbcon was made a compile-time static dependency of fbdev. We
> can't exit fbcon anymore without exiting fbdev first, which only works
> if all fbdev drivers have unloaded already. Hence this is all dead
> code.
> 
> v2: I missed that fbcon_exit is also called from con_deinit stuff, and
> there fbcon_has_exited prevents double-cleanup. But we can fix that
> by properly resetting con2fb_map[] to all -1, which is used everywhere
> else to indicate "no fb_info allocate to this console". With that
> change the double-cleanup (which resulted in a module refcount underflow,
> among other things) is prevented.
> 
> Aside: con2fb_map is a signed char, so don't register more than 128 fb_info
> or hilarity will ensue.
> 
> v3: CI showed me that I still didn't fully understand what's going on
> here. The leaked references in con2fb_map have been used upon
> rebinding the fb console in fbcon_init. It worked because fbdev
> unregistering still cleaned out con2fb_map, and reset it to info_idx.
> If the last fbdev driver unregistered, then it also reset info_idx,
> and unregistered the fbcon driver.
> 
> Imo that's all a bit fragile, so let's keep the con2fb_map reset to
> -1, and in fbcon_init pick info_idx if we're starting fresh. That
> means unbinding and rebinding will cleanse the mapping, but why are
> you doing that if you want to retain the mapping, so should be fine.
> 
> Also, I think info_idx == -1 is impossible in fbcon_init - we
> unregister the fbcon in that case. So catch&warn about that.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  drivers/video/fbdev/core/fbcon.c | 39 +++++---------------------------
>  1 file changed, 6 insertions(+), 33 deletions(-)
This patch was #09/33 in your patch series, now it is independent change.

Do you want me to apply it now or should I wait for the new version of
the whole series?

[ I looked at all patches in the series and they look fine to me.
  After outstanding issues are fixed I'll be happy to apply them all
  to fbdev-for-next (I can create immutable branch if needed). ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
