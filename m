Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B84C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA6421D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jH9P6cEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgACLiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:38:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50048 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:38:46 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200103113844euoutp016db5975666a03600428eb506880b85f1~mXYAfMho30815508155euoutp01D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 11:38:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200103113844euoutp016db5975666a03600428eb506880b85f1~mXYAfMho30815508155euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578051524;
        bh=arudGcoc+C6m1BJC+20hGHyM7CgsaKpi0vt+2+tPm+Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jH9P6cEcXyHw0apwzdHroYuBaielz15VWNmeuwJfBqtK5yq2+WvAo/JgGp5QJ/rYO
         cYqUmDEFpVyQHQabE9CTIILdjkzXATU3M9dGbrFgsBno96IeizvOVWD/zrwtMldzpc
         xOexFeQq9yRxaJatOaYlwTlcSHIu3thBtaXxtjy0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200103113843eucas1p13c77707f315ea2ebcc0416cb878ebeaa~mXYALpIwQ2505425054eucas1p1h;
        Fri,  3 Jan 2020 11:38:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 50.E6.61286.3C72F0E5; Fri,  3
        Jan 2020 11:38:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200103113843eucas1p2eadd8977c0d32c461145ec04e6033d8b~mXX-vVO2b1942519425eucas1p2y;
        Fri,  3 Jan 2020 11:38:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103113843eusmtrp2d2b911d7fab0bee7173f869ad67bd78a~mXX-uyGzZ0326803268eusmtrp2Q;
        Fri,  3 Jan 2020 11:38:43 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-0e-5e0f27c32c81
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.D0.07950.3C72F0E5; Fri,  3
        Jan 2020 11:38:43 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103113843eusmtip12eafddbdc95b285423503f1995a4a78d~mXX-bhVuR1164911649eusmtip1e;
        Fri,  3 Jan 2020 11:38:43 +0000 (GMT)
Subject: Re: [PATCH 2/3] video: fbdev: mmp: add COMPILE_TEST support
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <21153de6-885a-b52f-e051-0d6070daf2e9@samsung.com>
Date:   Fri, 3 Jan 2020 12:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <28d91688-6df2-9207-7d88-34d024baf727@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87qH1fnjDKZeN7W4te4cq8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJVx5uct9oIV/BW3
        D/YwNTA+5uli5OCQEDCReLvArIuRi0NIYAWjRNvvC4wQzhdGiRN3jzJBOJ8ZJTYuvMbexcgJ
        1jF301EWiMRyRomFa3ezQjhvGSXOrZ0NViUs4CIxt38PG4gtIqAuMfvkHWYQm1kgQeLLzc9g
        NpuAlcTE9lWMIDavgJ3Ess03wOIsAioSdyfPZwKxRQUiJD49OMwKUSMocXLmExYQm1PAXmL5
        ownsEDPFJW49gahnFpCXaN46mxnkIAmBbnaJxx8vM0Kc7SJxbO5EJghbWOLV8S1Q78hI/N85
        nwmiYR2jxN+OF1Dd2xkllk/+xwZRZS1x59wvNlCQMQtoSqzfpQ8RdpTYfW0jEyQk+SRuvBWE
        OIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULyziwk78xC2LuAkWUVo3hq
        aXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYEo5/e/4px2MXy8lHWIU4GBU4uFNUOaPE2JNLCuu
        zD3EKMHBrCTCWx7IGyfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKY
        LBMHp1QD4/yTUesnBkxcxJiiufqplUTmr53CZhUXmq7+yvz/YJ3Qve3l09s05Nq/M97ZF+Vj
        OiO0bcvSM1dNXQ4uWcPQ8ueylo2N0qKA/e+Oz7ELObaYN57dWbdJemXf1R3WQrXeV8wePbwp
        8rgtcL3Pl8/x9idUb65hfhxumndlpntlLr9xbtOUiWbTjyqxFGckGmoxFxUnAgCJ3f45JQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7qH1fnjDJbfkrS4te4cq8WVr+/Z
        LE70fWC1uLxrDpsDi8f97uNMHn1bVjF6fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx5uct9oIV/BW3D/YwNTA+5uli5OSQEDCRmLvp
        KAuILSSwlFHi1k+RLkYOoLiMxPH1ZRAlwhJ/rnWxdTFyAZW8ZpTY+LORDSQhLOAiMbd/D5gt
        IqAuMfvkHWaIouOMEguX3WUGSTALJEhsuj8VrIhNwEpiYvsqRhCbV8BOYtnmG2A1LAIqEncn
        z2cCsUUFIiQO75gFVSMocXLmE7DjOAXsJZY/msAOMVNd4s+8S1DzxSVuPYHoZRaQl2jeOpt5
        AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBEbTt2M8tOxi7
        3gUfYhTgYFTi4eVQ5I8TYk0sK67MPcQowcGsJMJbHsgbJ8SbklhZlVqUH19UmpNafIjRFOi5
        icxSosn5wOjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqL3i
        oAnDwltT/1pKmfXcc7p4y0Fpw8E60YYDHWuuxU9XU7nh4vXDO8vveYtJ4o3TmQF6CnkveJ6x
        vj80ecLmFAnrmWlyBfdZ7+oab/opJdv7cv+2m3NVJz1W6HAXzHno80f2iO37Dq6DqXp97Xmd
        olOVnk6aOzfMJTGm6MfDSpa5zDrGW5vNlFiKMxINtZiLihMBDbLqXLYCAAA=
X-CMS-MailID: 20200103113843eucas1p2eadd8977c0d32c461145ec04e6033d8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c
References: <CGME20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c@eucas1p1.samsung.com>
        <d21a19ea-8c18-80df-ae79-76de7c5ee67c@samsung.com>
        <28d91688-6df2-9207-7d88-34d024baf727@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/20/19 11:56 AM, Andrzej Hajda wrote:
> On 27.06.2019 16:07, Bartlomiej Zolnierkiewicz wrote:
>> Add COMPILE_TEST support to mmp display subsystem for better compile
>> testing coverage.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, I've queued the patch for v5.6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  --
> Regards
> Andrzej
> 
> 
>> ---
>>  drivers/video/fbdev/mmp/Kconfig    |    2 +-
>>  drivers/video/fbdev/mmp/hw/Kconfig |    3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> Index: b/drivers/video/fbdev/mmp/Kconfig
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/Kconfig
>> +++ b/drivers/video/fbdev/mmp/Kconfig
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  menuconfig MMP_DISP
>>  	tristate "Marvell MMP Display Subsystem support"
>> -	depends on CPU_PXA910 || CPU_MMP2
>> +	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
>>  	help
>>  	  Marvell Display Subsystem support.
>>  
>> Index: b/drivers/video/fbdev/mmp/hw/Kconfig
>> ===================================================================
>> --- a/drivers/video/fbdev/mmp/hw/Kconfig
>> +++ b/drivers/video/fbdev/mmp/hw/Kconfig
>> @@ -1,7 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  config MMP_DISP_CONTROLLER
>>  	bool "mmp display controller hw support"
>> -	depends on CPU_PXA910 || CPU_MMP2
>> +	depends on HAVE_CLK && HAS_IOMEM
>> +	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
>>  	help
>>  		Marvell MMP display hw controller support
>>  		this controller is used on Marvell PXA910 and
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
