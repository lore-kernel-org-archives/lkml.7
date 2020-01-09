Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65789C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B8E2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QcRNSbd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgAIKgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:36:10 -0500
Received: from mout.web.de ([212.227.15.3]:58671 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbgAIKgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578566143;
        bh=EAK3sIZQqu0iFAcyFsqjs/RIgac6F6FxW7c+AFFkbbY=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=QcRNSbd14ZnDuspkGxFkcxGd6Ny4Uop1ENm8rpKaezOtoPVBku46Vp4Nnls2YC3Bc
         AbAh4Y+TMCL/qnKf8ACiSbXbsP7guddSCsiYlU3s66ScmPGzN0RFJL5IPxVgygjY/U
         xq/RFci2pddE9uP8L8M+yOHrdE+LwI6hhdvpZT88=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.1.10]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRlJB-1jHw2A2MwL-00SuIO; Thu, 09
 Jan 2020 11:35:43 +0100
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
Subject: Re: [PATCH v2] coccinelle: semantic patch to check for inappropriate
 do_div() calls
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Message-ID: <9a2b7d00-442e-0c1b-73cc-aed2bbecd13a@web.de>
Date:   Thu, 9 Jan 2020 11:35:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107170240.47207-1-wenyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WQTsQgK7Zxi8JJdexL2nh4QMQONYnADY/CTwBZ2MvoDHSOQrVVS
 lZdmgm+fK2ihMAKLvebw6ESBMCPdzCJBrqOklZ1C/I3wpA+H5Jc9MWSSWzVqEZDYsoeIhYq
 dwo6qIlYMHa0VCsAyPdhtgaqys1AxYwvTyDC10qChNRWIy/pQuvsRpjD8IMbNoEN/dZ9RL5
 8qvlMaeabtN/g2Ta1BlZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VO4QRwtOxv0=:oqDN8u7+OElC/+vpzLIEb4
 SgTI/1kROQ9CqxJZY7SIaagjeCD89JOs8wetst2J8AiOaUsUYEceaxrVKspqAzqkkzkGrt5Cy
 PrQc3rWC+/jqnmpGi2U6FVhKORbfEOMNnvz3nl9FopASjjVDwKXASZsKaoG5M586z3ncOHWZ8
 8Q8F4jzTbgRrLjUg+wQB8KnOPY4NDZTS/fIfR06HOGoQaRNiu9/AAuW/eThpiO0LWcOG8q/uV
 joK3esSfIdAFnxayXHBCvaVYCShMlCdzB1uP8r4BJ+Q0I48u8FMS9DWBiKulWiddWLGYdey/G
 EvmIDio79cGdi6zgfgVqAC/hGhtQsQp1yIMtZFeSZk2IV269+wcj97TG7sf00wsAgk1QoHcty
 1kJkW2e+sfh11BO9/+6qupYpeva3qxL0TZkJeVawFqSNHeHI4tDRiIPYfSgrv/CnOeGLI7Dz4
 zc9DfcA/JVYPtxXxQ80NDUN7NNM40oMfENM5x2kga9e8eH+v1BDY8V465WhxVJC7VCW1X5g5n
 6MjDs6+YC6ZDoBw/39zs2Ke9ao+O6MEdQ99+Fwl0dZzXFQBBfsxPaEBoSRZtyG+8uoHfQACWu
 7F80PMV+dt6GsnfPWyQs8vP4rUABIn/06HbJCEdlVnts/diY09KDZrQLcz6zTOUEfCU/SQxVt
 SM4Mo+7MImiePx4SwOFLbQc+UAf17JL9nyvxT81bMOvwoQqTKBTw/q9f4dfc6Gvfh6+Wqvs9g
 9ANL6qb6761u4LQWJ7hUxqOR1gskCkDJab/9Jwm5upPfdw5xmYn4lTFmfuiKTH135eCySjgMc
 e88LHj4AjBXVdOFfAiRR8Zoar/13HUaO2Ycjw/rp7if76psbHr33jrivbYXs5hnRuEAA6khlz
 7qwQs8B7UWed3K07X0S9ahA1D7k1A09g16QjcW+3EQrIqW+iQ3itgytgtSDKcxoPGGyijPPQH
 40qFxNroj2SdJBJ6LkBfq5XwmqA6E2EU8glIuJDcZCOwl0VGD7Vbtfw17NtY5Mf0lo3moau9+
 qSTiVDu4twvsZenO46AIxvuIFncsFbjoZQuazRRoXd5hKx4OrAWelVIj4KxxC7lulu8HU0cit
 m+vHVWXlGwwJCD219HgyI/rr98BUpdpINwxmiuIyFDibOt/W8ZYqFzNIh2sTI/4BL74IvQm1z
 zYaWv/ab5Ud5hwYqTFyJmmII8wgbQL5L03Ngev1HvUnJSj6/iUxvhn+POPpPmONXDA/0SVZcA
 pi7zjAAdiLkMvDN2x3vKXRFIaFDJRmfX4/437j0YGlNGG59tODLYBZF9nWZc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - fix 'WARNING:' twice in each case.

A duplicate text was removed.


> +@script:python depends on org@
> +p << r.p;
> +ul << r.ul;

I interpret this variable assignment in the way that it will work only
if the corresponding branch of the SmPL disjunction was actually matched
by the referenced SmPL rule.
Thus I suggest now to split the source code search pattern into
four separate rules.


> +warnings =3D construct_warnings(ul, "div64_ul")

* Can two identifiers be nicer without an =E2=80=9Cs=E2=80=9D?

* Would it be sufficient to pass a shorter identification
  (without the prefix =E2=80=9Cdiv64_=E2=80=9D)?

Regards,
Markus
