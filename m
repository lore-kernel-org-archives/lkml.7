Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA37C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A066C2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gCRgJlgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDANBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:01:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38647 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfDANBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:01:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401130149euoutp01ad0f03dac4307c0db4d4255cabb60877~RW0efTChI1335413354euoutp01i
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 13:01:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401130149euoutp01ad0f03dac4307c0db4d4255cabb60877~RW0efTChI1335413354euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554123709;
        bh=fpUf5UnoMDVqCB8Nld3n5rQAKISJ04PzCpBv8Spc/7o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gCRgJlgFadeJ9CFDrZcDcNzCgD5QVPXIsEZpejUOuF+jgGU8UqQ40x12JLBZXLpvl
         pnbpnMnomd9AI1HsguaeCFbQlKet90is/NKE3bWXQ8Qb0ULu9zk3zwlwo8xrpZjw6x
         O7XNdMYtrqRZOwZjYsfLt/E99iyoiXcoCsnJzqBA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190401130149eucas1p1872efc4c1ab5f798be5ce9add4294644~RW0eAP37o2890128901eucas1p1y;
        Mon,  1 Apr 2019 13:01:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 56.95.04377.CBB02AC5; Mon,  1
        Apr 2019 14:01:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401130148eucas1p22233bc8e7a0dc850d7ac0d5511e57213~RW0dGqB3X1969819698eucas1p2L;
        Mon,  1 Apr 2019 13:01:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401130147eusmtrp14443b5a48837cac033c7974e59215a1b~RW0c4nGEt1518515185eusmtrp1Z;
        Mon,  1 Apr 2019 13:01:47 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-1a-5ca20bbcab06
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.92.04146.BBB02AC5; Mon,  1
        Apr 2019 14:01:47 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401130147eusmtip13662c01bfed0f9ef8e199268f1212ce1~RW0ckSOQ_2648826488eusmtip1c;
        Mon,  1 Apr 2019 13:01:47 +0000 (GMT)
Subject: Re: [PATCH] omapfb: Fix potential NULL pointer dereference in
 kmalloc
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d9416512-1daf-252d-409c-5826445510b0@samsung.com>
Date:   Mon, 1 Apr 2019 15:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190302204006.9953-1-pakki001@umn.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7p7uBfFGMy4ZWhx5et7NosT886y
        W5zo+8BqcXnXHDaL2Uv6WSwWL//J6MDmcb/7OJPH1YVN7B6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZexYPIm5oIG54vL35SwNjLuYuhg5OSQETCSe/D7O0sXIxSEksIJR4s2TqawQzhdGiVen+tkh
        nM+MEosmfWWEaemaOJ0ZIrGcUeLG/r9QLW8ZJeZdfgRWJSwQIPH33H92EFtEQFliSfN/sCXM
        Al2MEqcf7wXbziZgJTGxfRVQAwcHr4CdxILruiBhFgEViUWXfzGDhEUFIiT6z6iDhHkFBCVO
        znzCAmJzCphKnPz8BWwVs4CBxJFFc1ghbHmJ7W/ngB0nITCZXWLZhmesEFe7SBy6fYMZwhaW
        eHV8CzuELSNxenIPC0TDOkaJvx0voLq3M0osn/yPDaLKWuLw8YtQkxwl1l7dDXa0hACfxI23
        ghCb+SQmbZvODBHmlehoE4KoVpPYsGwDG8yurp0roW7wkFiz8DLrBEbFWUh+m4Xkn1lI/lnA
        yLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMKWc/nf8yw7GXX+SDjEKcDAq8fBWMC2M
        EWJNLCuuzD3EKMHBrCTCe6Z/QYwQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZ
        qakFqUUwWSYOTqkGxqLIJVc0o1tmrro1++SEv3/V0gRfege/Ya98WPjs2v3dGSqsQVZXr9vx
        uepMi7HZGh3zVs87+0KlrKLzB6dol8bGPjYDTsE5Zuc9K+XXqCxUnq7xl9fQt5Cp42DhXM8z
        /56ueVfpd6t63p1vdzMdLEQjpA7fNjzkz/Pnrbrk7spTz9h/FPyyUGIpzkg01GIuKk4EAAoN
        ZJIlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7q7uRfFGNw8aGhx5et7NosT886y
        W5zo+8BqcXnXHDaL2Uv6WSwWL//J6MDmcb/7OJPH1YVN7B6fN8kFMEfp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZexYPIm5oIG54vL35SwNjLuY
        uhg5OSQETCS6Jk5n7mLk4hASWMoosfDjPrYuRg6ghIzE8fVlEDXCEn+udbFB1LxmlJh+7zQr
        SEJYwE/iz8YnYINEBJQlljT/Z4Eo6mCUmHd/HpjDLNDFKLFz3g4WkCo2ASuJie2rGEE28ArY
        SSy4rgsSZhFQkVh0+RcziC0qECFx62EHWDmvgKDEyZlPwGxOAVOJk5+/MILYzAJ6Ejuu/2KF
        sOUltr+dwzyBUXAWkpZZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBOth37
        uXkH46WNwYcYBTgYlXh4K5gWxgixJpYVV+YeYpTgYFYS4T3TvyBGiDclsbIqtSg/vqg0J7X4
        EKMp0BMTmaVEk/OBMZxXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNT
        qoFRaseUOx8yEoU3Gp9cGdq6mdNkq+eSd98svp27NZevzP5rlIWzUvmFUJYVafNnnWhIUAoJ
        KHRWPx9l9qk9xFZzRtKU5XPCNs+vuh668Nvz8NZ6X8GyJc23D+1qWP/oi8eWt4eW3FS7ctf6
        9M2FXXu2yUTuYHHfv2zCD3+r3rDmZl42tptleRozlFiKMxINtZiLihMBMWZ1b6kCAAA=
X-CMS-MailID: 20190401130148eucas1p22233bc8e7a0dc850d7ac0d5511e57213
X-Msg-Generator: CA
X-RootMTR: 20190302204019epcas2p39a9b9bc29383567d5442fcb3a7efaeed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190302204019epcas2p39a9b9bc29383567d5442fcb3a7efaeed
References: <CGME20190302204019epcas2p39a9b9bc29383567d5442fcb3a7efaeed@epcas2p3.samsung.com>
        <20190302204006.9953-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/02/2019 09:40 PM, Aditya Pakki wrote:
> Memory allocated, using kmalloc, for new_compat may fail. This patch
> checks for such an error and prevents potential NULL pointer
> dereference.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
