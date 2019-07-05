Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E180C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4A216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P5AKdrd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfGEPQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:16:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58022 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfGEPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:16:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190705151626euoutp01488ec5f4b72f14cd13fe969ace664a5c~ui8IMt3O-0131101311euoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 15:16:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190705151626euoutp01488ec5f4b72f14cd13fe969ace664a5c~ui8IMt3O-0131101311euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562339786;
        bh=MtNtGRdGYlJXyRRrGWSLm9dBjD9CzU/0eY5SDO5caDI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P5AKdrd3BOx1Hvh/1nkZcY8lx5IH28H3j888RCrTffAr2ZH9xiFnBg79yz/03sXqt
         jSkorBtH6V4mm/aSjHpK8Xzq4DME+vv/l8qRMcVnGMmRTZnqe3mb5e70K1x1H8+Rg0
         PrdoqqgHeZBYwMtJZjKwcjZ9Oj2xKZ+h7eUUazrw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190705151625eucas1p2229fd74627829fcc1d0b400988efa3e3~ui8HtvFVC0423204232eucas1p2x;
        Fri,  5 Jul 2019 15:16:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 67.5B.04298.9C96F1D5; Fri,  5
        Jul 2019 16:16:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190705151624eucas1p1cc3747c06ef51edab7a7e83a7f3ef057~ui8Gx4xEL0380803808eucas1p1b;
        Fri,  5 Jul 2019 15:16:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190705151624eusmtrp2e980ee27e8f6641c9c722f0919b648b8~ui8Gj4cbc3106131061eusmtrp2y;
        Fri,  5 Jul 2019 15:16:24 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-43-5d1f69c9fe07
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 37.77.04146.8C96F1D5; Fri,  5
        Jul 2019 16:16:24 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190705151624eusmtip1e8a679db120447f67385f93fb2bb9a39~ui8GP1GrP2671826718eusmtip17;
        Fri,  5 Jul 2019 15:16:24 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch
 fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4771baff-b157-2416-d43b-bf6d8980fbb3@samsung.com>
Date:   Fri, 5 Jul 2019 17:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625160103.GA13133@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87onM+VjDZa/lrS48vU9m8XWPaoW
        K77MZLc4051rcaLvA6vF5V1z2BzYPGY3XGTxWHdQ1WPnrLvsHve7jzN5fN4kF8AaxWWTkpqT
        WZZapG+XwJXRtewWU8EU3orjs6azNDB+4+pi5OCQEDCROHJaoYuRi0NIYAWjxKHjd1ggnC+M
        Emu2vmXvYuQEcj4zSszpNwKxQRpuHvvMBFG0nFFixv5jzBDOW0aJxa0vWEGqhAX8JVqa7jGB
        2CICRhKzZ3SzghQxg+w4fPM1G0iCTcBKYmL7KkYQm1fATuLU406wZhYBFYmZ84+DrRYViJC4
        f2wDK0SNoMTJmU9YQGxOAQOJbdc2gC1gFhCXuPVkPpQtL9G8dTYzxKmr2CXubIE620Xi7aOF
        LBC2sMSr41vYIWwZif8754O9IyGwjlHib8cLZghnO6PE8sn/2CCqrCUOH7/ICgoxZgFNifW7
        9CHCjhIHNzQyQwKST+LGW0GIG/gkJm2bDhXmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tks
        JN/MQvLNLIS9CxhZVjGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmnNP/jn/awfj1UtIh
        RgEORiUe3hNO8rFCrIllxZW5hxglOJiVRHgTg4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZ
        HkQLCaQnlqRmp6YWpBbBZJk4OKUaGGO3qJ/ZESqlIyW97ePfuGCLO3PU9ogeCtL1+n73TfIz
        i80Zy+qlpASip7S2fQ7cYmv4T+v9bIlPR+orrO5sbLRkzprU9+qMXqpOo673d8/ahdP4neXW
        TMlher65s9jk4IxKXz1+Df0Gk93nwk7eX7Oa/67tjDu7K0qW6/CJ9vTM3BddVXd5lhJLcUai
        oRZzUXEiALxjRfM1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7onMuVjDT5+lrW48vU9m8XWPaoW
        K77MZLc4051rcaLvA6vF5V1z2BzYPGY3XGTxWHdQ1WPnrLvsHve7jzN5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRtewWU8EU3orj
        s6azNDB+4+pi5OSQEDCRuHnsM1MXIxeHkMBSRokru/ewdTFyACVkJI6vL4OoEZb4c62LDaLm
        NaNE15cb7CAJYQFfiZkN35hBbBEBI4nZM7pZQYqYBVYwSixb95kVoqOZUeLRi4NgVWwCVhIT
        21cxgti8AnYSpx53soLYLAIqEjPnHwebKioQIXHm/QoWiBpBiZMzn4DZnAIGEtuubWACsZkF
        1CX+zLvEDGGLS9x6Mh8qLi/RvHU28wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWK
        E3OLS/PS9ZLzczcxAuNs27Gfm3cwXtoYfIhRgINRiYf3hJN8rBBrYllxZe4hRgkOZiUR3sQg
        oBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NAXkm8oamhuYWlobmxubGZhZI4b4fAwRgh
        gfTEktTs1NSC1CKYPiYOTqkGxqoYNt8zzB0/lopu5l0u/cXXfjfXw5fmzaqRxh9+TS+eKCO8
        XNTMdbNh+Qfhe5IPJv89krnN6KhSyytu1t039s9r/vXMOqzh9yLLgNOxRzd//tfcNeW0XsDW
        RnVBIQ4Nv80OJ1QEBMMNnzG5JAXuW2k47e2SJZ3W3SEfFO06zzJolzE+PzFltxJLcUaioRZz
        UXEiAEIxPL/JAgAA
X-CMS-MailID: 20190705151624eucas1p1cc3747c06ef51edab7a7e83a7f3ef057
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625160111epcas3p162f3d789c6219e679d9fd30c6a6b3d51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625160111epcas3p162f3d789c6219e679d9fd30c6a6b3d51
References: <CGME20190625160111epcas3p162f3d789c6219e679d9fd30c6a6b3d51@epcas3p1.samsung.com>
        <20190625160103.GA13133@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:01 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_blank’:
> drivers/video/fbdev/s3c-fb.c:811:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    sfb->enabled &= ~(1 << index);
>    ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> drivers/video/fbdev/s3c-fb.c:814:2: note: here
>   case FB_BLANK_NORMAL:
>   ^~~~
>   LD [M]  drivers/staging/greybus/gb-light.o
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp10b.o
> drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_check_var’:
> drivers/video/fbdev/s3c-fb.c:286:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    var->transp.length = 1;
>    ~~~~~~~~~~~~~~~~~~~^~~
> drivers/video/fbdev/s3c-fb.c:288:2: note: here
>   case 18:
>   ^~~~
> drivers/video/fbdev/s3c-fb.c:314:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    var->transp.offset = 24;
>    ~~~~~~~~~~~~~~~~~~~^~~~
> drivers/video/fbdev/s3c-fb.c:316:2: note: here
>   case 24:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comments are modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
