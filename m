Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2850C20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CJYOeogB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfJCR2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:28:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:59037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbfJCR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570123715;
        bh=1/9ytc+GiSYLmzLUQTHXod+HPAelk3SiwurUk+Qr1yw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CJYOeogBGQo0GZboKNzoPTNFGJP7gyTe8ysUI62iHOFyQnMY/RnxxLPJXFY3m6aVU
         LoTHWUKCu1EBTOKHcImQvCF7pGjJ1bhUlh7jiJmQe4t+EjMIAidDjTbuVrYLfx7vYC
         w/NihBJnoa8wfRFhVXlCTAk5cLTu2mniycEzcyRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.116]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1i19Lu1F6X-00tPuP; Thu, 03
 Oct 2019 19:28:35 +0200
Subject: Re: [PATCH] ARM: dt: check MPIDR on MP devices built without SMP
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20191002114508.1089-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <e2487ea8-67d0-b850-af63-683dff498275@gmx.net>
Date:   Thu, 3 Oct 2019 19:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002114508.1089-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:sY96XPCdbmODy3ENQlqjYJoCke2gtAyeaRHQ/ewzjOXNOxvx0/A
 qbuh9Z8YocIKS/wvcaobPGkEZeoW4UtoD0zFjrSOTvzB2S3MjUxsBhQ0ELhAx8mZNPUS83w
 sJU+6SLWL1qvXoaSnaGzdmjFYgEz2yAcUD6v3dnb7VNTV1KVvYl8aChNgpanuSYxw6Ooejb
 lzhdZTT81abj3HPqjb7Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8KbZNVHwWY=:JS9pNupe6kR583TYXbT6TH
 UaYtQkAAEYgrXx7mWwajxIETZwCTKTyfva4pSeSaX7cazQDSxqwSsPJhjS7cdcmmy9sQaI/Kl
 ZPUIbAvFllW1gJeQclovYN+ID6gkzaMlTkpntqQdFOiqMwdB9kWBRlwLWd/Os2Lt/HtjqTsH7
 clN650pzstI/5hsZgQv0a3EQ/DxCvRpY/8uGnREMtW9ZPBI/0OIMfqsbPugdM7C64PqPlmL4U
 Be7tTEsnYYjwkbnyujZv9BQzfhgJlk8P0pvNoPca8hexkDfh+wJktFtScnPyBk8jQpKNNqJ1U
 qEWDDfTPEKAGox6UXUphWMe4YYSZAnQ279D2rkSiX7r6tRGUjVaXnBoQ5DyK/zdz7U5hwKrdx
 H9pJq1WTRnxyWfLEd2SjStCS21pTbrVjmUkhfSH2t3XlTUX7Pogzel3vB4Oi9m1CEcRzqc0+J
 PD1410f+rGm3bogyd74o8CoeLRjexA1BH3Jkh8mK2HnNMq2RxvV27KZuAyU3wXPxSuNTG6tYQ
 G74aUtPwn99fsFNLvFfSDjnlJLePz0oOWkHkkFe3xckF09Y/CXopTtHqVC/mQa2GnxfTF71qK
 WWMtgGBAEjPsVZBr/T6V0GVhdRt9+36/OGfBX+d9NVoZIK0om+hY6X17Ia8eH6syUhSH1xtn3
 +HuqlQRJhrAaz8/6JqAtJIlG6VLlVj1gaYk+CHTIF3EheK4TtFZN0lGe+i7zEKvHbplLAqFca
 NwZEgiXI+KrRZMEtRTUcET8luQRjYcvMMDySRsAgs8oF4vHpgh1APRkDI5MDHZ1ElOHVH+y4d
 a7krHpVFk1jDG4Ys5MIz9qqNQBmrI7BQP2dXnTKRqzqUQ4hU4SAqe5KOOEVF/t3A+xu8G2Rhh
 MNenCWNqmHz2whisbbp691OBNxgoyfmkjuN6HNUrDuYIJduP470F2eEl+FMt6/YYR81rao86a
 llJwZcWjVcfqdRXISg1Zts5SYFaX1p9dR2/QP0oQIx6cuME3WurlroEaZbCDvxRFRceKYYHLv
 d0qxN6w6yhr40yA/z6uYWDXed1uC7op1mBAAcdY2VmScyOTYhrcAh1905754n7hkHSui+54WF
 kFgiSrnuft9aeSd957wKJM77N8Sy9yK9folc2RmpjN1vWWGyIbiUGmfJPLyw/kpv/JMCPLuNM
 8WG0zHrZlsx+0mC7feEPs/WQizIYfHZ2EpuImNcxT5R9IiSVGlEH4BXuHzAvyY88i65WfOyEy
 rJH4oBbAkzVsVbea10jG63+VJPQC75sq9fo33wFraGHKOPztjKmjBqLRpleQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.10.19 um 13:45 schrieb Nicolas Saenz Julienne:
> Currently, in arm_dt_init_cpu_maps(), the hwid of the boot CPU is read
> from MPIDR on SMP devices and set to 0 for non SMP. This value is then
> matched with the DT cpu nodes' reg property in order to find the boot
> CPU in DT.
>
> On MP devices build without SMP the cpu DT node contains the expected
> MPIDR yet the hwid is set to 0. With this the function fails to match
> the cpus and uses the default CPU logical map. Making it impossible to
> get the CPU's DT node further down the line. This causes issues with
> cpufreq-dt, as it triggers warnings when not finding a suitable DT node
> on CPU0.
>
> Change the way we choose whether to get MPIDR or not. Instead of
> depending on SMP check the number of CPUs defined in DT. Anything > 1
> means MPIDR will be available.
>
> This was seen on a Raspberry Pi 2 build with bcm2835_defconfig.
>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Tested-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

