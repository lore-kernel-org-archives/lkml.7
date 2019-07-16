Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C32C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5312145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ew94lgP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfGPMGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:06:10 -0400
Received: from mout.web.de ([212.227.15.3]:50655 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPMGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563278745;
        bh=fQ2avAzYiPevEbhCwSjxbKxm382jCizRyfFyZNtG3Ek=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ew94lgP5Zie6bRKv5mnw5smaZfl5NLJo5yPIugbQ5UwzOP2NRAV4+IJFD8GwbsAqq
         u8tpoAbUCysFlijuxgQpUV7lVLZjgzzOwAOS7L5gxqzTfKZOX1J2JRe4QSiyBsMiii
         7JqLKWRzm1NQnxp/nArhri7X/TxMLSK0TBr3Ihco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.184.87]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfqSa-1i8IsG3Rrg-00NBrF; Tue, 16
 Jul 2019 14:05:44 +0200
Subject: Re: [v3] coccinelle: semantic code search for missing of_node_put
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>
References: <1563246347-7803-1-git-send-email-wen.yang99@zte.com.cn>
 <663d8141-5740-a452-1f4a-8335203e65ba@web.de>
 <alpine.DEB.2.21.1907161307550.2885@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <14f4d5dc-f3b1-5cfa-4a2b-046516369fc4@web.de>
Date:   Tue, 16 Jul 2019 14:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907161307550.2885@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O/J7dleIdBQm+2ZfcOfG6bx3mi+ociPJMh8sAXQfCyvBCXRTt5Y
 uDTfuPQ/T4DjZo/SvY/mq+TaPA7lV5M0qD9XtSXpWtXQ+KSVX63cW+91xr0i4N8iQxli+V0
 rwz9lMKebC5/dK9ot+VmMI6RXZMiL9zLVXj/urtnTx599ZsxldhnoWpl4J8E9zJuDU4Z6iK
 AKJupp5LNyG8tlIGEy5KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lcmMCWpnpeA=:XoxIpEl4FyIuuAcWkc7eCb
 K+mza35OOW3CzmQYaoUEStfrO88bCc8Abxe7bdWxi8bUSSVAqaQkdZyuskNe8bgmwhY7uY2hz
 2MbfwB/6SzNwpvQ4KmK4KWN9lNWMaOeu4YL69elM+jRQkjaXmdF13M/w1OQATm2sucXZzdCZu
 E5925xPbT956Pi/Z/BZ7WfX1C1Wb8A5Ux9LshK8vN3Z4ArFQLO5z+kEZHX6hvzPEDZwdxjGFU
 xyJoqbPycO1TAg6sQn5dFF+gVZ6t8DVAPB0OTb5jvxEJ2DXyKl+sGQx9FThmE+RSmeVXTqnCz
 wLAhTDSWwGZuR2bEvrzosfAhVsWt8ojdwyIN1514yJehGN90W6fbNkcAvw4HQofH4trz5iI+E
 6DV2/TjwF6ZqIl0TdGeYlElCLPHvCPUJ+/jtc1TkNtDhQ/dRYxeUsTCYBf15bVvrZ14r+vZ6t
 OQ6kiMhTd42JIWCWgVTsvojYjEwkXmLl8rSd1oU0fXgUnF7fCWaJnL8dl0HtAGkxMSM7yz0eY
 GSOcfp+rL7xnkfxJdQkKE+ff7ex+cuErrGK/w+9pC7t2B+7nVfMNb3R+XAryBsQCuHSfwwGZo
 sxf9X8X6/QMJrEZd/P6y+XWkzEsO8gQiDonw3GeXw45FFpliJcy+QhDp7jkgoHZO7/U6H1PzP
 Fo6Tfp91nkRMEE1OlqQUjC0YlwElZJc6HysQ21iDknsJyvCjTv9G7Gcy3yE3718jCOZ91v06u
 cC6Com5AR5kGoH9Tk63S5IE7N1rQtTN+3iD7GBHftBDPFEtDJa6+qPfsCpj0OJhwkYXl/8Vbv
 RGFvKulA6B3KRlwkTkUQSe1qRpy/A4Ri7g67SRDl1QJNodZ5vTOcp20FYCxrWLP3bcMbJeSwM
 Ojgr3+2Lnr11PVzGUS9K+wXC3KZyJnHja+rQg98iOOSxzy1yQ5T0lKwpknTQugl1jjVavQN9N
 r45clvIHDw+omB5ubbEXU0ymxo+BcWqg6w2rbnjwRZM76phXzcWmJ6UQ49sfTqIpOl+AaYxAo
 TkN70hm23ViFjX7tcHF76/jcCvabvfjGgleu/CqTyNF6AbjW51fgdwbT9knVpkbYcwu6MSa3Z
 Z/CzIKyTaL8UXD0FP/6lXTc/XCxd6I22pS5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why would you like to keep this SmPL code in the commit description?
>
> I don't know indetail what you are proposing,

I imagine that you can get more interesting software development ideas
from links to previous messages.
I hope that the desired clarification can become more constructive.

How are the chances to move such code into SmPL script files?


> but I would prefer not to put semantic patches that involve iteration
> into the kernel, for simplicity.

This view is also interesting.

But I hope that this functionality will become more helpful
if we can agree on value combinations which should be iterated
for powerful source code analysis.


>> I would prefer software evolution in an other direction.
>> https://lore.kernel.org/lkml/44be5924-26ca-5106-aa25-3cbc3343aa2c@web.d=
e/
>> https://lkml.org/lkml/2019/7/4/21

Would you like to add any more advices for affected software components?

Regards,
Markus
