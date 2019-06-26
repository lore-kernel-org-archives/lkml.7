Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B0DC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678FE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qn6ZRapl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfFZI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:27:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28665 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfFZI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:27:31 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190626082728epoutp039a27e152f1dba9eb7188c47cc336807e~rsjfjVZeW0789507895epoutp03R
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:27:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190626082728epoutp039a27e152f1dba9eb7188c47cc336807e~rsjfjVZeW0789507895epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561537648;
        bh=vIfP/LxFhgg0vmDLe5QOSTmHQKRzGG0ymNFxSAtgHNg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qn6ZRapl1sGYL5arN84TLjCUzgdo3s7oVRk3KtbMx3D1bPwolpBOlYBuMpk6S0t6M
         38DS2xw2jr6MAmN6cDgF/5HGCcco6vohSD8WzIJ4pAjM3pClSGowYYp4gCZtPSQauB
         TodesxgKJDUx3LxogqclzIrSIaEcMtdkMRp7DOPw=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190626082724epcas1p291088a897e2965bf49f01f2cdb5b1568~rsjbQaga61406614066epcas1p2t;
        Wed, 26 Jun 2019 08:27:24 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.5C.04139.86C231D5; Wed, 26 Jun 2019 17:27:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190626082719epcas1p319fda10a53b827fd8821000a4974e589~rsjW4eJkq0522405224epcas1p3o;
        Wed, 26 Jun 2019 08:27:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190626082719epsmtrp2cc293d4bb5c5db9c9bf35ae08973682e~rsjW0qtx-1906619066epsmtrp2E;
        Wed, 26 Jun 2019 08:27:19 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-7e-5d132c682e06
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.67.03662.76C231D5; Wed, 26 Jun 2019 17:27:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626082719epsmtip2504086534107729603952998d99495fd~rsjWp7Jf42640426404epsmtip2c;
        Wed, 26 Jun 2019 08:27:19 +0000 (GMT)
Subject: Re: [PATCH -next] extcon: fix fsa9480 Kconfig warning and build
 errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cd802d12-a246-fc9d-dd2f-7f0f22622e42@samsung.com>
Date:   Wed, 26 Jun 2019 17:29:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1075ea60-6657-ce8d-b527-639b4fc896ec@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se2xLYRT3tbe3HWqfO4+jCepi2UZn19a6YxNiaNQf84iwmLraa531pbcT
        I2FeMwuyDhk1rzBqFhM6psyYmkc8M2LeC/4QYhPCxLza3on99zvn/H7nnN/3HYWUOk6qFLl2
        N++yc1aa7EmcvRqv0VhGx2QnFd0h2YqaapJtDlSQ7JVDRYh9ts5Hsh+flxNsbf0jOVsV+Ikm
        yfXrWlpI/XnvC7n+jC9Bf2N3J6Hf7q9C+i+nh2SSWXlpFp4z8y41bzc5zLn2nHTaMMc4xajV
        JTEaJpUdR6vtnI1PpzNmZmqm5VpDq9DqFZw1P5TK5ASBHjMxzeXId/Nqi0Nwp9O802x1pjoT
        Bc4m5NtzEk0O23gmKWmsNkRcnGcpv7bG2Rq38tiWBnkhah9egqIUgFOg+GURUYJ6Kihch2DX
        rfsSMfiM4MiV513BNwQH7m2Q/pP8vuZDYUzhegS1wWiR1I7g6J69RLgQg2dBjadJFi70w68R
        7D7UFFFL8Wx4/KM1QiJxAjS8ayHDOBoPg0ff30S6KvFEKOv4IAtjAo+EE5vqJGHcH8+HZn+g
        i9MXbu55G+kThSeDb1+nTOw/EJ6+PSAR8VDYULtXGl4CcAcJtT6fRLSQAZ4HHTIRx8D76365
        iFXwpa2eFPFqOH4zSIriYgT+hvtdgmRoqNwRaqQITYiHmsAYMT0MznfuQ+LgPtD2dassTAGs
        hOIiSqQMh+bWF10rDILDm7eQpYj2drPj7WbB282C9/+wg4ioQgN4p2DL4QXGyXT/7dMocqYJ
        2jq08+7MRoQViO6tLBxKZVMyboVQYGtEoJDS/ZSVHM6mlGauYBXvchhd+VZeaETa0Gt7pKr+
        Jkfo6O1uI6Mdm5yczKYwOi3D0AOVxl5PFlI4h3PzeTzv5F3/dBJFlKoQkbrLs43L3xuWkSWl
        5co4g2eJN/rXohr1haX7z5WaC6ba2kb7s+aU/ZoRWx39aqdp7qWqV42xy4IjJsRsu9MbNGvT
        goHvtw3FOLdsessk04VP7fFBaoHqcY/B2oqN7/wpS0xXo8b/edh+UZe6fl71/nIia4ZE53lp
        OkVtPplniBt1gyYEC8ckSF0C9xfskvERvAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvG66jnCsweVNshZz1q9hs7i8aw6b
        xcGFbYwWtxtXsFm8vTOdxWLr3qvsFqt2/WF0YPdovHGDzWPnrLvsHptXaHmcmPGbxaNvyypG
        j8+b5ALYorhsUlJzMstSi/TtErgyph+tK3igUbG8cz97A+N75S5GTg4JAROJf0dXMHYxcnEI
        CexmlHjb/JcJIiEpMe3iUeYuRg4gW1ji8OFikLCQwFtGiVWzMkFsYYFAifUTj7GC9IoIPGGU
        mDvhCwtIglkgSOL9ybtsEA1TGCX2f2IEsdkEtCT2v7gBFucXUJS4+uMxWJxXwE5i0vfXrCA2
        i4CqxOrWHWA3iApESPS1zWaDqBGUODnzCdh8TgFHiRVzf7NC7FKX+DPvEjOELS5x68l8Jghb
        XqJ562zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+du
        YgTHlJbWDsYTJ+IPMQpwMCrx8DbIC8UKsSaWFVfmHmKU4GBWEuFdmigQK8SbklhZlVqUH19U
        mpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoGRaaWFwdMOj/kvTcojRVpunZsh
        tUtm432x+U+C/Hb/nFAa7L9hXXzXncnn3kz8k2MVY+3VF3zyMm/wZCa5u5ltfgmKNZI8Xtuu
        f1Q98/LK3vjAhPLDzI2R+V+T5IKfNn9WTXrIXzE5NfNC4gfvPT+KY58vlr30l2Hx50/afX8n
        lX7/uOPd174uJZbijERDLeai4kQA+/8QpqUCAAA=
X-CMS-MailID: 20190626082719epcas1p319fda10a53b827fd8821000a4974e589
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190626011050epcas1p3793984ff29bca6e3f57861c6ee837c29
References: <CGME20190626011050epcas1p3793984ff29bca6e3f57861c6ee837c29@epcas1p3.samsung.com>
        <1075ea60-6657-ce8d-b527-639b4fc896ec@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 6. 26. 오전 10:10, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Kconfig dependency warning and subsequent build errors caused by
> the Kconfig entry for EXTCON-FSA9480.  It should not select
> REGMAP_I2C unless I2C is already set/enabled.
> 
> WARNING: unmet direct dependencies detected for REGMAP_I2C
>   Depends on [n]: I2C [=n]
>   Selected by [y]:
>   - EXTCON_FSA9480 [=y] && EXTCON [=y] && INPUT [=y]
> 
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_byte_reg_read’:
> ../drivers/base/regmap/regmap-i2c.c:25:2: error: implicit declaration of function ‘i2c_smbus_read_byte_data’ [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_byte_data(i2c, reg);
>   ^
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_byte_reg_write’:
> ../drivers/base/regmap/regmap-i2c.c:43:2: error: implicit declaration of function ‘i2c_smbus_write_byte_data’ [-Werror=implicit-function-declaration]
>   return i2c_smbus_write_byte_data(i2c, reg, val);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_reg_read’:
> ../drivers/base/regmap/regmap-i2c.c:61:2: error: implicit declaration of function ‘i2c_smbus_read_word_data’ [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_word_data(i2c, reg);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_reg_write’:
> ../drivers/base/regmap/regmap-i2c.c:79:2: error: implicit declaration of function ‘i2c_smbus_write_word_data’ [-Werror=implicit-function-declaration]
>   return i2c_smbus_write_word_data(i2c, reg, val);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_read_swapped’:
> ../drivers/base/regmap/regmap-i2c.c:97:2: error: implicit declaration of function ‘i2c_smbus_read_word_swapped’ [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_word_swapped(i2c, reg);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_word_write_swapped’:
> ../drivers/base/regmap/regmap-i2c.c:115:2: error: implicit declaration of function ‘i2c_smbus_write_word_swapped’ [-Werror=implicit-function-declaration]
>   return i2c_smbus_write_word_swapped(i2c, reg, val);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_write’:
> ../drivers/base/regmap/regmap-i2c.c:129:2: error: implicit declaration of function ‘i2c_master_send’ [-Werror=implicit-function-declaration]
>   ret = i2c_master_send(i2c, data, count);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_gather_write’:
> ../drivers/base/regmap/regmap-i2c.c:150:2: error: implicit declaration of function ‘i2c_check_functionality’ [-Werror=implicit-function-declaration]
>   if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_NOSTART))
> ../drivers/base/regmap/regmap-i2c.c:163:2: error: implicit declaration of function ‘i2c_transfer’ [-Werror=implicit-function-declaration]
>   ret = i2c_transfer(i2c->adapter, xfer, 2);
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_smbus_i2c_write’:
> ../drivers/base/regmap/regmap-i2c.c:218:2: error: implicit declaration of function ‘i2c_smbus_write_i2c_block_data’ [-Werror=implicit-function-declaration]
>   return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
> ../drivers/base/regmap/regmap-i2c.c: In function ‘regmap_i2c_smbus_i2c_read’:
> ../drivers/base/regmap/regmap-i2c.c:233:2: error: implicit declaration of function ‘i2c_smbus_read_i2c_block_data’ [-Werror=implicit-function-declaration]
>   ret = i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);
> 
> ../drivers/extcon/extcon-fsa9480.c: In function ‘fsa9480_module_init’:
> ../drivers/extcon/extcon-fsa9480.c:383:2: error: implicit declaration of function ‘i2c_add_driver’ [-Werror=implicit-function-declaration]
>   return i2c_add_driver(&fsa9480_i2c_driver);
> ../drivers/extcon/extcon-fsa9480.c: In function ‘fsa9480_module_exit’:
> ../drivers/extcon/extcon-fsa9480.c:389:2: error: implicit declaration of function ‘i2c_del_driver’ [-Werror=implicit-function-declaration]
>   i2c_del_driver(&fsa9480_i2c_driver);
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Found in mmotm; applies to linux-next.
> 
> To extcon maintainers:  there are a few more extcon driver Kconfig
> entries that seem to have this same problem of selecting REGMAP_I2C
> without checking that I2C is set/enabled.

Thanks for your fixup. I'll check it with more effort.
Applied it.

> 
>  drivers/extcon/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- mmotm-2019-0625-1620.orig/drivers/extcon/Kconfig
> +++ mmotm-2019-0625-1620/drivers/extcon/Kconfig
> @@ -39,7 +39,7 @@ config EXTCON_AXP288
>  
>  config EXTCON_FSA9480
>  	tristate "FSA9480 EXTCON Support"
> -	depends on INPUT
> +	depends on INPUT && I2C
>  	select IRQ_DOMAIN
>  	select REGMAP_I2C
>  	help
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
