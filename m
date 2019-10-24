Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15278CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D141B20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RnmPKNNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436930AbfJXKwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:52:42 -0400
Received: from mout.web.de ([212.227.17.11]:51927 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbfJXKwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571914345;
        bh=iI51j7SUEVcjtncibBNx174LoRy0C3KuowunLQfdYbc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RnmPKNNJ2lAHwCeg5YYiot6GLYrwrG+JiGldcWMtfK7rigsKuxsf/0bs2kr8DkBFk
         OEOXLkWEpDiowpNIc2To7A5PfJ6BJTFCZ8GNwZVVZA40U4i60GlvDZOuor4qRSjZPC
         wiIkJMnewxiC1b039y7E9o3f0oPRzJxcDGn7I/lk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.110.199]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LudGm-1hx9uS3m0u-00zocP; Thu, 24
 Oct 2019 12:52:25 +0200
Subject: Re: [v2] coccicheck: support $COCCI being defined as a directory
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>
References: <201910241758198340332@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ea6265f3-4dce-4539-b12f-dfdbd064f852@web.de>
Date:   Thu, 24 Oct 2019 12:52:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <201910241758198340332@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:n3/oztCB4GyirEK1BaRZAa19cDyO3ArlxMFp2cM+KRsaiOZDhdj
 EkvjcPDEQVhQEGXE/HbSrppNFNZiMCQ0kgx/mxY6n9FK3UTGiAyHxUd52oiIb2szJTXqFl4
 QPwY2q9PArB6GZJtICKaN+1jczozklB/bQsDW0ni+iuDGeKvKHpjmkUsi/kyGiUtWQzRPsD
 w144JfGjaMHoD8RAs36lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BaIoyD/pznI=:3hptLX/I+0WY0ksFKa7NEp
 pPiiNTLo8OagUBo6cTo9roWBCKkYy4cRHN9ccv6xLcgwuRHFbQ0qQc7cNLwaQn48IhEFu0Fo6
 GhYTbT90vJrojvGFdJDt2NAaHref6rCrIfX9etvpxiu6QIjI3EGo+SMG9frQNoxYi5zk0STBu
 mrhMf1xyBNRzQxAOtOTd6dg4IqSlMgp0sgL0x8q8h5BMoZAOJGBDKmNxZ2qv+yLQ+T7gx7gKG
 Umy3SVzNFnyvLUmsYWXNk4gjVXJjGNKdS1wKybvy9irjDTSNCcXyymA3F4X4e6/J3g5E0tFZw
 wioHblQbtFm+3yFR8OLT8ljiMT51RIi5A7vW8jni3vzJJpMtS8/Ah7fnrYHhbWgbHCLJQmxwF
 c8n0FsEcQofm6KXW1q3Z5CwpbUkf1zmlAEXkZ+B6/euI7l+Uz0ve7lZe40sytKDVJL/GpvS3Z
 OV1l6JQi+IFWLFCgoJXTuWVjD06kD+KQsI6nV55YMCKyfYeaWU5r6dj1Cd/rIpPG8wX6NScS3
 FkUeYWdOh86TNnR4/K3yr2X1oJW/scydxJoca5S4cZI50rWvbSW8pIkNoqhcmDZubRXE4fSPw
 CBWE04Ci/W1gSk/ux2p+DToO1gsMpyD0HFgSNIBVO9NozLHQXP3nvJQ6P5uKcIuU3NQNyWt36
 Rn53989Y8S/cKjbtYJXrmu7F88ybkuZH0wXBFWeFJeZswMhP2Nsoy6ectvXnryQ3Avo5QbBOU
 ICUVMHO+EPQWCkW6tHWlyjFFhVzKmifNhcVyUrcHW4tvkF3raFCBryJac9Yca7/fQHFV1tDZC
 +0h6mbhC6P+AWyciq36i131kHfpfHjw+bq75mRGC/suvY9w6UAcPSy/Q4OpqKCgY5yYUtxK4o
 Sys/h4a0XBkhGJISmNAXhKExl9FjnTk+wCKaL7j/UDz+6F6JYeTUN6+jt8Ee7pCmNGWkGJXsU
 vLul4Ymu0rfeGxF0o5Nf3mOnsosyTbXXTfG7mipPF8QQV0CiTmaCdgb9TAIlj3glEqy5LBKbp
 DoY8wUE3WqUhGy0An/s1No2aJ68O8BNExTE33O75iqbuTXD5Ri+Ty2tNRj64giQUoxGPtgcSg
 CC0y7pUxwegM5Z8ounglqT9y9ynVOeXe+/CqVLzykq2+ki9ytRQOJASXPigCeWPgYHTqfLFhL
 3iG9YPXvAI45Mw46xin9OhpzmpKmTOkoUWfSQQvx2T1ONURG+c5fNi9St1yWUiF/9cb/w1wxE
 N2NmPguVuQXQpZc9Utn4wAD+GSRE+/mJQuf11uRun74qfx2IRvg+a/2r1LmA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How do you think about to use the subject "[PATCH] coccicheck: Support search in a selected directory"?

I am unsure about such a reduced variant.
Its acceptance will depend also on other Linux contributors as usual.

Regards,
Markus
