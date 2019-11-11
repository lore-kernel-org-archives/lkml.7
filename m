Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF671C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80D720659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rg/ApI+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfKKSqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:46:05 -0500
Received: from mout.web.de ([212.227.15.14]:39173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbfKKSqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573497940;
        bh=9VbZaOOM3OJAJ847ZwASCO3Wa+fwQtpV6qiUVxqwOVM=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=rg/ApI+gbUHk3XpfF+RaRG1XOS6lrWvOkKU0L4X4IzQoBnUXKw+yrb2parKXCcZ/4
         xEzd4NCAQxXgqW9sRtE2Vfpwc5fvNAVIuEDMgESEB64QvGzk5b9uJdKsmxOqKI49He
         FJW5wlqqzWVp8lO3Z/F6TO258q9mxHVXlvxQlqCs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.55.229]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLac-1hvSAj3lSM-00a0BL; Mon, 11
 Nov 2019 19:45:40 +0100
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1573458124-14528-1-git-send-email-zhong.shiqi@zte.com.cn>
Subject: Re: [v7] coccicheck: Support search for SmPL scripts within selected
 directory hierarchy
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af9cad95-56d8-943d-6f99-8ec896861694@web.de>
Date:   Mon, 11 Nov 2019 19:45:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573458124-14528-1-git-send-email-zhong.shiqi@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5tz9Ggc0FPeY8StAM6C6Du7/Lbh7k9AWV8CQVDmekHx09X0o5fE
 1Buw8LSlbX7d1YRr1Q73RIq+BJotk/AaAjWqDS5ef5KgRuGaLZnZBfNfgv86B8PuBeZ3YR0
 LCuORevkiW5YGYcbHubNWjmb2faZSGB5JigJZgmwp3vD/RpbTlX7n693hyzRR7F+ZofBnAt
 I8Py4mp4IHViVO5hZkA1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPtAKnkNY+0=:m+YUaMXdwYs27Z/nLGvDe5
 LIxy4YSnYvtDft6fr5MpBPMHm29jjXgnhe373u8k2NvpIj4STpdxIyvpHKhyp+eGKpFEfM14N
 +yJ7TTsjzVvLtW+Pr2MLyqXWcQ7W8Fpex1gtFbfnWHCFCNxYjd5dsG5wwye+dtFQ68CtyVRpn
 A4N0YKSN9MohOL4F/qDaAg4Weq0ddydQlP7ae4MQDQcAtiXHNKnCHaiu4s1ZMwU7bxSRbRkCJ
 t1qjMWLKAD68D2ZAOyyaNVm80Omie3XbEJ/S4a2HBrqGMSFgdzX2BMYfspFnSKUOQcB+ylMNY
 rNwIApXMqoyKi+Mc1g5G8TyZZdpJmUBEqmAOy/cEno0+vOp45HELwy5vbaYMDmvjBCiHTJxsN
 x4Fm3YTZkSYc1X5iIKvOqC/6lbNZZ/XCR3URljVzdvklfZX/V2bB/RsFOJa3rpJ/x0oQs+i2r
 MAx6aeG7BhQCDdNzYDDmnlpwfZjfakQmXCmLKolF3kit+vjCyZcxpI0N5GCCxc3LsMgjBkB4r
 ms9vxAN6EU1ngzIPepOVFSx4hfVKn3pYVhaoES6kMcAQD82dii3yNTSoA4EsGF+4QurmjrUZe
 BBZSpfCDomIaTPXmkog5WB5Ugn/DjUUmW8xNxxws73dsh/5ZX10C3yEYBxOp/CEnZUlqH9TzT
 kWsMufQEMYSlFr94fG+6fGbHFy/6Aa5UX+DSGsbuWM59LY2g+Bwg4r0rkN5+wMr+SuzCcz4PL
 0OU8zL/beaw+7m5SJT5N1aK5iywJBYiY/cTRpo5FDjzC4FSikTyNF3xY8eG3e+TvnLksvH5QZ
 BhIDbWsfAP61CALfCIv3xm0MpbsgQNR/C0gYcpO9/hW6Vd9xWw1l5C0dLlwxKTvxyEAIKsnBN
 C5DoVXLcVFt2prUHaPk9z+q3by84Io0fv14JlkW5nIeGhO7h0G9PGEDVKcT5QouTrh2oVM5MZ
 6hfOhZEmXW+JHIqLHF1CmD1273Umq+OBzKde04Syvasf/j7TBROT4Mp0gvTKovFb0fTdw4eeG
 hakZK78yP4DV/0rQBpUSnQ1a3dE7gyfTfIXw+3mRvBWkX7y2/1kHJm/CcHm2ebvKj/jBV0laT
 sQNGN0P1GMwdDUaU7tKy9/A5w7KSoCCkAbu6RPuTTw3dDrfhM6+rCboARQIe9FAMsO/LnpUSn
 o//KVX6SlZ4esI/7/AvgCgDUw+Xg4gpBc1G9IYGaAOc7D+/jfvs+LCXuKSH8d+L6w2r410J54
 tNPWEMaMfa/x6Ao/srya3LYE8cJVTMXxqEHFySg0NKPetQwh0e5a0nxBKhnU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v7:
>         1:adjust coccinelle.rst documentation

Thanks for your contribution.

Now I am curious if other contributors will add corresponding review comme=
nts.


>         2:fix a repo of "default"

I find the word =E2=80=9Crepo=E2=80=9D partly unclear at the moment.

Regards,
Markus
