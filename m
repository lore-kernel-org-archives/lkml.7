Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D15C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E05A20867
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I2Bz8yw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403844AbfJCQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:31:11 -0400
Received: from mout.web.de ([212.227.17.11]:42687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403824AbfJCQbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570120240;
        bh=tb+bIDGQBs+ntTnSgfe0s9MwVA9SDsOiJM4Tsjn0pPg=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=I2Bz8yw+bcYsr2MrVHtp1Gn3X2f3w6992XseqcUqBKj1XyHEe+MGvkKVgaAQeE/pF
         nLxIt87ATFNxZgMBs14LsC/xYL9LvRfUprRFN+ZuDF0/AZhq4ioWle+L2yuAgJw57F
         Bh9fWsFZS++YHY/gpq/BWumwxMuxRUiEfdvv3W1E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.81.27]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M40zO-1hy7TR3OpW-00razP; Thu, 03
 Oct 2019 18:30:39 +0200
Cc:     linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        YueHaibing <yuehaibing@huawei.com>
References: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0765d504-cc91-baea-ae3d-ec4c0a2c194c@web.de>
Date:   Thu, 3 Oct 2019 18:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F+JSg/0mwKCAcWtRTNJc2ejjAS/1qD7UsMGj1o3osY0iza+S8a6
 cc1pTlF7bCaF2dBac/nvPgJF/+Myuo4xu+ZbNN2BIfTVTrwOEbEkRQkbH2uZabj3c2e75RY
 PObmsRP8U6gau3LKyHmPGN2+8Xnp+Jdzc/rMxhtViPQqWrXnZlVpig+qg8g5AhP7gDqPH+3
 QcqGrbYmPpWj0u5vhRFRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+afk+NT2GQ=:SbY7XsYtOCe10YoRpQH3Hv
 0IxBVlyx1+IymGVO8r9Ws8uTh1WOF7I43f8Ptjpcogk9fDOue/u7aqEa+668Qc3i9k7Q+1/b+
 37xC6NLksQzMcEDTD5iDjOR7elwAj/hioxr1CL4Y4ETOXIwoC3g0QlTzWhe0bZfVyTQckjJJT
 CKijSUqLq6Od0fPnCMag2mrefWWhcJoEwmcVTLIA9MIb2kuvO00c/jdPs59lepwBIa31M5ZJ1
 w87snanqMiiO5Ym3rf86GpX6TR+IsqJET55VYChoPBLGM9/p8pj4+c3GY05HtAIFTO6nZVOEF
 UXt7i9PSOtFeqhL/MXeV2hu2D2TeE8Y/AYYZF5RwrWKZn88xooOqWIC0G/YoJ9qeeyjNh8m1v
 ENGmUTmrmpNcQfnD/6zTeB1fEk4wJKoCzpo+CtO0V5/c7NFFPP6VwGnW5V3RMUUrL6mHokGsi
 2lbefx2FhvpoX9hAjUgsD0sV1nFX13KDs5YzNIKFybqzufj8OAYJba+NU1JEFntSbR5AcpwL+
 Rm4yPZwyDhUOddcUwvAOVWTGloXosoJab5rmqHula38gFEq8hwXDVuSo7ViJmq9t+21NEsrHR
 /bXQeBMeC5LPKgadupnya/pbGSm0KSOuZvUoRo6l0feHzKALVKf9suC8jfNa3jy423MxnDDMz
 SkvZ57OnL2kRdX/imB5w9yryTjdKnQ989Qr7VwXjDwQmTgsgbiYfTvGzkfLbIl/xsd9qeiOj/
 byM4ZK31hEBk+aefUFB2SbCgU100Qj8uEoGMDjb4rU7DP2zfKa+T9Td8/yZitae/KfRO4C0O3
 Lmj2ulVRkXTdZAr0Pj50pu9msqcjdk4xC9moryGQCkEIULporjGvvdLXqwyFgTFD11mUKiwNI
 hYeOyjoyUpdMkKv5PTaLot9GtZpIuLFbjx9CTPYByF+cAthJlnysSMkjh+3KRKBybQK6NI7ZS
 emWgLaFmOcZmrzYaoyYEed14RWsCU9ubwHXUHjpumtfvYCrYFMpzw8ogZ6IrjmQARI7RTPMZw
 bcnO/LVMZGXuVrijfhb9AzwVEV/X8Ya9pFeTMP+B25AbVDH2AtaNQY/6/UZA2JcJ2A+nnSrFO
 ZsyRJyYRUKJ7+HegZqshNjdzgHNSMigdgaO7RMB5xfH4N8VLINsSYPrbavMW+X1mM+wp2WjoN
 SI1Vslnp6kbF95ZaoKNDhMF8I3OPL3JBHu77hNpjqLnbVor6A5GcsoNnSB/Fiw+mLRZnq4CK9
 /rjiT2Gz2k9ky6SJw0f0pQ62g1W2K3AXoMnat8AnO0JQCZqF2tlVAoTihyns=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Was this patch posted somewhere?

Yes, of course.

YueHaibing's update suggestions are available also by the usual
mailing list archive interfaces.
How do you think about to avoid the addition of the SmPL variable
=E2=80=9Cvirtual report=E2=80=9D to the script =E2=80=9Cadd_namespace.cocc=
i=E2=80=9D if you would dare
to integrate my change proposal for an adjusted directory hierarchy?

Regards,
Markus
