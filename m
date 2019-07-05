Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D7FC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE79218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 06:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qsEcNxVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfGEGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 02:46:33 -0400
Received: from mout.web.de ([212.227.17.12]:54997 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfGEGqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 02:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562309162;
        bh=JcTYobHeyGhruGwNxOsy2dXliswuFZOpaIUuBCFdMM4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qsEcNxVXjNdNNKUqnGJTQq7DpzNq5I/MFZgr0LGQqpiAZMm9qkZRc57LibGVgCqoi
         9dacJsHuCVGjnI6tOqjF6klQ59N81ulpfxWGk+sUiiS8maLknm3srjUhGkgmhGq0nF
         tOmZtMQQUVw1dL4v0ALyaRO6ceP0iG3MWHb5Y648=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.45.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8Xx-1iQIMZ1gjV-00jaIr; Fri, 05
 Jul 2019 08:46:02 +0200
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <201907051357245235750@zte.com.cn>
 <alpine.DEB.2.21.1907050811110.18245@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0972fc1d-2ed4-2f0c-ee50-d0d34f806e38@web.de>
Date:   Fri, 5 Jul 2019 08:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907050811110.18245@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N08N4FgmMDbzeUQoWKFJ7qYcy2mdQjKbLFFfA+zCj0IsRItVCDf
 huMh3RIfbPo52xeEy40qHyWYzbF8zqCV8ynx5kDvSO4BorrbxW963dY+gmwXWvvZt/at6Ly
 g0bx51pcLdaeT3HqGPySYgAabVb5HHZd1AljOVLTz3IXPYOujlv8YQB9iv5c+RXyrsNL9ay
 EXXoc9nUWHG+2IxRB8g3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rd8YfCtfBP8=:mlqxaQWa4ak9DD0y7tDvh0
 YJHNed1D+GhBA6YYWC0z8/EBEbeGbh0v4xjK9I6F4LwAVvijMkflq6m2ifV+NsP4NTxx5ZPv2
 caSJHDcvZ/+yqTEEOtu4yvF8ruQBhcNXErv7Zo1df5d07s/qnj3gFZnoDjUQIOS7PaUJ/MkFU
 3QJtAyRS9h+aa1pSJsNG3raBh9laEIazs63HWnu5l8js2rjkex4U7Y2TYqFVLV3c88HJumVoP
 TXFIiQmh2Q4eFct4QQ/ex7KBNAZsX3OFKHTp25RAB3vYOROMmrhA23sWZRPYW6F0JRfEbvsOT
 24fDcf1wsYA04LzRAIMEnn9CsqGWtsVcWx1KSb6jn4tpvo9kUecxdXHEcnG83eMKhhpO9EghH
 jwgT94pDbJfJOtoWRevEQJ8jBLoroyGq3E/430W283+JLWVuqw35oTBpnVPmZF3sRvfWSPUZ7
 ascZveYz7hWokTRVqfnPJO+eT+0i2YmudpYSfFX6dWEvOwT/FdPAgFkG05s3fAiN9iheEi4UD
 LyFQQBEFfza0sdEOGoO9Hx68QpE8v9xn4tUflsSFxq4LmNWkUSrEyUsyCjO49Gx/kmAQYMziN
 j9LXqhRQM82V3CENWkXWXADuMCPLTOGqZF2opDenQGMW1qAVbHc+Tchg2p84mo6Iv2pHWJJjK
 rl9BLpWykl/tRx6EzvLJDREstJAX+1XcSdeM2ED0oSCuUz4dvGdVDu/RgXtPvvQmSBB8p5ctm
 Be1OuSzmlgheZKY1hoCWCFeTyntAq8MN3d4Z25EZlolzYamAmLEfp2iKj3IAbvsrwlJgDolkP
 kqUUrVsqjQ5dJegQ6BdMOl7GHGY6PGpclBlZ0B4+MWDEMN5zuDGnhkdbfqb4qGfYWtUtvMtbx
 0CiPg8ErK490TEusxXUyXaFi1VE1LJJqapIYHYysdX57DqIkIK4TBJVQ8YtRwHdqHjbzrK7VE
 9+uXsc5KAys14geca0pRvvmaQNh4ThPwWSaWThM2uvy0K6SnnUVIHIj6vLD1JEdyO6kctUEip
 zWEjFun5ZJTHhrIq8mh+/ZJAsFHYPm7Q8mMs0SmI5yhbfMTkCMdyvKga+Xk2kWldZ+JuaFydb
 cD3Myfk09ZaqhxTNZ4pRQO/Kuv5xxFAMPT6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @script:python depends on report && r1@
>
> No need to depend on r1.  That is guaranteed by the inheritance on the
> metavariables below.

Will this information become more helpful for the completion of the corres=
ponding
software documentation?

Regards,
Markus
