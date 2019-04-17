Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95469C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A88A2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mA+9b5fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfDQIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:31:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:26577 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfDQIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:31:51 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190417083149epoutp0489b1b36f62af4d9498841af2001cdcfd~WNdS3s8Rc1654116541epoutp04B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:31:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190417083149epoutp0489b1b36f62af4d9498841af2001cdcfd~WNdS3s8Rc1654116541epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555489909;
        bh=d1z5BcC3mGOYIftRoNCo1RuVPhXlEthHYuTiQv36FiQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mA+9b5fgwpjJAnPImL5zEKZoKLwu7XXRy86YmMlUyKKf18cUhO5q3aOKx9HB9OXHK
         EdaZactf6NWrOEwXLBxwNDQO8Lvkmhkxf305oG6Y57Yzg0zyxIloL0AUqCiBqZZOyN
         p9/g5mb3S3eGm8Vr57adJ7glNFe5LRNxfxdfONmE=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417083145epcas1p1640bb1cd0b15c4e050bb6135edc88899~WNdPn50Tz2003720037epcas1p1C;
        Wed, 17 Apr 2019 08:31:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.10.04108.B64E6BC5; Wed, 17 Apr 2019 17:31:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190417083139epcas1p3125bdccd4ccf8a36c205f61ca295935a~WNdJ88IHh1033610336epcas1p3W;
        Wed, 17 Apr 2019 08:31:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417083139epsmtrp27b3a29c2785ff0ed2903b2fd167156df~WNdJ7j9dJ1354213542epsmtrp29;
        Wed, 17 Apr 2019 08:31:39 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-b8-5cb6e46b867a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.41.03692.B64E6BC5; Wed, 17 Apr 2019 17:31:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417083139epsmtip10dab60a7549a041a58f27d8da5714639~WNdJx2Bht3251632516epsmtip1h;
        Wed, 17 Apr 2019 08:31:39 +0000 (GMT)
Subject: Re: [GIT PULL] extcon fixes for v5.1-rc4
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <80f8e2e9-1b35-7934-a3aa-31bf5f03ec62@samsung.com>
Date:   Wed, 17 Apr 2019 17:32:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416104656.GA2870@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmvm7Ok20xBhM/MllMvHGFxaJ58Xo2
        i8u75rBZ3G5cwebA4rFpVSebx/65a9g9+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtj1cqVjAXrOSs+7V/A2MB4kr2L
        kZNDQsBEYlfvOaYuRi4OIYEdjBJzZs9mgXA+MUpc/X6FGaRKSOAbo8Tss/ZdjBxgHU8+ekCE
        9zJKvNzIDlH/nlHi0tODLCAJYQFDiamvd4NtEBHQkHh59BbYUGaBtYwSJ1YvYQRJsAloSex/
        cYMNxOYXUJS4+uMxWJxXwE7iw70pYItZBFQlOr7dAqsRFYiQuH9sAytEjaDEyZlPwJZxCuhJ
        XOxdDBZnFhCXuPVkPhOELS/RvHU2M8hiCYHrbBL7vq9kgvjZReL/yX6o/4UlXh3fAmVLSXx+
        t5cNwq6WWHnyCBtEcwejxJb9F1ghEsYS+5dOZgIFBbOApsT6XfoQy/gk3n3tYYWEEK9ER5sQ
        RLWyxOUHd6HWSkosbu+EGu8hse3NC8YJjIqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWG
        BabIkb2JEZwatSx3MB4753OIUYCDUYmHl+HP1hgh1sSy4srcQ4wSHMxKIryOKVtihHhTEiur
        Uovy44tKc1KLDzGaAkN7IrOUaHI+MG3nlcQbmhoZGxtbmBiamRoaKonzrndwjhESSE8sSc1O
        TS1ILYLpY+LglGpgFPop9u69peBLkbdzDB2fzl9Uuu+KrXqYwue7WcLfbBlYWDImh3wxzMtd
        odt6cudu6Z2C3bv9SuoidH/6HRR7mrY6KObhM5lnskIGIbZmy7UKXpr7pbP2qByOLPpkaXo7
        xvLGipRQ9zntj08LXbh7RvGfl62id+KLcz3iOlZ+Sz43nrea17dHiaU4I9FQi7moOBEAGNyX
        36MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnG72k20xBisXiVlMvHGFxaJ58Xo2
        i8u75rBZ3G5cwebA4rFpVSebx/65a9g9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK2PVypWM
        Bes5Kz7tX8DYwHiSvYuRg0NCwETiyUePLkZODiGB3YwSB6+kg9gSApIS0y4eZYYoEZY4fLi4
        i5ELqOQto8StlgesIDXCAoYSU1/vZgexRQQ0JF4evcUCUsQssJZR4vjrLiaIjm2MElM6rzOD
        VLEJaEnsf3GDDcTmF1CUuPrjMSOIzStgJ/Hh3hSwGhYBVYmOb7fAakQFIiTOvF/BAlEjKHFy
        5hMwm1NAT+Ji72KwK5gF1CX+zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nL
        AkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwVGipbmD8fKS+EOMAhyMSjy8K35u
        jRFiTSwrrsw9xCjBwawkwuuYsiVGiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp
        2ampBalFMFkmDk6pBkZrzYsPbwmYqcdV3fxpxPkkxnlTnZ1y9QneHV/T1WNzys0W6sXtXc+5
        QNGN9eaddC6NaeXt4u/qI0Vqmm+4vBK11qk8s//TknzmHL4dRcFLJ7raKB0I92vSf6eYVzRp
        X/eqpz2P3Z97T2CX1Sm/mVFeu7y43Jh9hcSxx6wpE47E5mgqNNtfVGIpzkg01GIuKk4EAKK5
        C4+OAgAA
X-CMS-MailID: 20190417083139epcas1p3125bdccd4ccf8a36c205f61ca295935a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096
References: <CGME20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096@epcas1p1.samsung.com>
        <b0dadf5d-ce6f-3767-3d0e-8972f718938f@samsung.com>
        <20190416104656.GA2870@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On 19. 4. 16. 오후 7:46, Greg KH wrote:
> On Fri, Apr 05, 2019 at 10:21:25AM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> This is extcon-fixes pull request for v5.1-rc4. I add detailed description of
>> this pull request on below. Please pull extcon with following updates.
>>
>> Best Regards,
>> Chanwoo Choi
>>
>> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
>>
>>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-5.1-rc4
>>
>> for you to fetch changes up to 86baf800de84eb89615c138d368b14bff5ee7d8a:
>>
>>   extcon: ptn5150: fix COMPILE_TEST dependencies (2019-04-05 10:08:37 +0900)
>>
>> ----------------------------------------------------------------
>> Arnd Bergmann (1):
>>       extcon: ptn5150: fix COMPILE_TEST dependencies
>>
>>  drivers/extcon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Now pulled, sorry for the delay, was on vacation.

Thanks for merge.

> 
> greg k-h
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
