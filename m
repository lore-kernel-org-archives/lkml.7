Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5EBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C7A2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MW5JQu2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGAJXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:23:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45616 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbfGAJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:23:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190701092329euoutp02eb8fc88b82d702aa9438b4affb6592bc~tPi0ZNKcT1290112901euoutp02j
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2019 09:23:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190701092329euoutp02eb8fc88b82d702aa9438b4affb6592bc~tPi0ZNKcT1290112901euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561973009;
        bh=QI5iVQFT+2D2h+UGA17833cZARFQzx3lh8FOwrsfy/I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MW5JQu2HM7QnlbhSPCyjQunsb+dN4o7e8Req67zaKFFPT6JVJQBqN6SAdiYI26gwV
         uJG4abj7beRfCOeXtyn2VPjG2cEpfdX0wTTCveCga94PV0K1ihQgHceLonQI7481yv
         yggVvBlcoyuDee5Z9GYRMYoPpkNgC+DjHJCgtuqs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701092328eucas1p15b5a7d8f33a636230bcb2485bc83fa05~tPi0D0p-q1758117581eucas1p1d;
        Mon,  1 Jul 2019 09:23:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3C.D4.04325.011D91D5; Mon,  1
        Jul 2019 10:23:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701092327eucas1p1cb466d226fa17a1462d0bdf5625ed721~tPizQ_t-D2711027110eucas1p14;
        Mon,  1 Jul 2019 09:23:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190701092327eusmtrp1a3677c1ea24aed39c35430b5b2aabbe3~tPizC-lOJ3244632446eusmtrp1d;
        Mon,  1 Jul 2019 09:23:27 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-17-5d19d110eca1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.AA.04140.F01D91D5; Mon,  1
        Jul 2019 10:23:27 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701092327eusmtip1784f1a91ab6166c69ae98d80537e0daf~tPiyxpu3V1704817048eusmtip1V;
        Mon,  1 Jul 2019 09:23:27 +0000 (GMT)
Subject: Re: [PATCH] drm: bridge: DRM_SIL_SII8620 should depend on, not
 select INPUT
To:     Randy Dunlap <rdunlap@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <a7edece4-fec4-5811-27a9-ca6c275a4c40@samsung.com>
Date:   Mon, 1 Jul 2019 11:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8baa25c0-498b-d321-4e6a-fe987a4989ba@infradead.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87oCFyVjDZpvKlpc+fqezWLS/Qks
        Fp0Tl7BbXN41h83i7Z3pLA6sHrM7ZrJ6bF6h5XG/+ziTR9+WVYwenzfJBbBGcdmkpOZklqUW
        6dslcGVcmPSJqeAXT8XzmYfZGxhXc3UxcnJICJhI9Px4zwZiCwmsYJS41ZTbxcgFZH9hlDhw
        aTo7hPOZUWLzsqvsMB1PTq5ng0gsZ5ToXb6HGcJ5yyixsW0i2CxhgTCJcw1HmUBsEYEaiem3
        zjGD2MwC0RI9y9ewgNhsApoSfzffBKvnFbCT+Lz3BCOIzSKgIvFzw2uwelGBCInLW3YxQtQI
        Spyc+QSsl1PAUWLO0gdMEDPlJba/nQM1X1zi1pP5TCAHSQgsYpc4sPMNG8TZLhKNd2ezQtjC
        Eq+Ob4F6R0bi9OQeFgi7XuL+ihZmiOYORomtG3YyQySsJQ4fvwjUzAG0QVNi/S59iLCjxM9T
        /9hBwhICfBI33gpC3MAnMWnbdGaIMK9ER5sQRLWixP2zW6EGikssvfCVbQKj0iwkn81C8s0s
        JN/MQti7gJFlFaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCyOf3v+NcdjPv+JB1iFOBg
        VOLhbbgjESvEmlhWXJl7iFGCg1lJhHf/CslYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+i
        hQTSE0tSs1NTC1KLYLJMHJxSDYwCM60ONS6Z9E53fcxR7fpvASq7ZRls463rLnCqfLzvfGah
        kv6Nm0VH6tJOLq2fvn7x3QrBB77WgW/bJxvHLOaoSnh7eHJmpJvtCrfsOVZPbIWrZP8aX9xc
        tPiHwo87F66833eNN+NqJKvMKb6t8v3ZL5ZcPNy5+f7y1dcNklz3LL8dcYPD74i/EktxRqKh
        FnNRcSIAA/IMhjIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t/xu7r8FyVjDW7c1rK48vU9m8Wk+xNY
        LDonLmG3uLxrDpvF2zvTWRxYPWZ3zGT12LxCy+N+93Emj74tqxg9Pm+SC2CN0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4MOkTU8EvnornMw+z
        NzCu5upi5OSQEDCReHJyPVsXIxeHkMBSRonpq64xQSTEJXbPf8sMYQtL/LnWBVX0mlHiVPdp
        xi5GDg5hgTCJ1idFIDUiAnUSPdMWMILYzALREr/OHGKGqJ8CNHTnQXaQBJuApsTfzTfZQGxe
        ATuJz3tPgDWwCKhI/NzwGmyZqECERF/bbKgaQYmTM5+wgNicAo4Sc5Y+YIJYoC7xZ94lZghb
        XmL72zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpec
        n7uJERhf24793LKDsetd8CFGAQ5GJR5ejVsSsUKsiWXFlbmHGCU4mJVEePevkIwV4k1JrKxK
        LcqPLyrNSS0+xGgK9NxEZinR5Hxg7OeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
        LUgtgulj4uCUamA8cOz1wg0Kj49LnruwfKJRY8PnycVflY9bPA41Z5/Crn/x0+rE3z1ui20a
        j3OK3t6XcI0xSvyeS87D30+iZ4T2z4l6uOebpZpjd+/kBTGvphnprorO27V/rlrPzt9305gn
        mBocjuoVPTu9puUVv32A4MMd5dF7j7Ut+Ob3Z0LlHKMfJ19ryb7JVmIpzkg01GIuKk4EAD83
        l7nFAgAA
X-CMS-MailID: 20190701092327eucas1p1cb466d226fa17a1462d0bdf5625ed721
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701033927epcas2p2d7d0b611a0d32b7b208acc787069a83a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701033927epcas2p2d7d0b611a0d32b7b208acc787069a83a
References: <CGME20190701033927epcas2p2d7d0b611a0d32b7b208acc787069a83a@epcas2p2.samsung.com>
        <8baa25c0-498b-d321-4e6a-fe987a4989ba@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.2019 05:39, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> A single driver should not enable (select) an entire subsystem,
> such as INPUT, so change the 'select' to "depends on".
>
> Fixes: d6abe6df706c ("drm/bridge: sil_sii8620: do not have a dependency of RC_CORE")
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
> Linus has written this a couple of times in the last 15 years or so,
> but my search fu cannot find it.  And there are a few drivers in the
> kernel tree that do this, but we shouldn't be adding more that do so.


The proper solution has been already posted [1], but it has not been
applied yet to input tree?

Randy are there chances your patchset will appear in ML in near future,
or should I merge your sii8620 patch alone?


[1]:
https://lore.kernel.org/lkml/20190419081926.13567-2-ronald@innovation.ch/


Regards

Andrzej



>
>  drivers/gpu/drm/bridge/Kconfig |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --- lnx-52-rc7.orig/drivers/gpu/drm/bridge/Kconfig
> +++ lnx-52-rc7/drivers/gpu/drm/bridge/Kconfig
> @@ -83,10 +83,9 @@ config DRM_PARADE_PS8622
>  
>  config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> -	depends on OF
> +	depends on OF && INPUT
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
>  	select RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>
>
>
>

