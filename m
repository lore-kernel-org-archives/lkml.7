Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660EBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D20204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BYJgNmKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfHSOC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:02:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33526 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfHSOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:02:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190819140226euoutp01aab7079f7ef90b4be29acd260c9225a4~8V9XH_aOZ1481314813euoutp01d
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:02:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190819140226euoutp01aab7079f7ef90b4be29acd260c9225a4~8V9XH_aOZ1481314813euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566223346;
        bh=jVgWyfwh3DFFBSBvPWE28F27h1CfoutZzZUgQq+jAik=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BYJgNmKlDl1UgIDktTWZkfincciHXaJNloevc2qD0jGUxEGTbpG1HJuIqcIW7Ie/N
         WK9hDmJB+3mYAsm5Z5rg4aHVK4FXEgLm6zIRBxO60VAFn3RdLSMk1eCF25Txe9vt7N
         VoOxREo5c/VoRwkgFRd3aNYGxpUvShNwlKJzOcjs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190819140225eucas1p13d915e6b8251ee484c7d1b0b9bbdbca9~8V9WoHy-b1971019710eucas1p1B;
        Mon, 19 Aug 2019 14:02:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F7.E5.04469.1FBAA5D5; Mon, 19
        Aug 2019 15:02:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190819140224eucas1p2f31f721b2ba3bcc3f561c9ee7236422a~8V9V1fEAB1286512865eucas1p2a;
        Mon, 19 Aug 2019 14:02:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819140224eusmtrp2fbefb65aaacdc43ea3f7d34d472b9793~8V9V07Wfx3080230802eusmtrp2X;
        Mon, 19 Aug 2019 14:02:24 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-4c-5d5aabf1a5e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.D4.04117.0FBAA5D5; Mon, 19
        Aug 2019 15:02:24 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140224eusmtip11f2a1b73203fe1055117a8fd78c48298~8V9Ves0B_0431304313eusmtip1-;
        Mon, 19 Aug 2019 14:02:24 +0000 (GMT)
Subject: Re: [PATCH] fbdev: sm712fb: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a7de5851-1b7c-bab5-4e3a-4d1fd5f6b65e@samsung.com>
Date:   Mon, 19 Aug 2019 16:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190724131744.1709-1-hslester96@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7ofV0fFGjz4wWVx5et7NovZh14y
        W5zo+8BqcXnXHDaLA6enMFusWbKH0YHNY+esu+we97uPM3k8v/+UzePzJrkAligum5TUnMyy
        1CJ9uwSujNe/1jMXHGWqmDg/pIGxh6mLkZNDQsBEonFnI5DNxSEksIJR4v2GsywQzhdGiX07
        2tghnM+MEuvuzGWHadl9+ShUYjmjxPfPG9ggnLeMEv/vXwOrEhawkHjf/BPMFhFQl/i8aydY
        B7PAbkaJlQ9fsYIk2ASsJCa2r2IEsXkF7CS23ZoIFmcRUJXYtm4KM4gtKhAhcf/YBlaIGkGJ
        kzOfsIDYnAKWEr0zQTZzAg0Vl7j1ZD4ThC0vsf3tHGaQZRICy9glft7byAZxt4vEp+0XGCFs
        YYlXx7dA/SMj8X/nfCaIhnWMEn87XkB1b2eUWD75H1S3tcTh4xeBzuAAWqEpsX6XPkTYUeJC
        /zU2kLCEAJ/EjbeCEEfwSUzaNp0ZIswr0dEmBFGtJrFh2QY2mLVdO1cyT2BUmoXktVlI3pmF
        5J1ZCHsXMLKsYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEw5p/8d/7SD8eulpEOMAhyM
        Sjy8HtOiYoVYE8uKK3MPMUpwMCuJ8FbMAQrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0k
        kJ5YkpqdmlqQWgSTZeLglGpgjNHkPiq0ttmQk53/AO9WRU/2WwYFi5wXXNcXdxOfuj7aSGTK
        2/kcrL+Vfj+KuM+odUQzvn59lMNV08f5r00k5048aLfl8FGltElHl7kWvCq9+yi5pSppQnSh
        QWD9r3KWmzM6v6clL9JjS86eV1GR9M9Suk6Z37HXvqzds3PPnJo1DMteZl5UYinOSDTUYi4q
        TgQAXLrWBjUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7ofVkfFGqx5o2Zx5et7NovZh14y
        W5zo+8BqcXnXHDaLA6enMFusWbKH0YHNY+esu+we97uPM3k8v/+UzePzJrkAlig9m6L80pJU
        hYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jNe/1jMXHGWqmDg/
        pIGxh6mLkZNDQsBEYvflo+xdjFwcQgJLGSUO3ZkH5HAAJWQkjq8vg6gRlvhzrYsNouY1o8Tf
        E+uYQRLCAhYS75t/soPYIgLqEp937QQbxCywm1Hi+O3PzBAdPYwSRxauAatiE7CSmNi+ihHE
        5hWwk9h2ayIriM0ioCqxbd0UsKmiAhESZ96vYIGoEZQ4OfMJmM0pYCnRO3MDG4jNDLTtz7xL
        zBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0
        L10vOT93EyMwwrYd+7llB2PXu+BDjAIcjEo8vB7TomKFWBPLiitzDzFKcDArifBWzAEK8aYk
        VlalFuXHF5XmpBYfYjQFem4is5Rocj4w+vNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTBKrZKe9ZPzgKxzt6yle/KZk2n9fEc3SKapBnm9kti/LZdpgmb/sTR1
        x+mK1/if84VfC+O1zvdQqv/rYrVgT+sql02f533ys+q2OydvfqylPzLqzJNXkZk+YrNTvzjX
        rLXgairg+KVj/FDm0NfDjmd6KxeX/WyVcfyyJvO87O2lR27vrt31/KASS3FGoqEWc1FxIgBK
        i/amxgIAAA==
X-CMS-MailID: 20190819140224eucas1p2f31f721b2ba3bcc3f561c9ee7236422a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190724131753epcas2p421536b8d2d873766882bea0e3ea4f351
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190724131753epcas2p421536b8d2d873766882bea0e3ea4f351
References: <CGME20190724131753epcas2p421536b8d2d873766882bea0e3ea4f351@epcas2p4.samsung.com>
        <20190724131744.1709-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/19 3:17 PM, Chuhong Yuan wrote:
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
