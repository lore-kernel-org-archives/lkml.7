Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70060CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F86720663
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fR/g9lMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfJVJMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:12:54 -0400
Received: from mout.web.de ([212.227.15.4]:53889 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbfJVJMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571735561;
        bh=7X8VPzfXyeZbtQNCoVO8DTiV4iU03bvctWw6Zpoy29A=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=fR/g9lMtRvoVFVfoSXCs5/jSsVWU6d99xFqhViPUe6CQkR3oCnAxtAlm5SI0QKVJq
         R0i9rbT/B93kA/w7mZGAxRDNGMboor9BGSv5xtlFwN4yXUiWrHeiTEj0u8X31CIXJ3
         TqeAvJeMdVspgxoOcm0UPMfTmQkVn3yez1PWMjnE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.150.42]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUBPu-1iV3iE41Qo-00R2EE; Tue, 22
 Oct 2019 11:12:41 +0200
Cc:     linux-kernel@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191021202626.5246-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] clocksource/drivers/davinci: Fix memory leak in
 davinci_timer_register
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1d9f02d3-45ac-1d2f-457b-91cae123383d@web.de>
Date:   Tue, 22 Oct 2019 11:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191021202626.5246-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RzN1YiacG8MmLcL8zUPl6r5PXF7Wed5b728Mu2rwRlYiPX9iNtF
 8yL2OZ0aK0fq1+DN2qU0HZjJl0OOgWeq8XnKLTq8frRUmsrLX2OS84sNuV1Jjkft6rhYkCK
 CnBg1yiTborkcbD4PbFA+RlLjRlkgHq2wqBY9vFPbHM/AD6dW8eRCjkxUveLsrpdrPO9dtw
 WLFMLcBBCQX17zooNLfcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LEF+jN6fgpU=:ic88S6x7uFnEwcMsv/Ye3Z
 ZZHAeJUCKjtNls7e7KpaPBtPOgJAXjVkfGXe2DCkCfWs9SvsbHqqPDXY52UMClor7UfeeGQXs
 bf9nbSOe7OxYwFTu2ahy0TeiPeLSsaDECTxeqzlje097JjphQ5d6yHrp0uApw7EkKIbnTa9uE
 NzJD/rYRwo4GgHrQWkBvZgLuzTiB76rSLell4MCksV8vsKi371cr14z30hGyc+ajD44JGqBhx
 /owW/ExcxYSk6voTfe3v8eYf8kN6vm8oLew6cwYi/mqcfvTDdcP6NcE1zheK72hJQfL1iWO1e
 6d2I23I1vHG3TZsJZxGs21ZjyX5ekWpTkjN2Dle/gz9SKTLkL68DLuanlEuZBfjeWNnC1tdm2
 kjGfC5YOrzqNkizd8GMCEXgs+qdIzfOmn18dm5cSTk0Mn0Wqd//h+hpAfRH2/r9Z//xq6rS+M
 hl+Ls26xYBwucaqvR4KJb/j4H/RQ4VqFXPjswvXjo1V6SOk2bs66OKsCizoNWh3GnPBJsP8G7
 KA+zzGJ18UMEeUbFYt1NOK+YA2EYGHFFBNuQ18wIrUEOIaHfG3pMlbcQFNvRinkPcag6lnOm6
 Ip2Ms+sEd/OAO8nQovIw9ZfQ2fBQ+gHcWewE3Lxn3ZzJTP+CDM9AS2KMXfSkAQD7o2TByLCxd
 sNDtoTRVojaL4w4m8qFnRw0IKGMke8DaaNL8XX/93GC+YXdUqEpzqHo0OqcJplnsVT8s1+q0n
 OKxJzaFr+J9Y6Exa2LJJrR7Q21PCeRHPTsbVVUYaJQ9/E+SQzt1MEWbahc9v/5BRCDAgqr1V7
 B4VDguOKssyCHGFBuI428ulAh4PdGdJMNAuTarnbj91lxIkxBK58OFKyeOS4bG0ffSpY39LJi
 5Mmoih0tVa0ijRngQpW/UoVZUBVOs93YXqAilUOizYdydAVpOfClnQ9xuajk01fHIEKeRubjT
 7vhRL5Sjgx7fpqG9i3NmQ+kS3dzmg12rSdXJuTWP9U9bEFpxWDhA3pCyK9jSOZIdCFoeAIBOz
 Ap0bogwQLQYLNn848wG6R2Lyyr/msIBr/rKUf/k/NiMLdziwAoWnNwBnH7U42MjBNeyALwG6y
 ft4CTISQSmCMSQAFMV+1tX8tzofCLDagbdYC8LIMQF6FHSTql9z6WZwcZYn5q9abAP4i602Qq
 yCYoDlmTuEOXIioJta4sDacJnbwzaBXUtAMD8JKSNXxck/EhOQg269ugYTCyFC9mZZXH/tAbZ
 VXe2nTUF/rckMhRdz5HMa2axBt43ued0QXmKbSKVnB7WeVb7MgL5kCJibsUs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the impelementation of davinci_timer_register() the allocated memory
> for clockevent should be released if request_irq() fails.

* Please avoid the copying of typos from previous change descriptions.

* Under which circumstances will an =E2=80=9Cimperative mood=E2=80=9D matt=
er for you here?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D7d194c2100ad2a6dded54588=
7d02754948ca5241#n151


> +++ b/drivers/clocksource/timer-davinci.c
> @@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk,
>  			 "clockevent/tim12", clockevent);
>  	if (rv) {
>  		pr_err("Unable to request the clockevent interrupt");
> +		kfree(clockevent);
>  		return rv;
>  	}

* Should a complete source code analysis point out that a similar fix
  will be needed also in the if branch after a failed call of
  the function =E2=80=9Cclocksource_register_hz=E2=80=9D?

* Can any more exception handling become relevant because of previous
  resource allocations in this function implementation?

Regards,
Markus
