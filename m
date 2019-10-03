Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D31C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB6220865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WOvwlG4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403819AbfJCQbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:31:05 -0400
Received: from mout.web.de ([212.227.17.12]:44143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403795AbfJCQbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570120240;
        bh=tb+bIDGQBs+ntTnSgfe0s9MwVA9SDsOiJM4Tsjn0pPg=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=WOvwlG4MkdA8XCIl4AAZGlscXcsQk3SDp/hiquJxe5iZCbjcpLgSFLqIBGCHwmiaU
         uv0y0n2kjEinnxEb4yJC0fHy/yfW22hqfTwly1Lmc0v5oRdIAxHpmvbtPFvPxyZSm1
         gXzr/JVi5UQCL68ij+tjQwvL4nsSu35dlHOtnilQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.81.27]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS290-1ii9WX3Oo6-00TEMf; Thu, 03
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
Message-ID: <9e15321d-5b95-c03c-e6eb-1d3d4a62478a@web.de>
Date:   Thu, 3 Oct 2019 18:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hGruMGWmBVqdnfQbUyzhCcgkhRAYdOGOuEGNeaWAC0TbUyOXvV2
 Jkj6yLwQm428I2j+yLV2lIxTQMSSHIeGhlCGFHarnztD77/oap9wzitcWxwDi4MB0bCoPSw
 d2BVvqQ0RgC9h3c/3m6pP4IL0Kezam49R6sG9idmclsgTfPp5wbKF9/d2rLOKSRTQ32bkTa
 UTGUa08FCdDgDaHvo1xIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0d2YuJ3+WLM=:KhWnqIGUmv89U1Bpzr4Dd1
 65N3u5Y7ik8nKQEHXteJtdSkwrMW7fRWq/908cu9GT/aiIeQr0p1SJAraAjcUCUd6PWc0URrv
 5ulG9+XbdDJq9mqKA0uV3bbf9Tp/CqARj9ZoRGPKXeRD9SdMgtZzeWCDrofB9dmAapftv4iDe
 khR+y2PlkUP9uThosnmoqTYv1YMCvzinAGPJFV+jD2vunEdkYesDBek2iSveG6yhn/JLiKZhC
 0P69KQFOaCGaP0ueAlAOtVeLONbZhpRKiGg6G+xA3Vkm09b9oCWnDJdLyP4jaDRDdC2H4HNaC
 mkZypriK6IS4zQJgrMSN3UnhHaWGngochJ4hb5OUKxWrmnm+VLkg/L4D+bZoBFXTfte/t+EAN
 W8Yzzf4NrX02TTXKdKRJjfOcQpZcxROO0n9pKqCfWDoq2Ee4n54dYuxrdFX/qMFDU6GTLW18Z
 +LBc1NROPAGmPLbhCeNGIvVzJO2TuUtFawkBQT6M4RY3SDGGkB2Bg+xpoyil84h4G/jTa3jxS
 nXgN9jXvMr3SQDY6hrMBanvtrHQc5kIF5OMN/I3rKZpLfZs43NFUTT0rpi2dvF6tD2dQtCCCY
 hldVco/Jyx7bqHQl0JY08p6rYDn74JBLkvtKxmORVv0nHAVArZjVsCSGdm4/J6tuAPr2KA7j5
 /bEnwbNfpnm2rnODQMJhq0fiXNGJ0oIT4OUfxTElUEuMcpod8WRTliLlsYyej6GTyKkw8viSU
 8Y2zcFoTQMjc7Ze3DnW9QcRGZdqwM2vRn6zIfyj1HnViriLqf4C3wrlN/MbyRIIS56aZ6J2R2
 nuQFBEENeYKBbgN1BTpqgjUGjk92ZxMMvkRN2zViKg6p5JVmyg8yUqE7xDJJgXcLgc1BH7R77
 zKjDpr65rGZsubC18CRfPFEh24wzIZfNVaWM2JGsOlm7aN+gBMSdg2FcxhrSpVY6h3GvZ9mDL
 8pCE8Wm/EeK3cY8isSyg/zIDrstMhcagsRTd0+hLvM6L2zbPPriqixNljy+IfZZkCkwr1242E
 xA0ERZnY1FJ0gO51OydiTmTrOTDDnAjyvjm89tB9euIlkTfDZj34vzoRqFH8ziuKN55Sdrpht
 Jby2Ki7zOyNvplMpY1NEGQNftvHYGBOtTqn5EBeUzwsNdr6YevTUiToAeWxkkcG75qiv2M8Xs
 cX56lqgnzrxML+bbCZ9yHvameyennGcEzHAqu1E2+gsNDX7ep85R2XBJS+RHVlORUbzRAOXqv
 +8o/480UuZ098rK5moRPJWxEOj2BpT9pBXoz49O/qnXKNhbNdy8Vk6pBvTNQ=
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
