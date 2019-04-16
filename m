Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC62C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E76C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hrdB5Rce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfDPIiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:38:03 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:31128 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPIiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:38:02 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190416083800epoutp044d1d359c5cc0c8534b14cd0876eb151a~V55a8hXu81698016980epoutp04I
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:38:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190416083800epoutp044d1d359c5cc0c8534b14cd0876eb151a~V55a8hXu81698016980epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555403880;
        bh=bR6l3o2kzr7v3fmE/FvSywSlUIF7Spki21FG/KMyfi0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hrdB5RceKrpkOXsoGIuHa0CkU5oLgcKPs7QjtPg7tbm6Eah1Dw5LAPnf3/edNiPkq
         TX/UnSEHiUujxlCeqJySs2o0f0fhKRmAiaB8SpzKkIQjFSSye6Ccn+xLapHNc0WiVx
         fJJikKfpvVTF+T702dQt1QwNMkJlTDIAUzDGlpkQ=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416083758epcas1p28d66834d2242fc0775573a7e00dcd137~V55ZDatF92363523635epcas1p2F;
        Tue, 16 Apr 2019 08:37:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.30.04108.F5495BC5; Tue, 16 Apr 2019 17:37:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190416083751epcas1p4c3685d84f0bcd785756b76e7ecc049b5~V55SLECqz3211532115epcas1p4u;
        Tue, 16 Apr 2019 08:37:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416083751epsmtrp2917cb91ac63ca1bddbffc7cb4de732bf~V55SKeeNa0442204422epsmtrp2u;
        Tue, 16 Apr 2019 08:37:51 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-ad-5cb5945fbf9d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.95.03692.F5495BC5; Tue, 16 Apr 2019 17:37:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416083751epsmtip1f9a77cf4b67b35efaea306d2f1992305~V55SDmXQV0986009860epsmtip1r;
        Tue, 16 Apr 2019 08:37:51 +0000 (GMT)
Subject: Re: [GIT PULL] extcon fixes for v5.1-rc4
To:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <bb7ae342-2cc7-aff2-cac0-190baa7b1e61@samsung.com>
Date:   Tue, 16 Apr 2019 17:38:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b0dadf5d-ce6f-3767-3d0e-8972f718938f@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3e6uV2v1Nk1P/ii7JaGg7s5mM9Q+FjXQQqkfEcK6uIsz98Xu
        JmVExsrSorK00swkK1QCY00Rw4ZafkCJpaZpmqU/pJVFpkgQte0u8t/znvOc85znvIcSy66Q
        kVSeycZZTayBJkOIlq6YuDhteXO2/NaSSlU2OkSoHHVNpGqwrZpUjZ+pJ3cSGmdjCalx33kU
        pLnsakSaeef6TOJIfoqeY3WcNYoz5Zh1eabcVDr9oFatVSbJmTgmWbWNjjKxRi6V3pORGbc3
        z+CVpKMKWIPdG8pkeZ5OSEuxmu02Lkpv5m2pNGfRGSzJlnieNfJ2U258jtm4nZHLFUov8Wi+
        /ma1g7Q4qeMvFheDitAHshQFU4C3Qm3lO5EPy3ArgoqaLaUoxIt/IHhX8oYUHosIbna2if5V
        zE+dFQmJdgQXF+4HWN8QXH/m8LNCMQMVnqdBpYiiwnAezJ0T+aAYG8Bdk+JjkDgW3LOj/ilW
        440wvDSNfFiK06C495kfEzgaHg7P+DuuxYfhQ/djicBZA32VM4QPB+MdcK3Y4eeLcQSMzdwV
        CXgDOJpvi32jAX5Jwvik0BTwHm/Bn4CZUPjc4woScCTMz7UH1nISGvqek0LxBQQu94BESCSC
        +8H1gJkYaGpLEMRWwdzCJYkvDFgKF4plAnsTDE5NBKTWQd35kkB7DbR8mUVX0caqZXaqllmo
        Wmah6r9YLSIaUThn4Y25HM9YlMv/2on8xxib3Iq6+zM6EaYQvVJKXXJlyyRsAX/C2ImAEtNh
        0l06b0iqY08Uclaz1mo3cHwnUnq3XSaOXJtj9p62yaZllIrExETVViZJyTB0hLRppzpbhnNZ
        G5fPcRbO+q9ORAVHFqGy11mnPYXlo44Bz/Ci5saKrFM4pr0hfLhySXug36MY0u4b36bY3Ke4
        Jxe/6ooP/TlxbErf0U2k71D/pvtqyXXhafYnvZODsvprL86igQ5jzPxblEpXfzxkVo/8iube
        qyaKZxPUYV/3e8p2j2VIzn9yfC/STT8tGul5rq6uR4M0wetZJlZs5dm/NgKGdqIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG78lK0xBgtXy1hMvHGFxaJ58Xo2
        i8u75rBZ3G5cwebA4rFpVSebx/65a9g9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK2P6nGa2
        gk0cFUe/fWNvYLzP1sXIySEhYCLx+UELUxcjF4eQwG5GiS/XVrBCJCQlpl08ytzFyAFkC0sc
        PlwMUfOWUeJ6yw+wZmEBQ4mpr3ezg9giApkSEzu2gPUyC+RIHNvbzg7RMIlRYtOqY2AJNgEt
        if0vboA18wsoSlz98ZgRxOYVsJNoO7EPzGYRUJVYdvUJE4gtKhAhceb9ChaIGkGJkzOfgNmc
        AvYSk9qaGSGWqUv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxgl
        UwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxguNES3MH4+Ul8YcYBTgYlXh4E/q2xAixJpYV
        V+YeYpTgYFYS4XVMAQrxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgm
        y8TBKdXAuHpx+ySZuZIpJZua2GZb+3C6G71IEI+8Pddm4xYW3ZCv12Vqq0vZo2pvs/zmT7GJ
        3/f09re9TV+63qxfL/mpw/v9safb9e8c015ac+WEqpWVWeF2xvtuRTPfsGqu/X/HXp498Ib8
        3J3HJp1RTv+yZOfS0syzTzk2bmLXuBG9xbhiVYlWfLjoaSWW4oxEQy3mouJEAKzVX5KPAgAA
X-CMS-MailID: 20190416083751epcas1p4c3685d84f0bcd785756b76e7ecc049b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096
References: <CGME20190405012051epcas1p14b640a6ebdc9d259d55df97b4e3b1096@epcas1p1.samsung.com>
        <b0dadf5d-ce6f-3767-3d0e-8972f718938f@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

Gently ping.

Best Regards,
Chanwoo Choi

On 19. 4. 5. 오전 10:21, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-fixes pull request for v5.1-rc4. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
> 
>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-5.1-rc4
> 
> for you to fetch changes up to 86baf800de84eb89615c138d368b14bff5ee7d8a:
> 
>   extcon: ptn5150: fix COMPILE_TEST dependencies (2019-04-05 10:08:37 +0900)
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       extcon: ptn5150: fix COMPILE_TEST dependencies
> 
>  drivers/extcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
