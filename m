Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39177C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011B6206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="svGCRGfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHSOKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:10:06 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46665 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfHSOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:10:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190819141004euoutp02defcf9562254cd09cdc2d2efe15cbc90~8WECMM5MX0419204192euoutp02i
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:10:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190819141004euoutp02defcf9562254cd09cdc2d2efe15cbc90~8WECMM5MX0419204192euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566223804;
        bh=eusqD32C53reMcLpq4AspXVI02zzuSAGpVBrYE+jreg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=svGCRGfQ1466A0x/4rdHfYOG5oKZH4aSvSrL95BLr4bLwQQ+dtYwN3KR/d5glhSAX
         4Duti7Wn3AbmyE11nEW9MXACf9vkdycbLNp58Lz6y0y1V0ASToCJPY/veO18Zw9xsT
         Oa2/OqeBLaJnEVTGVW/TWfcrfpRFiKBTm7k/CvZo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190819141004eucas1p2dcc2143c30cc81316c2fb8b8fcfe5848~8WEBswXLW2973429734eucas1p22;
        Mon, 19 Aug 2019 14:10:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.D9.04309.BBDAA5D5; Mon, 19
        Aug 2019 15:10:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190819141003eucas1p270a7faa948afa3434b7ee9cab924cd85~8WEA5bieK3113031130eucas1p2K;
        Mon, 19 Aug 2019 14:10:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819141003eusmtrp237fa8ed0433bc960718f0de4de43ef22~8WEA47JTs0194801948eusmtrp2b;
        Mon, 19 Aug 2019 14:10:03 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-3e-5d5aadbbaab3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.E5.04117.BBDAA5D5; Mon, 19
        Aug 2019 15:10:03 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819141002eusmtip1543c5d7a7def16c95b911c333cbb6b08~8WEAjZN8l1055510555eusmtip1W;
        Mon, 19 Aug 2019 14:10:02 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev/mmp/core: Use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d2b32f0f-307d-b286-22b5-2316c9de1d93@samsung.com>
Date:   Mon, 19 Aug 2019 16:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190807161312.GA26835@embeddedor>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd3da6NiDX4sN7C48vU9m8XWPaoW
        J/o+sFpc3jWHzYHFY91BVY/73ceZPD5vkgtgjuKySUnNySxLLdK3S+DKaLh5n7ngI3vFgU3L
        2RoYF7J1MXJySAiYSJyZs5Cxi5GLQ0hgBaPE8UV32CCcL4wSB2b+gcp8ZpS42zmLEaZlZcdT
        qMRyRomZT1+xgySEBN4ySkzbxwFiCwt4Sfw7f4kVxBYRMJKYPaMbzGYWSJA4vegeC4jNJmAl
        MbF9FdhQXgE7iTULbgLFOThYBFQlFu+vAgmLCkRI3D+2gRWiRFDi5MwnYK2cAgYST8/8YYQY
        KS5x68l8JghbXmL72znMEHe2s0ucmCEPYbtIvLx0kgXCFpZ4dXwLO4QtI/F/J0gvF5C9jlHi
        b8cLZghnO6PE8sn/oIFkLXH4+EVWkOOYBTQl1u/Shwg7Skze08UMEpYQ4JO48VYQ4gY+iUnb
        pkOFeSU62oQgqtUkNizbwAaztmvnSuYJjEqzkHw2C8k3s5B8Mwth7wJGllWM4qmlxbnpqcVG
        eanlesWJucWleel6yfm5mxiBqeT0v+NfdjDu+pN0iFGAg1GJh9djWlSsEGtiWXFl7iFGCQ5m
        JRHeijlAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYzt
        C3mXFx1jqE3cEsE8ic/0b46ypO1Ojtn9vF6vLhnci9369QJrmfS7Xe5GW7ZoCJj+urHOLixG
        hDnmZNcx59+h9ffPXT+4blHutjqT276O03mVXzqd4LN2tS9cnawutYnnmNw+paUZ1TNWHCtt
        NTYODdS7tIW7vuhN/hZzwaQDS22b+ZmDVZRYijMSDbWYi4oTAY3XKkAhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7q710bFGnw4wGVx5et7Noute1Qt
        TvR9YLW4vGsOmwOLx7qDqh73u48zeXzeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0XDzPnPBR/aKA5uWszUwLmTrYuTkkBAwkVjZ8ZQR
        xBYSWMooseySWhcjB1BcRuL4+jKIEmGJP9e6gMq5gEpeM0r82n6AHSQhLOAl8e/8JVYQW0TA
        SGL2jG5WkF5mgQSJZ/NSIOqbGSWmnXgGNp9NwEpiYvsqMJtXwE5izYKbLCD1LAKqEov3V4GE
        RQUiJM68X8ECUSIocXLmEzCbU8BA4umZP2CtzALqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj
        0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZGz7djPLTsYu94F
        H2IU4GBU4uH1mBYVK8SaWFZcmXuIUYKDWUmEt2IOUIg3JbGyKrUoP76oNCe1+BCjKdBvE5ml
        RJPzgVGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBUTrVvdLp
        18bVnAoxsxpKUvynV/2+84dZujC92mBCfq78189K93X3Xg7ievbF7FPS84PbRCL23bd7e4XB
        qX6VSH1syL4FWhbRf8P3MbN94v4Tz7Hx0j/9jUcX6Tmbr9k6T81G/O7sp8ujnrc9nZamseeo
        hNq5vMy4opVPfpyb7sIW5nB/mYa1hhJLcUaioRZzUXEiAMNwK9iyAgAA
X-CMS-MailID: 20190819141003eucas1p270a7faa948afa3434b7ee9cab924cd85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807161320epcas2p1457bd16d94c3f746543130153a472696
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807161320epcas2p1457bd16d94c3f746543130153a472696
References: <CGME20190807161320epcas2p1457bd16d94c3f746543130153a472696@epcas2p1.samsung.com>
        <20190807161312.GA26835@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/19 6:13 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct mmp_path {
> 	...
>         struct mmp_overlay overlays[0];
> };
> 
> size = sizeof(struct mmp_path) + count * sizeof(struct mmp_overlay);
> instance = kzalloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, overlays, count), GFP_KERNEL)
> 
> Notice that, in this case, variable size is not necessary, hence it
> is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
