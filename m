Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF0C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31137208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QOjXQkKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfFGMem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:34:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41964 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbfFGMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:34:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607123440euoutp018d566cbb93ce74b1c602626296751c65~l6q5diFz40273302733euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:34:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607123440euoutp018d566cbb93ce74b1c602626296751c65~l6q5diFz40273302733euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910880;
        bh=ThV8ofAnzhigMK3H1xSjiZjEi7SeHjE9WG2gTh0ZzbA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=QOjXQkKWVUqcButzAWqvdnYuLXCh3hyh51ATbkl9bW0tGpoDXHKDjEPEkdIp7pLM0
         fQjd5pdbGeE7d52eAG2jg/h+pbHycj6B71T9pBoffjYLBYcAzYJ2TXK3y9dGhpXVhj
         cb+QCy6/fPnk6WEbE6ARgeubMPO30h8hU/qh1YvI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607123440eucas1p195a08bb9e92f9b83f9b7b45390db04ba~l6q5Ka-iE2129821298eucas1p1d;
        Fri,  7 Jun 2019 12:34:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B4.E2.04325.FD95AFC5; Fri,  7
        Jun 2019 13:34:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607123439eucas1p16f9538b5b30f57daa4a11c2ea78015a9~l6q4KaFdz2129821298eucas1p1c;
        Fri,  7 Jun 2019 12:34:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607123438eusmtrp25d6480b9853f3f6989ca552d0dbe2962~l6q365ozf1102511025eusmtrp2M;
        Fri,  7 Jun 2019 12:34:38 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-16-5cfa59dfa5c9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.23.04140.ED95AFC5; Fri,  7
        Jun 2019 13:34:38 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123438eusmtip261872123b9a0aef3affed718a9c595be~l6q3s-Ucu2101821018eusmtip2o;
        Fri,  7 Jun 2019 12:34:38 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <df3ac4b0-2da5-1611-6ec2-be3f4cd3c935@samsung.com>
Date:   Fri, 7 Jun 2019 14:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e59b45f6-b8a5-ed99-f294-072df1a1d222@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd37kb9iDO490LK48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujGuzbrIXdLNVfDiW3MD4maWLkZND
        QsBEYs6nNiCbi0NIYAWjxNIpL5ggnC+MEjc7vrFBOJ8ZJW419DDBtKyd/oEZIrGcUaJ76weo
        /reMEgu3PmIEqRIW8JLY+v802BI2ASuJie2rwOIiAgkSK6bPALN5Bewk9q14xgZiswioSNx/
        /JMdxBYViJC4f2wDK0SNoMTJmU+A5nBwcArYS2yfYwYSZhYQl7j1ZD4ThC0vsf3tHLCDJAQ+
        s0mcePmYFeJSF4ktl9rZIWxhiVfHt0DZMhL/d85ngmhYxyjxt+MFVPd2Ronlk/+xQVRZSxw+
        fpEVZDOzgKbE+l36EGFHifOz14EdJCHAJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1m
        bdfOlcwQtofEtWO3mSYwKs5C8uUsJK/NQvLaLIQbFjCyrGIUTy0tzk1PLTbOSy3XK07MLS7N
        S9dLzs/dxAhMHqf/Hf+6g3Hfn6RDjAIcjEo8vB7sP2OEWBPLiitzDzFKcDArifCWXfgRI8Sb
        klhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoFR6fKkD52PGzzk
        H/gsff+ufJq6wNK20Aa9nktt1xY/ubmykpG/dubS8Hqp10LcfRa7X8zaml2qlrNNgc898M6Z
        vXuP1pTc4Ym/bitot97Seu+MFG3rzxdjVl68s0R25YaauA1HT+71/3rn5OcqcZPMvU7+h1bY
        Pa7heWrAtrG0LmieXfv7VawCSizFGYmGWsxFxYkAmf1rqhoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd17kb9iDP5dN7G48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jGuzbrIXdLNVfDiW3MD4maWLkZNDQsBEYu30D8xdjFwcQgJLGSUm
        f77P2MXIAZSQkTi+vgyiRljiz7UuNoia14wSCxccA2sWFvCS2Pr/NJjNJmAlMbF9FSOILSKQ
        IPH09Xw2EFtIwE5iScMqdhCbF8jet+IZWJxFQEXi/uOfYHFRgQiJM+9XsEDUCEqcnPmEBeQG
        TgF7ie1zzEDCzALqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj4Cwk3bOQtMxC0jILScsCRpZV
        jCKppcW56bnFRnrFibnFpXnpesn5uZsYgRGx7djPLTsYu94FH2IU4GBU4uGdwfQzRog1say4
        MvcQowQHs5IIb9mFHzFCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA+M1rySeENTQ3MLS0Nz
        Y3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxa98sCZz4T/sv/VGrPfi4lq/zPuz93
        rpwQsPCF6e+oT5FvmbwDPq1l7ak3WLsuPv1YwomK4PuW80KUTWMDLjQG/3iw0Oj39m1S0dZH
        faXO3xFcuOOfC8vL7Jl/+xNPlaXWNebOUcq4oKH/ZMr+uo56yacrOM70JR54t0lXdrqLXLnK
        f3vp9NtKLMUZiYZazEXFiQDXAHmzngIAAA==
X-CMS-MailID: 20190607123439eucas1p16f9538b5b30f57daa4a11c2ea78015a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607123439eucas1p16f9538b5b30f57daa4a11c2ea78015a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607123439eucas1p16f9538b5b30f57daa4a11c2ea78015a9
References: <e59b45f6-b8a5-ed99-f294-072df1a1d222@samsung.com>
        <CGME20190607123439eucas1p16f9538b5b30f57daa4a11c2ea78015a9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/19 1:58 PM, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to pvr2fb driver for better compile
> testing coverage.
> 
> While at it:
> 
> - mark pvr2fb_interrupt() and pvr2fb_common_init() with
>   __maybe_unused tag (to silence build warnings when
>   !SH_DREAMCAST)
> 
> - convert mmio_base in struct pvr2fb_par to 'void __iomem *'
>   from 'unsigned long' (needed to silence build warnings on
>   ARM).
> 
> - split pvr2_get_param() on pvr2_get_param_name() and
>   pvr2_get_param_val() (needed to silence build warnings on
>   x86).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
