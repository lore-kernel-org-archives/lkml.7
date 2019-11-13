Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D0206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hOW+RDIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfKMRJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:09:49 -0500
Received: from mout.web.de ([212.227.17.12]:45209 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfKMRJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573664975;
        bh=TbXQOl2DJCjg0tQYK7vyqi8tMf/qRCiawErn4PM7zTE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hOW+RDINVtvMcnOV+1A4GA2PwDuT/IxOb5csbnEZkr+JWw5lq8IocJ4rmjWCLlYh/
         FrYXOePoIGRJOVnNKF+GiR80VdPrUaZgi6TzObchjoD5qxyQ1TwlHXWjr3AwMCXK1t
         P/6YMqa5boB3xthvMPMtktKjVm4xoUKyldn+/9wM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.127.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhUbO-1iILDJ17Pm-00Mcds; Wed, 13
 Nov 2019 18:09:35 +0100
Subject: Re: [v4] s390/pkey: Fix memory leak in error case by using
 memdup_user() rather than open coding
To:     linux-s390@vger.kernel.org,
        =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Joe Perches <joe@perches.com>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
 <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
 <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
 <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
 <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
 <aca044e8-e4b2-eda8-d724-b08772a44ed9@web.de>
 <0c47ee47-35a0-65ee-4da1-e1745f882947@de.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <52593fb9-cfc4-e444-6657-aff6c622607d@web.de>
Date:   Wed, 13 Nov 2019 18:09:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0c47ee47-35a0-65ee-4da1-e1745f882947@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ME5xkgC5yOHpNij0d+x40tT/vh5JC03iLWsIMrjgCrMY/0QIiE+
 ktCheJC3chI8lum7qgjoE1C37zQblTWFynnUHjdR7tW6/UNiFqsrGPa083Uwh2akU5QuHGS
 LCO6H687s+AAg9HfPrFbyD8uUfRFHzyAxRpaycuebHVJkGuXxRwkwvevQgAtF6wF9M7hXGh
 m+lfIViytQWNa+UNSfVZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AfcU2xkBKMY=:D7wweDxYg8F5Ka5T4+EADM
 Lv+SiKoEnPOqHYwfhFTYLMwNbHUQqN+pBkqNib2KbKJm5FFG2A6BOkxCxwvPgtpBOL7ufJ+7c
 oB7UGsw8N/BUNLiVfq1jUMdWTBjO7ydGD1DrX8u5Hhv02sfOx+Cgj2uRHsiNR/RJqWY+erOR1
 NrhGy3+WGoJJ7s8yK3NKsj7meN/odMkR9r2aZkWyibnJfAShQ9OvuVI94SB/3VgiLSNgK0IQk
 wIduPLZVZ1sxDYz1znWIyTvmPRHbIKw/rFODLq0mm7r2WbH54CqB5ErTpTOAvUfScr4JjhW7q
 gWYeZn6Qlzuy5CAEV4YGp+oVg41cxGMqLcLJE3wFQEO5gR1FY3Baw3wb5SC4ugeV0JGoa90af
 2t+i719xkKMYjim1fYzp9uSmfAvhYwM7BbAm+t1n34OPwFLDQs1FDbpkh+mcuf/6FWWFrKG6p
 wMDPhKviDmu7ON4+cj/qhpStZSuW77/arcr5G9+2rbPUFf0MDAKq34aRir5QcAUb1OMyqZgVZ
 MWH3Qo+7lOhYLCxcHNVh/cZTwrQYYZk+C5Zz4SYVZg9XHCgdhvjYY44Ncderky/KNTCPEXpwJ
 LPMoc/O5R32uRT3MlgXChOjKdLEUzAwHBtwXtu2oAF06CHmq3BPe1cgbPIGGd96QFe5hSjhoL
 x+qme/N/G5xY9HdqIUalmgvpFzsiylxJqb9hGo4yW7LLkqz6dgCg1v2NUzhlHV7Fmxc0oQqj1
 2P6QeEC6yq2foBnGHrOi5XByvPFsmAcT2HknHXYiXz1MDN9SbBQPZhMld4T5Nu87OzJVjE2b1
 zF1CeRcOdRsb1hd1C0EJqF2eSg5USyW+Uv+O+RrsByuY4c4pu8vpAyglHL3O592zfYoNtKjNf
 D038V380sgwk8fI8Jpn0l3KBa8XdpjugIxzSZrHFRwK12qtqyotT1x8uLuw4k2lBAVb8fwZ0F
 lrG7WtB0u2DmN/x1RHjmHXH12RdQj49UcvYWGurRvOTFaf4doy+ASSEo/ioBVYMaUxwN67BKZ
 +lBAFQL5TKqSScGbp64jgQg7Qc7yVIWXA5middp7FcpGb0tZCw3iE0khWzn1glNfaESNGD78t
 xMPaBs+erbJeDz9um0MBSbPSrrjGgnoGvc4jTZayxd48tigA4yt28O7rzZW24vRKXpekxJDm8
 40t9Q1BOhrTpuP4N/UCSqSKU8eJQjtn0pxGhVYFPauPaehU9UErUGf3sykh7Xpw+SkUQE2ywL
 oGPF08d8tjcmvGaPeEX0O5QXfKeDGNkP3konsRy50+M/4SrWPj6XNiEkDIIE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> applied. [...]

I find it interesting how the commit message was changed once more.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8b57e7c852fc58a62e668a83c0fa8d9246131803
("s390/pkey: use memdup_user() to simplify code")

Regards,
Markus
