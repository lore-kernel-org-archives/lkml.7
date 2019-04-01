Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDFD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AUXE53GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDAPip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:38:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41291 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDAPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:38:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401153843euoutp014cd94dcb7364abc83b76642069a62b0a~RY9dcynhT0206802068euoutp01h
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 15:38:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401153843euoutp014cd94dcb7364abc83b76642069a62b0a~RY9dcynhT0206802068euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554133123;
        bh=TGfR92w9U1m+ZwvYGbspa1WDv6+8ltMskTlqO0URdBM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AUXE53GRrOsQkb7tbxQpgdVnJj2fYxqshKaVBOmjLczYzrHWxPr1c81QTqbn8EKwL
         qej7jDcPrT9mh8WGeOTE0egddKR+Yl09jSRy1oz52dvJ0zWbqkMfoWboEV9+KPITBD
         gdaPFH2XFo3bbsrkjb/jX2BU5HJ6ADylm97R/4qY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190401153842eucas1p15fe2312881144b184210838956cef858~RY9cxyqju1434014340eucas1p1n;
        Mon,  1 Apr 2019 15:38:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.71.04298.28032AC5; Mon,  1
        Apr 2019 16:38:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401153841eucas1p2097f83b6faa717e97e7cbce77a347f20~RY9b7aOof2216022160eucas1p2x;
        Mon,  1 Apr 2019 15:38:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401153841eusmtrp29a64cf6c38b32ad891f6b79ef3fff1a4~RY9btW8CU1455814558eusmtrp2Y;
        Mon,  1 Apr 2019 15:38:41 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-d6-5ca230825fb3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.D8.04146.18032AC5; Mon,  1
        Apr 2019 16:38:41 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401153840eusmtip267464552f0dd0e32e93ae19b1cbf8067~RY9bPgw3r1526115261eusmtip2X;
        Mon,  1 Apr 2019 15:38:40 +0000 (GMT)
Subject: Re: [PATCH 3/7] gbefb: switch to managed version of the DMA
 allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a61e5aa5-53ed-168c-9b75-cb0509e0c065@samsung.com>
Date:   Mon, 1 Apr 2019 17:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190321225235.30648-4-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++/sHI+rjbOp+GqptMJIygvdDlqiUXC+FX1JVNKVh2m6KTtq
        mVESuEwzSytrqZlJ3s3mdUkY05zipcy0i2SaCmmo4SVUyHI7M/z24/88z/95X3hJTNaMO5NR
        6nhWo1bEyAmRsKF9uXfvNe+iUO/F3xj9YXGWoMsq3gjowhY/Wj82iNNPtMVCuuPWL5zuf5lH
        0MZ7rxD9uusuRi/VjOEBIqZ/sA9jDLqvNoy+/AbBfMswCZja4qtMzqcSxDR/TiGYeb3rSTJY
        dDiCjYlKZDVe/uGiyM7sLhQ3LLhY2z4nTEFPBenIlgRqP6QNvEPpSETKqFIEowP3CbMgoxYQ
        rHQc5IV5BHWmzP+J8pFZnBdKEAxl9lvj0wh6GmYsLjvqJLSP3cTMbE/JYWKqx2LCqCoBDOnr
        kVkgKF+4c73cwmLKH4a78y3dQmontM7UrjFJOlBBkNW9i7dIofPhuNDMtpQ3DI9mWP7H1rit
        KA/n2Q0ap/MwcxdQvTYwV1dP8GMfg6m8nzY828GUqc7K2+Cv4bGAD1Qj+JP2w5puRFCSs2pN
        +0GrqQ83TwRUIDwv9eNRAp+mpXyxBLIbcjH+WQxpWhkfdIeaZzXEelW6ocxqYaCtSn0bbddt
        2Ey3YRvdhm0KEVaOHNkETqVkOR81e8GTU6i4BLXS81ysSo/WTqpr1TTXhBbfnzUiikTyLeJw
        p6JQGa5I5JJURgQkJrcXd2cVhsrEEYqkS6wmNkyTEMNyRrSVFModxcmbRkJklFIRz0azbByr
        WVcFpK1zCqqkJPtOaw+dGmuZDnBbzcgdbsY+HjDWpBa/9ap+UJF/+Up/SEGWZqh+Dzvprww2
        nHYtjjyjNsySIkfVccM+fFUX/0R6fne41IkbcR/tbHpBzim+LLUZg8K/T9ioU08kb15IGll2
        6VqYfKQddzkSpt0hlUR7uMeuOEh8tQVHKwPlQi5S4eOBaTjFP9OK6z5OAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7qNBotiDFqms1lc+fqezWLl6qNM
        Fgv2W1tsenyN1WJh2xIWixN9H1gtLu+aw2ZxaOpeRosDp6cwW/zY8JjVgcvj8rWLzB47Z91l
        99i0qpPN4373cSaPzUvqPSbfWM7osftmA5vH501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehknJ51mLLjHVLH52CeWBsbFTF2MnBwSAiYS
        qx68Z+1i5OIQEljKKPH/4D0ghwMoISNxfH0ZRI2wxJ9rXWwQNa8ZJa5M7mMFSQgL+Ens39AM
        NkhEQEni6auzjBBFKxkl3s78C+YwC6xlkrg/tQ2sg03ASmJi+ypGEJtXwE7i3pm5bCA2i4CK
        xOF3m8FsUYEIiVsPO1ggagQlTs58AmZzChhI3HvYzQxiMwvoSey4/osVwpaX2P52DvMERsFZ
        SFpmISmbhaRsASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMD423bs5+YdjJc2Bh9iFOBg
        VOLhjRBaFCPEmlhWXJl7iFGCg1lJhPdM/4IYId6UxMqq1KL8+KLSnNTiQ4ymQE9MZJYSTc4H
        poa8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2M3hEbmV4xRle6
        HjfQ9+7wNFHauvqrh7voxiUhjQ1MIQdNPnRu47/78/QpQ7uosizxisfe+8WYt6y5GCly46jm
        vsI/Cx4uVp398AlLQt6LfXz7l8mf5lt2qPlS+r8FO4Nf2Jb+LzQzUY0uT0sMfveMcWLXo6p3
        v44fYnyh7/qgquPAfqHPux21lViKMxINtZiLihMB5YHXDNUCAAA=
X-CMS-MailID: 20190401153841eucas1p2097f83b6faa717e97e7cbce77a347f20
X-Msg-Generator: CA
X-RootMTR: 20190321225318epcas1p2a3b1fc89a14c4ab1241d8b48293fb9e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321225318epcas1p2a3b1fc89a14c4ab1241d8b48293fb9e0
References: <20190321225235.30648-1-hch@lst.de>
        <CGME20190321225318epcas1p2a3b1fc89a14c4ab1241d8b48293fb9e0@epcas1p2.samsung.com>
        <20190321225235.30648-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/21/2019 11:52 PM, Christoph Hellwig wrote:
> gbefb uses managed resources, so it should do the same for DMA
> allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
