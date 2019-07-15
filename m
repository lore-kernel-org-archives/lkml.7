Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E9FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D2C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LdXEgd4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfGOLfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:35:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35232 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfGOLfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:35:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190715113500euoutp0145b6f766a1d8bbcfa94bfb402d884afe~xkXpFUnPC3235732357euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:35:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190715113500euoutp0145b6f766a1d8bbcfa94bfb402d884afe~xkXpFUnPC3235732357euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563190500;
        bh=MIukH0El9tJcqtJbIIQFsKMKpIMhv4HEJMktrHZYBsk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LdXEgd4hMqP1S4WLWQeNEwAc7lamXzzu+4mwEAOY/xF3YzxUcaiUuW9tbW+LAzdIy
         +yiGzgLTU4sV/sDVKVp9g5nI8ziJ+ZxmHhodbX+orzh411Ti+QjW3dNLOv+RofdcbE
         TMqqyyT6qdoYGGYRp7Ri0xqjWycU7LtDbZY49xAE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715113459eucas1p15f693e2320dbbd2bcf775538ef550176~xkXoskwew1822918229eucas1p1V;
        Mon, 15 Jul 2019 11:34:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 97.09.04377.3E46C2D5; Mon, 15
        Jul 2019 12:34:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715113458eucas1p16ced6c5303d28fa77c232dac8aa8979c~xkXn9ZaLM3249932499eucas1p1D;
        Mon, 15 Jul 2019 11:34:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190715113458eusmtrp20da04edc4180399cab77519238696a28~xkXnvWuL41624216242eusmtrp2x;
        Mon, 15 Jul 2019 11:34:58 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-9b-5d2c64e3cc8e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.77.04146.2E46C2D5; Mon, 15
        Jul 2019 12:34:58 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190715113458eusmtip1daaf872522432a32f452cf1b288ac30b~xkXncM0NI0034400344eusmtip1B;
        Mon, 15 Jul 2019 11:34:58 +0000 (GMT)
Subject: Re: [PATCH] video: radeon.h Fix Shifting signed 32 bit value by 31
 bits problem
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <46c5dc00-eb00-e229-62af-6e171f9f2a40@samsung.com>
Date:   Mon, 15 Jul 2019 13:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190706184111.GA13070@t-1000>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7qPU3RiDVZuF7W48vU9m0XX4xcs
        Fpd3zWGzmL1lHrvF3unLWB1YPXbOusvusX/uGnaP+93HmTx+/5jM6PF5k1wAaxSXTUpqTmZZ
        apG+XQJXxtwnL9gL/nJXTLs/i7GBcS5nFyMnh4SAicT2NadYuxi5OIQEVjBK3G34zALhfGGU
        OLv/FROE85lRYvXjVawwLX135jFDJJYzSnSvWgpV9ZZR4t+if0wgVcICURKLn0wG6xAR0JN4
        cmoTmM0s0Mcose5jCojNJmAlMbF9FSOIzStgJ9G/5yQbiM0ioCpxYtUMFhBbVCBC4v6xDawQ
        NYISJ2c+AYtzCuhInP9+AmqmuMStJ/OZIGx5ie1v54BdJyGwil3i0p0HbBBnu0jcb17NCGEL
        S7w6voUdwpaR+L9zPhNEwzpGib8dL6C6tzNKLJ/8D6rbWuLw8YtA6ziAVmhKrN+lDxF2lFh/
        fj8jSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZJzAqzULy2iwk78xC
        8s4shL0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKac0/+Of9nBuOtP0iFGAQ5G
        JR5ehxTtWCHWxLLiytxDjBIczEoivLZfgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJ
        pCeWpGanphakFsFkmTg4pRoY2xK2PJpQe9pu1ocJSzvUls53Xj93TRDXk7qUIpc1l2a0m8oX
        P5vWxj0vIaXG/nJznlDrv7bdK1Z4T9g386Jn9IPNIp8PnJst/ezXaYHIKZYVV+ey58haba1W
        N956U/of0zTdvbs1kvnznt0zt3Wrqp3IEXjANaFJmOm39/PKp6fPXl3yzvhomRJLcUaioRZz
        UXEiAKG5rUk1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7qPUnRiDfZdVbC48vU9m0XX4xcs
        Fpd3zWGzmL1lHrvF3unLWB1YPXbOusvusX/uGnaP+93HmTx+/5jM6PF5k1wAa5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextwnL9gL/nJXTLs/
        i7GBcS5nFyMnh4SAiUTfnXnMXYxcHEICSxkldm2Zz9rFyAGUkJE4vr4MokZY4s+1LjaImteM
        Eq3X7rKDJIQFoiQWP5nMCmKLCOhJPDm1CcwWEqiXePnnMitIA7NAH6PEoZ1L2UASbAJWEhPb
        VzGC2LwCdhL9e06CxVkEVCVOrJrBAmKLCkRInHm/ggWiRlDi5MwnYDangI7E+e8nwBYwC6hL
        /Jl3iRnCFpe49WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn
        5haX5qXrJefnbmIERti2Yz8372C8tDH4EKMAB6MSD69DinasEGtiWXFl7iFGCQ5mJRFe269A
        Id6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HRn9eSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
        9MSS1OzU1ILUIpg+Jg5OqQZGzkwBaeHZHnwuG5dwuz6e/XHlbclUNWemAw3Tnmr4+tVvnryL
        o7H0+mrevwsef8466NJ0928/26Zn56c4hx96/yPsWvy2da/1Kl/Ei/94HMV91Efsx/Yc+buz
        n/wX+bmx+5yvigbbX/EPuR5beiIlPuwP+uKfa3f+0yqV//eOaa8qmWrW4/7NTImlOCPRUIu5
        qDgRAJtg/vvGAgAA
X-CMS-MailID: 20190715113458eucas1p16ced6c5303d28fa77c232dac8aa8979c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190706184121epcas2p3e9f8717c9e809f7756b1dfa4665ce1c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190706184121epcas2p3e9f8717c9e809f7756b1dfa4665ce1c2
References: <CGME20190706184121epcas2p3e9f8717c9e809f7756b1dfa4665ce1c2@epcas2p3.samsung.com>
        <20190706184111.GA13070@t-1000>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/19 8:41 PM, Shobhit Kukreti wrote:
> Fix RB2D_DC_BUSY and HORZ_AUTO_RATIO_INC defines to use "U" cast to
> avoid shifting signed 32 bit values by 31 bit problem. This is not a
> problem for gcc built kernel.
> 
> However, the header file being a public api, other compilers may not
> handle the condition safely resulting in undefined behavior.
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

While you are at it please convert radeon.h to use BIT() macro.

> ---
>  include/video/radeon.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/video/radeon.h b/include/video/radeon.h
> index 005eae1..cb0a5f6 100644
> --- a/include/video/radeon.h
> +++ b/include/video/radeon.h
> @@ -531,7 +531,7 @@
>  #define RB2D_DC_FLUSH_2D			   (1 << 0)
>  #define RB2D_DC_FREE_2D				   (1 << 2)
>  #define RB2D_DC_FLUSH_ALL			   (RB2D_DC_FLUSH_2D | RB2D_DC_FREE_2D)
> -#define RB2D_DC_BUSY				   (1 << 31)
> +#define RB2D_DC_BUSY				   (1U << 31)
>  
>  /* DSTCACHE_MODE bits constants */
>  #define RB2D_DC_AUTOFLUSH_ENABLE                   (1 << 8)
> @@ -672,7 +672,7 @@
>  #define HORZ_STRETCH_ENABLE			   (1 << 25)
>  #define HORZ_AUTO_RATIO				   (1 << 27)
>  #define HORZ_FP_LOOP_STRETCH			   (0x7 << 28)
> -#define HORZ_AUTO_RATIO_INC			   (1 << 31)
> +#define HORZ_AUTO_RATIO_INC			   (1U << 31)
>  
>  
>  /* FP_VERT_STRETCH bit constants */

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
