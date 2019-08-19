Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0835204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BS+ZPiSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfHSOC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:02:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33798 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfHSOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:02:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190819140253euoutp01af64e2f282b34d23361ce410856688fa~8V9xFgEpo1554615546euoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190819140253euoutp01af64e2f282b34d23361ce410856688fa~8V9xFgEpo1554615546euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566223374;
        bh=f1rgvunrUpzZG+u9msffuBeFeKzI44ZL7IqCjQKLz1g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BS+ZPiSLvr/UKV/wA6d6QlLz/+I3Et3XWkNZz5Msw8iZktjCtYPv4H8b6k/prHzsm
         hffnBmDZlGy3ZnnXevx+/b0sggjMzmp55QHXVRUkiAmBjDWz8S90l5hZLinbT+vHl1
         AyozDdoFU3ruiQ1PZbK8r8p883bvRitZJRUnrxJ4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190819140253eucas1p18901738995874ff56f1a7a54eb5cc7be~8V9wiC30_1977819778eucas1p1b;
        Mon, 19 Aug 2019 14:02:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.F5.04469.D0CAA5D5; Mon, 19
        Aug 2019 15:02:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140252eucas1p1fc087ca9ea3523ef448ce28498e5c977~8V9vny0e91976619766eucas1p1r;
        Mon, 19 Aug 2019 14:02:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819140252eusmtrp237e6bc47d73c2522b328ce52d08b7556~8V9vnLW3c3080230802eusmtrp2M;
        Mon, 19 Aug 2019 14:02:52 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-b8-5d5aac0d2784
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.13.04166.C0CAA5D5; Mon, 19
        Aug 2019 15:02:52 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140252eusmtip13065ddc10526edf8763b61a827a80dee~8V9vTZN6k0664206642eusmtip13;
        Mon, 19 Aug 2019 14:02:52 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: aty: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e9d8fe12-e415-19b3-5c84-2927e26de1ec@samsung.com>
Date:   Mon, 19 Aug 2019 16:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190724131900.2039-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87q8a6JiDb5uZbX40NTKbHHl63s2
        i9mHXjJbnOj7wGpxedccNgdWj52z7rJ79LxpYfW4332cyePzJrkAligum5TUnMyy1CJ9uwSu
        jNVTT7MXHGWqmHogqYGxh6mLkYNDQsBEYme7ZRcjF4eQwApGiSmLPrBCOF8YJXp3b2GDcD4z
        SrzrOQzkcIJ1tO17wgKRWM4o8ap3LSNIQkjgLaPE+p5oEFtYwFriw+cuZhBbREBd4vOunewg
        DcwCUxkltl84yw6SYBOwkpjYvgqsmVfATmLxhulgcRYBVYmzZy6zgNiiAhES949tYIWoEZQ4
        OfMJWJxTwFJi0ooXYPXMAuISt57MZ4Kw5SW2v53DDLJMQmAeu8Scp9fZIR51kfhxPRbiA2GJ
        V8e3sEPYMhL/d4L0gtSvY5T42/ECqnk7o8Tyyf+gfraWOHz8IivIIGYBTYn1u/Qhwo4Sqw5+
        gJrPJ3HjrSDEDXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfOlcwTGJVmIflsFpJvZiH5ZhbC
        3gWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECU8zpf8c/7WD8einpEKMAB6MSD6/H
        tKhYIdbEsuLK3EOMEhzMSiK8FXOAQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5ak
        ZqemFqQWwWSZODilGhg55Aomv3Vkfv5JS87y4bob71ZWXRPbIhabteGm0rSgZV+FTp1cnh7p
        aGu3fFVf5nt5l2Uc5y/YJJ29NmNv0JbXCt/3v/7z/vey049vvTfsVLV5ceW5nWRbQRvTsdc7
        5JZWTbGew93+u+JH0KQHbLctg9a8KemrZJuW+tenyGX1z5AI7yvuim+ylViKMxINtZiLihMB
        fxWyVS0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7o8a6JiDXb3ilh8aGpltrjy9T2b
        xexDL5ktTvR9YLW4vGsOmwOrx85Zd9k9et60sHrc7z7O5PF5k1wAS5SeTVF+aUmqQkZ+cYmt
        UrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuqpp9kLjjJVTD2Q1MDYw9TF
        yMkhIWAi0bbvCUsXIxeHkMBSRokXP9qAEhxACRmJ4+vLIGqEJf5c62IDsYUEXjNKTNjsA2IL
        C1hLfPjcxQxiiwioS3zetZMdZA6zwFRGicnLDrJCDO1hlOhua2ABqWITsJKY2L6KEcTmFbCT
        WLxhOjuIzSKgKnH2zGWwGlGBCIkz71ewQNQISpyc+QTM5hSwlJi04gVYPTPQtj/zLjFD2OIS
        t57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT8
        3E2MwKjaduzn5h2MlzYGH2IU4GBU4uH1mBYVK8SaWFZcmXuIUYKDWUmEt2IOUIg3JbGyKrUo
        P76oNCe1+BCjKdBzE5mlRJPzgRGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUg
        tQimj4mDU6qBMYah6fm84FkBqcY8Ty7P2/iLec5ztxsvGPd3VRyU/y3f/UXq+X6HnBuF89+c
        5/i6Vm1G+LncurNmgXzm05sjXiSki5/cOH2PQZx5mFJ17uMlhTcOeDcL7AypmdCQ6zTryZJU
        qziGHTvEJnZ/zfaPmnjGo+aVYO3+t77+ZS2bbieaLv58dmlTkRJLcUaioRZzUXEiAMxcGbDA
        AgAA
X-CMS-MailID: 20190819140252eucas1p1fc087ca9ea3523ef448ce28498e5c977
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190724131908epcas2p473bd151e9c12b90d6dc9c4a39b522e3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190724131908epcas2p473bd151e9c12b90d6dc9c4a39b522e3a
References: <CGME20190724131908epcas2p473bd151e9c12b90d6dc9c4a39b522e3a@epcas2p4.samsung.com>
        <20190724131900.2039-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/19 3:19 PM, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
