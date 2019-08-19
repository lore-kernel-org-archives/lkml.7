Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCCB204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p3VK2Gjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfHSOCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:02:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43657 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfHSOCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:02:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190819140200euoutp022ad3aa104914b8971d73bb0f9e0e47a4~8V8_8c0X60064800648euoutp02A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190819140200euoutp022ad3aa104914b8971d73bb0f9e0e47a4~8V8_8c0X60064800648euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566223320;
        bh=/AOyRB5HeQ/lP4tN2GXWPCVhr7bSMVhaHv/qCtEHGp0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p3VK2GjloMj8jxxIoTv07gi0yEZNcJIlduSzTxgDMcxP9Ea+vWvOVx3oGL244Yfwn
         EWiahLcFYiBP81C/Ctm/QisD293pJcW4klb+TqTR/uBALuzeCTIz4Ts/ag504Q+tOU
         AFgLXn69oQHSY3qqN3nWGAViRwxkM2LYEzqEGjP8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190819140159eucas1p2a87c8aec2f1b259b566df03c731f1068~8V8_fy3bf1282112821eucas1p22;
        Mon, 19 Aug 2019 14:01:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F8.A8.04309.7DBAA5D5; Mon, 19
        Aug 2019 15:01:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190819140158eucas1p2b53a7522deb0ca862620d09b578382b7~8V89yL2vz1102711027eucas1p2T;
        Mon, 19 Aug 2019 14:01:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819140158eusmtrp248c9633966b0ae70d78f46b184f99763~8V89jXzJG2996429964eusmtrp22;
        Mon, 19 Aug 2019 14:01:58 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-56-5d5aabd7aa79
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.C4.04117.6DBAA5D5; Mon, 19
        Aug 2019 15:01:58 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140158eusmtip14bded87719194c0ae55f019129f491fc~8V89TIDKH0431304313eusmtip1x;
        Mon, 19 Aug 2019 14:01:58 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: pvr2fb: remove unnecessary comparison of
 unsigned integer with < 0
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7c233700-a6b2-54fd-e86d-a11583bb3ec3@samsung.com>
Date:   Mon, 19 Aug 2019 16:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190722203358.GA29111@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned3rq6NiDb5NELO48vU9m8XWPaoW
        J/o+sFpc3jWHzYHFY91BVY/73ceZPD5vkgtgjuKySUnNySxLLdK3S+DKeDTxOFvBJJaKV3d0
        Gxg3MncxcnJICJhI7L/3iK2LkYtDSGAFo8S8WxOZQBJCAl8YJfp+BkLYnxklNs0V7GLkAGv4
        /KgCon45o0TT/SOMEM5bRom7xx6xgjQIC6RLnO7aDzZIRMBIYvaMbrA4s0CCxOlF91hAbDYB
        K4mJ7asYQWxeATuJOX/3sYEsYBFQldgx0w8kLCoQIXH/2AZWiBJBiZMzn4C1cgoYSBzcdIgF
        YqS4xK0n85kgbHmJ7W/nMIPcIyHQzS5xfP8DVogvXSSW3fzJDmELS7w6vgXKlpH4vxOkGaRh
        HaPE344XUN3bGSWWT/7HBlFlLXH4+EVWkOuYBTQl1u/Shwg7SnQ9fcsECRU+iRtvBSGO4JOY
        tG06M0SYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJue
        WmyUl1quV5yYW1yal66XnJ+7iRGYRk7/O/5lB+OuP0mHGAU4GJV4eD2mRcUKsSaWFVfmHmKU
        4GBWEuGtmAMU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnV
        wOj/ZuuzY/td5h1elfChY2vwSsZTJcVVi4zlSu7MKSt8G3Vl/zUlg5aCa6snxrFkfpoufllj
        kfm/D4Hb3dSXfN0ptcswrzJjlqg9787SCyeFjlQ/XCHaw3xBcY2hY/yd83+vMmQqr64/UrG5
        /Pxpld6PgpMZtpj/UwhZmsB86WLOoWctpaJv/dWUWIozEg21mIuKEwGaKUnMHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7rXVkfFGkx8omJx5et7Noute1Qt
        TvR9YLW4vGsOmwOLx7qDqh73u48zeXzeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8WjicbaCSSwVr+7oNjBuZO5i5OCQEDCR+PyooouR
        i0NIYCmjxN87qxkh4jISx9eXdTFyApnCEn+udbFB1LxmlLiyZgUzSEJYIF3idNd+JhBbRMBI
        YvaMblaQXmaBBIln81Ig6psZJV7ubgSrZxOwkpjYvooRxOYVsJOY83cfG0g9i4CqxI6ZfiBh
        UYEIiTPvV7BAlAhKnJz5BMzmFDCQOLjpEJjNLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAK
        zULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGDfbjv3csoOx613w
        IUYBDkYlHl6PaVGxQqyJZcWVuYcYJTiYlUR4K+YAhXhTEiurUovy44tKc1KLDzGaAv02kVlK
        NDkfGNN5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYZ2xt1lay
        8m1/HMs3bd9pP/e18cxvFsgfmHNcesLSqG1n70imMunsybjZtkJ5SoD6HZG3y/WrSup+zGGf
        8e5489/9XOaKq9d+2Lwj6xBLiP2lhRFrDwn9dvinlLtj8jT5yyttfn5v2O+++uOOi5cZS92n
        KnX6O4V3Fe1wCz61JvvKO4vHmgxv7iuxFGckGmoxFxUnAgDRJrnDsQIAAA==
X-CMS-MailID: 20190819140158eucas1p2b53a7522deb0ca862620d09b578382b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722203403epcas2p32d13bdd6f29bed37696385baca909abf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722203403epcas2p32d13bdd6f29bed37696385baca909abf
References: <CGME20190722203403epcas2p32d13bdd6f29bed37696385baca909abf@epcas2p3.samsung.com>
        <20190722203358.GA29111@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/19 10:33 PM, Gustavo A. R. Silva wrote:
> There is no need to compare *var->xoffset* or *var->yoffset* with < 0
> because such variables are of type unsigned, making it impossible to
> hold a negative value.
> 
> Fix this by removing such comparisons.
> 
> Addresses-Coverity-ID: 1451964 ("Unsigned compared against 0")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
