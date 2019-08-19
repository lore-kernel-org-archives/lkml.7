Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927020651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C9fEQk77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfHSOeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:34:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54944 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHSOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:34:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190819143402euoutp02d3f7a772905ed6721dcaee0809c2858d~8WY9jd8Jc1876818768euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:34:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190819143402euoutp02d3f7a772905ed6721dcaee0809c2858d~8WY9jd8Jc1876818768euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566225242;
        bh=7K+UU79oq6nFe0po5DkVy0Gje7sdK3LBbSKWF/5wqUs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C9fEQk77lf9I4zoi0mcu5nFV5yaiWC2/X2BQqCQ2omveO3SVQNoLjXkabEi5xSQm9
         q6zMktkaV5jln5nAxfgBWuDyatoD4WwMeOKTov36uA4I8fE5MI9mffjqekNhrKGXeF
         8kB3TNjF9B1m1enGcUsRf+hESWrWpSJA1KH8tph8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190819143401eucas1p2b244a28ed16ca9d0116d62ba9871dd2a~8WY8mRHth1167611676eucas1p2N;
        Mon, 19 Aug 2019 14:34:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 57.28.04374.953BA5D5; Mon, 19
        Aug 2019 15:34:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190819143400eucas1p16aca480c54035284fd19536216226493~8WY7zCD8x3251132511eucas1p1g;
        Mon, 19 Aug 2019 14:34:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819143400eusmtrp21967ebe44c87c0d7abf96d4fe3c75226~8WY7kR8Ce1418314183eusmtrp2g;
        Mon, 19 Aug 2019 14:34:00 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-65-5d5ab35947c1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.37.04166.853BA5D5; Mon, 19
        Aug 2019 15:34:00 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819143400eusmtip1f94a5d2512217a6e9d131a3fe2e8a8fb~8WY7Ry0Eh2211722117eusmtip1v;
        Mon, 19 Aug 2019 14:34:00 +0000 (GMT)
Subject: Re: [PATCH v2] video: radeon.h Fix Shifting signed 32 bit value by
 31 bits problem
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <85b130de-4e1b-3004-ae5a-3cda5d732bcb@samsung.com>
Date:   Mon, 19 Aug 2019 16:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1563758072-898-1-git-send-email-shobhitkukreti@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7qRm6NiDV4clbO48vU9m0XX4xcs
        Fpd3zWGzmL1lHrvF3unLWB1YPXbOusvusX/uGnaP+93HmTx+/5jM6PF5k1wAaxSXTUpqTmZZ
        apG+XQJXxp0lbUwF1xUqjpyIaGD8K9nFyMkhIWAi0X65gbmLkYtDSGAFo8S3L8ehnC+MEuvm
        bmSEcD4zSpxa0MAI07Jy5k6oxHJGic272lkgnLeMEm8fzmEBqRIWiJU42vwYzBYR0JN4cmoT
        K4jNLNAHNPdjCojNJmAlMbF9FdhUXgE7iQkftjKB2CwCqhJti8+yg9iiAhES949tYIWoEZQ4
        OfMJ2ExOAXeJ9u0v2CBmikvcejKfCcKWl9j+dg7YDxICq9glFj1pYoc420ViV+sNKFtY4tXx
        LVC2jMT/nSDNIA3rGCX+dryA6t7OKLF88j82iCpricPHLwKdwQG0QlNi/S59EFNCwFFi4ywJ
        CJNP4sZbQYgb+CQmbZvODBHmlehoE4KYoSaxYdkGNpitXTtXMk9gVJqF5LNZSL6ZheSbWQhr
        FzCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMN6f/Hf+6g3Hfn6RDjAIcjEo8vB7T
        omKFWBPLiitzDzFKcDArifBWzAEK8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKa
        nZpakFoEk2Xi4JRqYHRRXp/7bIlIKftzB2YvX6lFJu82fmB8IPhpnfQZN6XXjzRL5Wty9oev
        0hN9XsL9VTN/ps/H24nXC7dZcvt9iuUTUUr6d8upQptb69zBC7+/Jv+5t3idtf9Rt0k3uZ6d
        fm39gc1Fb+qqmnOLwiqMZm7YeWbjwyK3XQfc+ZYf3pf/e+Ful42uf3mUWIozEg21mIuKEwEh
        6uo+MwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7oRm6NiDQ7+VrO48vU9m0XX4xcs
        Fpd3zWGzmL1lHrvF3unLWB1YPXbOusvusX/uGnaP+93HmTx+/5jM6PF5k1wAa5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexp0lbUwF1xUqjpyI
        aGD8K9nFyMkhIWAisXLmTsYuRi4OIYGljBKf7n5j7mLkAErISBxfXwZRIyzx51oXG0TNa0aJ
        cxsXM4EkhAViJZZ83s8MYosI6Ek8ObWJFaSIWaCPUeLQzqVQHecZJY58/AFWxSZgJTGxfRUj
        iM0rYCcx4cNWsEksAqoSbYvPsoPYogIREmfer2CBqBGUODnzCZjNKeAu0b79BRuIzSygLvFn
        3iVmCFtc4taT+UwQtrzE9rdzmCcwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhb
        XJqXrpecn7uJERhh24793LyD8dLG4EOMAhyMSjy8HtOiYoVYE8uKK3MPMUpwMCuJ8FbMAQrx
        piRWVqUW5ccXleakFh9iNAV6biKzlGhyPjD680riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MEbf2pWifzRvso9JwfxdBy/+3mslmckkwF928N4n8cAFjkXGx/M4
        Zn0Km1DtK7XS+HNY2+U/W0v/LtcJ/7v1qn6FybrjHgdfiv0+Lnbt7WqzabUqpeHyfNNdXhp/
        7Y38rxP6eb3OzQ37VHvnN4u+uG2RVPKfe9mtD4IX9j7buKrP1WLO5Iq1Km+UWIozEg21mIuK
        EwFlCYaExgIAAA==
X-CMS-MailID: 20190819143400eucas1p16aca480c54035284fd19536216226493
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722011449epcas2p1ddef0d4a3bc2d39d9d99c9a8e9c10dc7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722011449epcas2p1ddef0d4a3bc2d39d9d99c9a8e9c10dc7
References: <46c5dc00-eb00-e229-62af-6e171f9f2a40@samsung.com>
        <CGME20190722011449epcas2p1ddef0d4a3bc2d39d9d99c9a8e9c10dc7@epcas2p1.samsung.com>
        <1563758072-898-1-git-send-email-shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 7/22/19 3:14 AM, Shobhit Kukreti wrote:
> Fix RB2D_DC_BUSY and HORZ_AUTO_RATIO_INC defines to use "U" cast to
> avoid shifting signed 32 bit values by 31 bit problem. This is not a
> problem for gcc built kernel.
> 
> However, the header file being a public api, other compilers may not
> handle the condition safely resulting in undefined behavior.
> 
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
> ---
> Changes in v2:
> 	Replace bit shift operations with BIT() macro

1. Please update the patch summary & description to reflect that,
please see commit 13990cf8a180 for the reference:

commit 13990cf8a180cc070f0b1266140e799db8754289
Author: Amol Surati <suratiamol@gmail.com>
Date:   Sun Jul 7 14:27:29 2019 +0530

    ide: use BIT() macro for defining bit-flags
    
    The BIT() macro is available for defining the required bit-flags.
    
    Since it operates on an unsigned value and expands to an unsigned result,
    using it, instead of an expression like (1 << x), also fixes the problem
    of shifting a signed 32-bit value by 31 bits (e.g. 1 << 31).
    
    Signed-off-by: Amol Surati <suratiamol@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


2. Please use ./scripts/checkpatch.pl to check your patch and fix issue
reported by the script:

WARNING: please, no space before tabs
#147: FILE: include/video/radeon.h:458:
+#define FORCEON_MCLKB         ^I^I   ^I   BIT(17)$

WARNING: please, no space before tabs
#148: FILE: include/video/radeon.h:459:
+#define FORCEON_YCLKA         ^I    ^I   ^I   BIT(18)$

WARNING: please, no space before tabs
#149: FILE: include/video/radeon.h:460:
+#define FORCEON_YCLKB         ^I^I   ^I   BIT(19)$

WARNING: please, no space before tabs
#150: FILE: include/video/radeon.h:461:
+#define FORCEON_MC            ^I^I   ^I   BIT(20)$

WARNING: please, no space before tabs
#151: FILE: include/video/radeon.h:462:
+#define FORCEON_AIC           ^I^I   ^I   BIT(21)$

WARNING: please, no space before tabs
#219: FILE: include/video/radeon.h:544:
+#define CRTC_BYPASS_LUT_EN     ^I^I^I   BIT(14)$

WARNING: please, no space before tabs
#220: FILE: include/video/radeon.h:545:
+#define CRTC_EXT_DISP_EN      ^I^I^I   BIT(24)$

WARNING: please, no space before tabs
#453: FILE: include/video/radeon.h:740:
+#define SOFT_RESET_CP           ^I^I   BIT(0)$

WARNING: please, no space before tabs
#454: FILE: include/video/radeon.h:741:
+#define SOFT_RESET_HI           ^I^I   BIT(1)$

WARNING: please, no space before tabs
#455: FILE: include/video/radeon.h:742:
+#define SOFT_RESET_SE           ^I^I   BIT(2)$

WARNING: please, no space before tabs
#456: FILE: include/video/radeon.h:743:
+#define SOFT_RESET_RE           ^I^I   BIT(3)$

WARNING: please, no space before tabs
#457: FILE: include/video/radeon.h:744:
+#define SOFT_RESET_PP           ^I^I   BIT(4)$

WARNING: please, no space before tabs
#458: FILE: include/video/radeon.h:745:
+#define SOFT_RESET_E2           ^I^I   BIT(5)$

WARNING: please, no space before tabs
#459: FILE: include/video/radeon.h:746:
+#define SOFT_RESET_RB           ^I^I   BIT(6)$

WARNING: please, no space before tabs
#460: FILE: include/video/radeon.h:747:
+#define SOFT_RESET_HDP          ^I^I   BIT(7)$

WARNING: please, no space before tabs
#496: FILE: include/video/radeon.h:888:
+#define GMC_CLR_CMP_CNTL_DIS      ^I^I   BIT(28)$

total: 0 errors, 17 warnings, 0 checks, 502 lines checked


3. Please update Cc: list of your mail by all mailing lists returned by
./scripts/get_maintainer.pl:

$ ./scripts/get_maintainer.pl -f include/video/atmel_lcdc.h
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> (maintainer:FRAMEBUFFER LAYER)
dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER)
linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
linux-kernel@vger.kernel.org (open list)

>  include/video/radeon.h | 338 ++++++++++++++++++++++++-------------------------
>  1 file changed, 169 insertions(+), 169 deletions(-)
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
