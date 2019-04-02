Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEA32133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cUiMVDX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfDBMur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:50:47 -0400
Received: from mout.web.de ([212.227.15.4]:40793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBMur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554209431;
        bh=YWe3x4Ab+DN21xLH/3ej+DIn072nsp6Y1nUAwKbSYbU=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=cUiMVDX7RI9pYRaXUrT0F1E77baFeBA+MU20WcspsS9Tg2AVePp3bxhmMD6Sm3Dha
         hde4wWFlxa1B9fYX2lrWmW99f/nA78SSYWQn82w3ga29DJODrI1zpwjiPpjT1NRVL0
         9o6L7X9a3/SfAhLR4L/z0PPNExGzS28P9ZUUqpRU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.142.30]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40jS-1gtDkr0lvu-00rXfO; Tue, 02
 Apr 2019 14:50:31 +0200
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH 7/7] cpufreq: ppc_cbe: fix possible object reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>, kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <89ab8dd4-e997-1796-a522-863ff511bb58@web.de>
Date:   Tue, 2 Apr 2019 14:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554082674-2049-8-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/MVpmJK7geEaoXQchFCCLFHOxRManEGapod54a5xXziFWmlh2i
 zxmIlD0WmQG1r7XS/5tPNHPYDfE+d5XX14iw536AbjT4XC/0R+J6uP1i1OpPABQwce0SUWY
 bCrTa7YhId00ntD42q2hU95VEYcZksOffUzEcozVD5lvUGRlwp+4yV5iHj/tTxtfCk7rrYp
 C8Ysj5/oMiYxDF7LyLwyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A2CROXi6o7E=:tCW6XyMJuo8Aqgu3l5c00x
 M1rbpE6hx1dqnYmeq3FW8NUbDJeN+qoy/Vy6WOgjkogK66wiSlLPrTh/DXjjg6nwvqMzec8ym
 msyMvdgbvS/awfdwhnZYHGHwd9wIDJVpIQHeed53lnxgliLlukfQWKGnjd7BkbRIf0TfC8LV4
 PAZYNX6FtizIIxQLdybDXZnBhaxq09GlOQTIxswOeZwFUwzG4py0+edHMlS+5anHbtaNmpavY
 pAmQNwQrUI1MFVtnefK1rzEkYL2FScdXZsA2o30vzfIIKOqLoBIK18w8CTaVDiZoU3fCAHjsU
 pKFuAan/aCK5iAtmY2ZnousOFqObkG8WgSlyh3QfSV0d3xefMlciwOiki2BUuv92z6hWhbv+f
 1X+ZWOcx8R+/8daQ5Nrw8ila/6i4lSyhsdZ8//jdGG0HvF8Qg5kwn0wQXOrHRhchdKNAyyN6E
 wcd8lZN4ONPv+l1ZuQduM4ZwNwOqFP8Yu/FTDNbnb3S5nhRwyhSQwjnoHy+cqYjYzJ2EJP/sf
 vLSJ5iIlQBcivfqWIHtAo0UpxFALdAEjzrMozDOEN/LjqHhefIPzl7p4wsKzwD5bkHdlt+0t1
 5jt+ZIuP19viAdhma27gx+zXC11PnlI9512cVQzdig+acdUygfYS2fTZlTFJMw3bYg9C3FH0K
 uJU3z7NWJh8mO86gO2hF6MPFL2hPd/Dst80swrOnbMu1x1ptR4QM67yIA2nc3JKJoZ970pBTP
 oGCb9TajPH1SY/5qyNbcUCqHmQ6t+3b/5o8qPSb/0f8j0fNHxo1MyMGUmxXFGTCrPFsxUPQZA
 5GtC/JRtZ0Z9wKLjW8q2rPdOD2fxfB/pYMOdSYr1TCIbC/7zRbI87IDmh6MnH+x1b4zTVTLXG
 tZixYktUGSjSgmE2dYvovXQwqzLS2CFUikZ4ByLRk4EenWsT5/lPxH0eA4EA/wAoWuHCpmu9U
 FhjFIYbDZEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -86,6 +86,7 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy =
*policy)
>  	if (!cbe_get_cpu_pmd_regs(policy->cpu) ||
>  	    !cbe_get_cpu_mic_tm_regs(policy->cpu)) {
>  		pr_info("invalid CBE regs pointers for cpufreq\n");
> +		of_node_put(cpu);
>  		return -EINVAL;
>  	}

I have taken another look at the implementation of this function.
I find that the second statement =E2=80=9Creturn -EINVAL=E2=80=9D would ne=
ed related
source code adjustments.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/ppc_cbe_cpufreq.c?id=3D05d08e2995cbe6efdb993482ee0d38a77040=
861a#n96

How do you think about to complete the exception handling here?

Regards,
Markus
