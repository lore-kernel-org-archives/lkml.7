Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF63C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E729208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="arF6hBfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfF1K1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:27:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38678 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1K1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:27:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628102720euoutp0213a6631e74cbed16b5c2ac053de4d57c~sVet_7-gu2549325493euoutp02m
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:27:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628102720euoutp0213a6631e74cbed16b5c2ac053de4d57c~sVet_7-gu2549325493euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561717640;
        bh=IR57OlJ6q19NWP/1YHwDGXEZrUWkd2VUa8JWG7Fmdts=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=arF6hBfpe46LgoPZCB2162zlbbgUreatFSTzGJeooRx8XenDqUVxFgTvsWEigLsfR
         ZRpTCsWYHQv5/URBNk+9ax9usqVd5l5NVa6X2/3hfEL7MgknbWPljvQ8wClmVmKvXn
         rJ36jV/Z5AJvqsy+CW25DbFA4w5wa9QTk+y1lRV0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628102720eucas1p12869ba4574dd05263b88133cce69c3d9~sVetaWheX0397803978eucas1p1d;
        Fri, 28 Jun 2019 10:27:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 74.EF.04325.78BE51D5; Fri, 28
        Jun 2019 11:27:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190628102719eucas1p2c601b723f6cefca76a9e9246d7f9447a~sVeszABqC0359603596eucas1p2M;
        Fri, 28 Jun 2019 10:27:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628102719eusmtrp1d776940a506c18ffceed114468c842bb~sVesk5x3t1691316913eusmtrp1k;
        Fri, 28 Jun 2019 10:27:19 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-68-5d15eb87bb13
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.63.04140.68BE51D5; Fri, 28
        Jun 2019 11:27:18 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628102718eusmtip26c0203e6afed48bef2d8aef30b26f4c8~sVesJoY2L1337713377eusmtip2D;
        Fri, 28 Jun 2019 10:27:18 +0000 (GMT)
Subject: Re: [PATCH 2/3] video: fbdev: intelfb: return -ENOMEM on
 framebuffer_alloc() failure
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Maik Broemme <mbroemme@libmpq.org>
Message-ID: <ff1c6cab-ecc0-10e2-b1ad-69d73368a754@samsung.com>
Date:   Fri, 28 Jun 2019 12:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a659cb04-b16c-a3a0-30f4-b2f90b0d7196@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7rtr0VjDf5eN7G48vU9m8WJvg+s
        Fpd3zWGz+HWSyYHF4/rPG0we97uPM3l83iQXwBzFZZOSmpNZllqkb5fAlfHk2lfmgutMFX+3
        bGFrYJzH1MXIySEhYCLR/rWTpYuRi0NIYAWjxP9r89hAEkICXxgl/k61hEh8ZpSYcOwbI0zH
        wenbmCESyxkltix6zAThvGWUWLaoFWyusEC8xOcvr1lAbDYBK4mJ7avAukUEEiRWTJ8BZHNw
        MAuoSVxfVA0S5hWwk5h4sgmshEVAVeL33cWsILaoQITE/WMbWCFqBCVOznwCNpJTwF5i45RW
        ZhCbWUBc4taT+UwQtrzE9rdzwI6TEOhml5jecRDqaheJs0tfMUPYwhKvjm9hh7BlJE5P7mGB
        aFgH9HLHC6ju7YwSyyf/Y4OospY4fPwiK8TVmhLrd+lDhB0lJtw6DxaWEOCTuPFWEOIIPolJ
        26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQvDYLyTuzkLwzC2HvAkaWVYziqaXFuemp
        xcZ5qeV6xYm5xaV56XrJ+bmbGIHp5PS/4193MO77k3SIUYCDUYmHV2GnSKwQa2JZcWXuIUYJ
        DmYlEV7Jc0Ah3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFIN
        jOUPA+VjJj+X0Gzfmip58Vi3Fj+Xyr+se3ezLpcLHnd4mXFVcuL65S+q7Ir82hVl1TN/v78b
        3TDr7Vp7x4yITZPq39Vmf73J5bk0u//RQqsf26cmO+Sc+Wv58n1ldMXFKKb4j2HxLsWaGm/L
        Zz+N2bbb/WTUVC3ub81Txe5sUXtfNyP5wSEjOyWW4oxEQy3mouJEAOKjqVQjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7rtr0VjDfat4LG48vU9m8WJvg+s
        Fpd3zWGz+HWSyYHF4/rPG0we97uPM3l83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/Hk2lfmgutMFX+3bGFrYJzH1MXIySEhYCJxcPo2
        5i5GLg4hgaWMEo/fLGfsYuQASshIHF9fBlEjLPHnWhcbRM1rRolPfY8YQRLCAvESn7+8ZgGx
        2QSsJCa2rwKLiwgkSDx9PZ8NZA6zgJrE9UXVIGEhATuJ5beWsoLYvED2xJNNYOUsAqoSv+8u
        BouLCkRInHm/ggWiRlDi5MwnYDangL3EximtzCA2s4C6xJ95l6BscYlbT+YzQdjyEtvfzmGe
        wCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg9Gw79nPLDsau
        d8GHGAU4GJV4eBV2isQKsSaWFVfmHmKU4GBWEuGVPAcU4k1JrKxKLcqPLyrNSS0+xGgK9NxE
        ZinR5HxgZOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBsX8DA
        cz385vNF9fX7+R60P01f7+T3eqsW/y/Lg8kbdSZuE/GOmH2I/cPqHLbCLveapX3l11xe7tNe
        tVSaUyDO9+Xy87w+pbx7ldfFSXQVffhQvsxpxekvnCFfDNnDqsyu+ijnrpnu1aEg7mBfkhE3
        p/nX3aZjulbzvI8fFDJZ3Oy2+Zsu8w0lluKMREMt5qLiRAAUYFzNtAIAAA==
X-CMS-MailID: 20190628102719eucas1p2c601b723f6cefca76a9e9246d7f9447a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190628102719eucas1p2c601b723f6cefca76a9e9246d7f9447a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190628102719eucas1p2c601b723f6cefca76a9e9246d7f9447a
References: <a659cb04-b16c-a3a0-30f4-b2f90b0d7196@samsung.com>
        <CGME20190628102719eucas1p2c601b723f6cefca76a9e9246d7f9447a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/19 4:48 PM, Bartlomiej Zolnierkiewicz wrote:
> Fix error code from -ENODEV to -ENOMEM.
> 
> Cc: Maik Broemme <mbroemme@libmpq.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
