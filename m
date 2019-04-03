Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E266C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47B62075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ElYrKIgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDCOYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:24:07 -0400
Received: from mout.web.de ([217.72.192.78]:33181 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfDCOYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554301437;
        bh=yLanSsWQDAbT24V98EHzftp/emW8dqpvJFH9gryEI5g=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=ElYrKIgtWaQ78PLG0JgrOyMzHn8jefeAnkzInCPiBbffl7JCVMwqs0jbwNsjbHgcD
         PhLTetAzJEN7bZkODGFZB/s+UlQKIsYoqPI+9/zstpr4x4wBu6fAweKtw5/ozODc4n
         5MCjgjlcvXvHUNlFN+yr8VNz0o1DR2iH33Shwxt0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.115.60]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcV4-1hIrnr2KWQ-007FNl; Wed, 03
 Apr 2019 16:23:57 +0200
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [5/7] cpufreq/pasemi: Checking implementation of
 pas_cpufreq_cpu_init()
To:     Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
Date:   Wed, 3 Apr 2019 16:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3s/asdTdcxZ1lSGA/kR668i/m0CEywgCZlQOwvwZo4Hh9XSQCuY
 mJvCUhPpP9MraubGwRF8XG8Z2ugPn5bgLOs5u9/GXtrwlnaT83mV3KcURPdf+fiGPtenD7b
 ObletnjW3BV7lQvWMVm+PXYS2k3Iok3yU3+QTr+g9191FtnIrhjlubdZB4UR2jGbojVvP7V
 p8+7Bcz7HULFySZacWJ/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ugs3oOaf2Ks=:HwHOeR6CzdEDi/wSqFl/bn
 A3cV+cEK6cbXnwVPT/HElW1p2AebmK/tsHAqtgyao++eTetRgkIkVQbKAt923wk+DOGUrPAEx
 TxMlPj2UbgsPUd2wmmrDdfJO+II46axGQiuohcGMhGO62yL8NYzF3tpBPvgReyXh8lp8/s862
 pHeK3j7z8mSJCxAxWJw+eDSy//vmD5b7XcLrDOMVMOBLuZmL8MPaBfvXW8TT81iqXp2OUjCBp
 //0eygb50sOsSXnIq+yZ4hlv70Nu1Nexb2112JkiZC5r2YLGioWtaf1/LqU4goX5oYY4wQXy7
 Kx/pLGoq0mcIoIK8CYZymKe70dPRMIov5+a5uAN7t/zZ7HTJfEZewSlTuoD+eb2FvAD3uw8fw
 RO2DRUXXgBzjgRFyr5yQxu0sAxi54WWGKqpwmvP7njEkQOS36hXBbAIwmn8SqemEyB27zo61I
 BJ4s/HBKZ6plttc2xxMxNwtZWtDXM/2hGYiezpvFpLC/RKLDj5aL170B9JTvv02c7u+Q/S4J2
 6QTJoVrJW/sNpqCPffGAIjbSvITwnFuVbZElBbnFtdxftrCVu3qASXjyrUsRxBMu/9gz0Hp05
 3NDcNkBbJGCw3RFI8UB6kcy+HPsFDlOV6bhEYHQXYlR0dlsNWMK5tKS7zopSsKtfifxzuLe0N
 TPSmOzouoYhGEkGXUmLiMGRZeF6U8JbeEFiGYB8OdF2lF4vyqjIIdYuESnvRqhHy7N92UgrmS
 ZrQCsrpRE/1XT61IVZKQwtrzoHkAf6wULlImfUuceKdT0UBob3pWx9YbA+p+uGQeXNbucrDhP
 ngr+oTXHMmGqL53G0ikXqMJxfpspdE2dXvUfPUll+f8kcImH82HgJTe2ZE4rZm6gidMmxhuBG
 u2Ntb+aiedPbTiXcv6RdV+AZUE5V4rQ7ikQQCP1Q7M+zeC83fGHyLfV1Tk22bvPi7hRmh82Vv
 buMouKU8zdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -146,6 +146,7 @@  static int pas_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>
>  	cpu =3D of_get_cpu_node(policy->cpu, NULL);
>
> +	of_node_put(cpu);
>  	if (!cpu)
>  		goto out;

Can the statement =E2=80=9Creturn -ENODEV=E2=80=9D be nicer as exception h=
andling
in the if branch of this source code place?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/pasemi-cpufreq.c?id=3Dbf97b82f37c6d90e16de001d0659644c57fa4=
90d#n137

Regards,
Markus
