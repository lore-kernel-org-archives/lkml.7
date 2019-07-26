Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A15C41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A521951
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="btwBiIdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGZP6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:58:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:59389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGZP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564156653;
        bh=qQMv8Gq4VWw3O9pfd3Hcs8DunZMxg+zrMDk3d/xK/Ig=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=btwBiIdpDEYqjFNOFAQZfoI6LC6YCv7SMbakhPOWf43dVDwnvKQzwlTnVN3J2Eg7w
         Vp0xsYm8cr9OECam+mOvuzsqjJb2YxPA4Vpy/ZlXnc6yiWqb5zZWS8zg0NpgIy81xy
         sVq+tHzpofGTGHvTwUZa9eVve65y/rltKpJEZlVA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.127]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1hwrCA3God-00TRbQ; Fri, 26
 Jul 2019 17:57:33 +0200
Subject: Re: [PATCH v2 -next] staging: vc04_services: fix
 used-but-set-variable warning
To:     YueHaibing <yuehaibing@huawei.com>, eric@anholt.net,
        gregkh@linuxfoundation.org, inf.braun@fau.de,
        nishkadg.linux@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190725142716.49276-1-yuehaibing@huawei.com>
 <20190726092621.27972-1-yuehaibing@huawei.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <229b2d16-9623-6005-2e1b-4d1f239643a2@gmx.net>
Date:   Fri, 26 Jul 2019 17:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726092621.27972-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:a2QhRZDV76cNOnjxUp2kDO8bbHN+pQ+5quVTlxjJKZaXVZ8NaaZ
 jaLLWxgnA8kgLJwLh5hRmDmyoaB+0mL5oxcM9ioK+We71b9cPSxIo4RfJjsnDQ5LiM+DRrd
 cEqT6ewd45gEwSuo7F/WosYaSPOtL6R8nN6o65GqjcroVOpVPwZZb1gqtbFzfnDUOlpZDtC
 P19ql6muElPiWevB/OJ5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5yPF2OLnToQ=:YON+oYprlbkfGhoC6RuoYj
 nz07pRF4vW8w4G0wmk9aqybt7RDI33cerMdwgmokxtMhpRSoTyhDRe/0xputZ3tPGHqgzNvnP
 3Hj+ksOssb1Bo5s5XOzuKuaX818IisjjZm36cDLQNrimqpUrt2ATI5W1EMbgU7Vhp28c/MpGj
 0D1IO4n8Ku1iduTVfOJie1joYj+b3oKDCbHULvNmJ8gfmBzI1tHKsMvESj/elfYlTi3v/5NU+
 H+ld7i6+zc6Gq4G/Y7u4cdHnbYlM13ruyGKDz8ZD1hSWRXydTNxr/jH9eMYxFmUGZYW+ab61s
 kal+mn1AELb1IrK/ChExhHmkDXI13Xy/FL+zTFvU9tjMYd5On3xHLm08fbp5ch2mQqBCkrkvH
 hltK4YmbU05PLASo+5iCIPT8KZhr9ZGCNq+AKua7j32FIHOyqcm0tBm0j7km4rg5Ay/NiMHLR
 +e7vfpB+65StkgSe7S7khtwwoN07fPCQR9VxB1dTBJqI1Rwv5QIiCuy3R+yrNnN6BbHN6Fdb7
 XfqZ5FFazb70uJ6VGdmy/iA06X8edPspsc+aV8cQ3LY7DlueSlFLOsBxqLhRuOehhqTuooBAE
 7j8eIB+Uxvkbha24/WkvUjgLN5exo+zScz8kb1iaOX3n4C9MtFeCymUrOdTvSMg3VZ/g3mbrC
 qVLWgmp+blBrPHXr+pZVV6uPZohXTx8mn3LmNAyTG4GRNo0iZfg1HGM4KIzrT0+Ai6Tb4BJ1h
 qKiXdnQ8GtYjYb7p02AHPBtt5c317KFXhqrJUelQ3LD4yzUYqH88qSlsz5eksGX+ge+bhGK5E
 AbVLaGC5DPt3Yt2QU1RvK4Qgeo95M4LJN+O7K05xe10GWV+d/GwAKuqSkX79riGv5YUn7YXIf
 cKRZveHfGQOB4xnXtvA0Tx2Z9uH4Vz0WDj24+aYp096orJBluAdKE5pcoqTM1b9AmFOBhsmix
 l4CISh7f/HWOfUyLX0dbFcCPHUMq4t0V2R+JeIu+HAVOloHTaupOdchmXqUcl6HD4pGWtqG4x
 cjETbP2INxt1vUhSfMRJLaSx7rAZchcbYAmFOJhE/Azdgxe/3srFFJoE2Un9jzmwGoAe0kffc
 dQKRQ9SojxtTmQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Am 26.07.19 um 11:26 schrieb YueHaibing:
> Fix gcc used-but-set-variable warning:

just a nit. It is call "unused-but-set-variable"

Acked-by: Stefan Wahren <wahrenst@gmx.net>

>
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function vchiq_release_internal:
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:16: warning:
>  variable local_entity_uc set but not used [-Wunused-but-set-variable]
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2827:6: warning:
>  variable local_uc set but not used [-Wunused-but-set-variable]
>
> Remove the unused variables 'local_entity_uc' and 'local_uc'
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
