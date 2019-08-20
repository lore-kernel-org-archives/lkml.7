Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A97DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C61214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U8+1JORN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfHTQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:55:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50652 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfHTQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:55:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190820165527euoutp026cd34482037349be80295b7d265001ec~8r9tk2KsS1494914949euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:55:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190820165527euoutp026cd34482037349be80295b7d265001ec~8r9tk2KsS1494914949euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566320127;
        bh=li/0tzXuJt9yS0hPXQDqDRBE64v+UGsLf5a0R5Op65s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U8+1JORNmSkSjliTjS+HpxTmESkECObRQ5kwZXVPIrN25MkaCiPTI94qYqusvCL0S
         iss3d4CUXZs0THf7EfyvhZGlJTw0xRN8p+SrUF08hyzsNoiC3AEDVFImg+VAFfLVSx
         SdTaGYJ9UaMZMV2PDysE/HonrBn/5Gm/ZtIQ1rC8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820165526eucas1p2594cfdd080957edee8b45d9e84ad2217~8r9sy3EQP3014330143eucas1p2s;
        Tue, 20 Aug 2019 16:55:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 41.62.04374.EF52C5D5; Tue, 20
        Aug 2019 17:55:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190820165525eucas1p2c98ae7d5e46db1c666c1451033e2bcb4~8r9sA25qQ2380723807eucas1p2L;
        Tue, 20 Aug 2019 16:55:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190820165525eusmtrp23fde9f1f1b854433c6d7819aef5ec37d~8r9ryxDJK0532405324eusmtrp2h;
        Tue, 20 Aug 2019 16:55:25 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-98-5d5c25fe8a35
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.C8.04166.DF52C5D5; Tue, 20
        Aug 2019 17:55:25 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190820165524eusmtip1f27b2cac9b793b64ac808a6c1cae7069~8r9rV7blN2012320123eusmtip1P;
        Tue, 20 Aug 2019 16:55:24 +0000 (GMT)
Subject: Re: [PATCH v5] ata/pata_buddha: Probe via modalias instead of
 initcall
To:     Max Staudt <max@enpas.org>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, schmitzmic@gmail.com,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a5f087c0-2caa-c976-9551-8642170a8883@samsung.com>
Date:   Tue, 20 Aug 2019 18:55:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b91ccdbd-c955-9ff2-502d-e8e80e181b52@enpas.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87r/VGNiDb5+Z7VYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFsUl01Kak5mWWqRvl0CV8aBNb8YC2ayVDy4vpu5gXE9cxcjJ4eEgInE4Q9N
        rCC2kMAKRolbJ1m6GLmA7C+MEv+PPIRyPjNKHFqzhw2mY+HnA6wQieWMEnfn/GeHcN4ySlw9
        vIkJpEpYIFBixvvH7CC2iICcxMfWq4wgRcwC2xgljp5+BZZgE7CSmNi+ihHE5hWwk2hq2QBk
        c3CwCKhKfJikABIWFYiQuH9sAytEiaDEyZlPWEBsTgFbiQs7NoPFmQXEJW49mc8EYctLbH87
        B+q3Y+wS91YUg4yUEHCReHJRDCIsLPHq+BZ2CFtG4v9OkFYuIHsdo8TfjhfMEM52Ronlk/9B
        vWwtcfj4RVaQQcwCmhLrd+lDhB0ldn/fxQQxn0/ixltBiBP4JCZtm84MEeaV6GgTgqhWk9iw
        bAMbzNqunSuZJzAqzULy2Cwkz8xC8swshL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn
        525iBCak0/+Of93BuO9P0iFGAQ5GJR7ehOvRsUKsiWXFlbmHGCU4mJVEeCvmRMUK8aYkVlal
        FuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYAxb03ynv+PNrl8vp/U6
        us+Kk8+rm8PlZXAiPkg/dLtFRPRSx5sLIsJ/vWpadfXWOneRFxvuSdj155jqmGk8a3DZ8iGc
        VXzv59/Hb+jm/7hR9sHy28ubpQrvJI/PtNjf+8y4u7S2deVByz2MIRqlV+o/PQ7RPHi49cCH
        vwuWrA5l9N8bzP5l93slluKMREMt5qLiRAAT31tJRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7p/VWNiDXa8FLJYfbefzeLZrb1M
        FrPfK1sc2/GIyeLyrjlsFrvf32e0eNj0gclibut0dgcOj8NfN7N57Jx1l93j8tlSj0OHOxg9
        Dp47x+jxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsaBNb8YC2ayVDy4vpu5gXE9cxcjJ4eEgInEws8HWLsYuTiEBJYyShxZ0wrkcAAl
        ZCSOry+DqBGW+HOtiw2i5jWjxIoHWxhBEsICgRIz3j9mB7FFBOQkPrZeZQQpYhbYxijx9dp0
        RoiOd4wSN78+ZQWpYhOwkpjYvgqsm1fATqKpZQMjyDYWAVWJD5MUQMKiAhESZ96vYIEoEZQ4
        OfMJmM0pYCtxYcdmsDHMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJ
        ywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBUbjt2M/NOxgvbQw+xCjAwajEw7vjZnSs
        EGtiWXFl7iFGCQ5mJRHeijlRsUK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0wQeSXxhqaG
        5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGH2nbzfzbVnVr6SXFG/vs9Ve
        88LOo4/fLs3yDX00K6vrlJZWi98KobX7N99602mz+fJEIz7hVY8NF71cm6JcFLd30ZvYX5fa
        z1xmbF2sUpeqHXTOqIhlfkHTi3PnV7s/X5Ok6fbhidal6rXbD9zZdS8hIZ7b6/PSWuG/6wMK
        hWftm3bgwZkD3e1KLMUZiYZazEXFiQAu6mUN2AIAAA==
X-CMS-MailID: 20190820165525eucas1p2c98ae7d5e46db1c666c1451033e2bcb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c
References: <CGME20190812164840epcas2p4b88d3ebaf313f0c99ccb693047bce04c@epcas2p4.samsung.com>
        <20190812164830.16244-1-max@enpas.org>
        <9966f79c-278b-5ec9-3c4b-e1de55af55f0@samsung.com>
        <b91ccdbd-c955-9ff2-502d-e8e80e181b52@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 6:42 PM, Max Staudt wrote:
> Hi Bartlomiej,
> 
> On 08/20/2019 02:06 PM, Bartlomiej Zolnierkiewicz wrote:
>> WARNING: line over 80 characters
>> #354: FILE: drivers/ata/pata_buddha.c:287:
>> +        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
> 
> I see no good way to shorten this one. I think it's obvious enough to allow overflowing by a few chars - do you agree?

Yes, I agree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
