Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1A5ECE58B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15320222CA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WcqjNGqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfJEQa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:30:29 -0400
Received: from mout.web.de ([212.227.15.3]:44017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEQa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570293015;
        bh=87n4kg+fR+Y1+xpvz5fyxHKWdJH95A9k7Flf6LNmjFA=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=WcqjNGqQ58sU8s7B26E2HZ3ve4t/m06v966JI5yt1NzHIoywdmwyv8nJU4RG84bwn
         mRZR0qfDhgte3NYESA445K6/pzVi+ovSpRpEsv6Rn9z+VLVFPQI1QYocEWvY2uwrA/
         RghGu0X1JLNmaZvr6gTsBMU4nlrOEPrpea1E5R9o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAvVk-1iQiZv1nUa-009vyC; Sat, 05
 Oct 2019 18:30:15 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191004200319.22394-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] staging: vt6655: Fix memory leak in vt6655_probe
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        devel@driverdev.osuosl.org
Message-ID: <1d0ba4c6-99ed-e2c9-48a2-ce34b0042876@web.de>
Date:   Sat, 5 Oct 2019 18:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004200319.22394-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:zd5wPEFaPYD2QW+eeMyABcG/UY6DUrEzSELFjAfB1cCB4lcdG/+
 7ttLI3kbeQAJkl7tx9//AF9mZdL5A+V2p3vzckE1CRaDzash0xR9Ap3oJT/EZkZ9MhgCirH
 hRUStdXxeuc+9FA/wsM0Qw6RLdjQTSrGevZ63A1a6H2XYks6AK6LULp4myvq+seevKcfFdl
 YvbRp1TmBi3NaUl4FHhYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/LNEIeoKxk=:H5RziFHM248eXRXAyi+437
 6syRz/mPgRdHCZhNnbiIlkCI8fACKrG1TScrKVYEeEodphajxx2cVP6G5zX6bnnzN0s+84tyX
 CB0R1nFAdNn9ri/ACVCYcbgRxe3X+JxAdBYYLE2Tqospm1jKgF5zYjxS3q8xsdE7c68TWqN0l
 Wlxj43TVzWuDdRmgpQOV3yPiWIXeR+bcRqsRsIbajFenMVGocGv6KTIVIdtwTedzy47BWfos+
 RSdVt8dsD/QQhzgKrEoOo4dxMBmOXpubC82BXLA0Hv0DesY1C3xXOD6u2ui8wKAXxClV2OdMh
 /+DtkqVeX2BTu7ZRjQML9uONFwn/zqlge4X0rqELk8VnokQWKCYC2HDbgYtdgkTZe8AyZDMxK
 7HT/gkwsL/kxkVYhpqqrkUiNw8pfLiecfSXsSpDCI+VQAYKGdWFpyqgk3By+wtAnL1IYrh04u
 HcXxwE69gLMOM+DNqKfkoUxoYg6P5GkVUrkfQtfGelWX8ViIUV/LbMeb+Zlp8Dc+3+OirJLoj
 wwBI1QBp7EkbWDV+spK0/F5uqAtjG8GrTgNgTdR1jcVCov/1qXnWBRWnomwuysZlFshhLE/JG
 q654arTN+rbVuLfU4Yy8E3bquJJFAorlq1vsi85EiBpoOxQAC/v2P0+CQmIQlx+II7y+6KPjq
 rZtRjxxTkHbBehugmQWxmHeNGkUMI86MicIIE66lkFPl6BiMnZZzd8t9HQ6GxQ2DsqaKIJrIW
 eWy7buKVtLtFuyCcAL6s+fBN7q2I/VzrD1IJvb87fFPnExqSxY8+NTxDHoVE/3gGqDc4sNxUF
 +Uf/2HPGMHC3pjZyBwc5MbBVvy4EyQ72GWs9LCsomBkFiNSkxiwNgT8Z43Uih7ynuDJNNK1s5
 eZcqT6hzgkAiM35Vt5efyxuWh/vesx10ozBAwx0oXWhDItQBrQyCT3AQyNxq1/q7HEgi7d3l8
 APA0oQAtp1WDasJPlvJoYIrTmBG6VrEDtrMSJBqQghKPxVGahszaB+BC7UnRsbVX0YtwNAjJl
 ERUPfmlNJdlI5QlZUiecgZ3PGEnqncSb5ECQzkD+GMzBC3lWUxqgEzJCUSdE+O/FJnq/Ka/7k
 a1P0dd/77acfjlYvNk2Zf56Cs4mVlxx7i/q00tVY6dWw07bF9rSZgbi2B4MJOZ4Q7XlnojDi0
 MlZz7L+BBB2hmYFebXJexQeAc8V04LtWTsj4PVzMgMOY6h+v5LgnWoaAepAeNbfQuAd/vp5Eg
 ZoyNQ8Y9ihWcXezUPQyR3m0KHikM9iKPLRDpOkz0UJlS90L9SAT8d0BtAaFE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In vt6655_probe, if vnt_init() fails the cleanup code needs to be called
> like other error handling cases. The call to device_free_info() is
> added.

Please improve this change description.

Regards,
Markus
